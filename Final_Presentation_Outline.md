# Final Presentation Outline: FPGA-Based Seizure Detection

> **Tip for Presenting:** Do not read paragraphs off the slides. Put the bullet points below on your slides, and use the "Speaker Notes" to explain the concepts. Use the images we generated wherever a slide calls for one!

---

## Slide 1: Title Slide
* **Title:** Design and Implementation of an FPGA-Based Seizure Detection System
* **Subtitle:** An Ultra-Low-Power Hardware-Software Co-Design for Wearable Edge Computing
* **Presented By:** [Your Name]
* **Guide:** [Your Teacher's Name]

---

## Slide 2: Introduction
* **What is Epilepsy?** A neurological disorder characterized by recurrent, unprovoked seizures caused by abnormal electrical discharges in the brain.
* **Diagnosis:** Electroencephalography (EEG) is the gold standard for monitoring brainwaves.
* **The Shift to Edge Computing:** 
  * Traditional detection uses bulky computers.
  * Wearable health devices require real-time monitoring directly on the patient (Edge Computing).
  * FPGAs (Field Programmable Gate Arrays) offer the perfect platform due to their massive parallel processing and ultra-low power consumption.

---

## Slide 3: Problem Statement
* Current machine-learning seizure detection systems rely on standard CPUs/Microprocessors.
* **The Issues:**
  * **High Latency:** Operating systems introduce processing delays.
  * **High Power Consumption:** Complex algorithms drain batteries quickly, making them unsuitable for 24/7 wearable medical patches.
* **The Need:** A purely digital, hardware-based approach that detects seizures instantly while consuming a fraction of a Watt.

---

## Slide 4: Objectives
1. **Processor-Free Architecture:** To develop a bare-metal, purely digital seizure detection circuit in Verilog HDL.
2. **Extreme Efficiency:** To implement a detection algorithm utilizing less than 1% of the FPGA’s logic resources.
3. **Hardware-Software Interface:** To build a custom UART protocol to stream processed medical data to a PC in real-time.
4. **Live Visualization:** To create a Python PyQtGraph dashboard that actively monitors the hardware and triggers critical alerts instantly.

---

## Slide 5: Literature Survey
* **Valentino et al. (2025):** Wearable SNNs on FPGA. *Achieved high accuracy but required significant hardware resources (DSPs).*
* **Sayeed & Kumar (2023):** Low-Power VLSI Architecture. *Addressed power consumption by removing redundant logic.*
* **Our Project's Position:** We bridge the gap by completely eliminating the microprocessor, using an O(1) algorithm that requires less than 1% logic utilization, while still providing a modern GUI for doctors.

---

## Slide 6: Proposed Methodology
* **Hardware-Software Co-Design Pipeline:**
  1. **Data Acquisition:** CHB-MIT Scalp EEG Dataset (16-bit, 256 Hz) loaded into FPGA Block RAM.
  2. **Hardware Detection:** Sliding Window Spike Counter executes in 10 nanoseconds.
  3. **Local Display:** Multiplexed 7-Segment Display counts live spikes on the board.
  4. **Transmission:** UART Protocol serializes data at 115200 baud.
  5. **Software Dashboard:** Python reads the COM port and plots the live EEG wave and Seizure Flag.

---

## Slide 7: The Core Algorithm
* **The Sliding Window Spike Counter**
  * **Amplitude Thresholding:** Normal brainwaves = ±100 µV. Seizure spikes = **> ±200 µV**.
  * **Temporal Window:** Analyzes 512 continuous samples (exactly 2 seconds of brain activity).
  * **Accumulative Thresholding:** If the window accumulates **25 spikes**, a seizure is declared.
  * **O(1) Complexity:** The hardware only performs one addition and one subtraction per clock cycle, making it insanely fast and resource-efficient.

---

## Slide 8: System Architecture
* **[INSERT IMAGE: system_architecture.png or block diagram]**
* **Speaker Notes:** Explain how the data flows from the BRAM -> Detection Core -> UART Transmitter -> PC. Emphasize that there is NO processor (like ARM or MicroBlaze) anywhere in this diagram.

---

## Slide 9: Implementation Details
* **Hardware Platform:** Digilent Basys 3 Board (Xilinx Artix-7 FPGA).
* **Language:** Verilog HDL (Synthesized using Vivado 2025.2).
* **Custom UART Packet:**
  * 4-Byte structure ensures perfect synchronization.
  * Byte 1: Sync Byte (`0xA5`)
  * Byte 2 & 3: 16-bit EEG Data
  * Byte 4: Seizure Flag (0 = Normal, 1 = ALARM)

---

## Slide 10: Results - Functional Validation
* **[INSERT IMAGE: Simulation Waveform showing the seizure triggering]**
* **Validation Dataset:** Tested using Patient 1 data from the CHB-MIT Database (containing a documented 40-second seizure).
* **Results:** 
  * **100% Accuracy** on the target vector.
  * **0 False Positives** during the 196 seconds of normal brain activity.
  * Early detection triggered within just 2 seconds of the seizure's physiological onset.

---

## Slide 11: Results - Live Python Dashboard
* **[INSERT IMAGES: Python Dashboard Normal (Green) and Seizure (Red)]**
* **Speaker Notes:** Show the audience the Python UI. Explain that the GUI has zero perceptible latency. The moment the hardware sets the flag, the UI instantly flashes "⚠ SEIZURE DETECTED".

---

## Slide 12: System Performance & Resource Analysis
* **[INSERT IMAGE: system_performance_analysis.png (The 4-graph image we generated today)]**
* **The Proof of Engineering:**
  * **Latency:** 10 nanoseconds (1 clock cycle).
  * **Power:** 0.12 Watts (Drastically lower than CPUs).
  * **Logic Utilization:** < 1% of LUTs and Flip-Flops used. 99% of the chip is free for future upgrades.

---

## Slide 13: Conclusion & Future Scope
* **Conclusion:** 
  * Successfully developed a foundational Proof-of-Concept for wearable medical devices.
  * Proved that digital logic alone (without a CPU) can accurately identify seizures in real-time with negligible power draw.
* **Future Scope:**
  * Scaling the logic to support multi-channel EEG arrays (Parallel processing).
  * Integrating a Bluetooth Low Energy (BLE) module to replace the wired UART connection for truly wireless ambulatory monitoring.

---

## Slide 14: Questions?
* Thank you for your time.
* *Have your Basys 3 board plugged in and ready to demo if they ask to see it!*
