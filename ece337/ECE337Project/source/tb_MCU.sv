// $Id: $
// File name:   tb_MCU.sv
// Created:     4/24/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench for MCU
`timescale 1ns/100ps
module tb_MCU();
    localparam	CLK_PERIOD	= 2.5;
    localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
    localparam  	NUM_CNT_BITS = 4;

    reg tb_start;
    reg [3:0][7:0]tb_ram_data;
    reg [31:0] tb_start_addr;
    reg [31:0] tb_ram_in_addr;
    reg [31:0] tb_ram_out_addr;

   // addr_calc
    reg tb_clk;
    reg tb_n_rst;
    reg tb_addr_calc_done;
    reg [31:0] tb_addr_calc;
    reg tb_addr_calc_incdec;
    reg tb_addr_calc_new_row;
    reg tb_addr_calc_init;
    reg [9:0] tb_in_row_cnt;
    reg [9:0] tb_in_col_cnt;
    reg [31:0] tb_addr_calc_start;
    reg tb_addr_calc_en;

    reg tb_win_buf_full;
    reg tb_win_buf_fill_done;
    reg tb_win_buf_init;
    reg tb_win_buf_new_row;
    reg tb_win_buf_incdec;
    reg tb_win_buf_r_en;
    reg tb_win_buf_w_en;
    reg [3:0][7:0] tb_win_buf_in_buf;

    reg tb_gauss_addr_calc; // enabled when window buffer is full
    reg tb_gauss_calc_en; // enabled when gaussian blur is done for a single 3x3 matrix

    reg tb_gauss_blur_done; // done signal for entire 6x6 block
    reg tb_gauss_blur_calc_done; // done signal for single iteration
    reg tb_gauss_blur_en; // enabled when window buffer is full
    reg tb_gauss_blur_calc; // disabled when gaussian buffer is full

    reg tb_gauss_buf_full;
    reg tb_gauss_buf_en;

    reg tb_sobel_done;
    reg tb_sobel_en; // enabled when sobel is done

    reg tb_mag_done;
    reg tb_mag_r_en;

    reg tb_grad_done;
    reg tb_grad_r_en;

    reg tb_out_addr_done;
    reg tb_out_addr_en;
    reg [3:0] tb_out_row_cnt;
    reg [3:0] tb_out_col_cnt;
	
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	MCU DUT (
	    .start(tb_start),
	    .ram_data(tb_ram_data),
	    .start_addr(tb_start_addr),
	    .ram_in_addr(tb_ram_in_addr),
	    .ram_out_addr(tb_ram_out_addr),
	    .clk(tb_clk),
	    .n_rst(tb_n_rst),
	    .addr_calc_done(tb_addr_calc_done),
	    .addr_calc(tb_addr_calc),
	    .addr_calc_new_row(tb_addr_calc_new_row),
	    .addr_calc_incdec(tb_addr_calc_incdec),
	    .addr_calc_init(tb_addr_calc_init),
	    .in_row_cnt(tb_in_row_cnt),
	    .in_col_cnt(tb_in_col_cnt),
	    .addr_calc_start(tb_addr_calc_start),
	    .addr_calc_en(tb_addr_calc_en),
	    .win_buf_full(tb_win_buf_full),
	    .win_buf_fill_done(tb_win_buf_fill_done),
	    .win_buf_init(tb_win_buf_init),
	    .win_buf_new_row(tb_win_buf_new_row),
	    .win_buf_incdec(tb_win_buf_incdec),
	    .win_buf_r_en(tb_win_buf_r_en),
	    .win_buf_w_en(tb_win_buf_w_en),
	    .win_buf_in_buf(tb_win_buf_in_buf),
	    .gauss_calc_en(tb_gauss_calc_en),
	    .gauss_blur_done(tb_gauss_blur_done),
	    .gauss_blur_calc_done(tb_gauss_blur_calc_done),
	    .gauss_blur_en(tb_gauss_blur_en),
	    .gauss_blur_calc(tb_gauss_blur_calc),
	    .gauss_buf_full(tb_gauss_buf_full),
	    .gauss_buf_en(tb_gauss_buf_en),
	    .sobel_done(tb_sobel_done),
	    .sobel_en(tb_sobel_en),
	    .mag_done(tb_mag_done),
	    .mag_r_en(tb_mag_r_en),
	    .grad_done(tb_grad_done),
	    .grad_r_en(tb_grad_r_en),
	    .out_addr_done(tb_out_addr_done),
	    .out_addr_en(tb_out_addr_en),
	    .out_row_cnt(tb_out_row_cnt),
	    .out_col_cnt(tb_out_col_cnt)
	);
	
	integer test_num = 0;
	initial begin
	    tb_n_rst = 1'b0;
	    tb_ram_data = {8'd255, 8'd0, 8'd128, 8'd95};
	    tb_in_row_cnt = 10'd600;
	    tb_in_col_cnt = 10'd800;
	    tb_addr_calc_init = 1'b1;
	    tb_addr_calc_new_row = 1'b1;
	    tb_addr_calc_incdec = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_n_rst = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    
	    test_num = test_num + 1;
	    tb_start = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    
	    tb_addr_calc_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_addr_calc_done = 1'b0;
	    
	    tb_win_buf_fill_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_win_buf_fill_done = 1'b0;
	    
	    tb_win_buf_full = 1'b1;
	    tb_win_buf_fill_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_win_buf_full = 1'b0;
	    tb_win_buf_fill_done = 1'b0;
	    
	    tb_gauss_blur_calc_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_gauss_blur_calc_done = 1'b0;
	    
	    tb_gauss_buf_full = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_gauss_buf_full = 1'b0;
	    
	    tb_sobel_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_sobel_done = 1'b0;
	    
	    tb_mag_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_mag_done = 1'b0;
	    
	    tb_grad_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_grad_done = 1'b0;
	    
	    tb_out_addr_done = 1'b1;
	    @(posedge tb_clk);
	    @(posedge tb_clk);
	    tb_out_addr_done = 1'b0;
	end
endmodule

