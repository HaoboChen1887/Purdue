// $Id: $
// File name:   mag_wrapper.sv
// Created:     4/25/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module mag_wrapper
(
	input clk,
	input n_rst,
	input mag_en,
	input [3:0][3:0][8:0] x_in,
	input [3:0][3:0][8:0] y_in,
	output reg grad_done,
	output reg [3:0][3:0][17:0] grad_out
);

	reg [3:0][3:0][8:0] x_out;
	reg [3:0][3:0][8:0] y_out;
	reg mag_done;
	reg grad_en;

	magnitude MAG(
		.clk(clk),
		.n_rst(n_rst),
		.mag_en(mag_en),
		.x_in(x_in),
		.y_in(y_in),
		.x_out(x_out),
		.y_out(y_out),
		.mag_done(mag_done)
	);
	
	gradient GRAD(
		.clk(clk),
		.n_rst(n_rst),
		.sobel_x(x_out),
		.sobel_y(y_out),
		.grad_en(grad_en),
		.grad_done(grad_done),
		.grad_out(grad_out)
	);
	
	mag_mcu MCU(
		.clk(clk),
		.n_rst(n_rst),
		.mag_en(mag_en),
		.mag_done(mag_done),
		.grad_done(grad_done),
		.grad_en(grad_en)
	);	
		
endmodule
	
