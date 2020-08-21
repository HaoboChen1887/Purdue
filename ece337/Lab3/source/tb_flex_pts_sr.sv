// $Id: $
// File name:   tb_flex_pts_sr.sv
// Created:     9/2/2013
// Author:      foo
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: Flexible Parallel to Serial shift register test bench

`timescale 1ns / 10ps

module tb_flex_pts_sr ();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	
	// Shared Test Variables
	reg tb_clk;
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// Default Config Test Variables & constants
	localparam DEFAULT_SIZE = 4;
	localparam DEFAULT_MSB = 1;

	tb_flex_pts_sr_DUT #(.SIZE(DEFAULT_SIZE), .MSB(DEFAULT_MSB)) stp_default(.tb_clk);
	tb_flex_pts_sr_DUT #(.SIZE(8),            .MSB(1), .NAME("config1")) stp_config1(.tb_clk);
	tb_flex_pts_sr_DUT #(.SIZE(4),            .MSB(0), .NAME("config2")) stp_config2(.tb_clk);
	
endmodule // tb_flex_pts_sr

module tb_flex_pts_sr_DUT
	#(parameter SIZE = 4, MSB = 1, NAME = "default")
	(input wire tb_clk);
   
	localparam MAX_BIT = (SIZE - 1);
	localparam OUT_BIT = MAX_BIT*MSB; // The bit output by the shift register
	
	integer tb_test_num;
	integer tb_i;
	integer tb_fail_cnt;
	reg tb_n_rst;
	reg [MAX_BIT:0] tb_parallel_in;
	reg tb_shift_enable;
	reg tb_load_enable;
	reg tb_serial_out;
	reg [MAX_BIT:0] tb_test_data;

	// DUT portmaps
	generate
	if(NAME == "default")
		flex_pts_sr DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.parallel_in(tb_parallel_in),
			.shift_enable(tb_shift_enable),
			.load_enable(tb_load_enable),
			.serial_out(tb_serial_out)
		);
	else if (NAME == "config1")
		pts_sr_8_msb DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.parallel_in(tb_parallel_in),
			.shift_enable(tb_shift_enable),
			.load_enable(tb_load_enable),
			.serial_out(tb_serial_out)
		);
	else if (NAME == "config2")
		pts_sr_4_lsb DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.parallel_in(tb_parallel_in),
			.shift_enable(tb_shift_enable),
			.load_enable(tb_load_enable),
			.serial_out(tb_serial_out)
		);
	endgenerate


	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst; // FIXME: Removal time (01CLK -> 01R) is 281.25ps, but this needs to be 800 to prevent metastable value warnings
		output parallel_in = tb_parallel_in,
			shift_enable = tb_shift_enable,
			load_enable = tb_load_enable;
		input serial_out = tb_serial_out;
	endclocking

	// Default Configuration Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst		= 1'b1;				// Initialize to be inactive
		// Initialize parallel in to be idle values
		tb_parallel_in		= '1;
		tb_shift_enable		= 1'b0;				// Initialize to be inactive
		tb_load_enable		= 1'b0;				// Initialize to be inactive
		tb_test_num 		= 0;
		
		// Power-on Reset of the DUT
		// Assume we start at positive edge. Immediately assert reset at first negative edge
		// without using clocking block in order to avoid metastable value warnings
		@(negedge tb_clk);
		tb_n_rst	<= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		@cb;
		cb.n_rst	<= 1'b1; 	// Deactivate the chip reset
		
		// Wait for a while to see normal operation
		@cb;
		
		// Test 1: Check for Proper Reset w/ Idle input (during reset pulse, and after reset pulse)
		tb_test_num = tb_test_num + 1;
		
		cb.shift_enable <= 1'b0;
		cb.n_rst	<= 1'b0;
		cb.parallel_in	<= 'b1;
		// Wait two cycles, long enough for the reset to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;
		// Check that the output is idle
		if (1'b1 == cb.serial_out)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);

		// Test 2: De-assert reset, and verify that the device output is still 1'b1
		tb_test_num = tb_test_num + 1;
		// Wait two cycles, long enough for the reset to get to the DUT, and to receive
		// the response back
		cb.n_rst	<= 1'b1;
		@cb;
		@cb;

		// Check that the output is idle
		if (1'b1 == cb.serial_out)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
		
		// Test 3: Check that output is IDLE/HIGH during reset pulse with both enables HIGH
		tb_test_num = tb_test_num + 1;
		// First, reset the DUT with input idle/low
		@cb;
		cb.parallel_in 	<= '0;
		cb.shift_enable	<= 1'b1;
		cb.load_enable	<= 1'b1;
		cb.n_rst	<= 1'b0;

		// Wait two cycles, long enough for the reset to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;
		// Check that the output is idle
		if (1'b1 == cb.serial_out)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);

		// Test 4: Check that a IDLE/HIGH is shifted into the high bit with load_en off
		// and shift_on on.
		tb_test_num = tb_test_num + 1;
		run_reset_DUT();
		cb.parallel_in	<= '1;
		// Perform test
		cb.parallel_in		<= '0;
		cb.shift_enable		<= 1'b1;
	
		// Wait two cycles, long enough for the shift to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;
		if (1'b1 == cb.serial_out)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
			
		// Test 5: Check for Proper Load Enable Control w/ load on and and shift off
		// Power-on Reset of the DUT (Best case conditions)
		tb_test_num = tb_test_num + 1;
		run_reset_DUT();
		cb.parallel_in	<= '0;
		cb.shift_enable	<= 1'b1;
		cb.load_enable	<= 1'b1;
		
		// leave asserted for one cycle, and then change input
		@cb;
		cb.parallel_in	<= '1;
		cb.shift_enable <= 1'b0;
		cb.load_enable	<= 1'b0; 	
		// Wait two cycles, long enough for the deassertion to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;

		if (1'b0 == cb.serial_out)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
			
		// Test 6: Reset, load a pattern, and verify that it properly shifts out
		tb_test_num = tb_test_num + 1;
		run_reset_DUT();
		cb.parallel_in	<= '0;
		cb.shift_enable	<= 1'b1;
		cb.load_enable	<= 1'b1;
		
		// leave asserted for one cycle
		@cb;
		cb.shift_enable <= 1'b0;
		cb.load_enable	<= 1'b0; 	
		
		// Wait two cycles, long enough for the deassertion to get to the DUT, and to receive
		// the response back
		@cb;
		@cb;

		if (cb.serial_out == '0)
			$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
			
		// Test 7: Check for Normal operation (load then shift). Check until output is all IDLE/low
		// Power-on Reset of the DUT (Best case conditions)
		tb_test_num = tb_test_num + 1;
		run_reset_DUT();
		// Perform test
		// Perform load
		tb_test_data =  {(SIZE/2){2'b10}};
		cb.parallel_in <= tb_test_data;
		cb.load_enable <= 1'b1;
		@cb;
		cb.load_enable <= 1'b0;
		cb.parallel_in <= '1;
		@cb;@cb;
		
		if (tb_test_data[OUT_BIT] == cb.serial_out)
		begin
			// Start shifting and track failures
			cb.shift_enable <= 1'b1;
			tb_fail_cnt = 0;
			for(tb_i = 0; tb_i < SIZE; tb_i = tb_i + 1)
			begin
				@cb;
				if (tb_test_data[OUT_BIT] != cb.serial_out)
				begin
					// Current shift test failed
					tb_fail_cnt = tb_fail_cnt + 1;
				end
				// Shift test data
				if(MSB)
					tb_test_data = {tb_test_data[(MAX_BIT - 1):0], 1'b1};
				else
					tb_test_data = {1'b1,tb_test_data[MAX_BIT:1]};
			end
			
			// Check if a failure occured
			if(0 < tb_fail_cnt)
				// Test failed
				$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
			else // Test case passed
				$info("%s Test Case %0d:: PASSED", NAME, tb_test_num);
		end
		else // Test case failed
			$error("%s Test Case %0d:: FAILED", NAME, tb_test_num);
	end

	task run_reset_DUT();
		@cb;
		cb.parallel_in 	<= '1;
		cb.shift_enable	<= 1'b0;
		cb.load_enable	<= 1'b0;
		cb.n_rst	<= 1'b0;

		@(cb);
		cb.n_rst	<= 1'b1;	// Deactivate the chip reset
		@(cb);
	endtask
endmodule // tb_flex_pts_sr_DUT

