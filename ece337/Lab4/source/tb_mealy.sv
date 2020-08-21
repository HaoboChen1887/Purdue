// $Id: $
// File name:   tb_moore.sv
// Created:     2/1/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for moore model.
// 
// 
`timescale 1ns / 100ps
module tb_mealy();
	localparam CLK_PERIOD = 2.5;
	
	reg tb_clk;
	reg tb_n_rst;
	reg tb_i;
	reg tb_o;
	reg tb_expected_o;
	integer testcase;

	mealy DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.i(tb_i),
		.o(tb_o)
	);
	
	// Clock setup
	always begin:CLK
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	initial begin:TEST
		testcase = 0;
		tb_n_rst = 1;
		#(CLK_PERIOD)
		// Test 1
		testcase = testcase + 1;
		tb_n_rst = 0;
		#(CLK_PERIOD)
		tb_n_rst = 1;
		tb_i = 0;
		tb_expected_o = 0;

		// Wait for possible delay
		#(CLK_PERIOD * 3)
		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 2
		testcase = testcase + 1;
		tb_n_rst = 1;
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_expected_o = 1;

		// Wait for possible delay
		
		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 3
		testcase = testcase + 1;
		tb_n_rst = 0;

		#(CLK_PERIOD)
		tb_n_rst = 1;
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_expected_o = 1;

		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 4
		testcase = testcase + 1;
		tb_n_rst = 1;
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_expected_o = 0;

		// Wait for possible delay
		
		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 5
		testcase = testcase + 1;
		tb_n_rst = 0;
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_expected_o = 0;

		// Wait for possible delay
		
		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 6
		testcase = testcase + 1;
		tb_n_rst = 1;
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_expected_o = 1;


		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end

		// Test 7
		testcase = testcase + 1;
		tb_n_rst = 1;
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_i = 0;
		@(posedge tb_clk)
		#2
		tb_i = 1;
		@(posedge tb_clk)
		#2
		tb_expected_o = 1;

	
		
		if(tb_o == tb_expected_o) begin
			$info("Test %d: passed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
		else begin
			$error("Test %d: failed (tb_o: %d, tb_expected_o: %d)", testcase, tb_o, tb_expected_o);
		end
	   
	end	
endmodule
