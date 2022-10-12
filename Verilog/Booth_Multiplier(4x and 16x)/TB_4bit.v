`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 04:50:37
// Design Name: 
// Module Name: TB_4bit
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


module TB_4bit(
    input clk
    );
    
reg enable;
reg [3:0] A,B;
wire [7:0] product;
wire val;


Booth_4bit Booth_4bitdut(
    .clk(clk),
    .en(enable),
    .A(A),
    .B(B),
    .Prod(product),
    .done(val)
);

initial
begin

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0010;
B = 4'b0010;
#1000

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0011;
B = 4'b0100;
#1000

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0001;
B = 4'b0011;
#1000

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0100;
B = 4'b0010;
#1000
$stop;


end
endmodule
