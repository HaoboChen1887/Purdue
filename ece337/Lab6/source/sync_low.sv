// $Id: $
// File name:   sync_low.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Synchronizer Design

module sync_low(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);
	
	reg temp_out;
	
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			temp_out <= 1'b0;
			sync_out <= 1'b0;
		end
		else
		begin
			temp_out <= async_in;
			sync_out <= temp_out;
		end		
	end
endmodule
