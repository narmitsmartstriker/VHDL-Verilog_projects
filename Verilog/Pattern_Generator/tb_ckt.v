`timescale 1ns / 1ps

module tb_ckt;

reg clk, en, gen ,in;
wire[3:0] Y;

CKT uut(
.clk(clk), .en(en), .gen(gen) , .in(in), .Y(Y)
);

initial clk = 0;
always #20 clk = ~clk;

initial begin
en = 1;gen = 1; in = 1; #1000000
in = 0 ;#10000;

end 
endmodule








 