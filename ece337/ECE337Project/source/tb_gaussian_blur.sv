// $Id: $
// File name:   tb_gaussian_blur.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_gaussian_blur
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	
	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_read_en;
	reg [3:0] tb_x_in;
	reg [3:0] tb_y_in;
	reg [2:0][2:0][7:0] tb_data_in;
	reg tb_gauss_done;
	reg tb_calc_done;
	reg [7:0] tb_pixel_o;
	integer tcase = 0;
	
	// DUT Port Map
	gaussian_blur DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.read_en(tb_read_en),
		.x_in(tb_x_in),
		.y_in(tb_y_in),
		.data_in(tb_data_in),
		.gauss_done(tb_gauss_done),
		.calc_done(tb_calc_done),
		.pixel_o(tb_pixel_o)
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
		// Initialization
		tb_n_rst = 1'b0;
		tb_read_en = 1'b0;
		tb_gauss_done = 1'b0;
		tb_x_in = 4'd0;
		tb_y_in = 4'd0;
		//tb_x_i = 4'b0000;
		//tb_y_i = 4'b0000;
		// Every pixels initialize to '0
		tb_data_in[0][0] = 8'b00000000;
		tb_data_in[0][1] = 8'b00000000;
		tb_data_in[0][2] = 8'b00000000;
		tb_data_in[1][0] = 8'b00000000;
		tb_data_in[1][1] = 8'b00000000;
		tb_data_in[1][2] = 8'b00000000;
		tb_data_in[2][0] = 8'b00000000;
		tb_data_in[2][1] = 8'b00000000;
		tb_data_in[2][2] = 8'b11111111;
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 1 - Check enable, only calculate when gauss_en == 1
		tb_n_rst = 1'b1;
		@(posedge tb_clk)

		tcase = 1;
		assert (tb_pixel_o == 8'b00000000) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)

		// Test case 2
		tb_read_en = 1'b1;
		
		tb_data_in[0][0] = 8'b00000000;
		tb_data_in[0][1] = 8'b00000000;
		tb_data_in[0][2] = 8'b11111111;
		tb_data_in[1][0] = 8'b00000000;
		tb_data_in[1][1] = 8'b00000000;
		tb_data_in[1][2] = 8'b00000000;
		tb_data_in[2][0] = 8'b00001111;
		tb_data_in[2][1] = 8'b00000000;
		tb_data_in[2][2] = 8'b00000000;	
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 2;
		assert (tb_pixel_o == 8'b00011110) begin
			$info("Test case 2 passed!");
		end
		else begin
			$error("Test case 2 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 3 - check overflow
		tb_data_in[0][0] = 8'b11111111;
		tb_data_in[0][1] = 8'b11111111;
		tb_data_in[0][2] = 8'b11111111;
		tb_data_in[1][0] = 8'b11111111;
		tb_data_in[1][1] = 8'b11111111;
		tb_data_in[1][2] = 8'b11111111;
		tb_data_in[2][0] = 8'b11111111;
		tb_data_in[2][1] = 8'b11111111;
		tb_data_in[2][2] = 8'b11111111;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 3;
		assert (tb_pixel_o == 8'b11111111) begin
			$info("Test case 3 passed!");
		end
		else begin
			$error("Test case 3 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		
		// Test case 4
		tb_data_in[0][0] = 8'b00000000;
		tb_data_in[0][1] = 8'b00000000;
		tb_data_in[0][2] = 8'b00000000;
		tb_data_in[1][0] = 8'b00000000;
		tb_data_in[1][1] = 8'b00000000;
		tb_data_in[1][2] = 8'b00000000;
		tb_data_in[2][0] = 8'b00000000;
		tb_data_in[2][1] = 8'b00000000;
		tb_data_in[2][2] = 8'b00001001;
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 4;
		assert (tb_pixel_o == 8'b00000001) begin
			$info("Test case 4 passed!");
		end
		else begin
			$error("Test case 4 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 5
		tb_x_in = 4'd5;
		tb_y_in = 4'd5;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 5;
		assert (tb_gauss_done == 1'b1) begin
			$info("Test case 5 passed!");
		end
		else begin
			$error("Test case 5 failed!");
		end				
	end
endmodule






