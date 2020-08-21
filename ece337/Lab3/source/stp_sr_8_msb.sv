// $Id: $
// File name:   stp_sr_8_msb.sv
// Created:     9/2/2013
// Author:      foo
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: 8-bit MSB Serial to Parallel shift register

module stp_sr_8_msb
(
	input wire clk,
	input wire n_rst,
	input wire serial_in,
	input wire shift_enable,
	output wire [7:0] parallel_out 
);

	flex_stp_sr 
	#(
		.NUM_BITS(8),
		.SHIFT_MSB(1)
		)
	CORE(
		.clk(clk),
		.n_rst(n_rst),
		.serial_in(serial_in),
		.shift_enable(shift_enable),
		.parallel_out(parallel_out)
	);

endmodule
