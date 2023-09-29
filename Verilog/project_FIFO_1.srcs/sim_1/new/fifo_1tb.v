`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 14:24:31
// Design Name: 
// Module Name: fifo_1tb
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


module fifo_1tb();

    // Inputs
    reg clk;
    reg [1:0] data_in;
    reg wr;
    reg rd;
    reg rst;
    reg status;

    // Outputs
    wire [3:0] data_out;
    wire empty;
    wire full;
    wire half;
    wire idle;

    // Instantiate the FIFO module
    fifo_1 fifo (
        .clk(clk),
        .data_in(data_in),
        .data_out(data_out),
        .wr(wr),
        .rd(rd),
        .rst(rst),
        .status(status)
       
    );

    // Clock generation    
 initial begin
       clk = 0;
       data_in = 0;
       wr = 0;
       rd = 0;
       rst = 0;
       status = 0;
       #10 wr = 1; data_in = 2'd1;
       #10         data_in =2'd0;
       #30 wr = 0; rd = 0; status = 1;
       #10 wr = 0; rd = 1; status = 0;
       #10 wr = 0; rd = 1; status = 0;
       #10 status =1;
//       #500
//           $finish;       
       end
    always begin
           #5 clk = ~clk; // Toggle the system clock every 10 time units
       end
endmodule
   
