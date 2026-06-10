`timescale 1ns / 1ps

module top_seizure_det(
    input wire clk,
    input wire rst,
    input wire signed [15:0] eeg_data_in, // 16-bit incoming data from the brain
    input wire data_valid,                // Signal indicating new data is valid
    output reg         seizure_detected,          // Final classification output (1 = seizure, 0 = normal)
    output reg [9:0]   spike_count                // Exposed for 7-segment display
);

    // Algorithm Parameters
    parameter WINDOW_SIZE = 512;       // 2 seconds worth of data sampled at 256 Hz
    parameter THRESHOLD_SPIKES = 25;   // Trigger alarm if 25 spikes occur within the 2 seconds
    
    // Stateful Registers for the Sliding Time Window algorithm
    reg [WINDOW_SIZE-1:0] spike_history;
    
    // Combinational logic: Check if the current single data point is an abnormal spike
    wire current_spike;
    assign current_spike = (eeg_data_in > 16'sd200 || eeg_data_in < -16'sd200) ? 1'b1 : 1'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            seizure_detected <= 1'b0;
            spike_history <= 0;
            spike_count <= 0;
        end else begin
            if (data_valid) begin
                // 1. Shift the new spike into our 2-second history buffer
                spike_history <= {spike_history[WINDOW_SIZE-2:0], current_spike};
                
                // 2. Fast Adder: Keep a running total instead of iterating through 512 elements
                // New total = Old total + new incoming spike - oldest spike falling out
                spike_count <= spike_count + current_spike - spike_history[WINDOW_SIZE-1];
                
                // 3. Evaluate the Seizure condition based on the accumulated total
                // We use the "future" state of spike_count to react immediately
                if ((spike_count + current_spike - spike_history[WINDOW_SIZE-1]) >= THRESHOLD_SPIKES) begin
                    seizure_detected <= 1'b1;
                end else begin
                    seizure_detected <= 1'b0;
                end
            end
        end
    end

endmodule
