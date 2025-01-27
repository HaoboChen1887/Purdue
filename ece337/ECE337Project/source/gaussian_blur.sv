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
	input [2:0] x_in,
	input [2:0] y_in,
	input [2:0][2:0][7:0] data_in,
	output reg gauss_done,
	output reg calc_done,     // Output to gauss_addr_calc as an input
	output reg [7:0] pixel_o
);
	typedef enum bit [1:0] {IDLE, GAUSS_CALC1, GAUSS_CALC2, GAUSS_END} stateType;
	stateType state, nextState;
	reg [11:0] total;
	reg [11:0] next_total;
	reg next_gauss_done;
	reg next_calc_done;
	reg [7:0] next_pixel_o;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			total <= '0;
			gauss_done <= 1'b0;
			calc_done <= 1'b0;
			pixel_o <= '0;
		end
		else begin
			state <= nextState;
			total <= next_total;
			gauss_done <= next_gauss_done;
			calc_done <= next_calc_done;
			pixel_o <= next_pixel_o;
		end
	end
	
	always_comb
	begin
		nextState = state;
		next_total = total;
		next_gauss_done = gauss_done;
		next_calc_done = calc_done;
		next_pixel_o = pixel_o;
		
		case(state)
			IDLE:
			begin
				if(read_en == 1) begin
					next_calc_done = '0;
					nextState = GAUSS_CALC1;
				end
			end
			
			GAUSS_CALC1:
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
				nextState = GAUSS_CALC2;
			end
				
			GAUSS_CALC2:
			begin
				next_pixel_o = next_total / 9;
				nextState = GAUSS_END;
			end

			GAUSS_END:
			begin	
				next_total = '0;
				next_calc_done = 1;
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
