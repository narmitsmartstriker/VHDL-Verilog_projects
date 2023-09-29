`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 14:23:02
// Design Name: 
// Module Name: fifo_1
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


module hardcode_data(sel,DATA);
input [1:0] sel;
output reg [3:0] DATA;

always@(sel) begin
    case(sel)
        2'd0 : DATA = 4'ha;
        2'd1 : DATA = 4'hb;
        2'd2 : DATA = 4'h0;
        2'd3 : DATA = 4'hf;
        default : $display("Invalid SEL");
    endcase
end    
    
endmodule

module control(wr,rd,rst,clk,wclk,rclk,wr_en,rd_en);
input wr,rd,rst,clk;
output reg wclk = 0,rclk = 0,wr_en = 0,rd_en = 0;

always@(posedge clk) begin
    if (wr)begin
    #5 wclk <= ~wclk;
    wr_en <= 1'b1;
    end

    if (rd)begin
    #5 rclk <= ~rclk;
    rd_en <= 1'b1;
    end
    
    if (rst)begin
    wclk <= 1'b0;
    rclk <= 1'b0;
    wr_en <= 1'b0;
    rd_en <= 1'b0;
    end
end

endmodule

module fifo_1(wr,rd,rst,clk,status,data_in,data_out);
input wr,rd,rst,clk,status;
input [1:0] data_in;
output wire [3:0] data_out;
wire full,empty,half,idle;

reg [3:0] fifo[0:3];
reg [2:0]  readCounter = 0, writeCounter = 0, Count = 0;
wire [3:0] data;
wire wclk, rclk, wr_en, rd_en;

assign full = ((writeCounter == 3'b100) & (readCounter ==3'b000) ? 1 : 0); //(Count==0)? 1'b1:1'b0; 
assign empty = (writeCounter == readCounter ) ? 1: 0; //(Count==2)? 1'b1:1'b0; 
assign half = ((writeCounter - readCounter) == 2'b10 ) ? 1: 0; //(Count==4)? 1'b1:1'b0;  
assign idle = (wr==0 & rd==0)? 1'b1:1'b0;  

control c0(wr,rd,rst,clk,wclk,rclk,wr_en,rd_en);
hardcode_data hcd0(data_in,data);

assign data_out = (status) ? {full,empty,half, idle} : ((rd) ? fifo[readCounter]: 0);



always@(posedge clk) begin
if (rst) begin 
   readCounter <= 0; 
   writeCounter <= 0;
   fifo[0] <=0; fifo[1] <=0; fifo[2] <=0; fifo[3] <=0;
  end 
end

always@(posedge wclk) begin
    if(wr_en==1 && !full)begin
    fifo[writeCounter] <= data; 
    writeCounter <= writeCounter+1;
    end
 end

always@(posedge rclk) begin
    if(rd_en==1 && !empty)begin
    //data_out  <= fifo[readCounter]; 
    readCounter <= readCounter+1; 
    end
       

end

endmodule
    
