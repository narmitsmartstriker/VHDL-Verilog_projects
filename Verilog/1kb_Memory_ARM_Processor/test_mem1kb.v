`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2022 14:22:19
// Design Name: 
// Module Name: test_mem1kb
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
module test_mem1kb();
    
 reg clk, rst, read, write;
 reg [31:0] wr_data;
 reg [7:0] write_addr, read_addr;
        
        
 wire [31:0] rd_data;
 wire wr_done, rd_done;
        
 mem_1kb uut(
            .clk(clk),
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
        
always #5 clk = ~clk;
initial begin
                
clk = 1'b0;
rst = 1'b1;
read = 1'b0;
write = 1'b0;
            
#20;
            // write_addr and read_addr can take value from 0 to 255 8bit data
            // write data should be 32 bit
            
rst = 1'b0;
write = 1'b1;
write_addr = 8'd0;
wr_data = 32'd1000;
            
#100;
            
rst = 1'b1;
write = 1'b0;
#50;
            
rst = 1'b0;
read = 1'b1;
read_addr = 8'd0;
            
#100;
            
 rst = 1'b1;
 read = 1'b0;
 #50;
            
 rst = 1'b0;
 write = 1'b1;
 write_addr = 8'd255;
 wr_data = 32'd88889;
 #100;
            
 rst = 1'b1;
 write = 1'b0;
 #50;
            
  rst = 1'b0;
  read = 1'b1;
  read_addr = 8'd255;
            
 end
endmodule