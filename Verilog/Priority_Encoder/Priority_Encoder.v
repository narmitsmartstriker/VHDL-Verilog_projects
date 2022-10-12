module Priority_Encoder(


input [15:0] p,
input En,

output reg VALID,

output reg [3:0] y
);

reg [3:0] y1;

always @ (p)
begin

casex(p)
16'b1xxxxxxxxxxxxxxx : y=4'b0000;
16'b01xxxxxxxxxxxxxx : y=4'b0010;
16'b001xxxxxxxxxxxxx : y=4'b0100;
16'b0001xxxxxxxxxxxx : y=4'b0110;
16'b00001xxxxxxxxxxx : y=4'b1000;
16'b000001xxxxxxxxxx : y=4'b1010;
16'b0000001xxxxxxxxx : y=4'b1100;
16'b00000001xxxxxxxx : y=4'b1110;
16'b000000001xxxxxxx : y=4'b1111;
16'b0000000001xxxxxx : y=4'b1101;
16'b00000000001xxxxx : y=4'b1011;
16'b000000000001xxxx : y=4'b1001;
16'b0000000000001xxx : y=4'b0111;
16'b00000000000001xx : y=4'b0101;
16'b000000000000001x : y=4'b0011;
16'b0000000000000001 : y=4'b0001;
default : y = 4'b1111;
endcase



begin
if(En==1'b0)
begin
 y = 4'b1111;
 VALID <= 1'b0;
 end
 
 else
 begin
 
 VALID <= 1'b1;
 end
 
end
 
end
endmodule


