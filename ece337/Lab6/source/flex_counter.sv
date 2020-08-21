// $Id: $
// File name:   flex_counter.sv
// Created:     1/29/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Flexible Counter Specifications

module flex_counter
#(
	NUM_CNT_BITS = 4
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [NUM_CNT_BITS - 1:0] rollover_val,
	output reg [NUM_CNT_BITS - 1:0] count_out,
	output reg rollover_flag
);

	reg [NUM_CNT_BITS - 1:0] next_count;
	reg [NUM_CNT_BITS - 1:0] curr_count;
	reg curr_rollover_flag;
	reg next_rollover_flag;
	always_ff @ (posedge clk, negedge n_rst) begin
		if(n_rst == 1'b0) begin
			curr_count <= '0;
			curr_rollover_flag <= '0;
		end
		else begin
			curr_count <= next_count;
			curr_rollover_flag <= next_rollover_flag;
		end
	end

	always_comb begin
		if(clear == 1'b1) begin
			next_count = '0;
			next_rollover_flag = 0;
		end
		else begin
			if(count_enable == 1'b0) begin
				next_count = curr_count;
				next_rollover_flag = 0;
			end
			else begin
				next_count = curr_count + 1;
				next_rollover_flag = 0;
				if(next_count == rollover_val) begin
					next_rollover_flag = 1;
				end
				if(next_count == rollover_val + 1) begin
					next_count = 1;
				end
			end
		end
	end
	
	assign count_out = curr_count;
	assign rollover_flag = curr_rollover_flag;
endmodule
