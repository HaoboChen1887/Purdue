// $Id: $
// File name:   moore.sv
// Created:     2/1/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: iMoore Machine '1101' Detector Design.
module moore
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output reg o
);

    typedef enum logic [2:0] {WAITING, RCV1, RCV11, RCV110, RCV1101} 
    state_type;
    state_type state, nextstate;
    always_ff @(posedge clk,negedge n_rst) begin:StateReg
        if (n_rst == 0)
            state <= WAITING;
        else
            state <= nextstate;
    end

    always_comb begin : Next_state
        nextstate = state;
	o = 0;
        case (state)
            WAITING: begin
                if (i == 1)
                    nextstate = RCV1;
                else
                    nextstate = WAITING;
            end
            RCV1: begin
                if (i == 1)
                    nextstate = RCV11;
                else
                    nextstate = WAITING;
            end
            RCV11: begin
                if (i == 0)
                    nextstate = RCV110;
                else
                    nextstate = RCV11;
            end
            RCV110: begin
                if (i == 1)
                    nextstate = RCV1101;
                else
                    nextstate = WAITING;
            end
            RCV1101: begin
		o = 1;
                if (i == 1)
                    nextstate = RCV11;
                else
                    nextstate = WAITING;
            end
        endcase
    end
 
endmodule
