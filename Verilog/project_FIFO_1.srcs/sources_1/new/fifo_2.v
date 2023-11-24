`timescale 1ns / 1ps

module fifo_2(status,data_out,clk_in, rst_n, wr, rd, sel);  
  input wr, rd, clk_in, rst_n;  
  input status;
  input[1:0] sel;
  //input[3:0] data_in;   
  output[3:0] data_out; 
  wire[3:0] data_in; 
  wire fifo_full, fifo_empty, fifo_half,fifo_idle; 
  //reg[3:0] data_in; 
  wire[3:0] wptr,rptr;  
  wire fifo_we,fifo_rd; 
  wire clk;  
  Clock_divider clk_div(clk_in,clk);
  hardcode_data hcd0(sel,data_in);
  write_pointer top1(wptr,fifo_we,wr,fifo_full,clk,rst_n);  
  read_pointer top2(rptr,fifo_rd,rd,fifo_empty,clk,rst_n);  
  memory_array top3(status,fifo_full,fifo_empty,fifo_half,fifo_idle,data_out, data_in, clk,fifo_we, wptr,rptr);  
  status_signal top4(fifo_full, fifo_empty, fifo_half,fifo_idle, wr, rd, fifo_we, fifo_rd, wptr,rptr,clk,rst_n);  
 endmodule 

module Clock_divider(clock_in,clock_out
    );
input clock_in; // input clock on FPGA
output reg clock_out; // output clock after dividing the input clock by divisor
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd125000000;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz, if you want to get 1Hz signal to blink LEDs
// You will modify the DIVISOR parameter value to 28'd50.000.000
// Then the frequency of the output clk_out = 50Mhz/50.000.000 = 1Hz
always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
 clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;
end
endmodule

module hardcode_datax(sel,DATA);
input [1:0] sel;
output reg [3:0] DATA;

always@(sel) begin
    case(sel)
        2'd0 : DATA = 4'ha; //1010
        2'd1 : DATA = 4'hb; //1011
        2'd2 : DATA = 4'h0; //0000
        2'd3 : DATA = 4'hf; //1111
        default : $display("Invalid SEL");
    endcase
end    
    
endmodule

module memory_array(status,fifo_full,fifo_empty,fifo_half,fifo_idle,data_out, data_in, clk,fifo_we, wptr,rptr);  
  input[3:0] data_in; 
  input status;
  input fifo_full,fifo_half,fifo_idle,fifo_empty; 
  input clk,fifo_we;  
  input[3:0] wptr,rptr;  
  output[3:0] data_out;  
  reg[3:0] data_out2[7:0];  
  wire[3:0] data_out;  
  always @(posedge clk)  
  begin  
   if(fifo_we)   
      data_out2[wptr[3:0]] <=data_in ;  
  end  
  //assign data_out = data_out2[rptr[3:0]];  
  assign data_out = (status) ? {fifo_full,fifo_half,fifo_empty,fifo_idle} : data_out2[rptr[3:0]];
 endmodule  
 
 
module read_pointer(rptr,fifo_rd,rd,fifo_empty,clk,rst_n);  
  input rd,fifo_empty,clk,rst_n;  
  output[3:0] rptr;  
  output fifo_rd;  
  reg[3:0] rptr;  
  assign fifo_rd = (~fifo_empty)& rd;  
  always @(posedge clk or negedge rst_n)  
  begin  
   if(~rst_n) rptr <= 4'b0000;  
   else if(fifo_rd)  
    rptr <= rptr + 4'b0001;  
   else  
    rptr <= rptr;  
  end  
 endmodule 
 
 
module write_pointer(wptr,fifo_we,wr,fifo_full,clk,rst_n);  
   input wr,fifo_full,clk,rst_n;  
   output[3:0] wptr;  
   output fifo_we;  
   reg[3:0] wptr;  
   assign fifo_we = (~fifo_full)&wr;  
   always @(posedge clk or negedge rst_n)  
   begin  
    if(~rst_n) wptr <= 4'b0000;  
    else if(fifo_we)  
     wptr <= wptr + 4'b0001;  
    else  
     wptr <= wptr;  
   end  
  endmodule  
  
  
  module status_signal(fifo_full, fifo_empty, fifo_half,fifo_idle, wr, rd, fifo_we, fifo_rd, wptr,rptr,clk,rst_n);  
   input wr, rd, fifo_we, fifo_rd,clk,rst_n;  
   input[3:0] wptr, rptr;  
   output fifo_full, fifo_empty, fifo_half,fifo_idle;  
   wire fbit_comp;  
   wire pointer_equal;  
   wire[3:0] pointer_result;  
   reg fifo_full, fifo_empty, fifo_half,fifo_idle;  
   assign fbit_comp = wptr[3] ^ rptr[3];  
   assign pointer_equal = (wptr[2:0] - rptr[2:0]) ? 0:1;  
   assign pointer_result = wptr[3:0] - rptr[3:0];  
   always @(*)  
   begin  
    fifo_full =fbit_comp & pointer_equal;  
    fifo_empty = (~fbit_comp) & pointer_equal;
    fifo_half = (~fbit_comp) & (pointer_result == 4'b0100);  
    fifo_idle = (~wr & ~rd);
    //fifo_threshold = (pointer_result[3]||pointer_result[2]) ? 1:0;   
   end  
  endmodule  