`timescale 1ns / 1ps
// ============================================================================
// eeg_bram.v
// Synthesizable Block RAM module for EEG test vector storage.
//
// This module infers Block RAM on the Artix-7 FPGA and is initialized
// from the test_input.hex file at synthesis time. It acts as a read-only
// ROM that the sample_rate_ctrl addresses sequentially.
//
// Target: Xilinx Artix-7 xc7a35tcpg236-1 (Basys 3)
// BRAM Usage: ~34 of 50 available 36Kb Block RAMs
// ============================================================================

module eeg_bram #(
    parameter MEM_DEPTH = 76801,  // Number of 16-bit EEG samples
    parameter ADDR_W    = 17      // Address width: ceil(log2(76801)) = 17
)(
    input  wire              clk,
    input  wire [ADDR_W-1:0] addr,
    output reg  [15:0]       data_out
);

    // Declare the RAM array — Vivado will infer this as Block RAM
    // The rom_style attribute ensures Vivado maps this to BRAM, not LUTs
    (* rom_style = "block" *) reg [15:0] mem [0:MEM_DEPTH-1];

    // Initialize the memory from the hex file at synthesis/elaboration time
    // IMPORTANT: Update this path to match your project's file location.
    // Vivado resolves this relative to the project directory during synthesis.
    // You can also add the .hex file as a "Memory Initialization File" in
    // Vivado's source settings for the project.
    initial begin
        // Use absolute path to ensure Vivado finds it during synthesis
        $readmemh("C:/Users/Test/Desktop/MP/dataset/FPGA_test_vectors/test_input.hex", mem);
    end

    // Synchronous read — standard Block RAM inference pattern
    always @(posedge clk) begin
        data_out <= mem[addr];
    end

endmodule
