`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module program_counter_tb;
  parameter PERIOD = 10;
  logic nRST, CLK = 0;
  program_counter_if pcif();

  always #(PERIOD/2) CLK++;
  test PROG(CLK, nRST, pcif);

`ifndef MAPPED
  program_counter DUT(CLK, nRST, pcif);
`else
  program_counter DUT(
    .\CLK (CLK),
    .\nRST (nRST),
    .\pcif.brn (pcif.brn),
    .\pcif.jmp (pcif.jmp),
    .\pcif.jr (pcif.jr),
    .\pcif.imm16 (pcif.imm16),
    .\pcif.jmpaddr (pcif.jmpaddr),
    .\pcif.jraddr (pcif.jraddr),
    .\pcif.npc (pcif.npc),
    .\pcif.cpc (pcif.cpc)
  );
`endif

endmodule

program test(
  input logic CLK,
  output logic nRST,
  program_counter_if pcif
);

  initial begin
    pcif.brn = 1'b0;
    pcif.jmp = 1'b0;
    pcif.jr = 1'b0;
    pcif.imm16 = '0;
    pcif.jmpaddr = '0;
    pcif.jraddr = '0;
    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);
    @(posedge CLK);


    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    pcif.brn = 1'b1;
    pcif.imm16 = 3000;
    @(posedge CLK);
    pcif.brn = 1'b0;
    #(3);
    if(pcif.cpc == 12012)
      $display("Succeed pcif.cpc = %d", pcif.cpc);
    else
      $display("Failed pcif.cpc = %d", pcif.cpc);

    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    pcif.jmp = 1'b1;
    pcif.jmpaddr = 26'd20000;
    @(posedge CLK);
    pcif.jmp = 1'b0;
    #(3);
    if(pcif.cpc == 80000)
      $display("Succeed pcif.cpc = %d", pcif.cpc);
    else
      $display("Failed pcif.cpc = %d", pcif.cpc);

    nRST = 1'b0;
    @(posedge CLK);
    nRST = 1'b1;
    @(posedge CLK);
    @(posedge CLK);
    pcif.jr = 1'b1;
    pcif.jraddr = 32'hFFFF;
    @(posedge CLK);
    pcif.jr = 1'b0;
    #(3);
    if(pcif.cpc == 32'hFFFF)
      $display("Succeed pcif.cpc = %d", pcif.cpc);
    else
      $display("Failed pcif.cpc = %d", pcif.cpc);
  end
endprogram
