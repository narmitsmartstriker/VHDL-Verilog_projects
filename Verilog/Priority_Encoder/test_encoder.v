`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2022 08:51:18
// Design Name: 
// Module Name: test_encoder
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




module test_encoder;

reg En;
reg [15:0] p;
wire [3:0] y;
wire VALID;



    
   Priority_Encoder uut(
   .En(En), .p(p), .y(y), .VALID(VALID)
   );
   
   
   initial begin
   
   p = 15'b000000000000001; En = 1;
   #10; p = 15'b000000000000011;
   #10; p = 15'b000000000000111;
   #10; p = 15'b000000000001111;
   #10; p = 15'b000000000011111;
   #10; p = 15'b000000000111111;
   #10; p = 15'b000000001111111;En = 0;
   #10; p = 15'b000000011111111;En = 1;
   #10; p = 15'b000000111111111;
   #10; p = 15'b000001111111111;
   #10; p = 15'b000011111111111;
   #10; p = 15'b000111111111111;
   #10; p = 15'b001111111111111;
   #10; p = 15'b011111111111111;
   #10; p = 15'b111111111111111;
   #10; p = 15'b000000000000011;
  
   end
   
   
   
    
    
endmodule


