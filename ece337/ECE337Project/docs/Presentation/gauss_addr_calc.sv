// $Id: $
// File name:   gauss_addr_calc.sv
// Created:     4/12/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module gauss_addr_calc
(
	input clk,
	input n_rst,
	input calc_en,    // Calc_done from gaussian_blur
	output [3:0] x_o,
	output [3:0] y_o
);
	reg rollover_x = 1'b0;
	assign clear_x = (x_o==4'b0101);
	// Count for input coordingnates for x
	flex_counter #(4) X_COORDCOUNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.clear(clear_x),
		.count_enable(calc_en),
		.rollover_val(4'b0101),
		.count_out(x_o),
		.rollover_flag(rollover_x)
	);
	assign clear_y = (x_o==4'b0101&&y_o==4'b0101);

	// Count for input coordingnates for y
	flex_counter #(4) Y_COORDCOUNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.clear(clear_y),
		.count_enable(rollover_x),
		.rollover_val(4'b0101),
		.count_out(y_o),
		.rollover_flag()
	);
endmodule


