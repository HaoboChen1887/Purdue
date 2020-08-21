// $Id: $
// File name:   sobel_fir.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Sobel filter funtion block..

module sobel_fir
(
	input clk,
	input n_rst,
	input sobel_en,   // guass_done
	input [5:0][5:0][8:0] data_in2,
	output reg [3:0][3:0][8:0] data_x,
	output reg [3:0][3:0][8:0] data_y,
	output reg sobel_done
);
	typedef enum bit [1:0] {IDLE, SOBEL_CALC, SOBEL_END} stateType;
	stateType state, nextState;
	reg [3:0][3:0][8:0] next_data_x;
	reg [3:0][3:0][8:0] next_data_y;
	reg next_sobel_done;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			data_x <= '0;
			data_y <= '0;
			sobel_done <= 0;
		end
		else begin
			state <= nextState;
			data_x <= next_data_x;
			data_y <= next_data_y;
			sobel_done <= next_sobel_done;
		end
	end
	
	always_comb
	begin
		nextState = state;
		next_sobel_done = sobel_done;
		next_data_x = data_x;
		next_data_y = data_y;
		case(state)
			IDLE:
			begin
				if(sobel_en == 1) begin
					next_sobel_done = 0;
					nextState = SOBEL_CALC;
				end
			end
			
			SOBEL_CALC:
			begin
				if(sobel_en == 1) begin
				    next_data_x[0][0] = data_in2[1][2] - data_in2[1][0];
				    next_data_x[0][1] = data_in2[1][3] - data_in2[1][1];
				    next_data_x[0][2] = data_in2[1][4] - data_in2[1][2];
				    next_data_x[0][3] = data_in2[1][5] - data_in2[1][3];
				    next_data_x[1][0] = data_in2[2][2] - data_in2[2][0];
				    next_data_x[1][1] = data_in2[2][3] - data_in2[2][1];
				    next_data_x[1][2] = data_in2[2][4] - data_in2[2][2];
				    next_data_x[1][3] = data_in2[2][5] - data_in2[2][3];
				    next_data_x[2][0] = data_in2[3][2] - data_in2[3][0];
				    next_data_x[2][1] = data_in2[3][3] - data_in2[3][1];
				    next_data_x[2][2] = data_in2[3][4] - data_in2[3][2];
				    next_data_x[2][3] = data_in2[3][5] - data_in2[3][3];
				    next_data_x[3][0] = data_in2[4][2] - data_in2[4][0];
				    next_data_x[3][1] = data_in2[4][3] - data_in2[4][1];
				    next_data_x[3][2] = data_in2[4][4] - data_in2[4][2];
				    next_data_x[3][3] = data_in2[4][5] - data_in2[4][3];
		
				    next_data_y[0][0] = data_in2[2][1] - data_in2[0][1];
				    next_data_y[0][1] = data_in2[2][2] - data_in2[0][2];
				    next_data_y[0][2] = data_in2[2][3] - data_in2[0][3];
				    next_data_y[0][3] = data_in2[2][4] - data_in2[0][4];
				    next_data_y[1][0] = data_in2[3][1] - data_in2[1][1];
				    next_data_y[1][1] = data_in2[3][2] - data_in2[1][2];
				    next_data_y[1][2] = data_in2[3][3] - data_in2[1][3];
				    next_data_y[1][3] = data_in2[3][4] - data_in2[1][4];
				    next_data_y[2][0] = data_in2[4][1] - data_in2[2][1];
				    next_data_y[2][1] = data_in2[4][2] - data_in2[2][2];
				    next_data_y[2][2] = data_in2[4][3] - data_in2[2][3];
				    next_data_y[2][3] = data_in2[4][4] - data_in2[2][4];
				    next_data_y[3][0] = data_in2[5][1] - data_in2[3][1];
				    next_data_y[3][1] = data_in2[5][2] - data_in2[3][2];
				    next_data_y[3][2] = data_in2[5][3] - data_in2[3][3];
				    next_data_y[3][3] = data_in2[5][4] - data_in2[3][4];
				    nextState = SOBEL_END;
				end
				else begin
				    nextState = IDLE;				
				end
			end

			SOBEL_END:
			begin
				if(sobel_en == 1) begin
				    next_sobel_done = 1;
				    nextState = IDLE;
				end
				else begin
				    nextState = IDLE;				
				end
			end
		endcase
	end
endmodule		

