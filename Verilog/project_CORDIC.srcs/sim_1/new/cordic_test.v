`timescale 1 ns/1 ps

module cordic_test;

reg [15:0] Xin, Yin;
reg [15:0] angle;
wire [16:0] Xout, Yout;
reg clock;

sincosfinal uut(clock, angle, Xin, Yin, Xout, Yout);

//localparam gain = 16'b0100110110110111; // (1/1.647) << 15
localparam gain =  (1<<15)/1.647; // (1/1.647) << 15
reg signed [10:0] i;

initial begin

   clock = 1'b0;
   angle = 1'b0;
   Xin = gain;                    
   Yin = 1'd0;

   for (i = 0; i < 360; i = i + 1)    
   begin
      @(posedge clock);
      angle = ((1 << 16)*i)/360;    
   end

end

always #5 clock = ~clock;

endmodule