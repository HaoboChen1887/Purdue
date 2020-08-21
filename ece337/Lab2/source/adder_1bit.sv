// $Id: $
// File name:   adder_1bit.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Postlab 2.1.1 1-bit full adder

module adder_1bit(
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);
	assign sum = carry_in ^ (a ^ b);
	assign carry_out = ((!carry_in) & b & a) | (carry_in & (b | a));

endmodule
