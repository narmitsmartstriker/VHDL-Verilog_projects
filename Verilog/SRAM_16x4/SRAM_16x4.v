`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2022 14:02:27
// Design Name: 
// Module Name: SRAM_16x4
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
module SRAM_16x4(
    input clk, input rst, input read, input write, input [3:0] wr_data, input [3:0] write_addr, read_addr,
    output reg [3:0] rd_data,output reg wr_done,rd_done
    );
    parameter ADDR_WIDTH = 4 ; parameter mem_size = 15 ; parameter DATA_WIDTH = 3 ;
    // creates a array of size 16 X 4, means 16 locations each to store a 4-bit data
    reg [DATA_WIDTH:0] temp_mem[0:mem_size];
    always @(posedge clk)
    begin
        if(rst)
            begin
            wr_done<=0;
            rd_done<=0;
            end
        else
        begin
            if(write)
                begin
                temp_mem[write_addr] <= wr_data;
                wr_done <=1;
            end
            else
                begin
                wr_done<=0;
            end
        if(read)
            begin
            rd_data <= temp_mem[read_addr];
            rd_done <= 1;
        end
        else
            rd_done<=0;
        end
    end
endmodule


