/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;

  // direct connection
  assign ccif.iload = ccif.ramload;
  assign ccif.dload = ccif.ramload;

  assign ccif.ramstore = ccif.dstore;

  // control signals
  assign ccif.ramWEN = ccif.dWEN;
  assign ccif.ramREN = ccif.dREN != 1'b0 ? ccif.dREN : ccif.iREN;
  assign ccif.ramaddr = (ccif.dREN || ccif.dWEN) ? ccif.daddr : ccif.iaddr;

  always_comb begin
    ccif.iwait = 1'b1;
    ccif.dwait = 1'b1;
    casez(ccif.ramstate)
      FREE,
      BUSY,
      ERROR:begin
        ccif.iwait = 1'b1;
        ccif.dwait = 1'b1;
      end
      ACCESS:begin
        if(ccif.dREN || ccif.dWEN)begin
          ccif.dwait = 1'b0;
          ccif.iwait = 1'b1;
        end
        else if(ccif.iREN)begin
          ccif.dwait = 1'b1;
          ccif.iwait = 1'b0;
        end
      end
    endcase
  end
endmodule
