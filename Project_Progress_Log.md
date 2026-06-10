# Seizure Detection Project: Progress Log & Notes

This document contains a backup of the key developments, code logic, and Vivado instructions from our simulation phase setup.

## 1. Dataset & Thresholding Logic Discovery
- **Initial Setup**: Your Python script correctly extracted the EEG segment and quantized it. `test_input.hex` generated 10,241 samples correctly formatted for Verilog (`$readmemh`).
- **The Threshold Catch**: The placeholder threshold in your Verilog was originally `3000`. However, real biological EEG signals peak at around `500 uV` during a seizure. We lowered the required verification threshold to `200 uV` to align with the actual biological data from the CHB-MIT dataset.

## 2. Implementing the Sliding Window Algorithm
To prevent false alarms from random muscle movements/artifacts, we upgraded the algorithm from a naive "instant threshold" to a robust **Sliding Window Spike Counter**.

**How it works:**
* `WINDOW_SIZE = 512` (Since the data is 256Hz, this represents a 2-second moving window).
* `THRESHOLD_SPIKES = 25` (Requires 25 abnormal spikes within that 2-second window to flag a seizure).
* The FPGA uses an accumulator (`spike_count`) to continuously track how many spikes are inside the active memory buffer (`spike_history`), acting as a highly efficient energy accumulator.

## 3. Vivado Simulation Steps
To run and view the simulation properly:
1. **Relaunch Simulation**: Click the circular reload arrow in the Vivado Waveform interface whenever you change your `.v` files.
2. **View Internal Variables**: To view the `spike_count` logic working:
   - Go to the **Scopes** panel -> expand `tb_seizure_det` -> click `uut`.
   - From the **Objects** panel, drag `spike_count` into your waveform viewer.
   - Right-click it -> `Radix` -> `Unsigned Decimal`.
3. **Run the Full Timeline**: By default Vivado only simulates 1us. Click the **Run All** button (Play icon with an infinity symbol) to process all data points.
4. **Zoom Fit**: Click the magnifying glass with 4 outward arrows to see the entire 500+ microsecond timeline at once.

## 4. Hardware Deployment Phase (Basys 3)
We proceeded with **Option B** — mapping the algorithm to physical FPGA hardware.

### New Files Created
| File | Purpose |
|------|---------|
| `src/hdl/eeg_bram.v` | Block RAM module holding all 76,801 EEG samples (uses ~34 of 50 BRAMs) |
| `src/hdl/sample_rate_ctrl.v` | Divides 100 MHz → 256 Hz to feed samples at the biological rate |
| `src/hdl/basys3_top.v` | Top-level wrapper: wires BRAM → controller → detector → LEDs |
| `src/constraints/basys3_seizure_det.xdc` | Pin mappings for Basys 3 (clock, switches, 16 LEDs) |
| `python_sim_model/03_hex_to_coe.py` | Converts `test_input.hex` → `test_input.coe` for BRAM initialization |

### Physical I/O Mapping
- **SW[0]** = System reset (active-high)
- **SW[1]** = Loop enable (continuous replay vs. single-run)
- **LED[0]** = Seizure detected (ON during seizure)
- **LED[14]** = Done (recording playback complete)
- **LED[15]** = Heartbeat (~1 Hz blink, FPGA is alive)

### Vivado Instructions for Synthesis & Programming
1. Open Vivado → Create a **new project** (or use existing) targeting **xc7a35tcpg236-1**
2. **Add Design Sources**: Add all 4 `.v` files from `src/hdl/` (`basys3_top.v`, `eeg_bram.v`, `sample_rate_ctrl.v`, `top_seizure_det.v`)
3. **Add Constraints**: Add `src/constraints/basys3_seizure_det.xdc`
4. **Add Memory Init File**: Add `dataset/FPGA_test_vectors/test_input.hex` (or `.coe`) to the project
5. **Set Top Module**: Right-click `basys3_top` → Set as Top
6. **Run Synthesis** → **Run Implementation** → **Generate Bitstream**
7. **Program Device**: Open Hardware Manager → Auto Connect → Program Device

### Expected Behavior on Board
- LED[15] blinks steadily (~1 Hz heartbeat)
- LED[0] stays OFF for ~196 seconds (normal brain activity playing back)
- LED[0] turns ON around ~196 seconds (seizure detected!)
- LED[0] turns OFF after ~236 seconds (seizure ends, normal activity resumes)
- LED[14] turns ON at ~300 seconds (full 5-minute recording complete)
- If SW[1] is UP, the recording loops from the beginning

## 5. Next Steps
1. **Synthesize & Program**: Follow the Vivado instructions above to generate and load the bitstream
2. **Seven-Segment Display**: Add seizure duration timer on the Basys 3 display
3. **Multi-Channel**: Instantiate parallel detectors for additional EEG channels
