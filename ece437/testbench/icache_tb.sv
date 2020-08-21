`include "caches_if.vh"
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module icache_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;
  always #(PERIOD/2) CLK++;

  caches_if cif();
  datapath_cache_if dcif();
  test PROG(cif);
 

`ifndef MAPPED
  icache DUT(CLK,nRST,dcif,cif);
`else
  icache DUT(
  	.\CLK(CLK),
  	.\nRST(nRST),
  	.\dcif.imemaddr(dcif.imemaddr),
  	.\dcif.imemREN(dcif.imemREN),
  	.\dcif.ihit(dcif.ihit),
  	.\dcif.imemload(dcif.imemload),

  	.\cif.iwait(cif.iwait),
  	.\cif.iload(cif.iload),
  	.\cif.iREN(cif.iREN),
  	.\cif.iaddr(cif.iaddr)
  );
`endif
endmodule

program test(
	input logic CLK,
	output logic nRST,
	caches_if cif,
	datapath_cache_if dpif

);

  initial begin
    nRST = 1;
   dcif.imemaddr = '0;
   dcif.imemREN = '0;

   cif.iwait = 0;
   cif.iload = 0;
  end
endprogram