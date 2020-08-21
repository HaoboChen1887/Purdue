// $Id: $
// File name:   tb_win_buf.sv
// Created:     4/22/2018
// Author:      Ni Kang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for window buffer
`timescale 1ns/100ps
module tb_win_buf();
    localparam CLK_PERIOD = 2;
    
    reg tb_clk;
    reg tb_n_rst;
    reg [3:0][7:0] tb_in_buf;
    reg [2:0] tb_row_in_buf;
    reg [2:0] tb_col_in_buf;
    reg tb_new_row;
    reg tb_incdec;
    reg tb_r_enable;
    reg tb_w_enable;
    reg tb_init;
    reg tb_full;
    reg tb_fill_done;
    reg [2:0][2:0][7:0] tb_out_buf;
    
    always
    begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end
	
    win_buf DUT(
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .in_buf(tb_in_buf),
        .row_in_buf(tb_row_in_buf),
        .col_in_buf(tb_col_in_buf),
        .new_row(tb_new_row),
        .incdec(tb_incdec),
        .r_enable(tb_r_enable),
        .w_enable(tb_w_enable),
        .init(tb_init),
        .full(tb_full),
        .fill_done(tb_fill_done),
        .out_buf(tb_out_buf)
    );
	
    integer test_num;

    initial begin
        test_num = 1'b0;
        tb_n_rst = 1'b0;
        tb_row_in_buf = 1'b0;
        tb_col_in_buf = 1'b0;
        tb_new_row = 1'b0;
        tb_incdec = 1'b0;
        tb_r_enable = 1'b0;
        tb_w_enable = 1'b0;
        tb_init = 1'b1;

        // Initilization Case
        tb_in_buf = {8'd1, 8'd2, 8'd3, 8'd4};
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);

        test_num = test_num + 1;
        tb_n_rst = 1'b1;
        tb_r_enable = 1'b1;
        #(CLK_PERIOD * 40);
        @(posedge tb_clk);
        
        // Left Shift Case
        tb_r_enable = 1'b0;
        tb_n_rst = 1'b0;
        tb_in_buf = {8'd11, 8'd22, 8'd33, 8'd44};
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        tb_r_enable = 1'b1;
        tb_init = 1'b0;
        #(CLK_PERIOD * 40);
        @(posedge tb_clk);
        
        // Right Shift Case
        tb_r_enable = 1'b0;
        tb_n_rst = 1'b0;
        tb_in_buf = {8'd211, 8'd222, 8'd233, 8'd244};
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        tb_r_enable = 1'b1;
        tb_init = 1'b0;
        tb_incdec = 1'b1;
        #(CLK_PERIOD * 40);
        @(posedge tb_clk);
        
        // Down Shift Case
        tb_r_enable = 1'b0;
        tb_n_rst = 1'b0;
        tb_in_buf = {8'd211, 8'd222, 8'd233, 8'd244};
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        tb_r_enable = 1'b1;
        tb_init = 1'b0;
        tb_incdec = 1'b0;
        tb_new_row = 1'b1;
        #(CLK_PERIOD * 40);
        @(posedge tb_clk);  
              
        // Save data
        tb_r_enable = 1'b0;
        tb_row_in_buf = 3'd4;
        tb_col_in_buf = 3'd4;
        tb_r_enable = 1'b1;
        tb_w_enable = 1'b1;
        
        
    end
    
endmodule
