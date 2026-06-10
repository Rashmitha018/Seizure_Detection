`timescale 1ns / 1ps

module tb_seizure_det();

    // Replicate module inputs as registers
    reg clk;
    reg rst;
    reg signed [15:0] eeg_data_in;
    reg data_valid;

    // Replicate module outputs as wires
    wire seizure_detected;

    // Instantiate the Unit Under Test (UUT)
    top_seizure_det uut (
        .clk(clk),
        .rst(rst),
        .eeg_data_in(eeg_data_in),
        .data_valid(data_valid),
        .seizure_detected(seizure_detected)
    );

    // Memory array to hold the test inputs from Python
    // We generated 76801 samples (5 minutes of data) in the python script.
    reg [15:0] test_memory [0:76800]; 
    integer i;
    
    // Generate a 100MHz clock (Typical for Basys 3 FPGA)
    always #5 clk = ~clk;

    initial begin
        // 1. Initialize Inputs
        clk = 0;
        rst = 1;
        eeg_data_in = 0;
        data_valid = 0;

        // 2. Load the Hex file into our memory array
        // NOTE: Make sure the path matches where the hex file is!
        // Vivado simulator can read forward slashes usually without issues.
        $readmemh("C:/Users/Test/Desktop/MP/dataset/FPGA_test_vectors/test_input.hex", test_memory);
        
        // 3. Keep system in reset for 100ns, then lift reset
        #100;
        rst = 0;
        #100;

        // 4. Stream the EEG data from memory into the module
        // We will push one sample into the module at a time.
        for (i = 0; i < 76801; i = i + 1) begin
            // Wait for next clock edge
            @(posedge clk);
            eeg_data_in = test_memory[i];
            data_valid = 1;
            
            // Hold for 1 clock cycle
            @(posedge clk);
            data_valid = 0;
            
            // Wait some simulated time before sending the next sample
            // (Real time in hardware would be 3.9ms apart for 256Hz, but for
            // fast simulation we can fire them off rapidly to check logic).
            #40; 
        end

        // 5. End Simulation
        #200;
        $display("Simulation Finished.");
        $finish;
    end

endmodule
