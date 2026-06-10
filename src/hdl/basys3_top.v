`timescale 1ns / 1ps
// ============================================================================
// basys3_top.v
// Top-Level Hardware Wrapper for the Basys 3 FPGA Board
//
// Connects all sub-modules together and maps signals to physical I/O:
//   - CLK100MHZ  → 100 MHz on-board oscillator
//   - sw[0]      → System reset (active-high)
//   - sw[1]      → Loop enable (replay recording continuously)
//   - led[0]     → Seizure detected indicator
//   - led[14]    → Recording complete (done) indicator
//   - led[15]    → Heartbeat blink (~1 Hz, shows FPGA is alive)
//   - led[13:1]  → Unused (driven LOW)
//
// Architecture:
//   sample_rate_ctrl → eeg_bram → top_seizure_det → LEDs
//
// Target: Xilinx Artix-7 xc7a35tcpg236-1 (Basys 3)
// ============================================================================

module basys3_top(
    input  wire        CLK100MHZ,   // Basys 3 on-board 100 MHz oscillator
    input  wire [1:0]  sw,          // Slide switches: [0]=reset, [1]=loop
    output wire [15:0] led,         // On-board LEDs
    output wire [6:0]  seg,         // 7-Segment display cathodes
    output wire [3:0]  an,          // 7-Segment display anodes
    output wire        RsTx         // UART USB-Serial Transmit pin
);

    // ========================================================================
    // Internal Signals
    // ========================================================================
    wire        rst;
    wire        loop_en;
    wire        data_valid;
    wire [16:0] sample_addr;
    wire [15:0] eeg_data;
    wire        seizure_detected;
    wire [9:0]  spike_count;
    wire        done;

    // Map switches to meaningful names
    assign rst     = sw[0];    // Active-high reset
    assign loop_en = sw[1];    // Loop playback enable

    // ========================================================================
    // Module Instantiations
    // ========================================================================

    // 1. Sample Rate Controller: 100 MHz → 256 Hz pulses + address generation
    sample_rate_ctrl #(
        .CLK_FREQ    (100_000_000),
        .SAMPLE_RATE (256),
        .MEM_DEPTH   (76801),
        .ADDR_W      (17)
    ) u_sample_ctrl (
        .clk         (CLK100MHZ),
        .rst         (rst),
        .loop_en     (loop_en),
        .data_valid  (data_valid),
        .sample_addr (sample_addr),
        .done        (done)
    );

    // 2. Block RAM: Pre-loaded EEG data (76,801 x 16-bit samples)
    eeg_bram #(
        .MEM_DEPTH (76801),
        .ADDR_W    (17)
    ) u_eeg_mem (
        .clk       (CLK100MHZ),
        .addr      (sample_addr),
        .data_out  (eeg_data)
    );

    // 3. Seizure Detection Core (upgraded to output spike_count)
    top_seizure_det u_detector (
        .clk              (CLK100MHZ),
        .rst              (rst),
        .eeg_data_in      (eeg_data),
        .data_valid       (data_valid),
        .seizure_detected (seizure_detected),
        .spike_count      (spike_count)
    );

    // 4. Seven-Segment Display Logic
    wire [3:0] thou, hund, tens, ones;
    
    bin2bcd u_bin2bcd (
        .binary (spike_count),
        .thou   (thou),
        .hund   (hund),
        .tens   (tens),
        .ones   (ones)
    );
    
    seven_seg_mux u_seg_mux (
        .clk  (CLK100MHZ),
        .thou (thou),
        .hund (hund),
        .tens (tens),
        .ones (ones),
        .an   (an),
        .seg  (seg)
    );

    // 5. UART Transmitter for Python Dashboard
    uart_controller u_uart (
        .clk              (CLK100MHZ),
        .rst              (rst),
        .data_valid       (data_valid),
        .eeg_data         (eeg_data),
        .seizure_detected (seizure_detected),
        .tx_out           (RsTx)
    );

    // ========================================================================
    // Heartbeat Generator (~1 Hz blink on LED[15])
    // Toggles every 50,000,000 clocks = 0.5 seconds → 1 Hz blink
    // ========================================================================
    reg [25:0] heartbeat_counter;
    reg        heartbeat_led;

    always @(posedge CLK100MHZ or posedge rst) begin
        if (rst) begin
            heartbeat_counter <= 0;
            heartbeat_led     <= 1'b0;
        end else begin
            if (heartbeat_counter == 26'd49_999_999) begin
                heartbeat_counter <= 0;
                heartbeat_led     <= ~heartbeat_led;
            end else begin
                heartbeat_counter <= heartbeat_counter + 1;
            end
        end
    end

    // ========================================================================
    // LED Output Mapping
    // ========================================================================
    assign led[0]    = seizure_detected;  // SEIZURE ALERT — bright when active
    assign led[13:1] = 13'b0;            // Unused LEDs off
    assign led[14]   = done;             // Recording complete indicator
    assign led[15]   = heartbeat_led;    // Heartbeat — FPGA is alive

endmodule
