`timescale 1ns / 1ps
// ============================================================================
// bin2bcd.v
// Binary to Binary-Coded Decimal (BCD) converter.
// Implements the "Double Dabble" (Shift-and-Add-3) algorithm.
//
// Converts a 10-bit binary number (max 1023) into four 4-bit BCD digits
// (Thousands, Hundreds, Tens, Ones) for the 7-segment display.
// ============================================================================

module bin2bcd(
    input  wire [9:0]  binary,
    output reg  [3:0]  thou,
    output reg  [3:0]  hund,
    output reg  [3:0]  tens,
    output reg  [3:0]  ones
);

    integer i;
    
    always @(*) begin
        // Initialize outputs to zero
        thou = 4'd0;
        hund = 4'd0;
        tens = 4'd0;
        ones = 4'd0;
        
        // Loop through all 10 bits
        for (i = 9; i >= 0; i = i - 1) begin
            // Add 3 to columns >= 5
            if (thou >= 5) thou = thou + 3;
            if (hund >= 5) hund = hund + 3;
            if (tens >= 5) tens = tens + 3;
            if (ones >= 5) ones = ones + 3;
            
            // Shift left 1
            thou = thou << 1;
            thou[0] = hund[3];
            
            hund = hund << 1;
            hund[0] = tens[3];
            
            tens = tens << 1;
            tens[0] = ones[3];
            
            ones = ones << 1;
            ones[0] = binary[i];
        end
    end

endmodule
