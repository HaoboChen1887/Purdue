// $Id: $
// File name:   tb_gauss_addr_calc.sv
// Created:     4/12/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_gauss_addr_calc
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam NUM_PIX_ROW = 4;
	localparam TEST_DELAY = 10;
	
	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_calc_en;
	reg [2:0] tb_x_o;
	reg [2:0] tb_y_o;
	integer tcase = 0;
	
	// DUT Port Map
	gauss_addr_calc DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.calc_en(tb_calc_en),
		.x_o(tb_x_o),
		.y_o(tb_y_o)
	);
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		# (CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		# (CLK_PERIOD/2.0);
	end

	// Test bench process
	initial
	begin
		tb_n_rst = 0;
		tb_calc_en = 0;
		@(posedge tb_clk)
		@(posedge tb_clk)
	
		// Test case 1
		tb_n_rst = 1;
		tb_calc_en = 1'b0;
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 1;
		assert (tb_x_o == 0 && tb_y_o == 0) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end

		// Test case 2
		tb_calc_en = 1'b1;
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 2;
		assert (tb_x_o != 0 || tb_y_o != 0) begin
			$info("Test case 2 passed!");
		end
		else begin
			$error("Test case 2 failed!");
		end

		// Test case 3
		tb_calc_en = 1'b1;
		@(posedge tb_clk)
		
		tcase = 3;
		assert (tb_x_o != 0 || tb_y_o != 0) begin
			$info("Test case 3 passed!");
		end
		else begin
			$error("Test case 3 failed!");
		end
	end
endmodule
		
