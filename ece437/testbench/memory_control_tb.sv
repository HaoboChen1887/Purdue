`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module memory_control_tb;
  parameter PERIOD = 10;
  logic nRST, CLK = 0;
  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(1)) ccif(cif0, cif1);
  cpu_ram_if ramif();
  test PROG(CLK, nRST, cif0);

  always #(PERIOD/2) CLK++;

`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
  );
`endif

`ifndef MAPPED
  ram RAM (CLK, nRST, ramif);
`else
  ram RAM (
    .\CLK (CLK),
    .\nRST (nRST),
    .\ramif.ramstore (ramif.ramstore),
    .\ramif.ramaddr (ramif.ramaddr),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramload (ramif.ramload),
    .\ramif.ramstate (ramif.ramstate),
  );
`endif

  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ccif.ramload = ramif.ramload;
  assign ccif.ramstate = ramif.ramstate;
endmodule

program test(
  input logic CLK,
  output logic nRST,
  caches_if cif0
);

  initial begin
    parameter PERIOD = 10;
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);

    // init set up
    cif0.dWEN = 1'b0;
    cif0.dREN = 1'b0;
    cif0.iREN = 1'b0;
    cif0.dstore = '0;
    cif0.iaddr = '0;
    cif0.daddr = '0;

    // data write dWEN = 1'b1
    cif0.dWEN = 1'b1;
    @(posedge CLK);
   // while(memory_control_tb.ccif.ramstate != ACCESS)@(posedge CLK);
    if(cif0.dwait == 1'b0 && cif0.iwait == 1'b1)
      $display("Test Passed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    else
      $display("Test Failed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    cif0.dWEN = 1'b0;
    @(posedge CLK);

    // data read dREN = 1'b1
    cif0.dREN = 1'b1;
    @(posedge CLK);
    if(cif0.dwait == 1'b0 && cif0.iwait == 1'b1)
      $display("Test Passed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    else
      $display("Test Failed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    cif0.dREN = 1'b1;
    @(posedge CLK);

    // data read iREN = 1'b1 and dREN = 1'b1
    cif0.dREN = 1'b1;
    cif0.iREN = 1'b1;
    @(posedge CLK);
    if(cif0.dwait == 1'b0 && cif0.iwait == 1'b1)
      $display("Test Passed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    else
      $display("Test Failed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    cif0.dREN = 1'b0;
    cif0.iREN = 1'b0;
    @(posedge CLK);

    // data read iREN = 1'b1 only
    cif0.iREN = 1'b1;
    @(posedge CLK);
    if(cif0.dwait == 1'b1 && cif0.iwait == 1'b0)
      $display("Test Passed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    else
      $display("Test Failed: dwait = %b, iwait = %b", cif0.dwait, cif0.iwait);
    cif0.dREN = 1'b0;
    cif0.iREN = 1'b0;
    @(posedge CLK);

    // store and read
    cif0.daddr = 32'h8;
    cif0.dstore = 32'hAAAAAAAA;
    cif0.dWEN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.dWEN = 0;
    #(PERIOD);
    #(PERIOD);

    cif0.daddr = 32'h4;
    cif0.dstore = 32'hBBBBBBBB;
    cif0.dWEN = 1;
    #(PERIOD);
    #(PERIOD);

    cif0.dWEN = 0;
    #(PERIOD);
    #(PERIOD);

    cif0.daddr = 32'h0;
    cif0.dstore = 32'hCCCCCCCC;
    cif0.dWEN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.dWEN = 0;
    #(PERIOD);
    #(PERIOD);


    cif0.daddr = 32'h8;
    cif0.dREN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.dREN = 0;
    if(cif0.dload == 32'hAAAAAAAA)
      $display("Test Passed: dload = %h", cif0.dload);
    else
      $display("Test Failed: dload = %h", cif0.dload);


    cif0.daddr = 32'h4;
    cif0.dREN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.dREN = 0;
    if(cif0.dload == 32'hBBBBBBBB)
      $display("Test Passed: dload = %h", cif0.dload);
    else
      $display("Test Failed: dload = %h", cif0.dload);

    cif0.daddr = 32'h0;
    cif0.dREN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.dREN = 0;
    if(cif0.dload == 32'hCCCCCCCC)
      $display("Test Passed: dload = %h", cif0.dload);
    else
      $display("Test Failed: dload = %h", cif0.dload);

    cif0.iaddr = 32'h0;
    cif0.iREN = 1;
    cif0.dREN = 1;
    #(PERIOD);
    #(PERIOD);
    cif0.iREN = 0;
    cif0.dREN = 0;
    if(cif0.dload == 32'hCCCCCCCC)
      $display("Test Passed: dload = %h", cif0.dload);
    else
      $display("Test Failed: dload = %h", cif0.dload);
    dump_memory();
  end
  // automatic memory dump
  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
endprogram
