// $Id: $
// File name:   flex_counter.sv
// Created:     1/30/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module flex_counter
#(
	parameter NUM_CNT_BITS = 4
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [NUM_CNT_BITS-1:0] rollover_val,
	output reg [NUM_CNT_BITS-1:0] count_out,
	output reg rollover_flag
);

	reg [NUM_CNT_BITS-1:0] next_count_out;
	reg next_rollover_flag;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if( n_rst == 0 )
		begin
			rollover_flag <= '0;
			count_out <= '0;
		end
		else if( clear == 1 )
		begin
			rollover_flag <= '0;
			count_out <= '0;
		end
		else
		begin
			rollover_flag <= next_rollover_flag;
			count_out <= next_count_out;
		end
	end
		
	always_comb
	begin
		next_count_out = count_out;
		next_rollover_flag = rollover_flag;
		if(count_enable)
		begin
			if(rollover_flag)
			begin
				next_count_out = 0;
			end
			else
			begin
				next_count_out = count_out + 1;
			end
			
			if( next_count_out == rollover_val )
			begin
				next_rollover_flag = 1'b1;
			end
			else
			begin
				next_rollover_flag = 1'b0;
			end
		end
	end

endmodule









