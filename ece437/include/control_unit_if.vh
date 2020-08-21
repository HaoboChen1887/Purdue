/*
  Eric Villasenor
  evillase@gmail.com

  control unit interface
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  // pc ports
  logic brn, bne, jmp, jr;
  logic [ADDR_W - 1:0] jmpaddr;

  // alu ports
  logic [3:0] aluop;
  logic [OP_W - 1:0] opcode;

  // register file ports
  logic WEN;
  regbits_t wsel, rsel1, rsel2;

  // datapath ports
  
  logic extsel;
  logic luipad;
  logic [1:0] memreg;
  logic rdat2sel;
  logic [IMM_W - 1:0] imm16;
  logic dWEN, dREN;
  logic halt;

  // request unit ports
  word_t instr;

  // control unit ports
  modport cuif(
    input instr,

    output brn, bne, jmp, jr, jmpaddr,
    output aluop,
    output WEN, wsel, rsel1, rsel2,
    output luipad, extsel, memreg, rdat2sel, dWEN, dREN, halt,
    output imm16,
    output opcode
  );
endinterface

`endif //ALU_IF_VH
