// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/25/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: flexible and scalable serial to parallel shift register design

module flex_stp_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1
)
(
	input wire clk,
	input wire n_rst,
	input wire serial_in,
	input wire shift_enable,
	output reg [NUM_BITS - 1:0] parallel_out
);
	
	reg [NUM_BITS - 1:0] next_par;
	always_ff @ (posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			parallel_out <= '1;
		end
		else begin
			parallel_out <= next_par;
		end
	end
	
	always_comb begin
		next_par = '1;
		if(shift_enable == 1'b0) begin
			next_par = parallel_out;
		end
		else begin
			if(SHIFT_MSB == 1'b1) begin
				// Shift MSB first
				next_par = {parallel_out[NUM_BITS - 2:0], serial_in};
			end
			else begin
				// Shift LSB first
				next_par = {serial_in, parallel_out[NUM_BITS - 1:1]};
			end
		end
	end
	//assign next_par = '1 & !n_rst | n_rst & parallel_out & !shift_enable | SHIFT_MSB & n_rst & shift_enable & {parallel_out[NUM_BITS - 2:0], serial_in} | !SHIFT_MSB & n_rst & shift_enable & {parallel_out[NUM_BITS - 2:0], serial_in};
	
endmodule
