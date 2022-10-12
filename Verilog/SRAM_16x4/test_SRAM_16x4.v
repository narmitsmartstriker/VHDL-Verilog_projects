`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2022 14:06:34
// Design Name: 
// Module Name: test_SRAM_16x4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module test_SRAM_16x4;

reg clk, rst,read,write;
reg [3:0] wr_data;
reg [3:0] write_addr, read_addr;
wire [3:0] rd_data;
wire wr_done,rd_done;
 
SRAM_16x4 uut(.clk(clk),
.rst(rst),
.read(read),
.write(write),
.wr_data(wr_data),
.write_addr(write_addr),
.read_addr(read_addr),
.rd_data(rd_data),
.wr_done(wr_done),
.rd_done(rd_done)
);
 
always #5 clk = !clk;
initial begin
    clk = 1'b0;
    rst=0;
    read= 0; 
    write = 1; 
    wr_data=4'b0101;
    write_addr=4'd3;
    read_addr=4'd0; 
    #100;
    #10;
     
    rst=0;
    read= 1;
    write = 0;
    wr_data=0;
    write_addr=0;
    read_addr=4'd3;
    #100;
    #10;
    
    rst=0;
    read= 0; 
    write = 1; 
    wr_data=4'b0100;
    write_addr=4'd3;
    read_addr=4'd0;
         
    #100;
    #10;
          
     rst=0;
     read= 1;
     write = 0;
     wr_data=0;
     write_addr=0;
     read_addr=4'd3;
           
        
     
end
endmodule


