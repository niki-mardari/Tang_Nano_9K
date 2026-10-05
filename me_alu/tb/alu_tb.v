// Tested in Icarus Verilog on eda playground
module alu_tb;

// Code your testbench here
// or browse Examples
reg  [1:0] opp;
reg  [3:0] a;
reg  [3:0] b;

wire [3:0] out;
wire carry;
wire zero;	

alu dut (
    .opp(opp),
    .a(a),
    .b(b),
    .out(out),
    .carry(carry),
    .zero(zero)
);

// 3. Generate Test Cases (Stimulus)
initial begin
  
  	$dumpfile("dump.vcd"); // Create Value Change Dump to view when signals change 
  	$dumpvars(0, alu_tb); // Record the signals under the alu_tb testbench hierarchy.
  
    a = 4'd5;
    b = 4'd3;
    opp = 2'b00;
    #10;
    // Expect ADD: out = 8
	$display("ADD: a=%d b=%d out=%d carry=%b zero=%b", a, b, out, carry, zero);

    opp = 2'b01;
    #10;
    // Expect SUB: out = 2
	$display("ADD: a=%d b=%d out=%d carry=%b zero=%b", a, b, out, carry, zero);

    opp = 2'b10;
    #10;
    // Expect AND: out = 1
	$display("ADD: a=%d b=%d out=%d carry=%b zero=%b", a, b, out, carry, zero);

    opp = 2'b11;
    #10;
    // Expect OR: out = 7
	$display("ADD: a=%d b=%d out=%d carry=%b zero=%b", a, b, out, carry, zero);
  
  	a = 4'd15;
    b = 4'd1;
  	opp = 2'b00;
  	#10;
  	// Expected ADD: out = 0000, carry = 1, zero = 1
  	$display("ADD: a=%d b=%d out=%d carry=%b zero=%b", a, b, out, carry, zero);
  
  	a = 4'd3;
    b = 4'd5;
  	opp = 2'b01;
  	#10;
  // Expected SUB: out = -2 (1110), carry = 1, zero = 1
  $display("SUB: a=%d b=%d out=%b carry=%b zero=%b", a, b, out, carry, zero);
    $finish;
end
endmodule 