`timescale 1ns / 1ps
// ============================================================================
// led_blink_test.v
// "Hello World" for the Basys 3 — blinks all 16 LEDs at ~1 Hz
//
// Purpose: Verify that:
//   1. Vivado synthesis/implementation/bitstream flow works
//   2. USB programming cable is connected and working
//   3. FPGA board is functional
//
// Once this works, you're ready to load the full seizure detection design!
//
// Target: Xilinx Artix-7 xc7a35tcpg236-1 (Basys 3)
// ============================================================================

module led_blink_test(
    input  wire        CLK100MHZ,   // 100 MHz on-board oscillator
    input  wire [1:0]  sw,          // SW[0] and SW[1] for testing
    output reg  [15:0] led          // All 16 on-board LEDs
);

    // ========================================================================
    // 1 Hz Blink Counter
    // 100,000,000 / 2 = 50,000,000 (toggle every 0.5s = 1 Hz blink)
    // Need 26 bits to hold 50,000,000
    // ========================================================================
    reg [25:0] counter;
    reg        blink;

    always @(posedge CLK100MHZ) begin
        if (counter == 26'd49_999_999) begin
            counter <= 0;
            blink   <= ~blink;
        end else begin
            counter <= counter + 1;
        end
    end

    // ========================================================================
    // LED Patterns — controlled by switches to test multiple I/Os
    //
    //   SW[1:0] = 00 → All LEDs blink together at 1 Hz
    //   SW[1:0] = 01 → Running light (Knight Rider / KITT pattern)
    //   SW[1:0] = 10 → All LEDs solid ON
    //   SW[1:0] = 11 → Alternating pattern (even/odd LEDs swap)
    // ========================================================================

    // Slow counter for the running light pattern
    reg [3:0]  runner_pos;
    reg [22:0] runner_counter;  // Slower sub-clock for visible movement

    always @(posedge CLK100MHZ) begin
        if (runner_counter == 23'd4_999_999) begin  // ~20 Hz shift speed
            runner_counter <= 0;
            runner_pos     <= runner_pos + 1;
        end else begin
            runner_counter <= runner_counter + 1;
        end
    end

    // Output mux based on switch position
    always @(*) begin
        case (sw)
            2'b00:   led = blink ? 16'hFFFF : 16'h0000;             // All blink
            2'b01:   led = 16'b1 << runner_pos;                      // Running light
            2'b10:   led = 16'hFFFF;                                  // All ON
            2'b11:   led = blink ? 16'hAAAA : 16'h5555;              // Alternating
            default: led = 16'h0000;
        endcase
    end

endmodule
