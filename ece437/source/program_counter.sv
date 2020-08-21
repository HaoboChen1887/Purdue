`include "program_counter_if.vh"
`include "cpu_types_pkg.vh"

module program_counter(
  input logic CLK, nRST,
  program_counter_if.pc pcif
);

  import cpu_types_pkg::*;
  word_t cpcr, npcr, pcradd;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST)
      cpcr <= '0;
    else
      if(pcif.PCEN)
        cpcr <= npcr;
      else
        cpcr <= cpcr;
  end

  assign pcradd = cpcr + 4;
  assign pcif.cpc = cpcr;
  assign pcif.npc = pcradd;

  always_comb begin
    if(pcif.brn && pcif.imm16[15] == 0)
      npcr = {14'b0, pcif.imm16, 2'b0} + pcradd;
    else if(pcif.brn && pcif.imm16[15] == 1)
      npcr = {14'b11111111111111, pcif.imm16, 2'b0} + pcradd;
    else if(pcif.jmp)
      npcr = {pcradd[31:28], pcif.jmpaddr, 2'b0};
    else if(pcif.jr)
      npcr = pcif.jraddr;
    else
      npcr = pcradd;
  end
endmodule
