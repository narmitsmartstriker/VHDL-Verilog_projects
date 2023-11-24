`timescale 1 ns/1 ps

module sincosfinal(clock, angle, Xin, Yin, Xout, Yout);
   
   localparam ITR = 14; 
   
   input clock;
   input  signed [15:0] angle;
   input  signed [15:0] Xin, Yin;
   output signed    [16 :0] Xout,Yout; 
   
   wire signed [15:0] atan_table [0:15];
   
   assign atan_table[00] = 16'b0010000000000000; 
   assign atan_table[01] = 16'b0001001011100100; 
   assign atan_table[02] = 16'b0000100111111011; 
   assign atan_table[03] = 16'b0000010100010001; 
   assign atan_table[04] = 16'b0000001010001011;
   assign atan_table[05] = 16'b0000000101000101;
   assign atan_table[06] = 16'b0000000010100010;
   assign atan_table[07] = 16'b0000000001010001;
   assign atan_table[08] = 16'b0000000000101000;
   assign atan_table[09] = 16'b0000000000010100;
   assign atan_table[10] = 16'b0000000000001010;
   assign atan_table[11] = 16'b0000000000000101;
   assign atan_table[12] = 16'b0000000000000010;
   assign atan_table[13] = 16'b0000000000000001;



   reg signed [16 :0] X [0:ITR-1];
   reg signed [16 :0] Y [0:ITR-1];
   reg signed    [15:0] Z [0:ITR-1]; 
   

   wire  [1:0] quadrant;
   assign   quadrant = angle[15:14];
   
   always @(posedge clock)
   begin 
      case (quadrant)
         2'b00,
         2'b11:  
         begin    
            X[0] <= Xin;
            Y[0] <= Yin;
            Z[0] <= angle;
         end
         
         2'b01:
         begin
            X[0] <= -Yin;
            Y[0] <= Xin;
            Z[0] <= {2'b00,angle[13:0]}; 
         end
         
         2'b10:
         begin
            X[0] <= Yin;
            Y[0] <= -Xin;
            Z[0] <= {2'b11,angle[13:0]}; 
         end
         
      endcase
   end
   
 
   genvar i;
   generate
   for (i=0; i < (ITR-1); i=i+1)
   begin: XYZ
      wire                   Z_sign;
      wire signed  [16 :0] X_shr, Y_shr; 
   
      assign X_shr = X[i] >>> i; 
      assign Y_shr = Y[i] >>> i;
   
      assign Z_sign = Z[i][15]; 
   
      always @(posedge clock)
      begin
         X[i+1] <= Z_sign ? X[i] + Y_shr : X[i] - Y_shr;
         Y[i+1] <= Z_sign ? Y[i] - X_shr : Y[i] + X_shr;
         Z[i+1] <= Z_sign ? Z[i] + atan_table[i] : Z[i] - atan_table[i];
      end
   end
   endgenerate
   
   
   assign Xout = X[ITR-1];
   assign Yout = Y[ITR-1];
   

endmodule