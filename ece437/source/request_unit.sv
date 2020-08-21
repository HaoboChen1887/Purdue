`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

module request_unit
import cpu_types_pkg::*;
(
  input logic CLK, nRST,
  request_unit_if.ruif ruif
);

  assign ruif.imemREN = 1;
  assign ruif.PCEN = ruif.ihit;
  always_ff @ (posedge CLK, negedge nRST)begin
    if(!nRST)begin
      ruif.dmemREN <= 1'b0;
      ruif.dmemWEN <= 1'b0;
    end
    else begin
      if(ruif.ihit && !ruif.dhit)begin
        ruif.dmemWEN <= ruif.dWEN;
        ruif.dmemREN <= ruif.dREN;
      end
      else if(ruif.dhit)begin
        ruif.dmemREN <= 1'b0;
        ruif.dmemWEN <= 1'b0;
      end
    end
  end

  always_ff @ (posedge CLK, negedge nRST)begin
    if(!nRST)begin
      ruif.halt <= 1'b0;
    end
    else if(ruif.cuhalt)begin
      ruif.halt <= 1'b1;
    end
  end
endmodule
