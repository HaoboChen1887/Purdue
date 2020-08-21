// $Id: $
// File name:   tb_gauss_wrapper.sv
// Created:     4/25/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_gauss_wrapper
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	
	reg tb_clk;
	reg tb_n_rst;
	reg tb_win_buf_full;
	reg [2:0][2:0][7:0] tb_data_in;
	reg tb_sobel_en;
	reg [5:0][5:0][8:0] tb_buffer_out;
	reg tcase = 0;
	
	gauss_wrapper DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.win_buf_full(tb_win_buf_full),
		.data_in(tb_data_in),
		.sobel_en(tb_sobel_en),
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
		// Initialization
		tb_n_rst = 0;
		tb_win_buf_full = 0;
		tb_data_in = '0;
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test case 1
		tb_n_rst = 1'b1;
		tb_win_buf_full = 1'b1;
		tb_data_in =  '{'{8'd0, 8'd0, 8'd0},
				'{8'd0, 8'd0, 8'd0},
				'{8'd0, 8'd0, 8'd0}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_data_in =  '{'{8'd1, 8'd1, 8'd1},
				'{8'd1, 8'd1, 8'd1},
				'{8'd1, 8'd1, 8'd1}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_data_in =  '{'{8'd2, 8'd2, 8'd2},
				'{8'd2, 8'd2, 8'd2},
				'{8'd2, 8'd2, 8'd2}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_data_in =  '{'{8'd3, 8'd3, 8'd3},
				'{8'd3, 8'd3, 8'd3},
				'{8'd3, 8'd3, 8'd3}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_data_in =  '{'{8'd4, 8'd4, 8'd4},
				'{8'd4, 8'd4, 8'd4},
				'{8'd4, 8'd4, 8'd4}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		tb_data_in =  '{'{8'd5, 8'd5, 8'd5},
				'{8'd5, 8'd5, 8'd5},
				'{8'd5, 8'd5, 8'd5}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 1;
		assert (tb_buffer_out[0][0] == 9'b00000001 && tb_buffer_out[1][0] == 9'b00000010 && tb_buffer_out[2][0] == 9'b00000011 && tb_buffer_out[3][0] == 9'b00000100  && tb_buffer_out[5][5] == 9'b011111111) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end
	end
endmodule		
		
			
										
		
