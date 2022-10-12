`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2022 08:48:17
// Design Name: 
// Module Name: Johnson_counter
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


module Johnson_counter(

input clk, en, reset,
output [3:0] count_out,
reg [3:0] count_temp
);

always @(posedge (clk))
begin

if(reset == 1'b1)
begin
count_temp = 4'b0000;
end
else if(clk == 1'b1) 
begin
count_temp = {count_temp[2:0], ~count_temp[3]};
end
end

endmodule
