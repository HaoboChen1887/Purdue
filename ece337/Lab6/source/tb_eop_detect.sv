// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench eop_detect
`timescale 1ns/100ps
module tb_eop_detect();    
    reg tb_d_minus;
    reg tb_d_plus;
    reg tb_eop;
    
    integer tb_expected_eop;
    integer tb_test_case_num;
    
    eop_detect DUT(
        .d_plus(tb_d_plus),
        .d_minus(tb_d_minus),
        .eop(tb_eop)
    );
    
    initial begin
        tb_test_case_num = 0;
        // Test case 1
        tb_test_case_num++;
        tb_d_minus = 1'b0;
        tb_d_plus = 1'b0;
        tb_expected_eop = 1'b1;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);
            
        // Test case 2
        tb_test_case_num++;
        tb_d_minus = 1'b0;
        tb_d_plus = 1'b1;
        tb_expected_eop = 1'b0;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);
        
        // Test case 3
        tb_test_case_num++;
        tb_d_minus = 1'b1;
        tb_d_plus = 1'b0;
        tb_expected_eop = 1'b0;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);
        
        // Test case 4
        tb_test_case_num++;
        tb_d_minus = 1'b1;
        tb_d_plus = 1'b1;
        tb_expected_eop = 1'b0;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);  
                  
        // Test case 5
        tb_test_case_num++;
        tb_d_minus = 1'b1;
        tb_d_plus = 1'b0;
        tb_expected_eop = 1'b0;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);            
                  
        // Test case 6
        tb_test_case_num++;
        tb_d_minus = 1'b0;
        tb_d_plus = 1'b1;
        tb_expected_eop = 1'b0;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);  
                  
        // Test case 7
        tb_test_case_num++;
        tb_d_minus = 1'b0;
        tb_d_plus = 1'b0;
        tb_expected_eop = 1'b1;
        #(10);
        assert(tb_expected_eop == tb_eop)
            $info("Test case %b%b succeeded", tb_d_minus, tb_d_plus);
        else
            $info("Test case %b%b failed, eop = %b, expecting: %d", tb_d_minus, tb_d_plus, tb_eop, tb_expected_eop);
    end
endmodule


