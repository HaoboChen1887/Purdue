// $Id: $
// File name:   tb_addr_calc_win_buf.sv
// Created:     4/25/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench for connected windowbuffer and addr calc

`timescale 1ns / 100ps
module tb_addr_calc_win_buf();
	localparam	CLK_PERIOD	= 2;

	reg tb_clk;
	reg tb_n_rst;
	reg [31:0] tb_start_addr;
	reg tb_start;
	reg [3:0][7:0] tb_ram_data;
	reg [2:0] tb_row_in_buf;
	reg [2:0] tb_col_in_buf;
	reg [31:0] tb_ram_in_addr;
	reg [2:0][2:0][7:0] tb_data_out;
    reg tb_edge_detect_done;
	
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	addr_calc_win_buf DUT(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.start_addr(tb_start_addr),
		.start(tb_start),
		.ram_data(tb_ram_data),
		.row_in_buf(tb_row_in_buf),
		.col_in_buf(tb_col_in_buf),
		.ram_in_addr(tb_ram_in_addr),
		.data_out(tb_data_out),
		.edge_detect_done(tb_edge_detect_done)
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
		tb_start = '0;
		tb_start_addr = '0;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
        
		test_num = test_num + 1;
		tb_n_rst = 1'b1;
		tb_start_addr = 32'd100;
		tb_start = '1;
		tb_ram_data = {8'd10, 8'd11, 8'd255, 8'd254};
		tb_row_in_buf = 3'd5;
		tb_col_in_buf = 3'd3;
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
    end
endmodule

	
