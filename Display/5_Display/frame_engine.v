module frame_engine (
    input clk,
    input rst,
    input start,            // start writing
    output reg busy,
    output reg we, // Writing enable 
    output reg [13:0] addr, // Address of pixels
    output reg [15:0] data // Pixel color data 
);

reg start_d;
wire start_edge = start & ~start_d; // Only do it once

// Sceen data
localparam FB_W = 160;
localparam FB_H = 90; 
localparam FB_SIZE = FB_H * FB_W;

// Position values 
localparam FG_X0 = 20;
localparam FG_Y0 = 4;
localparam FG_W = 25;
localparam FG_H = 12;

reg[13:0] i;
reg[7:0] x;
reg [6:0] y;

// Checking if the pizel is within the screen dimensions 
wire in_fg=(
    (x >= FG_X0 && x < (FG_X0 + FG_W)) && 
    (y >= FG_Y0 && Y < (fg_y0 + FG_H));

// When reset,set all values to 0
always @(posedge clk or negedge rst)begin
    if(!rst) begin
        busy <= 0;
        we <= 0;
        addr <= 0;
        data <= 0;
        i <= 0;
        x <= 0;
        y <= 0;
        start_d<= 0;
    end else begin
        start_d <= start;
        if(start_edge && !busy)begin
            busy <= 1;
            i <= 0;
            x <= 0;
            y <= 0;
    end

    we <= 1;
    addr <= 1;

    if(in_fg)
        data <= 16'hf800;
    else
        data <= 

    end
    // To be continued ... 


endmodule