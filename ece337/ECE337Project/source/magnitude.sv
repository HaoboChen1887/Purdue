// $Id: $
// File name:   magnitude.sv
// Created:     2/13/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module magnitude
(
	input clk,
	input n_rst,
	input mag_en,
	input [3:0][3:0][8:0] x_in,
	input [3:0][3:0][8:0] y_in,
	output reg [3:0][3:0][8:0] x_out,
	output reg [3:0][3:0][8:0] y_out,
	output reg mag_done
);
	typedef enum bit [1:0] {IDLE, MAG_CALC, MAG_END} stateType;
	stateType state, nextState;
	reg [3:0][3:0][8:0] next_x_out;
	reg [3:0][3:0][8:0] next_y_out;
	reg next_mag_done;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			x_out <= '0;
			y_out <= '0;
			mag_done <= 0;
		end
		else begin
			state <= nextState;
			x_out <= next_x_out;
			y_out <= next_y_out;
			mag_done <= next_mag_done;
		end
	end
	
	always_comb
	begin
		nextState = state;
		next_x_out = x_out;
		next_y_out = y_out;
		next_mag_done = mag_done;
		
		case(state)
			IDLE:
			begin
				if(mag_en == 1) begin
					next_mag_done = 0;
					nextState = MAG_CALC;	
				end
			end
			
			MAG_CALC:
			begin
				// ABS(x_in)
				next_x_out[3][3] = (x_in[3][3][8] == 1)?(~x_in[3][3][8:0]+1):(x_in[3][3][8:0]);
				next_x_out[3][2] = (x_in[3][2][8] == 1)?(~x_in[3][2][8:0]+1):(x_in[3][2][8:0]);
				next_x_out[3][1] = (x_in[3][1][8] == 1)?(~x_in[3][1][8:0]+1):(x_in[3][1][8:0]);
				next_x_out[3][0] = (x_in[3][0][8] == 1)?(~x_in[3][0][8:0]+1):(x_in[3][0][8:0]);

				next_x_out[2][3] = (x_in[2][3][8] == 1)?(~x_in[2][3][8:0]+1):(x_in[2][3][8:0]);
				next_x_out[2][2] = (x_in[2][2][8] == 1)?(~x_in[2][2][8:0]+1):(x_in[2][2][8:0]);
				next_x_out[2][1] = (x_in[2][1][8] == 1)?(~x_in[2][1][8:0]+1):(x_in[2][1][8:0]);
				next_x_out[2][0] = (x_in[2][0][8] == 1)?(~x_in[2][0][8:0]+1):(x_in[2][0][8:0]);

				next_x_out[1][3] = (x_in[1][3][8] == 1)?(~x_in[1][3][8:0]+1):(x_in[1][3][8:0]);
				next_x_out[1][2] = (x_in[1][2][8] == 1)?(~x_in[1][2][8:0]+1):(x_in[1][2][8:0]);
				next_x_out[1][1] = (x_in[1][1][8] == 1)?(~x_in[1][1][8:0]+1):(x_in[1][1][8:0]);
				next_x_out[1][0] = (x_in[1][0][8] == 1)?(~x_in[1][0][8:0]+1):(x_in[1][0][8:0]);

				next_x_out[0][3] = (x_in[0][3][8] == 1)?(~x_in[0][3][8:0]+1):(x_in[0][3][8:0]);
				next_x_out[0][2] = (x_in[0][2][8] == 1)?(~x_in[0][2][8:0]+1):(x_in[0][2][8:0]);
				next_x_out[0][1] = (x_in[0][1][8] == 1)?(~x_in[0][1][8:0]+1):(x_in[0][1][8:0]);
				next_x_out[0][0] = (x_in[0][0][8] == 1)?(~x_in[0][0][8:0]+1):(x_in[0][0][8:0]);
	
				// ABS(y_in)
				next_y_out[3][3] = (y_in[3][3][8] == 1)?(~y_in[3][3][8:0]+1):(y_in[3][3][8:0]);
				next_y_out[3][2] = (y_in[3][2][8] == 1)?(~y_in[3][2][8:0]+1):(y_in[3][2][8:0]);
				next_y_out[3][1] = (y_in[3][1][8] == 1)?(~y_in[3][1][8:0]+1):(y_in[3][1][8:0]);
				next_y_out[3][0] = (y_in[3][0][8] == 1)?(~y_in[3][0][8:0]+1):(y_in[3][0][8:0]);

				next_y_out[2][3] = (y_in[2][3][8] == 1)?(~y_in[2][3][8:0]+1):(y_in[2][3][8:0]);
				next_y_out[2][2] = (y_in[2][2][8] == 1)?(~y_in[2][2][8:0]+1):(y_in[2][2][8:0]);
				next_y_out[2][1] = (y_in[2][1][8] == 1)?(~y_in[2][1][8:0]+1):(y_in[2][1][8:0]);
				next_y_out[2][0] = (y_in[2][0][8] == 1)?(~y_in[2][0][8:0]+1):(y_in[2][0][8:0]);

				next_y_out[1][3] = (y_in[1][3][8] == 1)?(~y_in[1][3][8:0]+1):(y_in[1][3][8:0]);
				next_y_out[1][2] = (y_in[1][2][8] == 1)?(~y_in[1][2][8:0]+1):(y_in[1][2][8:0]);
				next_y_out[1][1] = (y_in[1][1][8] == 1)?(~y_in[1][1][8:0]+1):(y_in[1][1][8:0]);
				next_y_out[1][0] = (y_in[1][0][8] == 1)?(~y_in[1][0][8:0]+1):(y_in[1][0][8:0]);

				next_y_out[0][3] = (y_in[0][3][8] == 1)?(~y_in[0][3][8:0]+1):(y_in[0][3][8:0]);
				next_y_out[0][2] = (y_in[0][2][8] == 1)?(~y_in[0][2][8:0]+1):(y_in[0][2][8:0]);
				next_y_out[0][1] = (y_in[0][1][8] == 1)?(~y_in[0][1][8:0]+1):(y_in[0][1][8:0]);
				next_y_out[0][0] = (y_in[0][0][8] == 1)?(~y_in[0][0][8:0]+1):(y_in[0][0][8:0]);
				
				nextState = MAG_END;	
			end
			
			MAG_END:
			begin
				next_mag_done = 1;
				nextState = IDLE;
			end
		endcase
	end
endmodule						

