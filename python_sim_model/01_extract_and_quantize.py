import mne
import numpy as np
import os

# 1. Configuration - Paths based on your new sorted structure
# We use absolute paths derived from the current script location to make it robust
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
MP_DIR = os.path.dirname(SCRIPT_DIR)

EDF_FILE_PATH = os.path.join(MP_DIR, 'dataset', 'CHB-MIT', 'chb01', 'chb01_03.edf')
OUTPUT_DIR = os.path.join(MP_DIR, 'dataset', 'FPGA_test_vectors')
OUTPUT_HEX_PATH = os.path.join(OUTPUT_DIR, 'test_input.hex')

# Ensure the output directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

# According to chb01-summary.txt, seizure in chb01_03 is from 2996s to 3036s
# We extract 5 minutes of data: ~3 min normal BEFORE seizure, 40s seizure, ~2 min normal AFTER
# This lets us verify the algorithm stays quiet during normal activity!
EXTRACT_START = 2800   # Start 196 seconds before the seizure
EXTRACT_END   = 3100   # End 64 seconds after the seizure
SEIZURE_START = 2996   # Actual seizure onset (for reference/logging only)
SEIZURE_END   = 3036   # Actual seizure end (for reference/logging only)

print("Loading EDF file...")
try:
    # Load the raw EEG data
    raw = mne.io.read_raw_edf(EDF_FILE_PATH, preload=False)
except FileNotFoundError:
    print(f"Error: Could not find the file at {EDF_FILE_PATH}")
    print("Please make sure the EDF file is exactly at that location.")
    exit(1)

# 2. Extract a 5-minute segment containing normal + seizure + normal data
print(f"Extracting 5-minute segment from {EXTRACT_START}s to {EXTRACT_END}s...")
print(f"  (Seizure is embedded at {SEIZURE_START}s to {SEIZURE_END}s within this window)")

# Pick only the single channel we need BEFORE loading data to save memory
raw.pick(['FP1-F7'])
raw.crop(tmin=EXTRACT_START, tmax=EXTRACT_END)
raw.load_data()

# Channel already selected above (FP1-F7)
data, times = raw[0, :]

# MNE returns data in Volts (as extremely small floating point numbers, e.g., 0.000045 V)
eeg_signal = data[0]

# 3. Fixed-Point Conversion (Crucial for FPGA)
# We must convert these tiny floating points into integers for Verilog. 
# We multiply by 1,000,000 to convert Volts to Microvolts (uV).
SCALE_FACTOR = 1e6 
scaled_signal = eeg_signal * SCALE_FACTOR

# Convert to 16-bit signed integer (Verilog's 16-bit reg)
# 16-bit limits are -32768 to +32767. EEG in uV usually fits perfectly in this range!
int_signal = np.int16(np.clip(scaled_signal, -32768, 32767))

# 4. Write to a Hex file for Verilog ($readmemh)
print(f"Writing fixed-point data to {OUTPUT_HEX_PATH}...")
with open(OUTPUT_HEX_PATH, 'w') as f:
    for val in int_signal:
        # Convert signed integer into a 16-bit two's complement hexadecimal string
        hex_val = f"{(int(val) & 0xFFFF):04X}"
        f.write(hex_val + '\n')

print(f"Success! {len(int_signal)} samples generated for Vivado.")
print("This file can now be used in your Verilog testbench via $readmemh!")
