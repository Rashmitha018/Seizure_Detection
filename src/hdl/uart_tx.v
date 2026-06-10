`timescale 1ns / 1ps
// ============================================================================
// uart_tx.v
// Basic UART Transmitter
// Configured for 115200 baud at 100 MHz clock
// ============================================================================

module uart_tx(
    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] tx_data,
    input  wire       tx_start,
    output reg        tx_active,
    output reg        tx_out,
    output reg        tx_done
);

    // 100,000,000 / 115200 = 868.05
    parameter CLKS_PER_BIT = 868;

    parameter s_IDLE         = 3'b000;
    parameter s_TX_START_BIT = 3'b001;
    parameter s_TX_DATA_BITS = 3'b010;
    parameter s_TX_STOP_BIT  = 3'b011;
    parameter s_CLEANUP      = 3'b100;

    reg [2:0]  state = 0;
    reg [9:0]  clk_count = 0;
    reg [2:0]  bit_index = 0;
    reg [7:0]  tx_data_reg = 0;

    always @(posedge clk) begin
        if (rst) begin
            state <= s_IDLE;
            clk_count <= 0;
            bit_index <= 0;
            tx_out <= 1'b1; // Idle state is high
            tx_done <= 1'b0;
            tx_active <= 1'b0;
        end else begin
            case (state)
                s_IDLE: begin
                    tx_out <= 1'b1;
                    tx_done <= 1'b0;
                    clk_count <= 0;
                    bit_index <= 0;

                    if (tx_start) begin
                        tx_active <= 1'b1;
                        tx_data_reg <= tx_data;
                        state <= s_TX_START_BIT;
                    end else begin
                        tx_active <= 1'b0;
                    end
                end

                s_TX_START_BIT: begin
                    tx_out <= 1'b0; // Start bit is low
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        state <= s_TX_DATA_BITS;
                    end
                end

                s_TX_DATA_BITS: begin
                    tx_out <= tx_data_reg[bit_index];
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 0;
                            state <= s_TX_STOP_BIT;
                        end
                    end
                end

                s_TX_STOP_BIT: begin
                    tx_out <= 1'b1; // Stop bit is high
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        tx_done <= 1'b1;
                        state <= s_CLEANUP;
                    end
                end

                s_CLEANUP: begin
                    tx_done <= 1'b0;
                    tx_active <= 1'b0;
                    state <= s_IDLE;
                end
                
                default: state <= s_IDLE;
            endcase
        end
    end
endmodule
