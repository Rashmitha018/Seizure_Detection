`timescale 1ns / 1ps
// ============================================================================
// uart_controller.v
// Orchestrates sending the 4-byte data packet over UART every time
// a new EEG sample is valid (at 256 Hz).
//
// Packet Format:
// Byte 1: 0xA5 (Sync Byte)
// Byte 2: eeg_data[15:8]
// Byte 3: eeg_data[7:0]
// Byte 4: {7'b0, seizure_detected}
// ============================================================================

module uart_controller(
    input  wire        clk,
    input  wire        rst,
    input  wire        data_valid,
    input  wire [15:0] eeg_data,
    input  wire        seizure_detected,
    output wire        tx_out
);

    reg  [7:0] tx_data_in;
    reg        tx_start;
    wire       tx_done;
    wire       tx_active;

    uart_tx tx_mod (
        .clk(clk),
        .rst(rst),
        .tx_data(tx_data_in),
        .tx_start(tx_start),
        .tx_active(tx_active),
        .tx_out(tx_out),
        .tx_done(tx_done)
    );

    parameter IDLE   = 3'd0;
    parameter WAIT1  = 3'd1;
    parameter WAIT2  = 3'd2;
    parameter WAIT3  = 3'd3;
    parameter WAIT4  = 3'd4;
    parameter FINISH = 3'd5;

    reg [2:0] state = IDLE;
    
    // Edge detection for data_valid
    reg data_valid_d = 0;
    wire data_valid_edge = data_valid && !data_valid_d;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            tx_start <= 0;
            data_valid_d <= 0;
        end else begin
            data_valid_d <= data_valid;
            tx_start <= 0; // Default to not starting
            
            case (state)
                IDLE: begin
                    if (data_valid_edge) begin
                        tx_data_in <= 8'hA5; // Sync Byte
                        tx_start <= 1;
                        state <= WAIT1;
                    end
                end
                
                WAIT1: begin
                    if (tx_done) begin
                        tx_data_in <= eeg_data[15:8]; // High Byte
                        tx_start <= 1;
                        state <= WAIT2;
                    end
                end
                
                WAIT2: begin
                    if (tx_done) begin
                        tx_data_in <= eeg_data[7:0]; // Low Byte
                        tx_start <= 1;
                        state <= WAIT3;
                    end
                end
                
                WAIT3: begin
                    if (tx_done) begin
                        tx_data_in <= {7'b0, seizure_detected}; // Flag Byte
                        tx_start <= 1;
                        state <= WAIT4;
                    end
                end
                
                WAIT4: begin
                    if (tx_done) begin
                        state <= FINISH;
                    end
                end
                
                FINISH: begin
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
