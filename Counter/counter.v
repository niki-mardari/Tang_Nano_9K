module top (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

reg [25:0] counter;
localparam [25:0] VAL = 25'd26_999_999; // Underscores are ignored during compilation
// Localparam becuase it never changes 
reg [5:0] number_counter; // Stores counter number

// Tang nano has a 27 Mhz oscillator meaning that there are 27 million oscillations per second 
// 27 million instructions per second 
// Can use 27 million oscillations to know 1 second has passed  

// Always is like an infinite loop 
// Posedge or negedge means will work on high and low

// Seconds counter
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 25'd0; // Reset counter 
        // "<=" means assign 
    else if (counter < VAL)       // 1s delay
        counter <= counter + 1'b1;
    else
        counter <= 25'd0;
end

// Numbers 0 - 63 binary counter 
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        number_counter <= 6'd0;
    else if (counter == VAL) begin
        if (number_counter == 6'd63)
            number_counter <= 6'd0; // Reset once 63
        else
            number_counter <= number_counter + 1'b1;
    end
end

// Turn on the corresponding led:
always @(*) begin
    case (number_counter)
        
        6'd0:  led = 6'b111111;
        6'd1:  led = 6'b111110;
        6'd2:  led = 6'b111101;
        6'd3:  led = 6'b111100;
        6'd4:  led = 6'b111011;
        6'd5:  led = 6'b111010;
        6'd6:  led = 6'b111001;
        6'd7:  led = 6'b111000;

        6'd8:  led = 6'b110111;
        6'd9:  led = 6'b110110;
        6'd10: led = 6'b110101;
        6'd11: led = 6'b110100;
        6'd12: led = 6'b110011;
        6'd13: led = 6'b110010;
        6'd14: led = 6'b110001;
        6'd15: led = 6'b110000;

        6'd16: led = 6'b101111;
        6'd17: led = 6'b101110;
        6'd18: led = 6'b101101;
        6'd19: led = 6'b101100;
        6'd20: led = 6'b101011;
        6'd21: led = 6'b101010;
        6'd22: led = 6'b101001;
        6'd23: led = 6'b101000;

        6'd24: led = 6'b100111;
        6'd25: led = 6'b100110;
        6'd26: led = 6'b100101;
        6'd27: led = 6'b100100;
        6'd28: led = 6'b100011;
        6'd29: led = 6'b100010;
        6'd30: led = 6'b100001;
        6'd31: led = 6'b100000;

        6'd32: led = 6'b011111;
        6'd33: led = 6'b011110;
        6'd34: led = 6'b011101;
        6'd35: led = 6'b011100;
        6'd36: led = 6'b011011;
        6'd37: led = 6'b011010;
        6'd38: led = 6'b011001;
        6'd39: led = 6'b011000;

        6'd40: led = 6'b010111;
        6'd41: led = 6'b010110;
        6'd42: led = 6'b010101;
        6'd43: led = 6'b010100;
        6'd44: led = 6'b010011;
        6'd45: led = 6'b010010;
        6'd46: led = 6'b010001;
        6'd47: led = 6'b010000;

        6'd48: led = 6'b001111;
        6'd49: led = 6'b001110;
        6'd50: led = 6'b001101;
        6'd51: led = 6'b001100;
        6'd52: led = 6'b001011;
        6'd53: led = 6'b001010;
        6'd54: led = 6'b001001;
        6'd55: led = 6'b001000;

        6'd56: led = 6'b000111;
        6'd57: led = 6'b000110;
        6'd58: led = 6'b000101;
        6'd59: led = 6'b000100;
        6'd60: led = 6'b000011;
        6'd61: led = 6'b000010;
        6'd62: led = 6'b000001;
        6'd63: led = 6'b000000;

        default: led = 6'b111111;
    endcase
end

endmodule
