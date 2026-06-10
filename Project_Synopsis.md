# Project Synopsis

## 1. Project Title
**Design and Development of a Low-Power, High-Speed FPGA-Based System for Real-Time Epileptic Seizure Detection**

## 2. Objective
The primary objective of this project is to design and implement a lightweight, hardware-accelerated epileptic seizure detection system on a Field-Programmable Gate Array (FPGA). The system aims to process digitized Electroencephalography (EEG) signals in real-time to detect the onset of seizures with high accuracy, minimal latency, and extremely low power consumption, making it suitable for wearable biomedical applications.

## 3. Problem Statement
Epilepsy affects approximately 50 million people worldwide. Real-time detection of seizures is critical for patient safety and timely medical intervention. Conventional software-based detection systems (using CPUs/GPUs) suffer from high power consumption, processing latency, and bulky hardware, making them unsuitable for continuous, battery-operated wearable monitoring. There is a need for a dedicated hardware solution that can perform continuous monitoring with high deterministic speed and low power.

## 4. Proposed Methodology
The project employs a custom digital logic design using Verilog HDL, implementing a **Sliding Window Spike Counter** algorithm. 
- **Data Acquisition:** Real patient EEG data is sourced from the CHB-MIT Scalp EEG Database and quantized into 16-bit fixed-point test vectors.
- **Algorithm Execution:** The FPGA continuously processes the incoming samples at a biological rate of 256 Hz. It applies an amplitude threshold (±200 μV) to identify abnormal neural spikes.
- **Temporal Windowing:** A 512-sample (2-second) sliding window continuously tracks the spike count. If the accumulated spikes exceed the threshold of 25 within the window, a seizure is officially flagged.
- **Hardware Mapping:** The algorithm is synthesized and deployed onto the Xilinx Artix-7 FPGA, utilizing Block RAM for data storage and custom clock dividers for accurate sample timing.

## 5. Hardware & Software Requirements
**Hardware Requirements:**
- Digilent Basys 3 FPGA Trainer Board (Xilinx Artix-7 xc7a35tcpg236-1)
- Micro-USB Cable (for programming and power)
- Modern PC for synthesis and simulation

**Software Requirements:**
- Xilinx Vivado ML Edition (for Synthesis, Implementation, and Bitstream generation)
- Python 3.x (with `mne` and `numpy` libraries for initial EEG data extraction)
- Verilog HDL (Hardware Description Language)

## 6. Expected Outcomes and Results
The system has been successfully verified through both behavioral simulation (XSim) and physical hardware deployment. Testing against a 5-minute EEG recording containing both normal activity and a 40-second seizure event demonstrated:
- **Accuracy:** 100% detection rate of the seizure event.
- **Reliability:** Zero false positives during normal, inter-ictal brain activity.
- **Efficiency:** The design consumes less than 3% of the available Artix-7 logic resources, proving its extreme lightweight nature and suitability for edge-computing medical devices.
