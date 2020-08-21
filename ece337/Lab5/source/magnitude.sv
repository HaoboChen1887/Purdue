// $Id: $
// File name:   magnitude.sv
// Created:     2/12/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: magnitude function.

module magnitude(
	input wire [16:0] in,
	output wire [15:0] out
);

	wire msb;
	wire [15:0] comp;

	assign comp = ~in[15:0] + 1;
	assign msb = in[16];
	assign out = (msb == 1'b1) ? comp : in[15:0];

endmodule

