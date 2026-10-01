// D Flip Flop with an AND gate circuit 
// Shows difference between sequential and combinational logic 
// sequential logic depends on current stored values and present inputs
// combinational only depends on present inputs

// Circuit: 
/*
D--DFF--Q
       |
    A--AND-OUT
*/

// Simple D Flip Flop with no reset
module d_FlipFlop(
    input clk,
    input d,
    input en,
    output reg q
);

    always @(posedge clk) begin
        if(en)
            q <= ~d;
    end

endmodule

// Main top module 
module top(
    input CLK,
    input D,
    input A,
    output [1:0] led    // 2 LEDS pin
);

// Using clock to count every one second 
localparam [24:0] ONE_SECOND = 25'd26_999_999; // Clock Value for 1 second
reg [24:0] counter = 25'd0; // Counter to store clock beats

wire tick_1s = (counter == ONE_SECOND);

always @(posedge CLK) begin 
    if(tick_1s)
        counter <= 25'd0;
    else
        counter <= counter + 1'b1;
end

wire Q; // D Flip Flop output 
wire OUT; // AND gate output

d_FlipFlop dff1( .clk(CLK), .d(D), .en(tick_1s), .q(Q));

assign OUT = ~A & Q; // Inverted to match LED active low logic

// Turn on LEDs (Active Low)
assign led[0] = ~Q;
assign led[1] = ~OUT;

endmodule