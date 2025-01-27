// $Id: $
// File name:   gauss_wrapper.sv
// Created:     4/25/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: 

module gauss_wrapper
(
    input wire clk,
    input wire n_rst,
    input wire win_buf_full,
    input [2:0][2:0][7:0] data_in,
    output wire sobel_en,
    output reg [5:0][5:0][8:0] buffer_out
);
    reg gauss_calc_en;
    reg [2:0] gauss_x_out;
    reg [2:0] gauss_y_out;
    reg gauss_blur_done;
    reg gauss_blur_calc_done;
    reg gauss_blur_en;
    reg [7:0] gauss_blur_pixel_out;
    reg gauss_buf_full;
    reg gauss_buf_en;

    gauss_mcu GAUSS_CONTROLLER (
	.clk(clk),
	.n_rst(n_rst),
	.win_buf_full(win_buf_full),
	.gauss_calc_en(gauss_calc_en), // enabled when gaussian blur is done for a single 3x3 matrix
	.gauss_blur_done(gauss_blur_done), // done signal for entire 6x6 block
	.gauss_blur_calc_done(gauss_blur_calc_done), // done signal for single iteration
	.gauss_blur_en(gauss_blur_en), // enabled when window buffer is full
	.gauss_buf_full(gauss_buf_full),
	.gauss_buf_en(gauss_buf_en),
	.sobel_en(sobel_en) // enabled when sobel is done
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
        .data_in(data_in),//
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
        .buffer_out(buffer_out)//
    );
                                      
endmodule

