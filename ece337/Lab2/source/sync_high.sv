// $Id: $
// File name:   sync_low.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Synchronizer Design

module sync_high(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out
);
	
	reg temp_out = 1'b1;
	
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			temp_out <= 1'b1;
		end
		else
		begin
			temp_out <= async_in;
		end		
	end

	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0)
		begin
			sync_out <= 1'b1;
		end
		else
		begin
			sync_out <= temp_out;
		end	
	end

endmodule
