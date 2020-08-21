// $Id: $
// File name:   test.sv
// Created:     2/4/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test

module test(
	input clk,
	input d,
	output reg q2
);
	reg q1;
	always @ (posedge clk) begin
		q1 <= d;
		q2 <= q1;
	end
endmodule
