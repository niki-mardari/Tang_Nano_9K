module framebuffer (
    input clc,          // Clock
    input we,           // Enable writing
    input [13:0] waddr; // writing address
    input [13:0] wdata;      // writing data 
    input [13:0] raddr;      // reading address
    output reg [15:0] rdata; // reading the data
);

// 3 Times smaller than actual resolution 
// Going to implement upscaling 
localparam FB_W = 160;
localparam FB_H = 90;
localparam FB_SIZE = FB_W * FB_H; // Getting fullsize in memoty 

reg [15:0] mem [0:FB_SIZE-1]; // 16 bits for every color

// Writing framebuffer into memory 
always @(posedge clk)begin
    if (we)
        mem[waddr] <=wdata;

    rdata <= mem[raddr]; // Readin the pixel data 
end

endmodule

