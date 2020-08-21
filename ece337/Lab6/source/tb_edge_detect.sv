// $Id: $
// File name:   tb_edge_detect.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbech edge detect
`timescale 1ns/100ps
module tb_edge_detect();
    localparam CLK_PERIOD = 100ns;
    localparam CHECK_DELAY = 5ns;
    
    reg tb_clk;
    reg tb_n_rst;
    reg tb_d_plus;
    reg tb_d_edge;
    
    integer tb_expected_d_edge;
    integer tb_test_case_num;
    
    always begin:CLK_GEN
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
    end
    
    edge_detect DUT (
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .d_plus(tb_d_plus),
        .d_edge(tb_d_edge)
    );
    
    initial begin
        tb_test_case_num = 0;
        tb_d_plus = 1;
        // Test case 1 reset
        tb_test_case_num++;
        tb_expected_d_edge = 1'b0;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        #(CLK_PERIOD/3.0)
        assert (tb_d_edge == tb_expected_d_edge)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_edge = %b, expecting: %-d", tb_test_case_num, tb_d_edge, tb_expected_d_edge);
            
        // Test case 2 d_plus from high to low
        // Preparing stage
        tb_test_case_num++;
        tb_expected_d_edge = 1'b1;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1       
        @(posedge tb_clk); // 2       
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8   
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1      
        #(CLK_PERIOD/3.0) 
        assert (tb_d_edge == tb_expected_d_edge)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_edge = %b, expecting: %-d", tb_test_case_num, tb_d_edge, tb_expected_d_edge);
        @(posedge tb_clk); // 2       
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8        
            
        // Test case 3 d_plus from low to high
        // Preparing stage
        tb_test_case_num++;
        tb_expected_d_edge = 1'b1;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1     
        @(posedge tb_clk); // 2       
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8   
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1  
        #(CLK_PERIOD/3.0)
        assert (tb_d_edge == tb_expected_d_edge)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_edge = %b, expecting: %-d", tb_test_case_num, tb_d_edge, tb_expected_d_edge);       
        @(posedge tb_clk); // 2     
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8  
            
        // Test case 4 d_plus keep high
        // Preparing stage
        tb_test_case_num++;
        tb_expected_d_edge = 1'b0;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1    
        @(posedge tb_clk); // 2       
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8   
        tb_d_plus = 1'b1;
        @(posedge tb_clk); // 1  
        #(CLK_PERIOD/3.0)
        assert (tb_d_edge == tb_expected_d_edge)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_edge = %b, expecting: %-d", tb_test_case_num, tb_d_edge, tb_expected_d_edge);       
        @(posedge tb_clk); // 2     
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8  
            
        // Test case 5 d_plus keep low
        // Preparing stage
        tb_test_case_num++;
        tb_expected_d_edge = 1'b0;
        tb_n_rst = 1'b0;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        @(posedge tb_clk);
        
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1     
        @(posedge tb_clk); // 2       
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8   
        tb_d_plus = 1'b0;
        @(posedge tb_clk); // 1  
        #(CLK_PERIOD/3.0)
        assert (tb_d_edge == tb_expected_d_edge)
            $info("Test case %d succeeded!", tb_test_case_num);
        else
            $error("Test case %d failed: tb_d_edge = %b, expecting: %-d", tb_test_case_num, tb_d_edge, tb_expected_d_edge);       
        @(posedge tb_clk); // 2     
        @(posedge tb_clk); // 3       
        @(posedge tb_clk); // 4       
        @(posedge tb_clk); // 5       
        @(posedge tb_clk); // 6       
        @(posedge tb_clk); // 7       
        @(posedge tb_clk); // 8  
    end
endmodule

