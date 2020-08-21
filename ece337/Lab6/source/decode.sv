// $Id: $
// File name:   decode.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: decoder

module decode(
    input wire clk,
    input wire n_rst,
    input wire d_plus,
    input wire shift_enable,
    input wire eop,
    output wire d_orig
);

    reg curr1, curr2;
    reg next_curr1, next_curr2;
    reg mux1, mux2;
    always_ff @ (posedge clk, negedge n_rst) begin
        if(n_rst == 1'b0)begin
            curr1 <= 1'b1;
            curr2 <= 1'b1;
        end
        else begin
            curr1 <= next_curr1;
            curr2 <= next_curr2;
        end
    end
    
    always_comb begin
        next_curr1 = d_plus;
        if(shift_enable == 1'b1)
            mux1 = d_plus;
        else
            mux1 = curr2;
        if(eop & shift_enable == 1'b1)
            mux2 = 1;
        else
            mux2 = mux1;
        next_curr2 = mux2;
    end
    
    assign d_orig = (curr1 == curr2);
    
endmodule

