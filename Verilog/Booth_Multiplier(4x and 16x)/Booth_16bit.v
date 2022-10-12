`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 04:39:54
// Design Name: 
// Module Name: Booth_16bit
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


module Booth_mul(

input clk,en,
input [15:0] A,B,
output reg [31:0] Prod,
output reg done
);

reg [15:0] cnt;
reg [32:0] temp;
wire [15:0] negB;

assign negB = ~B + 1'b1 ;

always @ (posedge clk)
begin
if(~en)
    begin
    cnt=16'd0;
    temp=33'd0;
    done <=1'b0;
    end
else
    begin
    
    if(cnt==16'd0)
        begin
        temp <= {16'd0,A,1'b0};
        cnt <= cnt+1;
        end
    else if(cnt> 16'd0 && cnt <16'd17)
        begin
        if(temp[1:0] == 2'b00 || temp[1:0] == 2'b11 )
        begin
        temp = {temp[32],temp[32:1]};
        cnt = cnt+1'b1;
        end
        else if(temp[1:0] == 2'b01)
        begin
        temp[32:17] = temp[32:17] + B;
        temp = {temp[32],temp[32:1]};
        cnt = cnt+1'b1;
        end
        else if(temp[1:0] == 2'b10)
        begin
        temp[32:17] = temp[32:17] + negB;
        temp = {temp[32],temp[32:1]};
        cnt = cnt+1'b1;
        end
        end
    else
        begin
        Prod = temp[32:1];
        done =1'b1;
        end
    end
end

endmodule

