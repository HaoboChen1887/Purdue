// $Id: $
// File name:   adder_1bit.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Postlab 2.1.1 1-bit full adder

`timescale 1ns/100ps
module adder_1bit(
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);

	always @ (a)
	begin
		assert((a == 1'b1) || (a == 1'b0))
			else $error("Input 'a' of component is not a digital logic value");
		assert((b == 1'b1) || (b == 1'b0))
			else $error("Input 'b' of component is not a digital logic value");
		assert((carry_in == 1'b1) || (carry_in == 1'b0))
			else $error("Input 'b' of component is not a digital logic value");
	end
	assign sum = carry_in ^ (a ^ b);
	assign carry_out = ((!carry_in) & b & a) | (carry_in & (b | a));
	always @ (a, b, carry_in)
	begin
		#(2) assert(((a + b + carry_in) % 2) == sum)
			else $error("Output 's' of first 1 bit adder is not coorect");
	end

endmodule
