// $Id: $
// File name:   sr_9bit.sv
// Created:     2/6/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: 9 bit shift register

module sr_9bit(
    input clk,
    input n_rst,
    input shift_strobe,
    input serial_in,
    output reg [7:0] packet_data,
    output reg stop_bit
);
    
    reg [8:0] data_all;
    flex_stp_sr #(9, 0) FLEX_STP(
        .clk(clk),
        .n_rst(n_rst),
        .serial_in(serial_in),
        .shift_enable(shift_strobe),
        .parallel_out(data_all)
    );
    assign packet_data = data_all[7:0];
    assign stop_bit = data_all[8];
endmodule

