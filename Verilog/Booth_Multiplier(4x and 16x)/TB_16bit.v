`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2022 05:23:14
// Design Name: 
// Module Name: TB_16bit
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


module TB_16bit(
    input clk
    );
    
    
reg enable;
reg [15:0] A,B;
wire [31:0] product;
wire val;


Booth_mul Booth_16bitdut(
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
A = 16'b0100000000000100;
B = 16'b0010;
#10000

enable = 1'b0;
#200
enable = 1'b1;
A = 8'b11110000;
B = 8'b01000000;
#10000

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0001;
B = 4'b0011;
#10000

enable = 1'b0;
#200
enable = 1'b1;
A = 4'b0100;
B = 4'b0010;
#10000
$stop;


end

endmodule
