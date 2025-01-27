// $Id: $
// File name:   edge_detector.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module addr_calc_win_buf
(
    input wire clk,
    input wire n_rst,
    input wire [31:0] start_addr,
    input wire start,
    input wire [3:0][7:0] ram_data,
    input wire [2:0] row_in_buf,
    input wire [2:0] col_in_buf,    
    output reg [31:0] ram_in_addr,
    output reg [2:0][2:0][7:0] data_out,
    output reg edge_detect_done
);

    reg addr_calc_en; 
    reg addr_calc_done;
    
    reg addr_calc_incdec;
    reg addr_calc_new_row;
    reg addr_calc_init;
    reg [9:0] addr_calc_row_cnt;
    reg [9:0] addr_calc_col_cnt;
    
    reg win_buf_incdec;
    reg win_buf_new_row;
    reg win_buf_init;
    reg win_buf_r_en;
    reg win_buf_w_en;
    reg win_buf_full;
    reg win_buf_fill_done;
    reg [3:0][7:0] win_buf_in_buf;

    win_buf_control WIN_BUF_CONTROLLOR (
	    .start(start),//
	    .ram_data(ram_data),//
	    .start_addr(start_addr),//
	    .clk(clk),//
	    .n_rst(n_rst),//
	    .addr_calc_done(addr_calc_done),//
	    .addr_calc(ram_in_addr),//
	    .addr_calc_new_row(addr_calc_new_row),//
	    .addr_calc_incdec(addr_calc_incdec),//
	    .addr_calc_init(addr_calc_init),//
	    .addr_calc_en(addr_calc_en),//
	    .win_buf_full(win_buf_full),//
	    .win_buf_fill_done(win_buf_fill_done),//
	    .win_buf_init(win_buf_init),//
	    .win_buf_new_row(win_buf_new_row),//
	    .win_buf_incdec(win_buf_incdec),//
	    .win_buf_r_en(win_buf_r_en),//
	    .win_buf_w_en(win_buf_w_en),//
	    .win_buf_in_buf(win_buf_in_buf)
    );
    
    addr_calc  ADDRESS_CALCULATION(
        .clk(clk),//
        .n_rst(n_rst),//
        .start_addr(start_addr),//
        .addr_calc_en(addr_calc_en),//
        .addr_done(addr_calc_done),//
        .incdec(addr_calc_incdec),//
        .new_row(addr_calc_new_row),//
        .row_cnt(addr_calc_row_cnt),//
        .col_cnt(addr_calc_col_cnt),//
        .calc_addr(ram_in_addr),//
        .init(addr_calc_init),//
        .finish(edge_detect_done)
    );
    
    win_buf WINDOW_BUFFER(
        .clk(clk),//
        .n_rst(n_rst),//
        .in_buf(ram_data),//
        .row_in_buf(row_in_buf),//
        .col_in_buf(col_in_buf),//
        .new_row(win_buf_new_row),//
        .incdec(win_buf_incdec),//
        .r_enable(win_buf_r_en),//
        .w_enable(win_buf_w_en),//
        .init(win_buf_init),//
        .full(win_buf_full),//
        .fill_done(win_buf_fill_done),//
        .out_buf(data_out)//
    );                                  
endmodule

