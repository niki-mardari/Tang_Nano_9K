module top (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

reg [27:0] counter;
reg [25:0] val = 25'd27_000_000; // Underscores are ignored during compilation

// Tang nano has a 27 Mhz oscillator meaning that there are 27 million oscillations per second 
// 27 million instructions per second 
// Can use 27 million oscillations to know 1 second has passed  

// Always is like an infinite loop 
// Posedge or negedge means will work on high and low

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 25'd0; // Reset counter 
        // "<=" means assign 
    else if (counter < val)       // 1s delay
        counter <= counter + 1'b1;
    else
        counter <= 25'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 6'b000001; // Setting led values, 0 means leave one on
    else if (counter == val)       // 1s delay
        led[5:0] <= {led[4:0],led[5]};
    else
        led <= led;
end

endmodule
