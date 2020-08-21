// $Id: $
// File name:   edge_detect.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: edge_detect

module edge_detect(
    input wire clk,
    input wire n_rst,
    input wire d_plus,
    output wire d_edge
);
    reg curr_d_plus, next_d_plus;
    
    always_ff @ (posedge clk, negedge n_rst) begin
        if(n_rst == 1'b0)begin
            next_d_plus <= 1;
            curr_d_plus <= 1;
        end
        else begin
            next_d_plus <= d_plus;
            curr_d_plus <= next_d_plus;
        end
    end
    
    assign d_edge = next_d_plus ^ curr_d_plus;
endmodule

