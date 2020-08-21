`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module hazard_unit_tb;
  parameter PERIOD = 10;
  hazard_unit_if huif();
  test PROG(huif);
 

`ifndef MAPPED
  hazard_unit DUT(huif);
`else
  hazard_unit DUT(
	.\huif.exbrn (huif.exbrn),
	.\huif.exbne (huif.exbne),
	.\huif.exzero (huif.exzero),
	.\huif.exjmp (huif.exjmp),
	.\huif.exjr (huif.exjr),
	.\huif.exWEN (huif.exWEN),
	.\huif.memWEN (huif.memWEN),
	.\huif.wbWEN (huif.wbWEN),
	.\huif.exwsel (huif.exwsel),
	.\huif.memwsel (huif.memwsel),
	.\huif.wbwsel (huif.wbwsel),
	.\huif.rs (huif.rs),
	.\huif.rt (huif.rt),

	.\huif.ifidfreeze (huif.ifidfreeze),
	.\huif.idexfreeze (huif.idexfreeze),
	.\huif.ifidflush (huif.ifidflush),
	.\huif.idexflush (huif.idexflush),
	.\huif.stall (huif.stall)
  );
`endif
endmodule

program test(
	hazard_unit_if huif
);

  initial begin
    parameter PERIOD = 10;
    // init set up
	huif.exbrn = '0;
	huif.exbne = '0;
	huif.exzero = '0;
	huif.exjmp = '0;
	huif.exjr = '0;
	huif.exWEN = '0;
	huif.memWEN = '0;
	huif.wbWEN = '0;
	huif.exwsel = '0;
	huif.memwsel = '0;
	huif.wbwsel = '0;
	huif.rs = '0;
	huif.rt = '0;
	#(PERIOD);

	huif.exbrn = '1;
	huif.exzero = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)begin
		$display("Success, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // else
	huif.exbrn = '0;
	huif.exzero = '0;
	#(PERIOD);

	huif.exbne = '1;
	huif.exzero = '0;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)begin
		$display("Success, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // else
	huif.exbne = '0;
	#(PERIOD);

	huif.exjmp = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)begin
		$display("Success, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // else
	huif.exjmp = '0;
	#(PERIOD);

	huif.exjr = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)begin
		$display("Success, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // if(huif.idexflush == 1'b1 && huif.ifidflush == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidflush = %b",huif.idexflush, huif.ifidflush);
	end // else
	huif.exjr = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.exwsel = 2;
	huif.exWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.exwsel = 0;
	huif.exWEN = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.memwsel = 2;
	huif.memWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.memwsel = 0;
	huif.memWEN = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.wbwsel = 2;
	huif.wbWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.wbwsel = 0;
	huif.wbWEN = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.exwsel = 4;
	huif.exWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.exwsel = 0;
	huif.exWEN = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.memwsel = 4;
	huif.memWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.memwsel = 0;
	huif.memWEN = '0;
	#(PERIOD);

	huif.rs = 2;
	huif.rt = 4;
	huif.wbwsel = 4;
	huif.wbWEN = '1;
	#(PERIOD);
	if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1 && huif.stall == 1'b1)begin
		$display("Success, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // if(huif.idexflush == 1'b1 && huif.ifidfreeze == 1'b1)
	else begin
		$display("Failure, idexflush = %b, ifidfreeze = %b, stall = %b", huif.idexflush, huif.ifidfreeze, huif.stall);
	end // else
	huif.wbwsel = 0;
	huif.wbWEN = '0;
	#(PERIOD);
  end
endprogram