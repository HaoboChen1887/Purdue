// $Id: $
// File name:   timer.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: timer

module timer(
    input wire clk,
    input wire n_rst,
    input wire d_edge,
    input wire rcving,
    output wire shift_enable,
    output wire byte_received
);

    reg [3:0] count_out;
    reg [3:0] byte_cnt;
    reg rollover_flag;
    flex_counter #(.NUM_CNT_BITS(4)) POSITION(
        .clk(clk),
        .n_rst(n_rst),
        .clear(d_edge),
        .count_enable(rcving),
        .rollover_val(4'd8),
        .count_out(count_out),
        .rollover_flag(rollover_flag)
    );
    
    flex_counter #(.NUM_CNT_BITS(4)) BYTE_CNT(
        .clk(clk),
        .n_rst(n_rst),
        .clear(~rcving|byte_received),
        .count_enable(shift_enable),
        .rollover_val(4'd8),
        .count_out(byte_cnt),
        .rollover_flag(byte_received)
    );

    assign shift_enable = (count_out == 3);
endmodule

