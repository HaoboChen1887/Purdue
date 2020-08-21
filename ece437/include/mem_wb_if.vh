`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

`include "cpu_types_pkg.vh"

interface mem_wb_if;
  import cpu_types_pkg::*;
word_t dmemload_in;
word_t jraddr_in, brnaddr_in;
word_t npc_in;
word_t port_o_in;
logic ihit, dhit;
logic halt_in;
logic[25:0] jmpaddr_in;
logic zero_in, neg_in, ov_in;
logic WEN_in;
logic [1:0] memreg_in;
logic brn_in, bne_in, jmp_in, jr_in;
logic [4:0] wsel_in;
logic freeze, flush;

word_t dmemload_out;
word_t jraddr_out, brnaddr_out;
word_t npc_out;
word_t port_o_out;
logic halt_out;
logic[25:0] jmpaddr_out;
logic zero_out, neg_out, ov_out;
logic WEN_out; 
logic [1:0] memreg_out;
logic brn_out, bne_out, jmp_out, jr_out;
logic [4:0] wsel_out;

modport mwif (
	input
		dmemload_in, 
		jraddr_in, brnaddr_in, 
		npc_in, 
		port_o_in, 
		ihit, dhit, 
		halt_in, 
		jmpaddr_in, 
		zero_in, neg_in, ov_in, 
		WEN_in, memreg_in, 
		brn_in, bne_in, jmp_in, jr_in, 
		wsel_in,
		freeze, flush,
	output
		dmemload_out, 
		jraddr_out, brnaddr_out, 
		npc_out, 
		port_o_out, 
		halt_out, 
		jmpaddr_out, 
		zero_out, neg_out, ov_out, 
		WEN_out, memreg_out, 
		brn_out, bne_out, jmp_out, jr_out, 
		wsel_out
	);
endinterface
`endif