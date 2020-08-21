// $Id: $
// File name:   gauss_buffer.sv
// Created:     4/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module gauss_buffer
(
	input clk,
	input n_rst,
	input buffer_en,   // From sobel
	input [3:0] x_in,
	input [3:0] y_in,
	input [7:0] pixel_in,
	output reg full,
	output reg [5:0][5:0][8:0] buffer_out
);
	typedef enum bit [1:0] {IDLE, FILL, DONE} stateType;
	stateType state, nextState;
	reg [5:0][5:0][8:0] next_buffer_out;
	reg next_full;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			buffer_out <= '0;
			full <= '0;
		end
		else begin
			state <= nextState;
			buffer_out <= next_buffer_out;
			full <= next_full;
		end
	end

	always_comb
	begin
		nextState = state;
		next_full = full;
		next_buffer_out = buffer_out;
		case(state)
			IDLE:
			begin
				if(buffer_en == 1) begin
					if(x_in < 5 || y_in < 5) begin
						if (full == 1) begin
							next_full = 0;
							next_buffer_out = '0;
						end
						nextState = FILL;
					end
					else if (x_in == 5 && y_in == 5) begin
						next_full = 1;
						nextState = DONE;
					end
					else begin
						nextState = IDLE;
					end
				end
			end

			FILL:
			begin
				next_buffer_out[x_in][y_in] = pixel_in;
				nextState = IDLE;
			end

			DONE:
			begin
				next_buffer_out[5][5] = pixel_in;
				nextState = IDLE;
			end
		endcase
	end
endmodule
