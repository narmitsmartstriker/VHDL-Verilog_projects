`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2022 03:43:20
// Design Name: 
// Module Name: CASEX_cqt
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


module TOP(A0, A1, Y);
 input [3:0] Y;
 output reg A0, A1;
    
    always @ (Y)
    begin
     casex (Y)
              4'b001x : A0 = 1'b1;
              4'b1xxx : A0=1'b1;
              default : A0=1'b0;
              
      endcase
       
       casex (Y)
              4'b01xx : A1 = 1'b1;
              4'b1xxx : A1=1'b1;
              default : A1=1'b0;
              endcase
    end   
endmodule
       
       
      
      
    
   
    
    
   