// $Id: $
// File name:   tb_rx_fifo
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench rx_fifo
`timescale 1ns/100ps
module tb_rx_fifo();
    localparam CLK_PERIOD = 2.5ns;
    localparam CHECK_DELAY = 5ns;
    
    reg tb_clk;
    reg tb_n_rst;
    reg tb_r_enable;
    reg tb_w_enable;
    reg [7:0] tb_w_data;
    reg [7:0] tb_r_data;
    reg tb_empty;
    reg tb_full;
    
    integer tb_test_case_num;
    
    always begin
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
    end
    
    rx_fifo DUT(
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .r_enable(tb_r_enable),
        .w_enable(tb_w_enable),
        .w_data(tb_w_data),
        .r_data(tb_r_data),
        .empty(tb_empty),
        .full(tb_full)
    );
    
    initial begin
        // initialize
        @(negedge tb_clk);
        tb_n_rst = 0;
        tb_r_enable = 0;
        tb_w_enable = 0;
        tb_w_data = 0;
        tb_test_case_num = 0;
        
        // Test case 1 full flag = 0
        tb_test_case_num++;
        @(negedge tb_clk);
        tb_n_rst = 1;
        assert (tb_full == 0)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end

        // Test case 2 empty flag = 1
        tb_test_case_num++;
        assert (tb_empty == 1)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end

        // insert item to the queue
        tb_w_enable = 1;
        tb_w_data = 8'b11111111;
        #(CLK_PERIOD)
        tb_w_enable = 0;
        #(CLK_PERIOD)
        tb_w_enable = 1;
        tb_w_data = 8'b00000000;
        #(CLK_PERIOD)
        tb_w_enable = 0;
        #(CLK_PERIOD)
        tb_w_enable = 1;
        tb_w_data = 8'b10101010;
        #(CLK_PERIOD)
        tb_w_enable = 0;
        #(CLK_PERIOD)
        tb_w_enable = 1;
        tb_w_data = 8'b01010101;
        #(CLK_PERIOD)
        tb_w_enable = 0;
        #(CLK_PERIOD)
        
        // Test case 3 pop the 1st item
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b11111111)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        #(CLK_PERIOD)
        
        // Test case 3 pop the 2nd item
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b00000000)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        
        // Test case 4 pop the 3rd item
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b10101010)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        
        // insert an item in the middle
        tb_w_enable = 1;
        tb_w_data = 8'b11011011;
        #(CLK_PERIOD);
        tb_w_enable = 0;
        #(CLK_PERIOD);
        
        // Test case 5 pop the 4th item
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b01010101)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        
        // Test case 6 pop the 5th item
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b11011011)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        
        // Test case 7 pop an item from an empty queue
        tb_r_enable = 1;
        tb_test_case_num++;
        assert (tb_r_data == 8'b11011011)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        #(CLK_PERIOD)
        tb_r_enable = 0;
        
        // Try to fill the queue
        for(tb_test_case_num = 0; tb_test_case_num < 10000; tb_test_case_num++) begin
            // insert an item in the middle
            tb_w_enable = 1;
            tb_w_data = 8'b11011011;
            #(CLK_PERIOD);
            tb_w_enable = 0;
            #(CLK_PERIOD);
        end
        assert (tb_full == 1)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
        
        // Try to drain the queue
        for(tb_test_case_num = 0; tb_test_case_num < 10000; tb_test_case_num++) begin
            tb_r_enable = 1;
            #(CLK_PERIOD)
            tb_r_enable = 0;
            #(CLK_PERIOD);
        end
        assert (tb_empty == 1)begin
            $info("Test case %d succeeded", tb_test_case_num);
        end 
        else begin
            $info("Test case %d failed", tb_test_case_num);
        end
    end
endmodule

