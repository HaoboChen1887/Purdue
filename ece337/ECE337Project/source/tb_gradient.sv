// $Id: $
// File name:   tb_gradient.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 100ps
module tb_gradient
();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	
	// Declare Design Under Test portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_grad_en;
	reg tb_grad_done;
	reg [3:0][3:0][8:0] tb_sobel_x;
	reg [3:0][3:0][8:0] tb_sobel_y;
	reg [3:0][3:0][17:0] tb_grad_out;
	reg [3:0][3:0][17:0] tb_grad_out_exp;
	integer tcase = 0;

	gradient DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
        	.grad_en(tb_grad_en),
        	.grad_done(tb_grad_done),
		.sobel_x(tb_sobel_x),
		.sobel_y(tb_sobel_y),
		.grad_out(tb_grad_out)
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
		tb_grad_en = 0;
		tb_grad_done = 0;
		tb_sobel_x = '0;
		tb_sobel_y = '0;
		tb_grad_out_exp = '0;
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test Case 1
		tb_n_rst = 1;
		tb_grad_en = 1;
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 1;
		assert (tb_grad_out == tb_grad_out_exp) begin
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
		tb_sobel_x = '{'{9'd1, 9'd0, 9'd0, 9'd0},
			       '{9'd0, 9'd3, 9'd0, 9'd0},
			       '{9'd0, 9'd255, 9'd0, 9'd0},
			       '{9'd0, 9'd0, 9'd0, 9'd60}};

		tb_sobel_y = '{'{9'd1, 9'd0, 9'd0, 9'd0},
			       '{9'd0, 9'd3, 9'd0, 9'd0},
			       '{9'd0, 9'd0, 9'd0, 9'd0},
			       '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_grad_out_exp = '{'{18'd2, 18'd0, 18'd0, 18'd0},
				    '{18'd0, 18'd18, 18'd0, 18'd0},
			            '{18'd0, 18'd65025, 18'd0, 18'd0},
			            '{18'd0, 18'd0, 18'd0, 18'd3600}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 2;
		assert (tb_grad_out == tb_grad_out_exp) begin
			$info("Test case 2 passed!");
		end
		else begin
			$error("Test case 2 failed!");
		end
				@(posedge tb_clk)		
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test Case 3
		tb_sobel_x = '{'{9'd1, 9'd255, 9'd0, 9'd0},
			       '{9'd0, 9'd3, 9'd0, 9'd0},
			       '{9'd0, 9'd255, 9'd0, 9'd0},
			       '{9'd0, 9'd0, 9'd0, 9'd60}};

		tb_sobel_y = '{'{9'd1, 9'd255, 9'd0, 9'd0},
			       '{9'd0, 9'd3, 9'd0, 9'd0},
			       '{9'd0, 9'd255, 9'd0, 9'd0},
			       '{9'd0, 9'd0, 9'd0, 9'd0}};

		tb_grad_out_exp = '{'{18'd2, 18'd130050, 18'd0, 18'd0},
				    '{18'd0, 18'd18, 18'd0, 18'd0},
			            '{18'd0, 18'd130050, 18'd0, 18'd0},
			            '{18'd0, 18'd0, 18'd0, 18'd3600}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 3;
		assert (tb_grad_out == tb_grad_out_exp) begin
			$info("Test case 3 passed!");
		end
		else begin
			$error("Test case 3 failed!");
		end
				@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		// Test Case 4
		tb_sobel_x = '{'{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255}};

		tb_sobel_y = '{'{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255},
			       '{9'd255, 9'd255, 9'd255, 9'd255}};

		tb_grad_out_exp = '{'{18'd130050, 18'd130050, 18'd130050, 18'd130050},
				    '{18'd130050, 18'd130050, 18'd130050, 18'd130050},
			            '{18'd130050, 18'd130050, 18'd130050, 18'd130050},
			            '{18'd130050, 18'd130050, 18'd130050, 18'd130050}};
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		@(posedge tb_clk)
		
		tcase = 4;
		assert (tb_grad_out == tb_grad_out_exp) begin
			$info("Test case 4 passed!");
		end
		else begin
			$error("Test case 4 failed!");
		end
	end
endmodule
