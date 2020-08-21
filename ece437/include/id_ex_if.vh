`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

`include "cpu_types_pkg.vh"

interface id_ex_if;

	import cpu_types_pkg::*;

	logic ihit,dREN_in,halt_in,dWEN_in,luipad_in,jr_in,jmp_in,brn_in, bne_in,rdat2sel_in,WEN_in,extsel_in;
	logic [1:0] memreg_in;
	logic [ADDR_W - 1:0] jmpaddr_in;
	word_t rdat1_in, rdat2_in, npc_in;
	logic [AOP_W - 1:0] aluop_in;
	logic [REG_W - 1:0] rs_in, rt_in, wsel_in;
	logic [IMM_W - 1:0] imm16_in;
	logic flush, freeze;
	word_t instr_in;



	logic dREN_out,halt_out,dWEN_out,luipad_out,jr_out,jmp_out,brn_out, bne_out,rdat2sel_out,WEN_out,extsel_out;
	logic [1:0] memreg_out;
	logic [ADDR_W - 1:0] jmpaddr_out;
	word_t rdat1_out, rdat2_out, npc_out;
	logic [AOP_W - 1:0] aluop_out;
	logic [REG_W - 1:0] rs_out, rt_out, wsel_out;
	logic [IMM_W - 1:0] imm16_out;
	word_t instr_out;



	modport idexif(
		input ihit, 
			dREN_in, 
			memreg_in, halt_in, dWEN_in, luipad_in, 
			jr_in, jmp_in, brn_in, bne_in, 
			rdat2sel_in, WEN_in, extsel_in, 
			jmpaddr_in, 
			rs_in, rt_in, wsel_in, 
			imm16_in,
			rdat1_in,rdat2_in,
			npc_in, 
			aluop_in, 
			freeze, flush,
			instr_in,
		output 
		dREN_out, 
			memreg_out, halt_out, dWEN_out, luipad_out, 
			jr_out, jmp_out, brn_out, bne_out, 
			rdat2sel_out, WEN_out, extsel_out, 
			jmpaddr_out, 
			rs_out, rt_out, wsel_out, 
			imm16_out,rdat1_out,rdat2_out,
			npc_out, 
			aluop_out,
			instr_out
		);

endinterface 
`endif
