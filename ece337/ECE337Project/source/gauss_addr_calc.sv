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
	output [2:0] x_o,
	output [2:0] y_o
);
	reg rollover_x;
	//assign clear_x = (x_o==3'b101);
	// Count for input coordingnates for x
	flex_counter #(3) X_COORDCOUNT
	(
		.clk(clk),
		.n_rst(n_rst),
		.clear(1'b0),
		.count_enable(calc_en),
		.rollover_val(3'b101),
		.count_out(x_o),
		.rollover_flag(rollover_x)
	);
	//assign clear_y = (x_o==3'b101&&y_o==3'b101);

	// Count for input coordingnates for y
	flex_counter #(3) Y_COORDCOUNT
	(
		.clk(x_o == 3'd0),
		.n_rst(n_rst),
		.clear(1'b0),
		.count_enable(rollover_x),
		.rollover_val(3'b101),
		.count_out(y_o),
		.rollover_flag()
	);
endmodule


