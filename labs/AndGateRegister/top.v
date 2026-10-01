// Similar Lab circuit except the and gate controls the input to the D-Flip-Flop

// Simple D Flip Flop with reset
module d_FlipFlop(
    input clk,
    input d,
    //input en,
    input rst,
    output reg q
);

    always @(posedge clk) begin
        if(rst)
            q <= 1'b0;
        else
            //if(en)
                q <= d;
    end

endmodule

module top(
    input CLK, 
    input RST,
    output led
    );
 
// Using clock to count every one second 
localparam [24:0] ONE_SECOND = 25'd26_999_999; // Clock Value for 1 second
reg [24:0] counter = 25'd0; // Counter to store clock beats

reg [2:0] d_reg = 3'b0; // For A, B, C Inputs

wire tick_1s = (counter == ONE_SECOND);

always @(posedge CLK) begin 
    if(tick_1s) begin
        counter <= 25'd0;
        if(d_reg == 3'b111)
            d_reg <= 3'b000;
        else  
            d_reg <= d_reg + 1'b1;
    end else begin
        counter <= counter + 1'b1;
    end
end


// Need to go through all possible combinations of 3 bits and store in wire d
/*
0 0 0 
0 0 1
0 1 0
0 1 1
1 0 0
1 0 1
1 1 0
1 1 1
*/

wire A, B, C, D, Q;

assign A = d_reg[2];
assign B = d_reg[1];
assign C = d_reg[0];

assign D = A & B & C;

d_FlipFlop dff1 (.clk(CLK), .d(D), .rst(~RST), .q(Q));

assign led = ~Q;

endmodule 