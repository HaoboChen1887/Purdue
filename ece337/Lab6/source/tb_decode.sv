// $Id: $
// File name:   tb_decode.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench decode
`timescale 1ns/100ps
module tb_decode();
    localparam CLK_PERIOD = 10ns;
    localparam CHECK_DELAY = 5ns;
    
    reg tb_clk;
    reg tb_n_rst;
    reg tb_d_plus;
    reg tb_shift_enable;
    reg tb_eop;
    reg tb_d_orig;
    
    integer tb_expected_d_orig;
    integer tb_test_case_num;
    
    always begin:CLK_GEN
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
    end
    
    decode DUT (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .d_plus(tb_d_plus),
        .shift_enable(tb_shift_enable),
        .eop(tb_eop),
        .d_orig(tb_d_orig)
    );
    
    initial begin
        tb_test_case_num = 1;
        // test case 1 reset
        tb_expected_d_orig = 1'b1;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        if (tb_d_orig == tb_expected_d_orig)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
            
        tb_test_case_num++;
        // test case 2 output 1 (ie: the values are same)
        tb_expected_d_orig = 1'b1;
        tb_n_rst = 1'b1;
        tb_d_plus = 1'b1;
        tb_shift_enable = 1'b0;
        tb_eop = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        if (tb_d_orig == tb_expected_d_orig)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
            
        tb_test_case_num++;
        // test case 3 output 0 , from toggle from high to low(ie: the values are different)
        // reset
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_expected_d_orig = 1'b0;
        tb_n_rst = 1'b1;
        tb_eop = 1'b0;
        tb_d_plus = 1'b1;
        tb_shift_enable = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_shift_enable = 1'b1;
        @(posedge tb_clk);
        tb_shift_enable = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_d_plus = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_shift_enable = 1'b1;
        @(posedge tb_clk);
        tb_shift_enable = 1'b0;
        
        if (tb_d_orig == tb_expected_d_orig)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
            
        tb_test_case_num++;
        // test case 4 output 1 , eop = 1 when shift_enable = 1, curr1 keep comparing with 1 given d_plus = 1
        
        // reset
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        // expected output
        tb_expected_d_orig = 1'b1;
        
        tb_n_rst = 1'b1;
        tb_d_plus = 1'b1;
        tb_eop = 1'b0;
        tb_shift_enable = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_eop = 1'b1;
        tb_shift_enable = 1'b1;
        
        if (tb_d_orig == tb_expected_d_orig)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
                        
        tb_test_case_num++;
        // test case 5 output 0 , eop = 1 when shift_enable = 1, curr1 keep comparing with 1 given d_plus = 0
        
        // reset
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        // expected output
        tb_expected_d_orig = 1'b0;
        
        tb_n_rst = 1'b1;
        tb_d_plus = 1'b0;
        tb_eop = 1'b0;
        tb_shift_enable = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_eop = 1'b1;
        tb_shift_enable = 1'b1;
        
        if (tb_d_orig == tb_expected_d_orig)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        
        // test case 6 continuous reading of a byte
        
        // reset
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_n_rst = 1'b1;
        tb_d_plus = 1'b0;
        tb_eop = 1'b1;
        tb_shift_enable = 1'b1;
        // prepareing state
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        @(posedge tb_clk); // 4
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8  
        tb_eop = 1'b0;
        tb_shift_enable = 1'b0;
        tb_test_case_num = 0;
        // 1st bit
        tb_test_case_num++;
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;        
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8   
             
        // 2nd bit
        tb_test_case_num++;
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b1;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 3rd bit
        tb_test_case_num++;
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 4th bit
        tb_test_case_num++;
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 5th bit
        tb_test_case_num++;
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 6th bit
        tb_test_case_num++;
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b1;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b1;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 7th bit
        tb_test_case_num++;
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b0;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b0;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
             
        // 8th bit
        tb_test_case_num++;
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1
        @(posedge tb_clk); // 2
        @(posedge tb_clk); // 3
        tb_shift_enable = 1'b0;
        // d_plus = 00101100
        // d_orig = 11000101
        tb_expected_d_orig = 1'b0;
        if (tb_d_orig == tb_expected_d_orig)
            $info("Reading bit %d succeeded!", tb_test_case_num);
        else
            $error("Reading bit %d failed: tb_d_orig = %1d, expecting: %1d", tb_test_case_num, tb_d_orig, tb_expected_d_orig);
        @(posedge tb_clk); // 4
        tb_shift_enable = 1'b1;
        @(posedge tb_clk); // 5
        @(posedge tb_clk); // 6
        @(posedge tb_clk); // 7
        @(posedge tb_clk); // 8
        
    end
endmodule

