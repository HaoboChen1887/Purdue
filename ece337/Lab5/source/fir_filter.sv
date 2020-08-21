// $Id: $
// File name:   fir_filter.sv
// Created:     2/12/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: fir_filter.

module fir_filter(
    input wire clk,
    input wire n_reset,
    input wire [15:0] sample_data,
    input wire [15:0] fir_coefficient,
    input wire load_coeff,
    input wire data_ready,
    output wire one_k_samples,
    output wire modwait,
    output wire [15:0] fir_out,
    output wire err
);

    wire dr, lc;
    wire cnt_up;
    wire clear;
    wire [2:0] op;
    wire [3:0] src1;
    wire [3:0] src2;
    wire [3:0] dest;
    wire overflow;
    wire [16:0] outreg_data;
    
    sync_low SYNC_DR(
        .clk(clk), 
        .n_rst(n_reset), 
        .async_in(data_ready), 
        .sync_out(dr)
    );

    sync_low SYNC_LC(
        .clk(clk), 
        .n_rst(n_reset), 
        .async_in(load_coeff), 
        .sync_out(lc)
    );

    controller CTRL(
        .clk(clk),
        .n_reset(n_reset),
        .dr(dr),
        .lc(lc),
        .overflow(overflow),
        .cnt_up(cnt_up),
        .clear(clear),
        .modwait(modwait),
        .op(op),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .err(err)
    );

    datapath DATAPATH(
        .clk(clk),
        .n_reset(n_reset),
        .op(op),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .ext_data1(sample_data),
        .ext_data2(fir_coefficient),
        .outreg_data(outreg_data),
        .overflow(overflow)
    );

    magnitude MAG(
        .in(outreg_data),
        .out(fir_out)
    );

    counter CNT(
        .clk(clk),
        .n_reset(n_reset),
        .cnt_up(cnt_up),
        .clear(clear),
        .one_k_samples(one_k_samples)
    );
endmodule

