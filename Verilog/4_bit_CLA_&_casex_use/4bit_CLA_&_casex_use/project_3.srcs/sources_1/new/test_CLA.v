
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2022 04:29:31
// Design Name: 
// Module Name: test_CLA
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


module test_CLA;
reg [3:0] a;
reg [3:0] b;
reg cin;

wire[3:0] sum;
wire cout;

CLA uut(
.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
);

initial begin
a = 0; b = 0; cin = 0;
#100;
a = 2; b = 6; cin = 1;
#100;
a = 2; b = 4; cin = 0;
#100;
a = 1; b = 7; cin = 1;
#100;
a = 10; b = 22; cin = 0;
#100;

end
endmodule