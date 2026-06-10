`timescale 1ns / 1ps
// ============================================================================
// seven_seg_mux.v
// 7-Segment Display Multiplexer
//
// Takes four 4-bit BCD digits and multiplexes them onto the Basys 3's
// 4-digit 7-segment display at a high refresh rate (~1 kHz).
// ============================================================================

module seven_seg_mux(
    input  wire        clk,        // 100 MHz board clock
    input  wire [3:0]  thou,
    input  wire [3:0]  hund,
    input  wire [3:0]  tens,
    input  wire [3:0]  ones,
    output reg  [3:0]  an,         // Anodes (Active LOW on Basys 3)
    output reg  [6:0]  seg         // Cathodes (Active LOW on Basys 3)
);

    // ========================================================================
    // Clock Divider for ~1 kHz refresh rate
    // 100,000,000 / 100,000 = 1,000 Hz
    // ========================================================================
    reg [16:0] refresh_counter = 0;
    wire [1:0] led_activating_counter;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end

    // Use top 2 bits of counter to select active digit (0,1,2,3)
    assign led_activating_counter = refresh_counter[16:15];

    // ========================================================================
    // Anode Control and Digit Selection
    // ========================================================================
    reg [3:0] current_digit;

    always @(*) begin
        case(led_activating_counter)
            2'b00: begin
                an = 4'b0111;      // Activate left-most digit (Thousands)
                current_digit = thou;
            end
            2'b01: begin
                an = 4'b1011;      // Activate second digit (Hundreds)
                current_digit = hund;
            end
            2'b10: begin
                an = 4'b1101;      // Activate third digit (Tens)
                current_digit = tens;
            end
            2'b11: begin
                an = 4'b1110;      // Activate right-most digit (Ones)
                current_digit = ones;
            end
        endcase
    end

    // ========================================================================
    // 7-Segment Decoder (Cathode Control)
    // Segments ordered: g f e d c b a (Active LOW)
    // ========================================================================
    always @(*) begin
        case(current_digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111; // Turn all off if invalid
        endcase
    end

endmodule
