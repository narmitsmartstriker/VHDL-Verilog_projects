`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 14.09.2023 15:54:32
//// Design Name: 
//// Module Name: FIFO
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module FIFO(
    input wire clk,         // On-board clock (125 MHz)
    input wire wclk,        // Write clock
    input wire rclk,        // Read clock
    input wire [3:0] data_in, // 4-bit data input
    output wire [3:0] data_out, // 4-bit data output
    input wire wr,          // Write enable
    input wire rd,          // Read enable
    input wire rst,         // Reset
    input wire status,      // Status display control (0: Data, 1: Status)
    output wire empty,      // Empty status signal
    output wire full,       // Full status signal
    output wire half,       // Half status signal
    output wire idle        // Idle status signal
);

  parameter FIFO_DEPTH = 8; //Number of FIFO locations

//  // Internal FIFO memory
  reg [3:0] fifo_mem [0:FIFO_DEPTH-1];
  reg [3:0] write_ptr, read_ptr;
  wire empty_bit;
  wire full_bit;
  wire half_bit;
  //reg [4:0] count;
  
 //Status generation logic
 assign empty_bit = (read_ptr == write_ptr);
 assign full_bit =((write_ptr + 1) % FIFO_DEPTH == read_ptr);
 assign half_bit = ((write_ptr - read_ptr) % FIFO_DEPTH >= FIFO_DEPTH / 2);
 
 //Data output mux
 assign data_out = (status) ? {empty_bit,full_bit,half_bit, idle} : fifo_mem[read_ptr];
 
  // Write control
   always @(posedge wclk or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
        end else if (wr && !full_bit) begin
            fifo_mem[write_ptr] <= data_in;
            write_ptr <= (write_ptr + 1) % FIFO_DEPTH;
        end
    end
 
   // Read control
    always @(posedge rclk or posedge rst) begin
          if (rst) begin
              read_ptr <= 0;
          end else if (rd && !empty_bit) begin
              read_ptr <= (read_ptr + 1) % FIFO_DEPTH;
          end
      end
  
  // Idle status 
  assign idle = (wr == 0) && (rd == 0);
  
 // Output status signals
 assign empty = empty_bit;
 assign full = full_bit;
 assign half = half_bit;   
     

endmodule


   
