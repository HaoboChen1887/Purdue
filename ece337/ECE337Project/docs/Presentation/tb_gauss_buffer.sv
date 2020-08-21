// $Id: $
// File name:   tb_gauss_buffer.sv
// Created:     4/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_gauss_buffer
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	
	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_buffer_en;
	reg [3:0] tb_x_in;
	reg [3:0] tb_y_in;
	reg [7:0] tb_pixel_in;
	reg tb_full;
	reg [5:0][5:0][7:0] tb_buffer_out;
	integer tcase = 0;

	gauss_buffer DUT
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.buffer_en(tb_buffer_en),
		.x_in(tb_x_in),
		.y_in(tb_y_in),
		.pixel_in(tb_pixel_in),
		.full(tb_full),
		.buffer_out(tb_buffer_out)
	);
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		# (CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		# (CLK_PERIOD/2.0);
	end

	initial
	begin
		tb_n_rst = 1'b0;
		tb_full = 1'b0;
		tb_buffer_en = 1'b0;
		tb_x_in = 4'b0000;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000000;
		tb_buffer_out = '0;
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 1	
		tb_n_rst = 1'b1;		
		tb_x_in = 4'b0011;
		tb_y_in = 4'b0101;
		tb_pixel_in = 9'b000001111;
		@(posedge tb_clk)

		tcase = 1;
		assert (tb_buffer_out[0][0] == 9'b00000000) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 2	
		tb_buffer_en = 1'b1;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 2;
		assert (tb_buffer_out[3][5] == 9'b00001111) begin
			$info("Test case 2 passed!");
		end
		else begin
			$error("Test case 2 failed!");
		end
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 3
		tb_x_in = 4'b0000;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000001;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_x_in = 4'b0001;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000010;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_x_in = 4'b0010;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000011;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_x_in = 4'b0011;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000100;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_x_in = 4'b0101;
		tb_y_in = 4'b0101;
		tb_pixel_in = 9'b011111111;
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 3;
		assert (tb_buffer_out[0][0] == 9'b00000001 && tb_buffer_out[1][0] == 9'b00000010 && tb_buffer_out[2][0] == 9'b00000011 && tb_buffer_out[3][0] == 9'b00000100  && tb_buffer_out[5][5] == 9'b011111111) begin
			$info("Test case 3 passed!");
		end
		else begin
			$error("Test case 3 failed!");
		end
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 4
		tb_x_in = 4'b0000;
		tb_y_in = 4'b0000;
		tb_pixel_in = 9'b000000001;
		@(posedge tb_clk)
		@(posedge tb_clk)
		tcase = 4;
		assert (tb_buffer_out[0][0] == 9'b00000001) begin
			$info("Test case 3 passed!");
		end
		else begin
			$error("Test case 3 failed!");
		end


	end
endmodule
		
