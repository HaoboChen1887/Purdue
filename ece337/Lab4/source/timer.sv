// $Id: $
// File name:   timer.sv
// Created:     2/6/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: timer module

module timer(
    input clk,
    input n_rst,
    input enable_timer,
    output reg shift_strobe,
    output reg packet_done
);
    reg [3:0] garbage1;
    reg [3:0] garbage2;
    flex_counter #(4) CLK_DIV(
        .clk(clk),
        .n_rst(n_rst),
        .clear(packet_done),
        .count_enable(enable_timer),
        .rollover_val(4'd10),
        .count_out(garbage1),
        .rollover_flag(shift_strobe)
    );

    flex_counter #(4) CNT_BIT(
        .clk(clk),
        .n_rst(n_rst),
        .clear(packet_done),
        .count_enable(shift_strobe),
        .rollover_val(4'd9),
        .count_out(garbage2),
        .rollover_flag(packet_done)
    );

endmodule
