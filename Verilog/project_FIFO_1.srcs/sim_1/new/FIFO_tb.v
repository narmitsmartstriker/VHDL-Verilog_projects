`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 00:14:01
// Design Name: 
// Module Name: FIFO_tb
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


module FIFO_tb();


    // Inputs
    reg clk;
    reg wclk;
    reg rclk;
    reg [3:0] data_in;
    reg wr;
    reg rd;
    reg rst;
    reg status;

    // Outputs
    wire [3:0] data_out;
    wire empty;
    wire full;
    wire half;

    // Instantiate the FIFO module
    FIFO fifo_inst (
        .clk(clk),
        .data_in(data_in),
        .data_out(data_out),
        .wr(wr),
        .rd(rd),
        .rst(rst),
        .status(status),
        .empty(empty),
        .full(full),
        .half(half)
    );

    // Clock generation
    always begin
        #10 clk = clk; // Toggle the system clock every 10 time units
    end

    always begin
        #5 wclk = ~wclk; // Toggle the write clock every 5 time units
    end

    always begin
        #7 rclk = ~rclk; // Toggle the read clock every 7 time units
    end

    // Initialize signals
    initial begin
        clk = 0;
        wclk = 0;
        rclk = 0;
        data_in = 0;
        wr = 0;
        rd = 0;
        rst = 1;
        status = 0;

        // Reset the FIFO
        #20 rst = 0;
        #20 rst = 0;

        // Perform some test operations
        #30 wclk = 1; wr = 1; data_in = 4'b0001; // Write data
        #10 wclk = 0; wr = 0;
        #30 wclk = 1; wr = 1; data_in = 4'b0010;
        #10 wclk = 0; wr = 0;
        #30 wclk = 1; wr = 1; data_in = 4'b0100;
        #10 wclk = 0; wr = 0;

        #50 rclk = 1; rd = 1; // Read data
        #10 rclk = 0; rd = 0;

        #30 wclk = 1; wr = 1; data_in = 4'b1000; // Write more data
        #10 wclk = 0; wr = 0;

        // Check status signals
        #30 status = 1; // Enable status display
        #10 status = 0; wr =1;
        #10 status =1;
        

        // Perform more operations as needed
      
        // End simulation
        $finish;
    end

    // Display signals in the console
    initial begin
        $monitor("Time=%0t: Data=%b, Empty=%b, Full=%b, Half=%b", $time, data_out, empty, full, half);
    end

endmodule

 
