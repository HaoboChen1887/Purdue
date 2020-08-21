// $Id: $
// File name:   rcu.sv
// Created:     2/6/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Receiver Control Circuit.

module rcu(
    input wire clk,
    input wire n_rst,
    input wire start_bit_detected,
    input wire packet_done,
    input wire framing_error,
    output reg sbc_clear,
    output reg sbc_enable,
    output reg load_buffer,
    output reg enable_timer
);
    typedef enum bit[2:0] {IDLE, CLEAR, READ, HOLD, WAIT, LOAD} stateType;
    stateType state, next_state;
   
	always_ff@(negedge n_rst, posedge clk)begin
		if(n_rst == 1'b0)begin
			state <= IDLE;
		end
		else begin
			state <= next_state;
		end
	end

	always_comb begin
		next_state = state;
	
		case(state)
			IDLE:
			begin
				if(start_bit_detected == 1'b1)
					next_state = CLEAR;
				else
					next_state = IDLE;
			end
			CLEAR:
			begin
				next_state = READ;
			end
			READ:
			begin
				if(packet_done == 1'b1)
					next_state = HOLD;
				else
					next_state = READ;
			end
			HOLD:
			begin
				next_state = WAIT;
			end
			WAIT:
			begin
				if(framing_error == 1'b1)
					next_state = IDLE;
				else
					next_state = LOAD;
			end
			LOAD:
			begin
				next_state = IDLE;
			end
		endcase
	end
        assign sbc_clear = (state == CLEAR);
        assign sbc_enable = (state == HOLD);
        assign enable_timer = (state == READ);
        assign load_buffer = (state == LOAD);
endmodule
