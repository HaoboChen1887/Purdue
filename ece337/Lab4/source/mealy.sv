// $Id: $
// File name:   mealy.sv
// Created:     2/1/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: Mealy machine '1101' Detector 

module mealy
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output reg o
);

    typedef enum logic [1:0] {RCV1, RCV11, RCV110, RCV1101} 
    state_type;
    state_type state, nextstate;
    always_ff @(posedge clk,negedge n_rst) begin:StateReg
        if (n_rst == 0)
            state <= RCV1;
        else
            state <= nextstate;
    end

    always_comb begin : Next_state
	o = 0;
	nextstate = state;
        case (state)
            RCV1: begin
                if (i == 1) begin
                    nextstate = RCV11;
		end
                else begin
                    nextstate = RCV1;
		end
            end
            RCV11: begin
                if (i == 0) begin
                    nextstate = RCV110;
		end
                else begin
                    nextstate = RCV1;
		end
            end
            RCV110: begin
                if (i == 1) begin
                    nextstate = RCV1101;
		end
                else begin
                    nextstate = RCV110;
		end
            end
            RCV1101: begin
                if (i == 1) begin
                    nextstate = RCV11;
		    o = 1;
		end
                else begin
                    nextstate = RCV1;
		end
	    end
	    default: begin
		nextstate = RCV1;
            end
        endcase
    end
   
endmodule
