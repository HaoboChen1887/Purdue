// $Id: $
// File name:   shift_register.sv
// Created:     2/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: shift_register

module shift_register(
    input wire clk,
    input wire n_rst,
    input wire shift_enable,
    input wire d_orig,
    output wire [7:0] rcv_data
);

    reg [7:0] tmp;
    flex_stp_sr #(8, 0) SHIFT_REG (
        .clk(clk),
        .n_rst(n_rst),
        .serial_in(d_orig),
        .shift_enable(shift_enable),
        .parallel_out(tmp)
    );
    assign rcv_data = tmp;

endmodule

