"""
Generate an EEG signal plot for the IEEE paper (Fig. 3).
Shows normal vs seizure activity with clear annotation.
"""
import mne
import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import os

matplotlib.use('Agg')  # Non-interactive backend

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
MP_DIR = os.path.dirname(SCRIPT_DIR)

EDF_FILE_PATH = os.path.join(MP_DIR, 'dataset', 'CHB-MIT', 'chb01', 'chb01_03.edf')
OUTPUT_PATH = os.path.join(MP_DIR, 'eeg_signal_plot.png')

EXTRACT_START = 2800
EXTRACT_END = 3100
SEIZURE_START = 2996
SEIZURE_END = 3036

print("Loading EDF file...")
raw = mne.io.read_raw_edf(EDF_FILE_PATH, preload=False, verbose=False)
raw.pick(['FP1-F7'])
raw.crop(tmin=EXTRACT_START, tmax=EXTRACT_END)
raw.load_data()

data, times = raw[0, :]
eeg_uv = data[0] * 1e6  # Convert to microvolts
time_axis = times + EXTRACT_START  # Absolute timestamps

# Create the figure
fig, ax = plt.subplots(figsize=(12, 4), dpi=150)

# Plot normal regions in blue
normal_mask = (time_axis < SEIZURE_START) | (time_axis > SEIZURE_END)
seizure_mask = (time_axis >= SEIZURE_START) & (time_axis <= SEIZURE_END)

ax.plot(time_axis[normal_mask], eeg_uv[normal_mask], color='#2196F3', linewidth=0.3, label='Normal (Inter-ictal)')
ax.plot(time_axis[seizure_mask], eeg_uv[seizure_mask], color='#F44336', linewidth=0.3, label='Seizure (Ictal)')

# Shade seizure region
ax.axvspan(SEIZURE_START, SEIZURE_END, alpha=0.15, color='red', label='Seizure Window (2996s–3036s)')

# Threshold lines
ax.axhline(y=200, color='#FF9800', linestyle='--', linewidth=1, alpha=0.7, label='Threshold (±200 μV)')
ax.axhline(y=-200, color='#FF9800', linestyle='--', linewidth=1, alpha=0.7)

ax.set_xlabel('Time (seconds)', fontsize=11, fontweight='bold')
ax.set_ylabel('Amplitude (μV)', fontsize=11, fontweight='bold')
ax.set_title('EEG Signal — Channel FP1-F7 (Patient chb01, Recording chb01_03)', fontsize=12, fontweight='bold')
ax.legend(loc='upper right', fontsize=8, framealpha=0.9)
ax.set_xlim(EXTRACT_START, EXTRACT_END)
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig(OUTPUT_PATH, dpi=150, bbox_inches='tight', facecolor='white')
print(f"Saved plot to {OUTPUT_PATH}")
