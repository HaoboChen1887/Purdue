// $Id: $
// File name:   tb_flex_counter.sv
// Created:     1/29/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for flex counter
`timescale 1ns / 100ps

module tb_flex_counter();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam NUM_CNT_BITS = 10;

	reg tb_clk;
	reg tb_n_rst;
	reg tb_clear;
	reg tb_count_enable;
    	reg [NUM_CNT_BITS-1:0] tb_rollover_val;
    	reg [NUM_CNT_BITS-1:0] tb_count_out;
    	reg [NUM_CNT_BITS-1:0] tb_expected_out;
    	reg tb_rollover_flag;
    	reg tb_expected_flag;
    	integer testcase;


    	flex_counter #(NUM_CNT_BITS) DUT 
    	( 
		.clk(tb_clk),
    	    	.n_rst(tb_n_rst),
    	    	.clear(tb_clear),
    	    	.count_enable(tb_count_enable),
    	   	.rollover_val(tb_rollover_val),
    	    	.count_out(tb_count_out),
    	    	.rollover_flag(tb_rollover_flag) 
    	);
	
	always begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end

	initial begin
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
        	@(posedge tb_clk)

        	//TEST CASE 1
        	testcase = 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 4;
        	tb_count_enable = 1'b0;
		tb_clear = 1'b1;

        	@(posedge tb_clk); 
        	#(CHECK_DELAY);
        	if((tb_count_out == 0) && (tb_rollover_flag == 0)) begin
        	    $info("Test case 1: Passed");
		end
        	else begin
        	    $error("Test case 1: Failed");
		end
        	
        	
        	//TEST CASE 2
        	
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
       	
        	testcase = testcase + 1;
	
		tb_n_rst = 1'b0;		
        	tb_rollover_val = 4;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
	
    	
        	#(CHECK_DELAY);
        	if((tb_count_out == 0) && (tb_rollover_flag == 0)) begin
        	    $info("Test case 2: Passed");
		end
        	else begin
        	    $error("Test case 2: Failed");
		end
	
	
        	//TEST CASE 3
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
       	
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 3;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
	
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	
        	#(CHECK_DELAY);
        	if((tb_count_out == tb_rollover_val) && (tb_rollover_flag == 1)) begin
        	    $info("Test case 3: Passed");
		end
        	else begin
        	    $error("Test case 3: Failed");
		end
	
        	//TEST CASE 4
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
        	
        	testcase = testcase + 1;
        	tb_count_enable = 1'b0;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 5;
        	
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
      	
        	#(CHECK_DELAY);
        	if((tb_count_out == 0) && (tb_rollover_flag == 0)) begin
        	    $info("Test case 4: Passed");
		end
        	else begin
        	    $error("Test case 4: Failed");
		end
	
        	//TEST CASE 5
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
      	
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 4;
        	tb_count_enable = 1'b1;
			
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk);
        	
        	tb_n_rst = 1'b0; 
        	@(posedge tb_clk);
	
        	#(CHECK_DELAY);
        	if((tb_count_out == 0) && (tb_rollover_flag == 0)) begin
        	    $info("Test case 5: Passed");
		end
        	else begin
        	    $error("Test case 5: Failed");
		end
	
        	//TEST CASE 6
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
	
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 6;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
		
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	
        	#(CHECK_DELAY);
        	if((tb_count_out == tb_rollover_val) && (tb_rollover_flag == 1)) begin
        	    $info("Test case 6: Passed");
		end
        	else begin
        	    $error("Test case 6: Failed");
		end
	
        	//TEST CASE 7
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 7;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
	
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
	
        	#(CHECK_DELAY);
        	if((tb_count_out == tb_rollover_val) && (tb_rollover_flag == 1)) begin
        	    $info("Test case 7: Passed");
		end
        	else begin
        	    $error("Test case 7: Failed");
		end
	
        	//TEST CASE 8
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
       	
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 8;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
	
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	
        	#(CHECK_DELAY);
        	if((tb_count_out == tb_rollover_val) && (tb_rollover_flag == 1)) begin
        	    $info("Test case 8: Passed");
		end
        	else begin
        	    $error("Test case 8: Failed");
		end
	
        	//TEST CASE 9
        	@(posedge tb_clk);
        	tb_clear = 1'b1;
        	@(posedge tb_clk);
        	tb_clear = 1'b0;
       	
        	testcase = testcase + 1;
		tb_n_rst = 1'b1;		
        	tb_rollover_val = 9;
        	tb_count_enable = 1'b1;
		tb_clear = 1'b0;
	
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk); 
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	@(posedge tb_clk);
        	
        	#(CHECK_DELAY);
        	if((tb_count_out == tb_rollover_val) && (tb_rollover_flag == 1)) begin
        	    $info("Test case 9: Passed");
		end
        	else begin
        	    $error("Test case 9: Failed");
		end
	end
endmodule

