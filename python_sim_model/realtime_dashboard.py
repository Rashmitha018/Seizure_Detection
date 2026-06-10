import sys
import serial
import numpy as np
import pyqtgraph as pg
from PyQt5.QtWidgets import QApplication, QMainWindow, QVBoxLayout, QWidget, QLabel
from PyQt5.QtCore import QThread, pyqtSignal, Qt
import argparse

# ==============================================================================
# Serial Reader Thread
# Reads 4-byte packets from the FPGA UART and emits signals to the GUI.
# Packet: [0xA5] [High_Byte] [Low_Byte] [Flag]
# ==============================================================================
class SerialReader(QThread):
    data_received = pyqtSignal(int, int) # eeg_val, seizure_flag

    def __init__(self, port, baud=115200):
        super().__init__()
        self.port = port
        self.baud = baud
        self.running = True

    def run(self):
        try:
            ser = serial.Serial(self.port, self.baud, timeout=1)
            print(f"Connected to FPGA on {self.port} at {self.baud} baud.")
        except Exception as e:
            print(f"Error opening serial port: {e}")
            return

        while self.running:
            # Sync to the 0xA5 byte
            byte1 = ser.read(1)
            if byte1 == b'\xA5':
                payload = ser.read(3)
                if len(payload) == 3:
                    high_byte = payload[0]
                    low_byte = payload[1]
                    flag = payload[2]

                    # Reconstruct 16-bit signed integer
                    eeg_val = (high_byte << 8) | low_byte
                    if eeg_val >= 32768:
                        eeg_val -= 65536
                    
                    self.data_received.emit(eeg_val, flag)

    def stop(self):
        self.running = False
        self.wait()

# ==============================================================================
# Main GUI Dashboard
# ==============================================================================
class Dashboard(QMainWindow):
    def __init__(self, port):
        super().__init__()
        self.setWindowTitle("Real-Time Epileptic Seizure Detection")
        self.resize(1000, 600)
        
        # Setup Layout
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        layout = QVBoxLayout(central_widget)
        
        # Status Label
        self.status_label = QLabel("PATIENT STATUS: NORMAL")
        self.status_label.setAlignment(Qt.AlignCenter)
        self.status_label.setStyleSheet("font-size: 24px; font-weight: bold; color: #00FF00; background-color: #111111; padding: 10px;")
        layout.addWidget(self.status_label)

        # Plot Widget
        pg.setConfigOption('background', '#111111')
        pg.setConfigOption('foreground', 'w')
        self.plot_widget = pg.PlotWidget(title="Live EEG Signal (FP1-F7)")
        self.plot_widget.setYRange(-1000, 1000)
        self.plot_widget.setLabel('left', 'Voltage (μV)')
        self.plot_widget.setLabel('bottom', 'Time (samples)')
        self.plot_widget.showGrid(x=True, y=True, alpha=0.3)
        layout.addWidget(self.plot_widget)

        # Plotting Data
        self.max_samples = 1500 # About 6 seconds of data at 256 Hz
        self.x_data = np.arange(self.max_samples)
        self.y_data = np.zeros(self.max_samples)
        
        self.curve = self.plot_widget.plot(self.x_data, self.y_data, pen=pg.mkPen('#00FF00', width=2))
        
        # Start Serial Thread
        self.reader = SerialReader(port=port)
        self.reader.data_received.connect(self.update_plot)
        self.reader.start()

    def update_plot(self, eeg_val, flag):
        # Shift data left and append new value
        self.y_data[:-1] = self.y_data[1:]
        self.y_data[-1] = eeg_val

        # Update Plot
        self.curve.setData(self.x_data, self.y_data)

        # Update Status and Colors based on Seizure Flag
        if flag == 1:
            self.status_label.setText("⚠ SEIZURE DETECTED ⚠")
            self.status_label.setStyleSheet("font-size: 24px; font-weight: bold; color: #FFFFFF; background-color: #FF0000; padding: 10px;")
            self.curve.setPen(pg.mkPen('#FF0000', width=3))
            self.plot_widget.getViewBox().setBackgroundColor('#330000')
        else:
            self.status_label.setText("PATIENT STATUS: NORMAL")
            self.status_label.setStyleSheet("font-size: 24px; font-weight: bold; color: #00FF00; background-color: #111111; padding: 10px;")
            self.curve.setPen(pg.mkPen('#00FF00', width=2))
            self.plot_widget.getViewBox().setBackgroundColor('#111111')

    def closeEvent(self, event):
        self.reader.stop()
        event.accept()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=str, default='COM3', help='COM Port of the FPGA (e.g. COM3)')
    args = parser.parse_args()

    app = QApplication(sys.argv)
    window = Dashboard(port=args.port)
    window.show()
    sys.exit(app.exec_())
