// $Id: $
// File name:   tb_addr_calc.sv
// Created:     4/21/2018
// Author:      Ni Kang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for addr_calc

`timescale 1ns/100ps
module tb_addr_calc();
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
    localparam  	NUM_CNT_BITS = 4;

	reg tb_clk;
	reg tb_n_rst;
	reg [31:0] tb_start_addr;
	reg tb_addr_calc_en;
	reg tb_addr_done;
	reg tb_incdec;
	reg [9:0] tb_row_cnt;
	reg [9:0] tb_col_cnt;
	reg [31:0] tb_calc_addr;
	reg tb_init;
	reg tb_new_row;
	
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	addr_calc DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.start_addr(tb_start_addr),
		.addr_calc_en(tb_addr_calc_en),
		.addr_done(tb_addr_done),
		.incdec(tb_incdec),
		.row_cnt(tb_row_cnt),
		.col_cnt(tb_col_cnt),
		.calc_addr(tb_calc_addr),
		.init(tb_init),
		.new_row(tb_new_row)
	);

	integer test_num;
	initial begin
		test_num = 0;
		tb_n_rst = 1'b0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);

		test_num = test_num + 1;
		tb_n_rst = 1'b1;
		tb_start_addr = '0;
		tb_addr_calc_en = '0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
        
		test_num = test_num + 1;
		tb_n_rst = 1'b1;
		tb_start_addr = 32'd100;
		tb_addr_calc_en = '1;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		
	end
endmodule
