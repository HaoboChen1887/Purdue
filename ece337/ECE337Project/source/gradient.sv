// $Id: $
// File name:   gradient.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module gradient
(
	input clk,
	input n_rst,
	input [3:0][3:0][8:0] sobel_x,
	input [3:0][3:0][8:0] sobel_y,
	input grad_en,
	output reg grad_done,
	output reg [3:0][3:0][17:0] grad_out
);
	typedef enum bit [1:0] {IDLE, GRAD_CALC1, GRAD_CALC2, GRAD_END} stateType;
	stateType state, nextState;
	reg [3:0][3:0][17:0] next_grad_out;
	reg next_grad_done;

	always_ff @(posedge clk, negedge n_rst)
	begin
		if(n_rst == 1'b0) begin
			state <= IDLE;
			grad_out <= '0;
			grad_done <= 0;
		end
		else begin
			state <= nextState;
			grad_out <= next_grad_out;
			grad_done <= next_grad_done;
		end
	end
	
	always_comb
	begin
		nextState = state;
		next_grad_out = grad_out;
		next_grad_done = grad_done;
		
		case(state)
			IDLE:
			begin
				if(grad_en == 1) begin
					next_grad_done = 0;
					nextState = GRAD_CALC1;
				end
			end
			
			GRAD_CALC1:
			begin	
				next_grad_out[3][3] = sobel_x[3][3] * sobel_x[3][3] + sobel_y[3][3] * sobel_y[3][3];
				next_grad_out[3][2] = sobel_x[3][2] * sobel_x[3][2] + sobel_y[3][2] * sobel_y[3][2];
				next_grad_out[3][1] = sobel_x[3][1] * sobel_x[3][1] + sobel_y[3][1] * sobel_y[3][1];
				next_grad_out[3][0] = sobel_x[3][0] * sobel_x[3][0] + sobel_y[3][0] * sobel_y[3][0];

				next_grad_out[2][3] = sobel_x[2][3] * sobel_x[2][3] + sobel_y[2][3] * sobel_y[2][3];
				next_grad_out[2][2] = sobel_x[2][2] * sobel_x[2][2] + sobel_y[2][2] * sobel_y[2][2];
				next_grad_out[2][1] = sobel_x[2][1] * sobel_x[2][1] + sobel_y[2][1] * sobel_y[2][1];
				next_grad_out[2][0] = sobel_x[2][0] * sobel_x[2][0] + sobel_y[2][0] * sobel_y[2][0];
				
				nextState = GRAD_CALC2;
			end
			
			GRAD_CALC2:
			begin
				next_grad_out[1][3] = sobel_x[1][3] * sobel_x[1][3] + sobel_y[1][3] * sobel_y[1][3];
				next_grad_out[1][2] = sobel_x[1][2] * sobel_x[1][2] + sobel_y[1][2] * sobel_y[1][2];
				next_grad_out[1][1] = sobel_x[1][1] * sobel_x[1][1] + sobel_y[1][1] * sobel_y[1][1];
				next_grad_out[1][0] = sobel_x[1][0] * sobel_x[1][0] + sobel_y[1][0] * sobel_y[1][0];

				next_grad_out[0][3] = sobel_x[0][3] * sobel_x[0][3] + sobel_y[0][3] * sobel_y[0][3];
				next_grad_out[0][2] = sobel_x[0][2] * sobel_x[0][2] + sobel_y[0][2] * sobel_y[0][2];
				next_grad_out[0][1] = sobel_x[0][1] * sobel_x[0][1] + sobel_y[0][1] * sobel_y[0][1];
				next_grad_out[0][0] = sobel_x[0][0] * sobel_x[0][0] + sobel_y[0][0] * sobel_y[0][0];
				
				nextState = GRAD_END;
			end
			
			GRAD_END:
			begin
				next_grad_done = 1;
				nextState = IDLE;
			end
		endcase
	end
endmodule						

