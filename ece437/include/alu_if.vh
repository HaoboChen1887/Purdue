/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  word_t    port_a, port_b, port_o;
  logic zero,ov,neg;
  logic [3:0] aluop;

  // register file ports
  modport aluif (
    input   port_a, port_b,
    input   aluop,
    output  port_o,
    output  zero,
    output  ov,
    output  neg
  );
  // register file tb
  modport tb (
    input   port_a, port_b,
    input   aluop,
    output  port_o,
    output  zero,
    output  ov,
    output  neg
  );
endinterface

`endif //ALU_IF_VH
