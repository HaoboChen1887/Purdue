// $Id: $
// File name:   flex_stp_sr.sv
// Created:     1/25/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: flexible and scalable serial to parallel shift register design

module flex_pts_sr
#(
	parameter NUM_BITS = 4,
	parameter SHIFT_MSB = 1
)
(
	input wire clk,
	input wire n_rst,
	input wire [NUM_BITS - 1:0] parallel_in,
	input wire shift_enable,
	input wire load_enable,
	output reg serial_out
);
	
	reg [NUM_BITS - 1:0] next_par;
	reg [NUM_BITS - 1:0] curr_par;
	always_ff @ (posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			curr_par <= '1;
		end
		else begin
			curr_par <= next_par;
		end
	end
	
	always_comb begin
		if(load_enable == 1'b1) begin
			next_par = parallel_in;
		end
		else if(shift_enable == 1'b1) begin
			if(SHIFT_MSB == 1'b1) begin
				// Shift MSB first
				next_par = {curr_par[NUM_BITS - 2:0], 1'b1};
			end
			else begin
				// Shift LSB first 
				next_par = {1'b1, curr_par[NUM_BITS - 1:1]};
			end
		end
		else begin
			next_par = curr_par;
		end
	end

	if(SHIFT_MSB == 1'b1) begin
		// Shift MSB first
		assign serial_out = curr_par[NUM_BITS - 1];
	end
	else begin
		// Shift LSB first
		assign serial_out = curr_par[0];
	end

endmodule
