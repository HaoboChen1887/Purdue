// $Id: $
// File name:   pts_sr_4_lsb.sv
// Created:     9/2/2013
// Author:      foo
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: 4-bit LSB Parallel to Serial shift register

module pts_sr_4_lsb
(
	input wire clk,
	input wire n_rst,
	input wire shift_enable,
	input wire load_enable,
	input wire [3:0] parallel_in,
	output reg serial_out 
);

	flex_pts_sr 
	#(
		.NUM_BITS(4),
		.SHIFT_MSB(0)
	)
	CORE(
		.clk(clk),
		.n_rst(n_rst),
		.parallel_in(parallel_in),
		.shift_enable(shift_enable),
		.load_enable(load_enable),
		.serial_out(serial_out)
	);

endmodule