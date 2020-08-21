// $Id: $
// File name:   adder_4bit.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Postlab 2.2 4-bit adder.

module adder_4bit(
	input [3:0] a,
	input [3:0] b,
	input carry_in,
	output [3:0] sum,
	output overflow
);

	wire [4:0] carrys;
	genvar i;

	assign carrys[0] = carry_in;
	generate
		for(i = 0; i <= 3; i = i + 1)
		begin
			adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
		end
	endgenerate
	assign overflow = carrys[4];

endmodule
