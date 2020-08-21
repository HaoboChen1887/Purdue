// $Id: $
// File name:   tb_test.sv
// Created:     2/4/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench for test.
`timescale 1ns/100ps
module tb_test();
	localparam CLK_PERIOD = 2.5;
	reg tb_clk;
	reg tb_d;
	reg tb_q2;
	always begin:CLK
		tb_clk = 1'b1;
		#(CLK_PERIOD);
		tb_clk = 1'b0;
		#(CLK_PERIOD);
	end

	test DUT(.d(tb_d), .clk(tb_clk), .q2(tb_q2));
	
	initial begin:TEST
		tb_d = 1'b0;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		#(2.5);
		tb_d = 1'b1;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_d = 1'b0;
	end
endmodule
