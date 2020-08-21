// $Id: $
// File name:   mag_mcu.sv
// Created:     4/25/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module mag_mcu
(
	input clk,
	input n_rst,
	input mag_en,
	input mag_done,
	input grad_done,
	output reg grad_en
);
	typedef enum bit [1:0] {MAG, GRAD} stateType;
	stateType state, next_state;
	reg next_grad_en;
	
	always_ff @ (posedge clk, negedge n_rst)
	begin
		if(n_rst == 0)begin
			grad_en <= 1'b0;
			state <= MAG;
		end
		else begin
			grad_en <= next_grad_en;
			state <= next_state;
		end
	end
	
	always_comb
	begin
		next_grad_en = grad_en;
		next_state = state;
		case(state)
			MAG:
			begin
				if (mag_en == 1) begin
					if (mag_done == 1) begin
						next_grad_en = 1;
						next_state = GRAD;
					end
				end
			end
		
			GRAD:
			begin
				if (grad_en == 1) begin
					if (grad_done == 1) begin
						next_grad_en = 1'b0;
						next_state = MAG;
					end
				end
			end

		endcase
	end
endmodule
	
		
