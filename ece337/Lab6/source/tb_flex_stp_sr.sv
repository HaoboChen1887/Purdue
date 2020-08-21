// $Id: $
// File name:   tb_flex_stp_sr.sv
// Created:     9/2/2013
// Author:      foo
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: Flexible Serial to Parallel Shift register test bench

`timescale 1ns / 10ps

module tb_flex_stp_sr ();

	// Define parameters
	// basic test bench parameters
	localparam	CLK_PERIOD	= 2.5;
	localparam	CHECK_DELAY = 1; // Check 1ns after the rising edge to allow for propagation delay
	
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
	
	localparam DEFAULT_SIZE = 4;
	localparam DEFALUT_MSB  = 1;

	tb_flex_stp_sr_DUT #(.SIZE(DEFAULT_SIZE), .MSB(DEFALUT_MSB)) stp_default(.tb_clk);
	tb_flex_stp_sr_DUT #(.SIZE(8),		  .MSB(1), .NAME("config1")) stp_config1(.tb_clk);
	tb_flex_stp_sr_DUT #(.SIZE(4),		  .MSB(0), .NAME("config2")) stp_config2(.tb_clk);
endmodule

module tb_flex_stp_sr_DUT
	#(parameter SIZE = 4, MSB = 1, NAME = "default")
	(input wire tb_clk);

	// Default Config Test Variables & constants
	localparam MAX_BIT = (SIZE - 1);
	
	integer tb_test_num;
	reg tb_n_rst;
	reg [MAX_BIT:0] tb_parallel_out;
	reg tb_shift_enable;
	reg tb_serial_in;
	reg [MAX_BIT:0] tb_test_data;
	reg [MAX_BIT:0] tb_expected_out;

	generate
	if(NAME == "default")
	// DUT portmaps
		flex_stp_sr DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.serial_in(tb_serial_in),
			.shift_enable(tb_shift_enable),
			.parallel_out(tb_parallel_out)
		);
	else if (NAME == "config1")
		stp_sr_8_msb DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.serial_in(tb_serial_in),
			.shift_enable(tb_shift_enable),
			.parallel_out(tb_parallel_out)
		);
	else if (NAME == "config2")
		stp_sr_4_lsb DUT
		(
			.clk(tb_clk),
			.n_rst(tb_n_rst),
			.serial_in(tb_serial_in),
			.shift_enable(tb_shift_enable),
			.parallel_out(tb_parallel_out)
		);
	endgenerate
	
	clocking cb @(posedge tb_clk);
 		// 1step means 1 time precision unit, 10ps for this module. We assume the hold time is less than 200ps.
		default input #1step output #100ps; // Setup time (01CLK -> 10D) is 94 ps
		output #800ps n_rst = tb_n_rst; // FIXME: Removal time (01CLK -> 01R) is 281.25ps, but this needs to be 800 to prevent metastable value warnings
		output serial_in = tb_serial_in,
			shift_enable = tb_shift_enable;
		input parallel_out = tb_parallel_out;
	endclocking
	
	// Default Configuration Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst		= 1'b1;		// Initialize to be inactive
		tb_serial_in	= 1'b1;		// Initialize to be idle
		tb_shift_enable		= 1'b0;		// Initialize to be inactive
		tb_test_num 	= 0;
		
		tb_test_data = '1;
		
		tb_expected_out = '1;
		
		// Power-on Reset of the DUT
		// Assume we start at negative edge. Immediately assert reset at first negative edge
		// without using clocking block in order to avoid metastable value warnings
		@(negedge tb_clk);
		tb_n_rst	<= 1'b0; 	// Need to actually toggle this in order for it to actually run dependent always blocks
		@cb;
		cb.n_rst	<= 1'b1; 	// Deactivate the chip reset
		
		// Wait for a while to see normal operation
		@cb;
		@cb;
		
		// Test 1: Check for Proper Reset w/ Idle (serial_in=1) input during reset signal
		tb_test_num = tb_test_num + 1;
		cb.n_rst <= 1'b0;
		cb.serial_in <= 1'b1;
		cb.shift_enable <= 1'b0;
		
		tb_test_data = '1;
		tb_expected_out = '1;
		@cb; // Measure slightly before the second clock edge
		@cb;
		if (tb_expected_out == cb.parallel_out)
			$info("%s Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Case %0d:: FAILED", NAME, tb_test_num);
		// De-assert reset for a cycle
		cb.n_rst <= 1'b1;
		@cb;
		
		// Test 2: Check for Proper Reset w/ Active (serial_in=0) inputs during reset signal
		tb_test_num = tb_test_num + 1;
		cb.n_rst <= 1'b0;
		cb.serial_in <= 1'b0;
		cb.shift_enable <= 1'b1;
		
		tb_test_data = '1;
		tb_expected_out = '1;
		@cb;
		if (tb_expected_out == cb.parallel_out)
			$info("%s Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Case %0d:: FAILED", NAME, tb_test_num);
		// De-assert reset for a cycle
		cb.n_rst <= 1'b1;
		@cb;
		
		// Test 3: Check for Proper Shift Enable Control w/ enable off and serial_in low
		// Power-on Reset of the DUT (Best case conditions)
		tb_test_num = tb_test_num + 1;
		run_reset_DUT();
		
		// Perform test
		cb.serial_in 	<= 1'b0;
		cb.shift_enable	<= 1'b0;
		
		tb_expected_out = '1;
		
		@(cb);
		@(cb);
		if (tb_expected_out == cb.parallel_out)
			$info("%s Case %0d:: PASSED", NAME, tb_test_num);
		else // Test case failed
			$error("%s Case %0d:: FAILED", NAME, tb_test_num);
		
		// Test 4: Check for Proper Shift Enable Control w/ enable on for one shift
		// Power-on Reset of the DUT (Best case conditions)
		@(cb); 
		tb_test_num = tb_test_num + 1;
		run_shift_test(.num_shifts(1), .test_data({(SIZE){1'b0}}));
		
		// Test 5: Check for Proper Shift Enable Control w/ enable on for full value shift
		// Power-on Reset of the DUT (Best case conditions)
		@(cb); 
		tb_test_num = tb_test_num + 1;
		run_shift_test(.num_shifts(SIZE), .test_data({(SIZE){1'b0}}));
		
		// Test 6: Check for Proper Shift Enable Control w/ enable on and mixed values
		// Power-on Reset of the DUT (Best case conditions)
		@(cb); 
		tb_test_num = tb_test_num + 1;
		run_shift_test(.num_shifts(SIZE), .test_data({(SIZE/2){2'b10}}));
	end

	task automatic run_reset_DUT();
		cb.serial_in 	<= 1'b1;
		cb.shift_enable	<= 1'b0;
		cb.n_rst	<= 1'b0;

		@(cb);
		cb.n_rst	<= 1'b1;	// Deactivate the chip reset
	endtask
	// Define outside of task so that they have a per-module scope. Declaring the task as
	// "automatic" would be correct, but make it hard to see the variables in the simulator
	integer tb_fail_cnt;
	reg [MAX_BIT:0] expected_out;
	integer shift_test_i;
	task automatic run_shift_test(input integer num_shifts, input [SIZE-1:0] test_data);

		run_reset_DUT();
		// Prep for shifting
		cb.shift_enable	<= 1'b1;

		expected_out = '1;
		
		// Shift through the full value and track failure(s)
		tb_fail_cnt = 0;
		for(shift_test_i = 0; shift_test_i < num_shifts; shift_test_i = shift_test_i + 1)
		begin
			// Schedule the new serial input value
			cb.serial_in <= test_data[(MAX_BIT - shift_test_i)]; 
			// Go to the next edge
			@(cb);
			// Compare expected output with actual and track failure(s)
			if (expected_out != cb.parallel_out)
			begin
				// Current shift failed
				tb_fail_cnt = tb_fail_cnt + 1;
			end
			// The next verification will include the previously shifted value
			if(MSB)
				expected_out = {expected_out[(MAX_BIT - 1):0], test_data[(MAX_BIT - shift_test_i)]};
			else
				expected_out = {test_data[(MAX_BIT - shift_test_i)], expected_out[(MAX_BIT):1]}; 
		end 
	   	@cb;
		// Compare the final expected output with actual and track failure(s)
		if (expected_out != cb.parallel_out)
		begin
			// Current shift failed
			tb_fail_cnt = tb_fail_cnt + 1;
		end
		// Check for failure(s)
		if(0 < tb_fail_cnt)
		begin
			// Test failed
			$error("%s Case %0d:: FAILED", NAME, tb_test_num);
		end
		else
		begin
			// Test passed
			$info("%s Case %0d:: PASSED", NAME, tb_test_num);
		end
	endtask
endmodule
