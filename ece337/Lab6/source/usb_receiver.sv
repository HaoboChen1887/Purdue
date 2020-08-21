// $Id: $
// File name:   usb_receiver.sv
// Created:     2/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: usb receiver

module usb_receiver(
    input wire clk,
    input wire n_rst,
    input wire d_plus,
    input wire d_minus,
    input wire r_enable,
    output wire [7:0] r_data,
    output wire empty,
    output wire full,
    output wire rcving,
    output wire r_error
);

    wire d_plus_sync;
    wire d_minus_sync;
    wire eop;
    wire d_edge;
    wire shift_enable;
    wire d_orig;
    wire byte_received;
    wire [7:0] rcv_data;
    sync_high SYNC_P (
        .clk(clk),
        .n_rst(n_rst),
        .async_in(d_plus),
        .sync_out(d_plus_sync)
    );
    
    sync_low SYNC_M (
        .clk(clk),
        .n_rst(n_rst),
        .async_in(d_minus),
        .sync_out(d_minus_sync)
    );
    
    eop_detect EOP (
        .d_plus(d_plus_sync),
        .d_minus(d_minus_sync),
        .eop(eop)
    );
    
    edge_detect EDGE (
        .clk(clk),
        .n_rst(n_rst),
        .d_plus(d_plus_sync),
        .d_edge(d_edge)
    );
    
    decode DECODE (
        .clk(clk),
        .n_rst(n_rst),
        .d_plus(d_plus_sync),
        .shift_enable(shift_enable),
        .eop(eop),
        .d_orig(d_orig)
    );
    
    timer TIMER (
        .clk(clk),
        .n_rst(n_rst),
        .d_edge(d_edge),
        .rcving(rcving),
        .shift_enable(shift_enable),
        .byte_received(byte_received)
    );
    
    shift_register SHIFT_REG (
        .clk(clk),
        .n_rst(n_rst),
        .d_orig(d_orig),
        .shift_enable(shift_enable),
        .rcv_data(rcv_data)
    );
    
    rx_fifo RX_FIFO (
        .clk(clk),
        .n_rst(n_rst),
        .r_enable(r_enable),
        .w_enable(w_enable),
        .w_data(rcv_data),
        .r_data(r_data),
        .empty(empty),
        .full(full) 	    
    );
    
    rcu RCU (
        .clk(clk),
        .n_rst(n_rst),
        .d_edge(d_edge),
        .eop(eop),
        .shift_enable(shift_enable),
        .rcv_data(rcv_data),
        .byte_received(byte_received),
        .rcving(rcving),
        .w_enable(w_enable),
        .r_error(r_error)
    );

endmodule

