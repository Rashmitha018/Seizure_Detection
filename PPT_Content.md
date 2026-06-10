# PowerPoint Presentation Content
## Design and Development of a Low-Power, High-Speed FPGA-Based System for Real-Time Epileptic Seizure Detection

> Use a dark-themed template with blue/teal accent colors for a professional engineering look.

---

## Slide 1: Title Slide

**Title:** Design and Development of a Low-Power, High-Speed FPGA-Based System for Real-Time Epileptic Seizure Detection

**Subtitle:** Simulation Phase — Behavioral Verification Using Vivado XSim

**Author:** [Your Name]
**Guide:** [Guide Name]
**Department:** [Your Department]
**College:** [Your College Name]
**Date:** April 2026

---

## Slide 2: Introduction

**Title:** Introduction

- Epilepsy is one of the most common neurological disorders, affecting over **50 million people** worldwide (WHO, 2023).
- Seizures are caused by **sudden, abnormal electrical discharges** in the brain.
- Early and accurate detection of seizures is critical for **timely medical intervention** and improving patient quality of life.
- **Electroencephalogram (EEG)** is the gold standard for monitoring brain electrical activity and detecting epileptic events.
- Current software-based detection systems suffer from **high latency and power consumption**, making them unsuitable for portable, real-time applications.

> **Visual:** Add an image of a human brain with EEG electrode placement (10-20 system diagram).

---

## Slide 3: Problem Statement

**Title:** Problem Statement

- Existing seizure detection systems are predominantly **software-based** (running on CPUs/GPUs), which introduces:
  - **High processing latency** (milliseconds to seconds)
  - **High power consumption** (unsuitable for wearable/implantable devices)
  - **Dependency on operating systems** (risk of crashes, delays)
- There is a critical need for a **dedicated hardware solution** that can process EEG signals in real-time with:
  - Ultra-low latency (nanosecond-level response)
  - Low power consumption
  - Deterministic, always-on operation

---

## Slide 4: Objectives

**Title:** Project Objectives

1. To design a **real-time seizure detection algorithm** suitable for hardware implementation.
2. To implement the algorithm in **Verilog HDL** targeting FPGA architecture.
3. To verify correctness through **behavioral simulation** using Xilinx Vivado XSim.
4. To validate the design using the **CHB-MIT Scalp EEG Database** — a clinically recorded, publicly available dataset.
5. To demonstrate a **simulation-first development methodology** before hardware deployment on the Basys 3 (Artix-7) FPGA board.

---

## Slide 5: Literature Survey

**Title:** Literature Survey

| Author(s) | Year | Method | Platform | Limitation |
|---|---|---|---|---|
| Shoeb & Guttag | 2010 | SVM Classifier | Software (MATLAB) | High computational cost |
| Gotman et al. | 2011 | Wavelet Transform | Software (C++) | Not real-time capable |
| Raghunathan et al. | 2009 | Threshold-based | ASIC | Fixed design, not reconfigurable |
| Peng et al. | 2020 | CNN on FPGA | Zynq FPGA | Complex, high resource usage |
| **This Work** | **2026** | **Sliding Window Spike Counter** | **Artix-7 FPGA** | **Lightweight, low-power, reconfigurable** |

> **Key Insight:** Most prior works either use computationally expensive ML models or are implemented purely in software. Our approach balances simplicity, speed, and hardware efficiency.

---

## Slide 6: System Architecture

**Title:** System Architecture — Overall Flow

```
┌──────────────┐     ┌──────────────────┐     ┌─────────────────┐     ┌──────────────┐
│  CHB-MIT     │     │  Python          │     │  Verilog HDL    │     │  Vivado      │
│  EEG Dataset │────▶│  Preprocessing   │────▶│  Seizure Det.   │────▶│  Simulation  │
│  (.edf)      │     │  & Quantization  │     │  Module         │     │  & Verify    │
└──────────────┘     └──────────────────┘     └─────────────────┘     └──────────────┘
```

**Stages:**
1. **Data Acquisition:** Real patient EEG recordings from CHB-MIT database
2. **Preprocessing:** Python (MNE library) → Extract channel → Scale to microvolts → Quantize to 16-bit signed integers
3. **Hardware Design:** Verilog HDL module with sliding window algorithm
4. **Verification:** Vivado XSim behavioral simulation with waveform analysis

---

## Slide 7: Dataset Description

**Title:** CHB-MIT Scalp EEG Database

- **Source:** Children's Hospital Boston & MIT (PhysioNet)
- **Subjects:** 23 pediatric patients with intractable epilepsy
- **Channels:** 23 EEG channels (International 10-20 system)
- **Sampling Rate:** 256 Hz
- **Resolution:** 16-bit
- **Used Recording:** Patient `chb01`, File `chb01_03.edf`
  - Total duration: 3600 seconds (1 hour)
  - **Seizure event:** 2996s to 3036s (40 seconds)
- **Test Window:** 2800s to 3100s (300 seconds = 5 minutes)
  - 196 seconds of **normal** activity before seizure
  - 40 seconds of **seizure** activity
  - 64 seconds of **normal** activity after seizure
- **Channel Used:** FP1-F7 (frontal lobe — highly sensitive to seizure activity)

---

## Slide 8: Signal Preprocessing

**Title:** EEG Signal Preprocessing Pipeline

**Step 1 — Raw Signal Extraction**
- EDF file loaded using Python MNE library
- Single channel (FP1-F7) isolated for processing

**Step 2 — Voltage Scaling**
- Raw floating-point values in Volts (e.g., 0.000045 V)
- Scaled by × 1,000,000 to convert to **Microvolts (μV)**

**Step 3 — Fixed-Point Quantization**
- Converted to **16-bit signed integers** (range: -32768 to +32767)
- Two's complement hexadecimal format for Verilog compatibility

**Step 4 — Test Vector Generation**
- Output: `test_input.hex` file (76,801 samples)
- Loaded into Verilog testbench via `$readmemh()` system task

> **Visual:** Show a plot of the raw EEG signal with the seizure region highlighted in red.

---

## Slide 9: Detection Algorithm — Sliding Window Spike Counter

**Title:** Detection Algorithm

**Problem with Simple Thresholding:**
- A single voltage spike above a threshold does NOT indicate a seizure.
- Random artifacts (eye blinks, muscle movements) can cause isolated spikes → **false positives**.

**Our Solution — Sliding Window Spike Counter:**

| Parameter | Value | Justification |
|---|---|---|
| Voltage Threshold | ±200 μV | Based on statistical analysis of the dataset (Max: 499 μV, Min: -479 μV) |
| Window Size | 512 samples | 2 seconds at 256 Hz sampling rate |
| Spike Count Threshold | 25 spikes | Requires sustained abnormal activity |

**Algorithm Logic (per clock cycle):**
1. Check if `|eeg_data_in| > 200 μV` → Mark as spike (1) or normal (0)
2. Shift into a **512-bit circular history buffer**
3. **Efficiently update running spike count:** `count = count + new_spike - oldest_spike`
4. If `spike_count ≥ 25` → `seizure_detected = 1`

> **Key Advantage:** The running sum approach requires only **1 addition and 1 subtraction per clock cycle**, making it extremely hardware-efficient.

---

## Slide 10: Verilog HDL Implementation

**Title:** RTL Design — `top_seizure_det.v`

**Module Interface:**
```verilog
module top_seizure_det(
    input  wire        clk,              // 100 MHz system clock
    input  wire        rst,              // Active-high reset
    input  wire signed [15:0] eeg_data_in,  // 16-bit EEG sample
    input  wire        data_valid,       // New sample strobe
    output reg         seizure_detected  // Detection flag
);
```

**Key Internal Registers:**
- `spike_history [511:0]` — 512-bit shift register (sliding window memory)
- `spike_count [9:0]` — 10-bit running accumulator
- `current_spike` — Combinational threshold comparator

**Target FPGA:** Xilinx Artix-7 (xc7a35tcpg236-1) — Basys 3 Board

---

## Slide 11: Testbench Design

**Title:** Simulation Testbench — `tb_seizure_det.v`

- **Clock Generation:** 100 MHz (10 ns period) — matches Basys 3 oscillator
- **Reset Sequence:** Active for first 100 ns, then released
- **Data Loading:** `$readmemh("test_input.hex", test_memory)` — loads 76,801 samples
- **Stimulus Loop:** Iterates through all samples, asserting `data_valid` for 1 clock cycle per sample
- **Simulation Duration:** ~3.84 ms (simulated time)

```
Timeline:  |--Reset--|----Normal Brain (196s)----|-Seizure (40s)-|--Normal (64s)--|
           0ns      200ns                                                    ~3.84ms
```

---

## Slide 12: Simulation Results

**Title:** Behavioral Simulation Results — Vivado XSim

> **Visual:** Insert your Vivado waveform screenshots here!

**Screenshot 1 — Full Timeline (Zoom Fit)**
- Show the entire 5-minute simulation
- `seizure_detected` remains LOW during normal activity
- `seizure_detected` goes HIGH during the seizure window
- `seizure_detected` returns LOW after seizure ends

**Screenshot 2 — Zoomed into Seizure Onset**
- Show `spike_count` gradually increasing
- Show the exact moment `spike_count` crosses threshold of 25
- Show `seizure_detected` transitioning from 0 → 1

**Screenshot 3 — Zoomed into Seizure End**
- Show `spike_count` decreasing as seizure activity subsides
- Show `seizure_detected` transitioning from 1 → 0

**Key Observations:**
- Zero false positives during the 196-second normal activity period
- Seizure correctly detected within the known seizure window
- Clean ON/OFF transitions with no flickering

---

## Slide 13: Resource Utilization (Estimated)

**Title:** FPGA Resource Utilization — Artix-7

| Resource | Used | Available | Utilization |
|---|---|---|---|
| LUTs | ~580 | 20,800 | ~2.8% |
| Flip-Flops | ~530 | 41,600 | ~1.3% |
| Block RAM | 0 (shift register) | 50 (36Kb each) | 0% |
| DSP Slices | 0 | 90 | 0% |
| I/O Pins | 20 | 106 | ~19% |

> **Highlight:** The design uses less than **3% of the FPGA's logic resources**, leaving ample room for future algorithm enhancements (multi-channel, FFT, etc.)

---

## Slide 14: Advantages of FPGA Implementation

**Title:** Why FPGA?

| Feature | Software (CPU/GPU) | FPGA (This Work) |
|---|---|---|
| Processing Latency | Milliseconds | **Nanoseconds** |
| Power Consumption | 15-300W | **< 1W** |
| Parallelism | Limited (sequential) | **Massive (parallel)** |
| Determinism | Non-deterministic (OS) | **Fully deterministic** |
| Reconfigurability | Software update | **Bitstream update** |
| Portability | Desktop/Server | **Wearable/Embedded** |

---

## Slide 15: Future Scope

**Title:** Future Scope

1. **Hardware Deployment:** Program the verified design onto the Basys 3 FPGA board with LED and 7-segment display outputs.
2. **Multi-Channel Processing:** Extend the design to process multiple EEG channels simultaneously for improved accuracy.
3. **Advanced Algorithms:** Implement frequency-domain features (FFT/Wavelet Transform) for more sophisticated classification.
4. **Machine Learning Integration:** Deploy a lightweight neural network classifier on FPGA for higher sensitivity.
5. **Real-Time ADC Interface:** Connect an Analog-to-Digital Converter for live EEG signal acquisition.
6. **Clinical Validation:** Test with additional patients from the CHB-MIT database and the University of Bonn dataset.
7. **Low-Power Optimization:** Target Xilinx Spartan or Lattice iCE40 FPGAs for ultra-low-power wearable applications.

---

## Slide 16: Conclusion

**Title:** Conclusion

- Successfully designed and simulated a **real-time epileptic seizure detection system** using Verilog HDL on Xilinx Vivado.
- The **Sliding Window Spike Counter** algorithm provides robust detection by requiring sustained abnormal activity, effectively filtering random noise and artifacts.
- Behavioral simulation using real patient data from the **CHB-MIT database** confirms:
  - ✅ Correct detection during seizure periods
  - ✅ Zero false alarms during normal brain activity
  - ✅ Clean state transitions at seizure onset and offset
- The design consumes **less than 3% of FPGA resources**, making it highly scalable.
- The **simulation-first methodology** ensures design correctness before hardware deployment, reducing debugging time and risk.

---

## Slide 17: References

**Title:** References

1. A. H. Shoeb, "Application of Machine Learning to Epileptic Seizure Detection," MIT, PhD Thesis, 2009.
2. A. L. Goldberger et al., "PhysioBank, PhysioToolkit, and PhysioNet," Circulation, vol. 101, no. 23, 2000.
3. R. G. Andrzejak et al., "Indications of nonlinear deterministic and finite-dimensional structures in time series of brain electrical activity," Physical Review E, vol. 64, no. 6, 2001.
4. Xilinx Inc., "Artix-7 FPGAs Data Sheet: DC and AC Switching Characteristics," DS181, 2020.
5. Digilent Inc., "Basys 3 Reference Manual," 2021.
6. World Health Organization, "Epilepsy Fact Sheet," 2023.

---

## Slide 18: Thank You

**Title:** Thank You

**Questions?**

[Your Name]
[Your Email]
[Your Department & College]
