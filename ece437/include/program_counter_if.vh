/*
  Eric Villasenor
  evillase@gmail.com

*/
`ifndef PROGRAM_COUNTER_VH
`define PROGRAM_COUNTER_VH

// all types
`include "cpu_types_pkg.vh"

interface program_counter_if;
  // import types
  import cpu_types_pkg::*;

  logic brn, jmp, jr, PCEN;
  logic [IMM_W - 1:0] imm16;
  logic [ADDR_W - 1:0] jmpaddr;
  word_t cpc, npc, jraddr;

  // program counter ports
  modport pc (
    input brn, jmp, jr, imm16, jmpaddr, jraddr, PCEN,
    output npc, cpc
  );
endinterface

`endif //ALU_IF_VH
