// $Id: $
// File name:   gaussian_blur.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: gaussian blur function block.
// 

module gaussian_blur(
	input clk,
	input n_rst,
	input read_en,   // From the next windowbuffer. If its filled, the read should be asserted.
	input gauss_en,  // From first windowbuffer.
	input [3:0] x_in,
	input [3:0] y_in,
	input [2:0][2:0][7:0] data_in,
	output reg gauss_done,
	output reg calc_done,     // Output to gauss_addr_calc as an input
	output reg [3:0] x_out,
	output reg [3:0] y_out,
	output reg [7:0] pixel_o
);
	typedef enum bit [1:0] {IDLE, GAUSS_CALC, GAUSS_END} stateType;
	stateType state, nextState;
	reg [11:0] total;
	reg [11:0] next_total;
	reg next_gauss_done;
	reg next_calc_done;
	reg [3:0] next_x_out;
	reg [3:0] next_y_out;
	reg [7:0] next_pixel_o;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			total <= '0;
			gauss_done <= 1'b0;
			calc_done <= 1'b0;
			x_out <= '0;
			y_out <= '0;
			pixel_o <= '0;
		end
		else begin
			state <= nextState;
			total <= next_total;
			gauss_done <= next_gauss_done;
			calc_done <= next_calc_done;
			x_out <= next_x_out;
			y_out <= next_y_out;
			pixel_o <= next_pixel_o;
		end
	end
	
	always_comb
	begin
		nextState = state;
		next_total = total;
		next_gauss_done = gauss_done;
		next_calc_done = calc_done;
		next_x_out = x_out;
		next_y_out = y_out;
		next_pixel_o = pixel_o;
		
		case(state)
			IDLE:
			begin
				if(gauss_en == 1 && read_en == 1) begin
					next_calc_done = '0;
					nextState = GAUSS_CALC;
				end
			end
			
			GAUSS_CALC:
			begin
				next_total += data_in[0][0];
				next_total += data_in[0][1];
				next_total += data_in[0][2];
				next_total += data_in[1][0];
				next_total += data_in[1][1];
				next_total += data_in[1][2];
				next_total += data_in[2][0];
				next_total += data_in[2][1];
				next_total += data_in[2][2];
				next_pixel_o = next_total / 9;
				nextState = GAUSS_END;
			end

			GAUSS_END:
			begin	
				next_total = '0;
				next_calc_done = 1;
				next_x_out = x_in;
				next_y_out = y_in;
				if(x_in == 3'd5 && y_in == 3'd5) begin
					next_gauss_done = 1;
				end
				else begin
					next_gauss_done = 0;
					nextState = IDLE;
				end			
			end
		endcase
	end
endmodule
