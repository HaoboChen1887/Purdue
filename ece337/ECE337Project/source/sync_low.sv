// $Id: $
// File name:   sync_low.sv
// Created:     1/23/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: PostLab Q4

module sync_low
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);

	reg temp;
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(1'b0 == n_rst)
		begin
			temp <= 1'b0;
			sync_out <= 1'b0;
		end
		else if (async_in == 0 | async_in == 1)
		begin
			temp <= async_in;
			sync_out <= temp;
		end
		else
		begin
			temp <= 1'b0;
			sync_out <= 1'b0;
		end			
	end
endmodule
				
