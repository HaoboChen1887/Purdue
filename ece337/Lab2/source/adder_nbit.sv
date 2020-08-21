// $Id: $
// File name:   adder_nbit.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: iParameterized Ripple Carry Adder Design.
// 

module adder_nbit#( 
	parameter BIT_WIDTH = 4
)
(
	input wire [BIT_WIDTH - 1:0] a,
	input wire [BIT_WIDTH - 1:0] b,
	input wire carry_in,
	output wire [BIT_WIDTH - 1:0] sum,
	output wire overflow
);
	genvar i;
	wire [BIT_WIDTH:0] carrys;

	generate
		assign carrys[0] = carry_in;
		for(i = 0; i < BIT_WIDTH; i++)
		begin
			adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i + 1]));
		end
	endgenerate
	assign overflow = carrys[BIT_WIDTH];

endmodule
