`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 04:01:18
// Design Name: 
// Module Name: pre_lab
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


module CKT(clk,en,gen,in,Y);

input clk, en, gen, in;
output reg [3:0] Y = 4'b0000;

reg in_prev ;

always@(posedge clk)
begin
if (en)
    begin
        if (in)
            begin
            if (!in_prev)
            Y <= 4'b0000;
            else
            Y <= Y + 4'b0010;
            end
        else
            begin
            if (in_prev)
            Y <= 4'b0000;
            else
                begin
                    case(Y)
                    4'b0000 : Y <= 4'b0001;
                    4'b1111 : Y <= 4'b0000;
                    default : Y <= Y + 4'b0010;
                    endcase
//                    if (Y == 4'b0000)
//                    Y <= 4'b0001;
//                    if (Y == 4'b1111)
//                    Y <= 4'b0000;
//                    else
//                    Y <= Y + 4'b0010;
                end
            end
    end
else
    Y<= 4'bXXXX;

in_prev <= in;
end

endmodule
