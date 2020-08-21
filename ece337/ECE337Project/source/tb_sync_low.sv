// 337 TA Provided Lab 2 Testbench
// This code serves as a starer test bench for the synchronizer design
// STUDENT: Replace this message and the above header section with an
// appropriate header based on your other code files

// 0.5um D-FlipFlop Timing Data Estimates:
// Data Propagation delay (clk->Q): 670ps
// Setup time for data relative to clock: 190ps
// Hold time for data relative to clock: 10ps

`timescale 1ns / 10ps

module tb_sync_low();

	// Define local parameters used by the test bench
	localparam	CLK_PERIOD		= 1;
	localparam	FF_SETUP_TIME	= 0.190;
	localparam	FF_HOLD_TIME	= 0.100;
	localparam	CHECK_DELAY 	= (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts
	
	localparam	RESET_OUTPUT_VALUE	= 1'b0;
	
	// Declare DUT portmap signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_async_in;
	wire tb_sync_out;
	
	// Declare test bench signals
	integer tb_test_num;
	string tb_test_case;
	integer tb_stream_test_num;
	
	// Clock generation block
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	// DUT Port map
	sync_low DUT(.clk(tb_clk), .n_rst(tb_n_rst), .async_in(tb_async_in), .sync_out(tb_sync_out));
	
	// Test bench main process
	initial
	begin
		// Initialize all of the test inputs
		tb_n_rst	= 1'b1;		// Initialize to be inactive
		tb_async_in	= 1'b0;		// Initialize to be low
		tb_test_num = 0;
		tb_test_case = "Test bench initializaton";
		#(0.1);
		
		// Test Case 1: Power-on Reset of the DUT
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Power on Reset";
		#(0.1);
		tb_n_rst	= 1'b0; 	// Activate reset
		tb_async_in	= 1'b1;		// Set to be the the non-reset value
		#(CLK_PERIOD * 0.5);
		// Check that internal state was correctly reset
		if(RESET_OUTPUT_VALUE == tb_sync_out)
		begin
			$info("Correct synchronizer output after reset applied in %s test case", tb_test_case);
		end
		else
		begin
			$error("Incorrect synchronizer output after reset applied in %s test case", tb_test_case);
		end
		// Check that the reset value is maintained during a clock cycle
		#(CLK_PERIOD);
		if(RESET_OUTPUT_VALUE == tb_sync_out)
		begin
			$info("Correct synchronizer output after clock cycle while in reset applied in %s test case", tb_test_case);
		end
		else
		begin
			$error("Incorrect synchronizer output after clock cycle while in reset applied in %s test case", tb_test_case);
		end
		
		// Release the reset away from a clock edge
		@(posedge tb_clk);
		#(2 * FF_HOLD_TIME);
		tb_n_rst	= 1'b1; 	// Deactivate the chip reset
		#0.1;
		// Check that internal state was correctly keep after reset release
		if(RESET_OUTPUT_VALUE == tb_sync_out)
		begin
			$info("Correct synchronizer output after reset was released in %s test case", tb_test_case);
		end
		else
		begin
			$error("Incorrect synchronizer output after reset was released in %s test case", tb_test_case);
		end
	
		// Test Case 2: Normal Operation with Input as a '1'
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Normal Operation with Input as a '1'";
		tb_async_in = 1'b1;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if(1'b1 == tb_sync_out)
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end
		
		// Test Case 3: Setup Violation with Input as a '0'
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Setup Violation with Input as a '0'";
		@(posedge tb_clk);
		#(CLK_PERIOD - (FF_SETUP_TIME * 0.5)); // Make sure the value get's updated during the setup time -> setup violation
		tb_async_in = 1'b0;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if((1'b1 == tb_sync_out) || (1'b0 == tb_sync_out))
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end
		
		// Test Case 4: Hold Violation with Input as a '1'
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Hold Violation with Input as a '1'";
		@(posedge tb_clk);
		#(FF_HOLD_TIME * 0.5); // Make sure the value get's updated during the hold time -> setup violation
		tb_async_in = 1'b1;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if((1'b1 == tb_sync_out) || (1'b0 == tb_sync_out))
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end
		
		// Test Case 5: Steady Stream of Unkown/Metastable inputs to showcase random decay behavior
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Steady Stream of Metastable inputs";
		for(tb_stream_test_num = 0; tb_stream_test_num < 100; tb_stream_test_num = tb_stream_test_num + 1)
		begin
			@(negedge tb_clk); 
			tb_async_in = 1'bx;
			@(posedge tb_clk);
			@(posedge tb_clk); 
		  #(CHECK_DELAY);
			if((1'b1 == tb_sync_out) || (1'b0 == tb_sync_out))
			begin // Test case passed
				$info("Correct synchronizer output for %s test case iteration %d", tb_test_case, tb_stream_test_num);
			end
			else
			begin // Test case failed
				$error("Incorrect synchronizer output for %s test case iteration %d test case", tb_test_case, tb_stream_test_num);
			end
		end
		
		// STUDENT: Add your tests after this point
	        // Test Case 6: Normal Operation with Input as a '0'
		@(negedge tb_clk);
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Normal Operation with Input as a '0'";
		tb_async_in = 1'b0;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if(1'b1 == tb_sync_out)
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end

	   	// Test Case 7: Setup Violation with Input as a '1'
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Setup Violation with Input as a '1'";
		@(posedge tb_clk);
		#(CLK_PERIOD - (FF_SETUP_TIME * 0.5)); // Make sure the value get's updated during the setup time -> setup violation
		tb_async_in = 1'b1;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if((1'b1 == tb_sync_out) || (1'b0 == tb_sync_out))
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end
		// Test Case 8: Hold Violation with Input as a '0'
		@(negedge tb_clk); 
		tb_test_num = tb_test_num + 1;
		tb_test_case = "Hold Violation with Input as a '0'";
		@(posedge tb_clk);
		#(FF_HOLD_TIME * 0.5); // Make sure the value get's updated during the hold time -> setup violation
		tb_async_in = 1'b0;
		@(posedge tb_clk); 
		@(posedge tb_clk); 
		#(CHECK_DELAY);
		if((1'b1 == tb_sync_out) || (1'b0 == tb_sync_out))
		begin // Test case passed
			$info("Correct synchronizer output for %s test case", tb_test_case);
		end
		else
		begin // Test case failed
			$error("Incorrect synchronizer output for %s test case", tb_test_case);
		end
	   
	end
endmodule
