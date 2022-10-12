`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 04:39:54
// Design Name: 
// Module Name: Booth_4bit
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


module Booth_4bit(

input clk,en,
input [3:0] A,B,
output reg [7:0] Prod,
output reg done
);

reg [3:0] cnt;
reg [8:0] temp;
wire [3:0] negB;

assign negB = ~B + 1'b1 ;

always @ (posedge clk)
begin
if(~en)
    begin
    cnt=4'd0;
    temp=9'd0;
    done <=1'b0;
    end
else
    begin
    
    if(cnt==4'd0)
        begin
        temp <= {4'd0,A,1'b0};
        cnt <= cnt+1;
        end
    else if(cnt> 4'd0 && cnt <4'd5)
        begin
        if(temp[1:0] == 2'b00 || temp[1:0] == 2'b11 )
        begin
        temp = {temp[8],temp[8:1]};
        cnt = cnt+1'b1;
        end
        else if(temp[1:0] == 2'b01)
        begin
        temp[8:5] = temp[8:5] + B;
        temp = {temp[8],temp[8:1]};
        cnt = cnt+1'b1;
        end
        else if(temp[1:0] == 2'b10)
        begin
        temp[8:5] = temp[8:5] + negB;
        temp = {temp[8],temp[8:1]};
        cnt = cnt+1'b1;
        end
        end
    else
        begin
        Prod = temp[8:1];
        done =1'b1;
        end
    end
end

endmodule
