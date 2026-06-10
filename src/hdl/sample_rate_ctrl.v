`timescale 1ns / 1ps
// ============================================================================
// sample_rate_ctrl.v
// Sample Rate Controller — generates 256 Hz data_valid pulses from 100 MHz
//
// The Basys 3 board runs at 100 MHz, but EEG data was sampled at 256 Hz.
// This module divides the clock to produce a single-cycle pulse every
// 390,625 clock cycles (100,000,000 / 256 = 390,625), matching the
// biological sample rate.
//
// It also drives the memory address counter that steps through the BRAM.
//
// Target: Xilinx Artix-7 xc7a35tcpg236-1 (Basys 3)
// ============================================================================

module sample_rate_ctrl #(
    parameter CLK_FREQ   = 100_000_000,  // 100 MHz board clock
    parameter SAMPLE_RATE = 256,          // EEG sample rate in Hz
    parameter MEM_DEPTH  = 76801,         // Total samples in BRAM
    parameter ADDR_W     = 17             // Address width
)(
    input  wire              clk,
    input  wire              rst,
    input  wire              loop_en,      // SW[1]: 1 = loop, 0 = stop at end
    output reg               data_valid,   // Single-cycle 256 Hz pulse
    output reg  [ADDR_W-1:0] sample_addr,  // Current BRAM read address
    output reg               done          // HIGH when all samples played (non-loop)
);

    // Division factor: how many 100 MHz clocks per 256 Hz tick
    // 100,000,000 / 256 = 390,625
    localparam integer DIV_COUNT = CLK_FREQ / SAMPLE_RATE;
    
    // Counter needs ceil(log2(390625)) = 19 bits
    reg [18:0] clk_counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_counter <= 0;
            sample_addr <= 0;
            data_valid  <= 1'b0;
            done        <= 1'b0;
        end else begin
            // Default: data_valid is only high for 1 clock cycle
            data_valid <= 1'b0;
            
            if (!done) begin
                if (clk_counter == DIV_COUNT - 1) begin
                    // Time to send the next sample
                    clk_counter <= 0;
                    data_valid  <= 1'b1;
                    
                    // Advance to next sample address
                    if (sample_addr == MEM_DEPTH - 1) begin
                        // Reached end of recording
                        if (loop_en) begin
                            // Loop mode: wrap back to the beginning
                            sample_addr <= 0;
                        end else begin
                            // Single-run mode: stop and signal done
                            done <= 1'b1;
                        end
                    end else begin
                        sample_addr <= sample_addr + 1;
                    end
                end else begin
                    clk_counter <= clk_counter + 1;
                end
            end
        end
    end

endmodule
