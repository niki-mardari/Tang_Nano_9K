// Built in LED counter for Tang Nano 9K 

// Counter starts 
// The first LED should turn on
// Next LED turns on after count reaches 
// Previous LEDs are left on 
// Once all LEDs are on, reset and start again 

module top (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

reg [24:0] counter; // Sized down to 25 bits to match val
reg [24:0] val = 25'd26_999_999; // Underscores are ignored during compilation

// Tang nano has a 27 Mhz oscillator meaning that there are 27 million oscillations per second 
// 27 million instructions per second 
// Can use 27 million oscillations to know 1 second has passed  

// Always is like an infinite loop 
// Posedge or negedge means will work on high and low

// Initial Start up values 
initial begin
    counter = 25'd0;
    led = 6'b111_111;   // All LEDs off (1)
end

// 1-second pulse generator
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        counter <= 25'd0; // Reset counter 
    end else if (counter < val) begin // 1s delay
        counter <= counter + 1'b1;
    end else begin
        counter <= 25'd0;
    end
end

// LED shifting logic block (All LED changes happen here)
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n) begin
        led <= 6'b111_111; // Reset to all LEDs OFF on physical button press
    end else if (counter == val) begin // 1s delay
        if (led == 6'b000_000) begin 
            led <= 6'b111_111; // Reset LEDs back to all OFF
        end else begin 
            // Using concatenation to shift left and bring in a 0
            // Basically adds a 0 element into led reg, overflowing (removing) the old ones
            led <= {led[4:0], 1'b0};
        end
    end
end

endmodule
