import os

# ============================================================================
# 03_hex_to_coe.py
# Converts test_input.hex (one hex value per line) into Xilinx .coe format
# for Block RAM initialization in Vivado.
#
# Usage: python 03_hex_to_coe.py
# ============================================================================

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
MP_DIR = os.path.dirname(SCRIPT_DIR)

INPUT_HEX_PATH  = os.path.join(MP_DIR, 'dataset', 'FPGA_test_vectors', 'test_input.hex')
OUTPUT_COE_PATH = os.path.join(MP_DIR, 'dataset', 'FPGA_test_vectors', 'test_input.coe')

print(f"Reading hex file: {INPUT_HEX_PATH}")

# Read all hex values from the existing file
hex_values = []
with open(INPUT_HEX_PATH, 'r') as f:
    for line in f:
        stripped = line.strip()
        if stripped:  # Skip empty lines
            hex_values.append(stripped)

print(f"Read {len(hex_values)} samples.")

# Write in Xilinx .coe format
# Format spec: 
#   memory_initialization_radix = 16;
#   memory_initialization_vector = 
#   XXXX,
#   XXXX,
#   ...
#   XXXX;   <-- last entry ends with semicolon
print(f"Writing COE file: {OUTPUT_COE_PATH}")

with open(OUTPUT_COE_PATH, 'w') as f:
    f.write("; =============================================================\n")
    f.write("; EEG Test Vector COE File for Xilinx Block RAM Initialization\n")
    f.write("; Generated from test_input.hex by 03_hex_to_coe.py\n")
    f.write(f"; Total samples: {len(hex_values)}\n")
    f.write("; Source: CHB-MIT chb01_03.edf, channel FP1-F7, 2800s-3100s\n")
    f.write("; =============================================================\n")
    f.write("memory_initialization_radix = 16;\n")
    f.write("memory_initialization_vector =\n")
    
    for i, val in enumerate(hex_values):
        if i < len(hex_values) - 1:
            f.write(f"{val},\n")
        else:
            f.write(f"{val};\n")  # Last entry ends with semicolon

print(f"Success! COE file written with {len(hex_values)} entries.")
print("Add this file to your Vivado project for Block RAM initialization.")
