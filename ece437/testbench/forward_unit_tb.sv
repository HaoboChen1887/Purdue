`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module forward_unit_tb;
  parameter PERIOD = 10;
  forward_unit_if fuif();
  test PROG(fuif);
 

`ifndef MAPPED
  forward_unit DUT(fuif);
`else
  forward_unit DUT(
	.\fuif.memwsel (fuif.memwsel),
	.\fuif.wbwsel (fuif.wbwsel),
	.\fuif.memWEN (fuif.memWEN),
	.\fuif.wbWEN (fuif.wbWEN),
	.\fuif.rs (fuif.rs),
	.\fuif.rt (fuif.rt),
	.\fuif.exinstr (fuif.exinstr),

	.\fuif.forwarda (fuif.forwarda),
	.\fuif.forwardb (fuif.forwardb)
);
`endif

endmodule

program test(
	forward_unit_if fuif
);

  initial begin
    parameter PERIOD = 10;
    // init set up
    fuif.memwsel = 0;
    fuif.wbwsel = 0;
    fuif.memWEN = 0;
    fuif.wbWEN = 0;
    fuif.rs = 0;
    fuif.rt = 0;
    fuif.exinstr = 0;
    #(PERIOD)

   	fuif.memwsel = 3;
   	fuif.memWEN = 1;
   	fuif.rs = 3;
   	fuif.rt = 0;
   	#(PERIOD)
   	if(fuif.forwarda == 2'b10)
   	begin
   		$display("Test case 1 Passed!");
   	end
   	else
   	begin
   		$display("Test case 1 Failed");
   	end
   	fuif.memwsel = 0;
    fuif.wbwsel = 0;
    fuif.memWEN = 0;
    fuif.wbWEN = 0;
    fuif.rs = 0;
    fuif.rt = 0;
    fuif.exinstr = 0;
   	#(PERIOD)

   	fuif.memwsel = 3;
   	fuif.memWEN = 1;
   	fuif.rs = 0;
   	fuif.rt = 3;
   	fuif.exinstr = 32'h10E00004; //BEQ R7, R0, 56
   	 #(PERIOD)
   	if(fuif.forwardb == 2'b10)
   	begin
   		$display("Test case 2 Passed!");
   	end
   	else
   	begin
   		$display("Test case 2 Failed");
   	end
   	fuif.memwsel = 0;
    fuif.wbwsel = 0;
    fuif.memWEN = 0;
    fuif.wbWEN = 0;
    fuif.rs = 0;
    fuif.rt = 0;
    fuif.exinstr = 0;
   	#(PERIOD)



   	fuif.wbwsel = 3;
   	fuif.wbWEN = 1;
   	fuif.rs = 3;
   	fuif.rt = 0;
   	 #(PERIOD)
   	if(fuif.forwarda == 2'b01)
   	begin
   		$display("Test case 3 Passed!");
   	end
   	else
   	begin
   		$display("Test case 3 Failed!");
   	end
   	fuif.memwsel = 0;
    fuif.wbwsel = 0;
    fuif.memWEN = 0;
    fuif.wbWEN = 0;
    fuif.rs = 0;
    fuif.rt = 0;
    fuif.exinstr = 0;
   	#(PERIOD)

   	fuif.wbwsel = 3;
   	fuif.wbWEN = 1;
   	fuif.rs = 3;
   	fuif.rt = 3;
   	fuif.exinstr = 32'h10E00004; //BEQ R7, R0, 56
   	 #(PERIOD)
   	if(fuif.forwarda == 2'b01 && fuif.forwardb == 2'b01)
   	begin
   		$display("Test case 4 Passed!");
   	end
   	else
   	begin
   		$display("Test case 4 Failed");
   	end
   	fuif.memwsel = 0;
    fuif.wbwsel = 0;
    fuif.memWEN = 0;
    fuif.wbWEN = 0;
    fuif.rs = 0;
    fuif.rt = 0;
    fuif.exinstr = 0;
   	#(PERIOD)

   	fuif.wbwsel = 3;
   	fuif.memwsel = 3;
   	fuif.memWEN = 1;
   	fuif.wbWEN = 1;
   	fuif.rs = 3;
   	fuif.rt = 3;
   	fuif.exinstr = 32'h10E00004; //BEQ R7, R0, 56
   	 #(PERIOD)
   	if(fuif.forwarda == 2'b10 && fuif.forwardb == 2'b10)
   	begin
   		$display("Test case 5 Passed!");
   	end
   	else
   	begin
   		$display("Test case 5 Failed");
   	end


  end
endprogram