`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module request_unit_tb;
  parameter PERIOD = 10;
  logic nRST, CLK = 0;
  request_unit_if ruif();
  test PROG(CLK, nRST, ruif);
  always #(PERIOD/2) CLK++;

`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\ruif.CLK (CLK),
    .\ruif.nRST (nRST),
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.dREN (ruif.dREN),
    .\ruif.cuhalt (ruif.cuhalt),
    .\ruif.halt (ruif.halt),
    .\ruif.imemREN (ruif.imemREN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.dmemWEN (ruif.dmemWEN)
    .\ruif.PCEN (ruif.PCEN)
  );
`endif
endmodule

program test(
  input logic CLK,
  output logic nRST,
  request_unit_if ruif
);

  initial begin
    parameter PERIOD = 10;
    // init set up
    nRST = 1'b0;
    ruif.ihit = 0;
    ruif.dhit = 0;
    ruif.dWEN = 0;
    ruif.dREN = 0;
    ruif.cuhalt = 0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);


    ruif.ihit = 1;
    ruif.dWEN = 1;
    ruif.dREN = 0;
    #(10)
    if(ruif.dmemWEN == ruif.dWEN && ruif.dmemREN == ruif.dREN)begin
      $display("success, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("success, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end
    else begin
      $display("fail, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("fail, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end


    ruif.ihit = 1;
    ruif.dhit = 1;
    ruif.dWEN = 0;
    ruif.dREN = 1;
    #(10)
    if(ruif.dmemWEN == ruif.dWEN && ruif.dmemREN == ruif.dWEN)begin
      $display("success, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("success, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end
    else begin
      $display("fail, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("fail, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end

    ruif.ihit = 0;
    ruif.dhit = 1;
    ruif.dWEN = 1;
    ruif.dREN = 0;
    #(10)
    if(ruif.dmemWEN == 1'b0 && ruif.dmemREN == 1'b0)begin
      $display("success, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("success, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end
    else begin
      $display("fail, dmemWEN = %b, dWEN = %b", ruif.dmemWEN, ruif.dWEN);
      $display("fail, dmemREN = %b, dREN = %b", ruif.dmemREN, ruif.dREN);
    end
  end
endprogram
