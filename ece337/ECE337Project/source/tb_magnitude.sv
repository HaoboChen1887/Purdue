// $Id: $
// File name:   tb_magnitude.sv
// Created:     4/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_magnitude
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	
	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_mag_en;
	reg tb_mag_done;
	reg [3:0][3:0][8:0] tb_x_in;
	reg [3:0][3:0][8:0] tb_y_in;
	reg [3:0][3:0][8:0] tb_x_out;
	reg [3:0][3:0][8:0] tb_y_out;
	reg [3:0][3:0][8:0] tb_x_out_exp;
	reg [3:0][3:0][8:0] tb_y_out_exp;
	integer tcase = 0;

	magnitude DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
        	.mag_en(tb_mag_en),
        	.mag_done(tb_mag_done),
		.x_in(tb_x_in),
		.y_in(tb_y_in),
		.x_out(tb_x_out),
		.y_out(tb_y_out)
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
		tb_mag_en = 0;
		tb_mag_done = 0;
		tb_x_in = '0;
		tb_y_in = '0;
		tb_x_out_exp = '0;
		tb_y_out_exp = '0;
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test Case 1
		tb_n_rst = 1;
		tb_mag_en = 1;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 1;
		assert (tb_x_out == tb_x_out_exp && tb_y_out == tb_y_out_exp) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test Case 2
		tb_x_in = '{'{-9'd1, 9'd0, 9'd0, 9'd0},
			    '{9'd0, -9'd3, 9'd0, 9'd0},
			    '{9'd0, -9'd255, 9'd0, 9'd0},
			    '{9'd0, 9'd0, 9'd0, -9'd60}};

		tb_y_in = '{'{9'd1, 9'd0, 9'd0, 9'd0},
			    '{9'd0, 9'd3, 9'd0, 9'd0},
			    '{9'd0, 9'd0, 9'd0, 9'd0},
			    '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_x_out_exp = '{'{9'd1, 9'd0, 9'd0, 9'd0},
			    	 '{9'd0, 9'd3, 9'd0, 9'd0},
			    	 '{9'd0, 9'd255, 9'd0, 9'd0},
			   	 '{9'd0, 9'd0, 9'd0, 9'd60}};

		tb_y_out_exp = '{'{9'd1, 9'd0, 9'd0, 9'd0},
			    	 '{9'd0, 9'd3, 9'd0, 9'd0},
			    	 '{9'd0, 9'd0, 9'd0, 9'd0},
			   	 '{9'd0, 9'd0, 9'd0, 9'd0}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 2;
		assert (tb_x_out == tb_x_out_exp && tb_y_out == tb_y_out_exp) begin
			$info("Test case 2 passed!");
		end
		else begin
			$error("Test case 2 failed!");
		end
	end
endmodule
