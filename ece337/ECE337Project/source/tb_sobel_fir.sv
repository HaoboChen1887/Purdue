// $Id: $
// File name:   tb_sobel_fir.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_sobel_fir ();

	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;

	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_sobel_en;
	reg tb_sobel_done;
	reg [5:0][5:0][8:0] tb_data_in2;
	reg [3:0][3:0][8:0] tb_data_x;
	reg [3:0][3:0][8:0] tb_data_y;

	reg [3:0][3:0][8:0] tb_exp_x_out;
	reg [3:0][3:0][8:0] tb_exp_y_out;

	integer tcase = 0;

	sobel_fir DUT
    	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
        	.sobel_en(tb_sobel_en),
        	.data_in2(tb_data_in2),
        	.data_x(tb_data_x),
        	.data_y(tb_data_y),
		.sobel_done(tb_sobel_done)
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
		tb_n_rst = 1'b0;
		tb_sobel_en = 1'b0;
		tb_sobel_done = 1'b0;

		tb_data_in2 = '{'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd1}};

		tb_exp_x_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_exp_y_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};

		
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 1 - Check enable, only calculate when sobel_en == 1
		tb_n_rst = 1'b1;
		@(posedge tb_clk)
		
		tcase = 1;
		assert (tb_data_x == tb_exp_x_out && tb_data_y == tb_exp_y_out) begin
			$info("Test case 1 passed!");
		end
		else begin
			$error("Test case 1 failed!");
		end
		@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)

		// Test case 2
		tb_sobel_en = 1'b1;
		tb_data_in2 = '{'{9'd0, 9'd5, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd1, 9'd2, 9'd11, 9'd3, 9'd0, 9'd0},
				'{9'd0, 9'd8, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd1}};

		tb_exp_x_out = '{'{-9'd10, -9'd1, 9'd11, 9'd3},
				 '{9'd0, 9'd8, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_exp_y_out = '{'{-9'd3, 9'd0, 9'd0, 9'd0},
				 '{9'd2, 9'd11, 9'd3, 9'd0},
				 '{9'd8, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 2;
		assert (tb_data_x == tb_exp_x_out && tb_data_y == tb_exp_y_out) begin
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
		tb_data_in2 = '{'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255}};

		tb_exp_x_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_exp_y_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};
		@(posedge tb_clk)
		@(posedge tb_clk)

		tcase = 3;
		assert (tb_data_x == tb_exp_x_out && tb_data_y == tb_exp_y_out) begin
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
		tb_data_in2 = '{'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0},
				'{9'd255, 9'd255, 9'd255, 9'd255, 9'd255, 9'd255},
				'{9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0}};

		tb_exp_x_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_exp_y_out = '{'{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0},
				 '{9'd0, 9'd0, 9'd0, 9'd0}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 4;		
		assert (tb_data_x == tb_exp_x_out && tb_data_y == tb_exp_y_out) begin
			$info("Test case 4 passed!");
		end
		else begin
			$error("Test case 4 failed!");
		end
	end
endmodule
