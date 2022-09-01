`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2022 03:59:02
// Design Name: 
// Module Name: test_TOP
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


module test_TOP;

reg [3:0] Y;
wire A0, A1;



    
   TOP uut(
   .Y(Y), .A0(A0), .A1(A1)
   );
   
   initial begin
   
   Y = 4'b0000 ; 
   #10;   Y = 4'b0001 ; 
   #10;   Y = 4'b0010 ; 
   #10;   Y = 4'b0011 ; 
   #10;   Y = 4'b0100 ; 
   #10;   Y = 4'b0101 ; 
   #10;   Y = 4'b0110 ; 
   #10;   Y = 4'b0111; 
   #10;   Y = 4'b1000 ; 
   #10;   Y = 4'b1001 ; 
   #10;   Y = 4'b1010 ; 
   #10;   Y = 4'b1011 ; 
   #10;   Y = 4'b1100 ; 
   #10;   Y = 4'b1101 ; 
   #10;   Y = 4'b1110 ; 
   #10;   Y = 4'b1111 ; 
      
    end
    
endmodule
