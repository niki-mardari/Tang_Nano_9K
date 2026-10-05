// This is a simple ALU implementaion 


module alu(
    input  [1:0] opp,
    input  [3:0] a,
    input  [3:0] b,
    output [3:0] out,
    output       carry,
    output       zero
    );

wire [3:0] add_result;
wire [3:0] sub_result;
wire [3:0] and_result;
wire [3:0] or_result;
wire       add_carry;
reg [3:0] OUT;

Adder add1 (.a(a), .b(b), .cin(1'b0), .sum(add_result), .cout(add_carry));
Subtractor sub1 (.a(a), .b(b), .sub(sub_result));
And and1 (.a(a), .b(b), .anded(and_result));
Or or1 (.a(a), .b(b), .ored(or_result));

// Mux   
always @(*) begin
    case (opp)
        2'b00: OUT = add_result;
        2'b01: OUT = sub_result;
        2'b10: OUT = and_result;
        2'b11: OUT = or_result;
        default: OUT = 4'b1111;
    endcase
end

assign out = OUT;
assign zero = (out == 4'b0000); // Set as 1 if true
assign carry = (opp == 2'b00) ? add_carry : 1'b0; // Applies only to addition opp

endmodule

// Need to handle overflow/ carry 
// Need full adder circuit 
module Adder ( 
    input  [3:0] a, 
    input  [3:0] b, 
    input        cin,
    input        sign, // For controlling if addition or subtraction 
    output [3:0] sum, 
    output       cout 
);

    // Automatically handles the 4-bit sum and the 1-bit carry-out
    // Using XOR to control sign inversion and two's complement
    // If sign is 0, bits stay the same, if sign is 1 bits invert then add 1
    assign {cout, sum} = {1'b0, a} + {1'b0, (b ^ {4{sign}})} + cin;
endmodule

// Subrtractor 

/*
// No need for Two's complement.
// 4 Bits already apply it.
// This is similar to A + ~B + 1 , so like addition with an inverted value 
// Take first bit to interpret signedness 
*/
module Subtractor (
    input [3:0] a,
    input [3:0] b,
    output [3:0] sub,
    output sub_carry
);
// Cin of 1 for Two's complement 
Adder add1 (.a(a), .b(b), .cin(1'b1), .sum(sub), .cout(sub_carry));
// assign sub = a - b;
endmodule

// Bitwise and 
module And (
    input  [3:0] a, 
    input  [3:0] b, 
    output [3:0] anded
);
    assign anded = a & b;
endmodule 

// Bitwise or
module Or (
    input [3:0] a,
    input [3:0] b,
    output [3:0] ored
);
assign ored = a | b;
endmodule 

module  