// $Id: $
// File name:   edge_detector.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module edge_detector
(
    input wire clk,
    input wire n_rst,
    input wire [31:0] start_addr,
    input wire start,
    input wire [3:0][7:0] ram_data,
    output reg [31:0] ram_in_addr,
    output reg [31:0] ram_out_addr,
    output reg [3:0][3:0][7:0] data_out,
    output reg win_buf_r_en,
    output reg out_addr_done,
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
    //reg win_buf_r_en;
    reg win_buf_w_en;
    reg [3:0][7:0] win_buf_in_buf;
    reg win_buf_full;
    reg win_buf_fill_done;
    reg [2:0][2:0][7:0] win_buf_out_buf;
    
    reg gauss_calc_en;
    reg [2:0] gauss_x_out;
    reg [2:0] gauss_y_out;
    
    reg gauss_blur_done;
    reg gauss_blur_calc_done;
    reg gauss_blur_en;
    reg [7:0] gauss_blur_pixel_out;
    
    reg gauss_buf_full;
    reg gauss_buf_en;
    reg [5:0][5:0][8:0] gauss_buf_out;
    
    reg sobel_en;
    reg sobel_done;
    reg [3:0][3:0][8:0] sobel_x_out;
    reg [3:0][3:0][8:0] sobel_y_out;
    
    reg mag_r_en;
    reg mag_done;
    reg [3:0][3:0][8:0] mag_data_x;
    reg [3:0][3:0][8:0] mag_data_y;
    
    reg grad_r_en;
    reg grad_done;
    reg [3:0][3:0][17:0] grad_out;
    
    reg out_addr_en;

    MCU MAIN_CONTROLLOR (
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
	    .in_row_cnt(addr_calc_row_cnt),//
	    .in_col_cnt(addr_calc_col_cnt),//
	    .addr_calc_en(addr_calc_en),//
	    .win_buf_full(win_buf_full),//
	    .win_buf_fill_done(win_buf_fill_done),//
	    .win_buf_init(win_buf_init),//
	    .win_buf_new_row(win_buf_new_row),//
	    .win_buf_incdec(win_buf_incdec),//
	    .win_buf_r_en(win_buf_r_en),//
	    .win_buf_w_en(win_buf_w_en),//
	    .win_buf_in_buf(win_buf_in_buf),//
	    .gauss_calc_en(gauss_calc_en),//
	    .gauss_blur_done(gauss_blur_done),//
	    .gauss_blur_calc_done(gauss_blur_calc_done),//
	    .gauss_blur_en(gauss_blur_en),//
	    .gauss_buf_full(gauss_buf_full),//
	    .gauss_buf_en(gauss_buf_en),//
	    .sobel_done(sobel_done),//
	    .sobel_en(sobel_en),//
	    .mag_done(mag_done),//
	    .mag_r_en(mag_r_en),//
	    .grad_done(grad_done),//
	    .grad_r_en(grad_r_en),//
	    .out_addr_done(out_addr_done),//
	    .out_addr_en(out_addr_en)//
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
        .finish(edge_detect_done),
        .init(addr_calc_init)//
    );
    
    win_buf WINDOW_BUFFER(
        .clk(clk),//
        .n_rst(n_rst),//
        .in_buf(win_buf_in_buf),//
        .row_in_buf(gauss_x_out),//
        .col_in_buf(gauss_y_out),//
        .new_row(win_buf_new_row),//
        .incdec(win_buf_incdec),//
        .r_enable(win_buf_r_en),//
        .w_enable(win_buf_w_en),//
        .init(win_buf_init),//
        .full(win_buf_full),//
        .fill_done(win_buf_fill_done),//
        .out_buf(win_buf_out_buf)//
    );
    
    gauss_addr_calc GAUSSIAN_ADDRESS_CALCULATION(
        .clk(clk),//
        .n_rst(n_rst),//
        .calc_en(gauss_calc_en),//
        .x_o(gauss_x_out),//
        .y_o(gauss_y_out)//
    );
    
    gaussian_blur GAUSSIAN_BLUR(
        .clk(clk),//
        .n_rst(n_rst),//
        .read_en(gauss_blur_en),//
        .x_in(gauss_x_out),//
        .y_in(gauss_y_out),//
        .data_in(win_buf_out_buf),//
        .gauss_done(gauss_blur_done),//
        .calc_done(gauss_blur_calc_done),//
        .pixel_o(gauss_blur_pixel_out)//
    );
    
    gauss_buffer GAUSSIAN_BUFFER(
        .clk(clk),//
        .n_rst(n_rst),//
        .buffer_en(gauss_buf_en),//
        .x_in(gauss_x_out),//
        .y_in(gauss_y_out),//
        .pixel_in(gauss_blur_pixel_out),//
        .full(gauss_buf_full),//
        .buffer_out(gauss_buf_out)//
    );
    
    sobel_fir SOBEL_FILTER(
        .clk(clk),//
        .n_rst(n_rst),//
        .sobel_en(sobel_en),//
        .data_in2(gauss_buf_out),//
        .data_x(sobel_x_out),//
        .data_y(sobel_y_out),//
        .sobel_done(sobel_done)//
    );
    
    magnitude MAGNITUDE(
        .clk(clk),//
        .n_rst(n_rst),//
        .x_in(sobel_x_out),//
        .y_in(sobel_y_out),//
        .mag_en(mag_r_en),//
        .mag_done(mag_done),//
        .x_out(mag_data_x),//
        .y_out(mag_data_y)//
    );
    
    gradient GRADIENT(
        .clk(clk),//
        .n_rst(n_rst),//
        .sobel_x(mag_data_x),//
        .sobel_y(mag_data_y),//
        .grad_en(grad_r_en),//
        .grad_done(grad_done),//
        .grad_out(grad_out)//
    );
    
    output_addr OUTPUT_ADDRESS(
        .clk(clk),//
        .n_rst(n_rst),//
        .data_in(grad_out),//
        .start_addr(start_addr),//
        .addr_calc_addr(ram_in_addr),
        .calc_en(out_addr_en),//
        .data_o(data_out),//
        .calc_addr(ram_out_addr),//
        .calc_done(out_addr_done)//
    );                                    
endmodule

