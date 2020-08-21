`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ex_mem_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, dhit;
  logic [1:0] memreg_in;
  logic jmp_in, brn_in, bne_in, jr_in;
  logic halt_in;
  logic WEN_in;
  logic dREN_in, dWEN_in;
  logic [25:0] jmpaddr_in;
  word_t npc_in;
  word_t jraddr_in, brnaddr_in;
  logic [4:0] wsel_in;
  word_t rdat2_in, port_o_in;
  logic zero_in, ov_in, neg_in;
  logic freeze, flush;
  word_t instr_in;
  word_t dmemload_in; // feedback from mem

  logic jmp_out, brn_out, bne_out, jr_out;
  logic [1:0] memreg_out;
  logic halt_out;
  logic WEN_out;
  logic dREN_out, dWEN_out;
  logic [25:0] jmpaddr_out;
  word_t npc_out;
  word_t jraddr_out, brnaddr_out;
  logic [4:0] wsel_out;
  word_t rdat2_out, port_o_out;
  logic zero_out, ov_out, neg_out;
  word_t instr_out;
  word_t dmemload_out;

  modport emif(
  	input 
  		ihit, dhit, 
  		jmp_in, brn_in, bne_in, jr_in, 
  		halt_in, 
  		memreg_in,
  		WEN_in, 
  		dREN_in, dWEN_in, 
  		jmpaddr_in, jraddr_in, brnaddr_in, 
  		npc_in,
      rdat2_in, wsel_in,
  		port_o_in, zero_in, ov_in, neg_in, 
      freeze, flush,
      instr_in,
      dmemload_in,
  	output
  		jmp_out, brn_out, bne_out, jr_out, 
  		halt_out, 
  		memreg_out,
  		WEN_out, 
  		dREN_out, dWEN_out, 
  		jmpaddr_out, jraddr_out, brnaddr_out, 
  		npc_out,
      rdat2_out, wsel_out,
  		port_o_out, zero_out, ov_out, neg_out,
      instr_out,
      dmemload_out
  	);
endinterface
`endif 