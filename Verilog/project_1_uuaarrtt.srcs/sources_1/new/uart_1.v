`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2023 16:17:19
// Design Name: 
// Module Name: UART
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


module uart_tx_16(
input clk,
input enable,
output tx_out,
output reg tx_done
);
wire [63:0]tx_data16 = 64'hB20087B20178B202;
reg [63:0]data;
assign tx_data = data[63:56];
reg load_send;
reg [2:0]state;
reg [3:0]count;
always @ (posedge txclk)begin
if(enable) begin
state <= 0;
data <= tx_data16;
load_send <= 1;
tx_done <= 0;
count <= 0;
end else begin
case(state)
3'd0:
begin
load_send <= 1;
state <= 1;
tx_done <= 0;
end
3'd1:
begin
tx_done <= 0;
load_send <= 0;
if(tx_empty)
state <= 2;
else
state <= 1;
end
3'd2:
begin
count <= count +1;
load_send <= 1;
data <= (data << 8);
state <= 3;
tx_done <= 0;
end
3'd3:
begin
if(count == 8) //No of 8-bit data
state <= 4;
else
state <= 0;
end
3'd4:
begin
tx_done <= 1;
load_send <= 1;
state <= 4;
end
default:
state <= 4;
endcase
end
end
//---------------------------- UART for 1 byte data transfer -------------------------------wire tx_empty,txclk;
wire [7:0] tx_data;
assign ld_tx_data = load_send;
assign tx_enable = ~load_send;
uart_tx_clk clk0(clk,txclk);
uart_tx TX(enable,txclk,ld_tx_data,tx_data,tx_enable,tx_out,tx_empty);
//------------------------------------------------------------------------------------------
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:50 10/05/2012 
// Design Name: 
// Module Name:    uart_tx 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_tx(
reset          ,
txclk          ,
ld_tx_data     ,
tx_data        ,
tx_enable      ,
tx_out         ,
tx_empty       
);

// Port declarations
input        reset          ; // to rst pin 
input        txclk          ; // set Baud rate as txclk clock frequency 
input        ld_tx_data     ; // load tx data to tx register when '1'
input  [7:0] tx_data        ; // tx data 8-bit data input
input        tx_enable      ; //  transmit when enable 
output       tx_out         ; // Serial port pin; goes to pin PACKAGE_PIN C4(nexys4) 
output       tx_empty       ; // give this pin to Spartan-3E LED
// Internal Variables 
reg [7:0]    tx_reg         ;
reg          tx_empty       ;
reg          tx_over_run    ;
reg [3:0]    tx_cnt         ; //counter
reg          tx_out         ; // serial output 


// UART TX Logic
always @ (posedge txclk or posedge reset)
if (reset) begin
  tx_reg        <= 0;
  tx_empty      <= 1;
  tx_over_run   <= 0;
  tx_out        <= 1; // default high 
  tx_cnt        <= 0;
end else begin
   if (ld_tx_data) begin//when 1
      if (!tx_empty) begin // when 0(not empty)
        tx_over_run <= 0;
      end else begin
        tx_reg   <= tx_data;// load tx_data when empty
        tx_empty <= 0;
      end
   end
   if (tx_enable && !tx_empty) begin// when clk is high and reg is not empty and tx_en is high
    
     tx_cnt <= tx_cnt + 1;
     if (tx_cnt == 0) begin
       tx_out <= 0;//start bit
     end
     if (tx_cnt > 0 && tx_cnt < 9) begin//8 bit data
        tx_out <= tx_reg[tx_cnt -1];// shifting and transmitting 
     end
     if (tx_cnt == 8) begin
       tx_out <= 1;// stop bit 1
       tx_cnt <= 0;
       //done <= 1'b0;
       tx_empty <= 1;// ready to take next data 
     end
   end
   if (!tx_enable) begin
     tx_cnt <= 0;
   end
end


endmodule

/*
This module is for generating clock pulse for UART transmitter which is also known as BAUD Rate
Alternatively baud rate is no of clock pulse per second
In each clock pulse, one bit of data is transmit to the receiver

**** Baud rate calculations ****
This module generates Baud rate = 115200 How?
My FPGA system clock is = 100MHz, Period = 10ns
So, (100 Mega clock pulse /115200) = 868 (This much no. of clock pulses are required for each bit)
125/230400 = 543
125/20000
*/
module uart_tx_clk(
input clk,
output reg clk_out

    );
    
    reg [20:0]count;
    always @ (posedge clk)begin
    if(count == 1086)            //baud rate is 115200 
        count <= 0;
    else
        count <= count + 1;
        
    clk_out <= (count < 543)?1:0;   //Duty cycle is 50%
    end
endmodule