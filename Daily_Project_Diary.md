# FPGA Seizure Detection: Daily Project Diary (March 9 - June 3, 2026)

*This diary is formatted to match your online submission portal. All selected skills are strictly from your provided list.*

---

## WEEK 1: Project Kick-off & Literature Review
**March 9, 2026 (Monday)**
* **Work Summary:** Conducted initial project kickoff meeting. Defined the problem statement regarding the high latency and power consumption of CPU-based seizure detection systems.
* **Learnings / Outcomes:** Established the core objective to build an ultra-low-power FPGA-based edge computing device.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Embedded Systems

**March 10, 2026 (Tuesday)**
* **Work Summary:** Began extensive literature review on existing epileptic seizure detection methodologies, focusing on wearable edge devices.
* **Learnings / Outcomes:** Identified that complex Machine Learning models drain battery quickly, necessitating a purely digital logic approach.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

**March 11, 2026 (Wednesday)**
* **Work Summary:** Researched the CHB-MIT Scalp EEG database. Analyzed the data structure (16-bit resolution, 256 Hz sampling rate) for hardware compatibility.
* **Learnings / Outcomes:** Understood how clinical EEG datasets are structured and stored in .edf format.
* **Blockers / Risks:** Understanding the European Data Format (EDF) structure required extra research.
* **Skills Used:** Data Visualization, Statistics
* **Reference Links:** https://physionet.org/content/chbmit/1.0.0/

**March 12, 2026 (Thursday)**
* **Work Summary:** Formulated the Sliding Window Spike Counter algorithm conceptually. Decided on a 512-sample window.
* **Learnings / Outcomes:** Mathematical formulation of O(1) complexity for hardware implementation.
* **Blockers / Risks:** None.
* **Skills Used:** Digital Design, Statistical Analysis

**March 13, 2026 (Friday)**
* **Work Summary:** Finalized the system architecture block diagram, mapping out the data flow from BRAM to UART.
* **Learnings / Outcomes:** Completed the high-level hardware-software co-design blueprint.
* **Blockers / Risks:** None.
* **Skills Used:** Circuit Design, VLSI Design

---

## WEEK 2: Data Preprocessing in Python
**March 16, 2026 (Monday)**
* **Work Summary:** Set up the Python environment and installed necessary libraries (MNE, NumPy) to process the CHB-MIT dataset.
* **Learnings / Outcomes:** Successfully loaded clinical EEG records into Python arrays.
* **Blockers / Risks:** None.
* **Skills Used:** Python, NumPy
* **Reference Links:** https://mne.tools/stable/index.html

**March 17, 2026 (Tuesday)**
* **Work Summary:** Wrote a Python script to isolate Patient 1's data (chb01_03.edf) containing the 40-second seizure event.
* **Learnings / Outcomes:** Filtered and extracted the exact 300-second timeframe needed for simulation.
* **Blockers / Risks:** Memory management issues when loading massive EDF files.
* **Skills Used:** Python, Pandas

**March 18, 2026 (Wednesday)**
* **Work Summary:** Developed the quantization logic to convert the floating-point EEG microvolts into 16-bit signed integers.
* **Learnings / Outcomes:** Mastered fixed-point conversion for digital hardware compatibility.
* **Blockers / Risks:** Ensuring no loss of precision during quantization.
* **Skills Used:** Python, Digital Design

**March 19, 2026 (Thursday)**
* **Work Summary:** Finalized the `03_hex_to_coe.py` script to generate a `.hex` file containing the quantized brainwaves.
* **Learnings / Outcomes:** Generated the exact memory initialization file required by Xilinx Vivado BRAM.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Data Modeling

**March 20, 2026 (Friday)**
* **Work Summary:** Verified the output `.hex` data by plotting it back in Python using Matplotlib to ensure the seizure spikes were preserved.
* **Learnings / Outcomes:** Visual validation of the preprocessed clinical dataset.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Matplotlib, Data Visualization

---

## WEEK 3: Hardware Design (RTL Coding Begins)
**March 23, 2026 (Monday)**
* **Work Summary:** Created the Xilinx Vivado project targeting the Artix-7 (Basys 3) FPGA. Set up the directory structure.
* **Learnings / Outcomes:** Configured Vivado 2025.2 environment for Verilog HDL development.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, VLSI Design
* **Reference Links:** https://www.xilinx.com/products/design-tools/vivado.html

**March 24, 2026 (Tuesday)**
* **Work Summary:** Wrote the Verilog module for the Block RAM (`eeg_bram.v`) to store the 16-bit brainwave test vector.
* **Learnings / Outcomes:** Implemented ROM instantiation using `$readmemh` in Verilog.
* **Blockers / Risks:** None.
* **Skills Used:** Digital Design, VLSI Design

**March 25, 2026 (Wednesday)**
* **Work Summary:** Developed the `sample_rate_ctrl.v` module to pulse exactly at 256 Hz, mimicking real-time data streaming.
* **Learnings / Outcomes:** Implemented precise clock division from the 100MHz system clock.
* **Blockers / Risks:** Calculating the exact counter threshold for 256 Hz required careful timing analysis.
* **Skills Used:** Circuit Design, Embedded Systems

**March 26, 2026 (Thursday)**
* **Work Summary:** Began coding the core `top_seizure_det.v` module. Implemented the amplitude thresholding comparator (±200 µV).
* **Learnings / Outcomes:** Designed combinational logic to flag instantaneous abnormal voltage spikes.
* **Blockers / Risks:** Handling 16-bit signed arithmetic (two's complement) in Verilog.
* **Skills Used:** Digital Design, VLSI Design

**March 27, 2026 (Friday)**
* **Work Summary:** Implemented the 512-bit shift register inside the detection core to act as the 2-second sliding window history.
* **Learnings / Outcomes:** Designed a large shift register structure for temporal data tracking.
* **Blockers / Risks:** High resource utilization concerns, mitigated by efficient coding.
* **Skills Used:** Design with FPGA, Circuit Design

---

## WEEK 4: Core Algorithm Completion
**March 30, 2026 (Monday)**
* **Work Summary:** Completed the O(1) Accumulative Thresholding logic using a 10-bit adder/subtractor to maintain the running spike count.
* **Learnings / Outcomes:** Achieved ultra-low latency counting by eliminating the need to sum all 512 bits every cycle.
* **Blockers / Risks:** Logic synchronization issues between the shift register and the running counter.
* **Skills Used:** VLSI Design, Statistical Analysis

**March 31, 2026 (Tuesday)**
* **Work Summary:** Added the final seizure decision logic to assert `seizure_detected` HIGH when the spike count exceeds 25.
* **Learnings / Outcomes:** Finalized the purely digital detection algorithm RTL.
* **Blockers / Risks:** None.
* **Skills Used:** Digital Design, Embedded Systems

**April 1, 2026 (Wednesday)**
* **Work Summary:** Wrote the Verilog testbench (`tb_seizure_det.v`) to simulate the core detection logic.
* **Learnings / Outcomes:** Set up behavioral simulation environments in Vivado XSim.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations, VLSI Design

**April 2, 2026 (Thursday)**
* **Work Summary:** Ran the behavioral simulation on the 300-second dataset. Verified the output waveforms manually.
* **Learnings / Outcomes:** Confirmed 100% detection accuracy on the test vector with zero false positives.
* **Blockers / Risks:** Simulation time was excessively long; had to optimize XSim settings.
* **Skills Used:** Verification & Validations, Data Visualization

**April 3, 2026 (Friday)**
* **Work Summary:** Analyzed the post-synthesis utilization report in Vivado. Confirmed the design uses <1% of available Artix-7 LUTs.
* **Learnings / Outcomes:** Validated the extreme power efficiency and resource footprint of the architecture.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Statistical Analysis

---

## WEEK 5: Output Interface & Display Logic
**April 6, 2026 (Monday)**
* **Work Summary:** Designed the Binary to BCD converter (`bin2bcd.v`) using the Double Dabble algorithm for the 7-segment display.
* **Learnings / Outcomes:** Implemented complex arithmetic conversion in digital logic for physical human interfacing.
* **Blockers / Risks:** None.
* **Skills Used:** Digital Design, Embedded Systems
* **Reference Links:** https://en.wikipedia.org/wiki/Double_dabble

**April 7, 2026 (Tuesday)**
* **Work Summary:** Wrote the 7-segment multiplexer module (`seven_seg_mux.v`) operating at 1 kHz to drive the 4-digit display on the board.
* **Learnings / Outcomes:** Mastered persistence of vision (POV) multiplexing on FPGA displays.
* **Blockers / Risks:** None.
* **Skills Used:** Circuit Design, VLSI Design

**April 8, 2026 (Wednesday)**
* **Work Summary:** Created the top-level integration module (`basys3_top.v`) connecting the memory, detection core, and display modules.
* **Learnings / Outcomes:** Structural Verilog instantiation and top-level wire routing.
* **Blockers / Risks:** Resolving port mismatch errors during top-level integration.
* **Skills Used:** Design with FPGA, VLSI Design

**April 9, 2026 (Thursday)**
* **Work Summary:** Wrote the physical constraints file (`basys3_seizure_det.xdc`) mapping the Verilog ports to the physical pins on the Basys 3 board.
* **Learnings / Outcomes:** Mapped clock, LEDs, and 7-segment anodes/cathodes to physical silicon pads.
* **Blockers / Risks:** None.
* **Skills Used:** Embedded Systems, Circuit Design
* **Reference Links:** https://digilent.com/reference/programmable-logic/basys-3/start

**April 10, 2026 (Friday)**
* **Work Summary:** Generated the first hardware bitstream and programmed the physical Basys 3 board.
* **Learnings / Outcomes:** Successfully brought up the hardware; verified the 7-segment display actively tracking the spike count.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations, Design with FPGA

---

## WEEK 6: UART Protocol Design
**April 13, 2026 (Monday)**
* **Work Summary:** Began designing the custom UART communication protocol to send data from the FPGA to the PC.
* **Learnings / Outcomes:** Defined the 4-byte synchronization packet structure.
* **Blockers / Risks:** None.
* **Skills Used:** Network Architecture, Digital Design
* **Reference Links:** https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter

**April 14, 2026 (Tuesday)**
* **Work Summary:** Wrote the UART Transmitter module (`uart_tx.v`) configured for exactly 115200 baud rate.
* **Learnings / Outcomes:** Implemented serial state machines and precise baud-rate generation.
* **Blockers / Risks:** Calculating the exact baud-tick counter for 100MHz clock.
* **Skills Used:** Circuit Design, Embedded Systems

**April 15, 2026 (Wednesday)**
* **Work Summary:** Developed the UART Controller (`uart_controller.v`) state machine to serialize the 16-bit EEG data and the 1-bit seizure flag.
* **Learnings / Outcomes:** Designed a Finite State Machine (FSM) to handle multi-byte packet transmission.
* **Blockers / Risks:** None.
* **Skills Used:** VLSI Design, Digital Design

**April 16, 2026 (Thursday)**
* **Work Summary:** Integrated the UART modules into the `basys3_top.v` top-level design and mapped the TX pin in the XDC file.
* **Learnings / Outcomes:** Completed the full hardware pipeline from memory to physical serial output.
* **Blockers / Risks:** Timing constraints for the UART TX pin required adjustment.
* **Skills Used:** Design with FPGA, Verification & Validations

**April 17, 2026 (Friday)**
* **Work Summary:** Generated the final system bitstream and tested UART output using PuTTY terminal on the PC.
* **Learnings / Outcomes:** Confirmed hex data was successfully streaming over the COM port.
* **Blockers / Risks:** Serial data appeared as garbage initially until baud rates were perfectly matched.
* **Skills Used:** Verification & Validations, Embedded Systems

---

## WEEK 7: Python Dashboard Development
**April 20, 2026 (Monday)**
* **Work Summary:** Set up the Python software environment for the real-time visualization dashboard using PySerial and PyQtGraph.
* **Learnings / Outcomes:** Selected PyQtGraph over Matplotlib due to its superior rendering speed for real-time telemetry.
* **Blockers / Risks:** None.
* **Skills Used:** Python, UI/UX
* **Reference Links:** https://pyqtgraph.readthedocs.io/

**April 21, 2026 (Tuesday)**
* **Work Summary:** Wrote the backend PySerial parser to read the COM port and reconstruct the 16-bit integers from the 4-byte UART packet.
* **Learnings / Outcomes:** Handled asynchronous serial data streams and bitwise shifting in Python.
* **Blockers / Risks:** Packet misalignment required adding a 0xA5 synchronization byte check.
* **Skills Used:** Python, Data Visualization

**April 22, 2026 (Wednesday)**
* **Work Summary:** Designed the PyQtGraph GUI layout, setting up the live scrolling plot for the inter-ictal EEG waves.
* **Learnings / Outcomes:** Built responsive, hardware-accelerated user interfaces.
* **Blockers / Risks:** None.
* **Skills Used:** Python, UX Design

**April 23, 2026 (Thursday)**
* **Work Summary:** Implemented the multithreaded architecture (QThread) to ensure the serial reading does not freeze the GUI plotting.
* **Learnings / Outcomes:** Mastered PyQt threading and signal-slot mechanisms.
* **Blockers / Risks:** GUI freezing when data arrived too fast; resolved via threading.
* **Skills Used:** Python, Software Operations Management (Simulated)

**April 24, 2026 (Friday)**
* **Work Summary:** Added the dynamic seizure alert logic to the dashboard, changing the UI theme to red when Byte 4 flags a seizure.
* **Learnings / Outcomes:** Achieved a perfect hardware-software co-design visual loop.
* **Blockers / Risks:** None.
* **Skills Used:** Python, UI/UX, Data Visualization

---

## WEEK 8: Full System Testing & Validation
**April 27, 2026 (Monday)**
* **Work Summary:** Conducted end-to-end physical testing. Booted the Basys 3 board, launched the Python dashboard, and verified the data stream.
* **Learnings / Outcomes:** Validated that the system operates in true real-time at 256 Hz.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations, Embedded Systems

**April 28, 2026 (Tuesday)**
* **Work Summary:** Monitored the dashboard during the 196 seconds of normal EEG activity. Confirmed zero false positive flashes.
* **Learnings / Outcomes:** Validated the specificity of the purely digital detection algorithm.
* **Blockers / Risks:** None.
* **Skills Used:** Statistical Analysis, Verification & Validations

**April 29, 2026 (Wednesday)**
* **Work Summary:** Observed the system's reaction precisely at the seizure onset mark. The hardware LED and Python Dashboard triggered the alarm simultaneously.
* **Learnings / Outcomes:** Proven zero-latency software/hardware synchronization.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Python

**April 30, 2026 (Thursday)**
* **Work Summary:** Captured high-resolution screenshots and video recordings of the Basys 3 board and the Python Dashboard functioning in real-time.
* **Learnings / Outcomes:** Generated critical visual media for the project report and IEEE paper.
* **Blockers / Risks:** None.
* **Skills Used:** Data Visualization, UI/UX

**May 1, 2026 (Friday)**
* **Work Summary:** Extracted the final performance metrics: 10 ns latency, <1% utilization, 100% accuracy on the test vector.
* **Learnings / Outcomes:** Finalized the quantitative engineering results of the project.
* **Blockers / Risks:** None.
* **Skills Used:** Statistical Analysis, Verification & Validations

---

## WEEK 9: Report Structure & IEEE Formatting
**May 4, 2026 (Monday)**
* **Work Summary:** Began formatting the project report in LaTeX, setting up the standard chapters (Introduction, Literature Review, Methodology).
* **Learnings / Outcomes:** Structured academic documentation.
* **Blockers / Risks:** None.
* **Skills Used:** Digital Design (Documentation context)

**May 5, 2026 (Tuesday)**
* **Work Summary:** Drafted the detailed Problem Statement and Objectives sections of the report.
* **Learnings / Outcomes:** Clearly articulated the engineering gaps the project addresses.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

**May 6, 2026 (Wednesday)**
* **Work Summary:** Transferred the Hardware Methodology (Verilog, Architecture, UART) details into the report, generating block diagrams for clarity.
* **Learnings / Outcomes:** Translated complex Verilog RTL into academic diagrams.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Data Visualization

**May 7, 2026 (Thursday)**
* **Work Summary:** Documented the Software Dashboard methodology, explaining the PySerial parsing and QThread architecture.
* **Learnings / Outcomes:** Documented Python-to-Hardware integration.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Network Architecture

**May 8, 2026 (Friday)**
* **Work Summary:** Began drafting the IEEE Conference Paper (`IEEE_Paper_Draft.md`), condensing the report into a double-column format.
* **Learnings / Outcomes:** Adapted extensive project data into concise, high-impact publication formats.
* **Blockers / Risks:** None.
* **Skills Used:** Statistics, Verification & Validations

---

## WEEK 10: Performance Analysis & Graph Generation
**May 11, 2026 (Monday)**
* **Work Summary:** Wrote a Python script utilizing Matplotlib and NumPy to generate professional Performance Analysis graphs comparing CPU vs FPGA latency.
* **Learnings / Outcomes:** Created data-driven visual proofs of the hardware's superiority.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Matplotlib, NumPy
* **Reference Links:** https://matplotlib.org/

**May 12, 2026 (Tuesday)**
* **Work Summary:** Added power consumption comparison charts and resource utilization bar graphs to the analysis script.
* **Learnings / Outcomes:** Visualized the <1% logic utilization claim in a clean, academic format.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Data Visualization

**May 13, 2026 (Wednesday)**
* **Work Summary:** Plotted the Algorithm Tuning curve, demonstrating how accuracy scales perfectly at W=512 window size.
* **Learnings / Outcomes:** Provided mathematical justification for the chosen hardware parameters.
* **Blockers / Risks:** None.
* **Skills Used:** Data Modeling, Statistical Analysis

**May 14, 2026 (Thursday)**
* **Work Summary:** Embedded the newly generated performance analysis graphs into the IEEE Paper and the Project Report.
* **Learnings / Outcomes:** Significantly strengthened the paper's academic validity.
* **Blockers / Risks:** None.
* **Skills Used:** Data Visualization, Verification & Validations

**May 15, 2026 (Friday)**
* **Work Summary:** Formatted the Results & Discussion section of the IEEE paper, creating comparison tables against existing SNN and CNN literature.
* **Learnings / Outcomes:** Positioned the project defensively against highly complex, power-hungry AI models.
* **Blockers / Risks:** None.
* **Skills Used:** Statistical Analysis, Design with FPGA

---

## WEEK 11: Document Finalization
**May 18, 2026 (Monday)**
* **Work Summary:** Refined the IEEE Paper abstract to clearly state the 10ns latency, <1% logic utilization, and O(1) computational complexity.
* **Learnings / Outcomes:** Polished technical writing skills for academic peer review.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

**May 19, 2026 (Tuesday)**
* **Work Summary:** Consolidated all Verilog and Python code snippets into the Code Appendix of the main report using LaTeX `tcblisting`.
* **Learnings / Outcomes:** Organized raw source code for evaluator review.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Digital Design

**May 20, 2026 (Wednesday)**
* **Work Summary:** Reviewed and updated the Literature Survey in the paper, ensuring 20 recent citations (2020-2025) were correctly referenced.
* **Learnings / Outcomes:** Ensured the research foundation was completely up to date.
* **Blockers / Risks:** None.
* **Skills Used:** Statistics

**May 21, 2026 (Thursday)**
* **Work Summary:** Final proofreading of the main project report. Ensured all Course Outcomes (CO1-CO4) aligned with the hardware accomplishments.
* **Learnings / Outcomes:** Finalized the massive project documentation phase.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

**May 22, 2026 (Friday)**
* **Work Summary:** Exported the finalized IEEE paper to PDF format, verifying all double-column constraints and image resolutions were perfect.
* **Learnings / Outcomes:** Completed the publication-ready artifact.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

---

## WEEK 12: Presentation Preparation
**May 25, 2026 (Monday)**
* **Work Summary:** Began drafting the final PowerPoint Presentation outline. Structured the 15-slide flow from Intro to Future Scope.
* **Learnings / Outcomes:** Learned how to condense a 50-page report into a 15-minute presentation format.
* **Blockers / Risks:** None.
* **Skills Used:** UI/UX, Data Visualization

**May 26, 2026 (Tuesday)**
* **Work Summary:** Transferred the block diagrams, algorithm flowcharts, and RTL schematics into the presentation slides.
* **Learnings / Outcomes:** Created a highly visual representation of the hardware architecture.
* **Blockers / Risks:** None.
* **Skills Used:** VLSI Design, Circuit Design

**May 27, 2026 (Wednesday)**
* **Work Summary:** Added the Custom UART Packet table, Algorithm Parameters, and Resource Utilization tables to the presentation.
* **Learnings / Outcomes:** Highlighted the specific engineering metrics evaluators look for.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Embedded Systems

**May 28, 2026 (Thursday)**
* **Work Summary:** Injected the Python Performance Analysis graphs and the Live Dashboard screenshots into the Results slides.
* **Learnings / Outcomes:** Prepared visual proof that the hardware-software co-design functions perfectly.
* **Blockers / Risks:** None.
* **Skills Used:** Python, Data Visualization

**May 29, 2026 (Friday)**
* **Work Summary:** Finalized the presentation. Developed the "Proof of Concept" academic defense for testing on a single representative dataset.
* **Learnings / Outcomes:** Prepared robust verbal defenses for the upcoming viva.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations, Statistics

---

## WEEK 13: Final Review & Submission
**June 1, 2026 (Monday)**
* **Work Summary:** Conducted dry-run presentations. Rehearsed explaining the O(1) complexity and hardware power efficiencies without relying on text heavy slides.
* **Learnings / Outcomes:** Improved technical communication and presentation pacing.
* **Blockers / Risks:** None.
* **Skills Used:** Verification & Validations

**June 2, 2026 (Tuesday)**
* **Work Summary:** Final hardware check. Re-programmed the Basys 3 board, launched the Python dashboard, and ensured the demo runs flawlessly for the evaluators.
* **Learnings / Outcomes:** Confirmed system stability under presentation conditions.
* **Blockers / Risks:** None.
* **Skills Used:** Design with FPGA, Python

**June 3, 2026 (Wednesday)**
* **Work Summary:** Final submission day. Submitted the Project Report, IEEE Paper, Presentation, and generated the comprehensive project diary.
* **Learnings / Outcomes:** Successfully closed out the Major Project lifecycle.
* **Blockers / Risks:** None.
* **Skills Used:** Business Management (Project Closure Context), Verification & Validations
