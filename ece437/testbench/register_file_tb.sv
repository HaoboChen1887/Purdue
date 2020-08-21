/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (
    .CLK(CLK),
    .rfif(rfif),
    .nRST(nRST)
  );
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
  input logic CLK,
  output logic nRST,
  register_file_if.rf rfif
);
  initial begin
    rfif.rsel1 = '0;
    rfif.rsel2 = '0;
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    rfif.wdat = '0;
    rfif.wsel = '0;
    for(int ct = 1; ct < 32; ct++)begin
      rfif.wdat = rfif.wsel + 1;
      rfif.wsel= rfif.wsel + 1;
      rfif.WEN = 1'b1;
      @(posedge CLK);
      @(posedge CLK);
      rfif.WEN = 1'b0;
      @(posedge CLK);
      @(posedge CLK);
    end

    @(posedge CLK);
    @(posedge CLK);

    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    rfif.wdat = '0;
    rfif.wsel = '0;
    for(int ct = 1; ct < 32; ct++)begin
      rfif.wdat = (rfif.wsel + 1) * 8;
      rfif.wsel= rfif.wsel + 1;
      rfif.WEN = 1'b1;
      @(posedge CLK);
      @(posedge CLK);
      rfif.WEN = 1'b0;
      @(posedge CLK);
      @(posedge CLK);
    end

    @(posedge CLK);
    @(posedge CLK);
    rfif.rsel1 = '0;
    rfif.rsel2 = '0;
    for(int ct = 0; ct < 32; ct++)begin
      @(posedge CLK);
      @(posedge CLK);
      $display("case %-d", ct);
      assert(rfif.rdat1 == rfif.rsel1 * 8)begin
        $display("Succeed! rdat1 = %d, expected = %d", rfif.rdat1, 8 * rfif.rsel1);
      end
      else begin
        $display("Failed! rdat1 = %d, expected = %d", rfif.rdat1, 8 * rfif.rsel1);
      end
      assert(rfif.rdat2 == rfif.rsel2 * 8)begin
        $display("Succeed! rdat2 = %d, expected = %d", rfif.rdat2, 8 * rfif.rsel2);
      end
      else begin
        $display("Failed! rdat2 = %d, expected = %d", rfif.rdat2, 8 * rfif.rsel2);
      end
      rfif.rsel1 = rfif.rsel1 + 1;
      rfif.rsel2 = rfif.rsel2 + 1;
    end
  end
endprogram
