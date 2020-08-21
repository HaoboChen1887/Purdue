// $Id: $
// File name:   tb_adder_nbit.sv
// Created:     1/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: testbench for nbit adder.
`timescale 1ns / 100ps

module tb_adder_16bit
();
	// Define local parameters used by the test bench
	localparam NUM_INPUT_BITS			= 16;
	localparam NUM_OUTPUT_BITS		= NUM_INPUT_BITS + 1; // 17
	localparam MAX_OUTPUT_BIT			= NUM_OUTPUT_BITS - 1; //  16
	localparam NUM_TEST_BITS 			= (NUM_INPUT_BITS * 2) + 1; // 33
	localparam MAX_TEST_BIT				= NUM_TEST_BITS - 1; // 32
	localparam NUM_TEST_CASES 		= 2 ** NUM_TEST_BITS; // 2^33
	localparam MAX_TEST_VALUE 		= NUM_TEST_CASES - 1; // 2^33 - 1
	localparam TEST_A_BIT					= 0; 
	localparam TEST_B_BIT					= NUM_INPUT_BITS; // 16
	localparam TEST_CARRY_IN_BIT	= MAX_TEST_BIT; // 32
	localparam TEST_SUM_BIT				= 0;
	localparam TEST_CARRY_OUT_BIT	= MAX_OUTPUT_BIT; // 16
	localparam TEST_DELAY					= 10;
	
	// Declare Design Under Test (DUT) portmap signals
	reg [15:0] tb_a;
	reg [15:0] tb_b;
	reg tb_carry_in;
	wire	[NUM_INPUT_BITS - 1:0] tb_sum;
	wire	tb_carry_out;
	
	// Declare test bench signals
	integer tb_test_case;
	reg [MAX_TEST_BIT:0] tb_test_inputs;
	reg [MAX_OUTPUT_BIT:0] tb_expected_outputs;
	reg no_match;
	
	// DUT port map
	adder_16bit DUT(.a(tb_a), .b(tb_b), .carry_in(tb_carry_in), .sum(tb_sum), .overflow(tb_carry_out));
	
	// Connect individual test input bits to a vector for easier testing
		
	
	
	
	// Test bench process
	initial
	begin
		// Test Case 0: A = 0x0000 B = 0x0000
		tb_a = 16'h0000;
		tb_b = 16'h0000;
		tb_carry_in ='0;
		tb_test_inputs = 0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;
		
		// Test Case 1: Large A, Small B
		tb_a = 16'hEEEE;
		tb_b = 16'h0001;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 2: Large B, Small A
		tb_a = 16'h0001;
		tb_b = 16'hEEEE;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 3: Large A, Large B
		tb_a = 16'hEEEE;
		tb_b = 16'hEEEE;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 4: Small A, Small B
		tb_a = 16'h0001;
		tb_b = 16'h0001;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 5
		tb_a = 16'h0A0A;
		tb_b = 16'h0A0A;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 6
		tb_a = 16'h7FFF;
		tb_b = 16'h7FFF;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 6
		tb_a = 16'hFFFF;
		tb_b = 16'hFFFF;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 7
		tb_a = 16'hA0A0;
		tb_b = 16'h0A0A;
		tb_carry_in ='0;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 8
		tb_a = 16'hFFFF;
		tb_b = 16'hFFFF;
		tb_carry_in ='1;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;

		// Test Case 8
		tb_a = 16'hC0C0;
		tb_b = 16'h0C0C;
		tb_carry_in ='1;
		// Calculate the expected outputs
		tb_expected_outputs = tb_a + tb_b + tb_carry_in;
		// Wait for DUT to process the inputs
		#1
		#(TEST_DELAY - 1);
		// Check the DUT's Sum output value
		if(tb_expected_outputs[15:0] == tb_sum)
		begin
			$info("Correct Sum value for test case %d!", tb_test_inputs);
			no_match = 0;
		end
		else
		begin
			$error("Incorrect Sum value for test case %d!", tb_test_case);
			no_match = 1;
		end
		assert(no_match == 0)
		else
			$error("The DUT does not match the expected output values");
		tb_test_inputs = tb_test_inputs + 1;
	end
	// Wrap-up process
	final
	begin
		if(NUM_TEST_CASES != tb_test_case)
		begin
			// Didn't run the test bench through all test cases
			$display("This test bench was not run long enough to execute all test cases. Please run this test bench for at least a total of %d ns", (NUM_TEST_CASES * TEST_DELAY));
		end
		else
		begin
			// Test bench was run to completion
			$display("This test bench has run to completion");
		end
	end
endmodule
