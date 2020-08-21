`ifndef HAZARD_UNIT_VH
`define HAZARD_UNIT_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;

	import cpu_types_pkg::*;

	logic exWEN, memWEN, wbWEN;
	logic exbrn;
	logic exbne;
	logic exzero;
	logic exjmp;
	logic exjr;
	logic dhit;
	logic [REG_W - 1:0] exwsel, memwsel, wbwsel;
	logic [REG_W - 1:0] rs, rt;
	word_t exinstr;

	logic stall;
	logic ifidfreeze, idexfreeze, exmemfreeze, memwbfreeze;
	logic ifidflush, idexflush, exmemflush, memwbflush;

	modport huif (
		input 
			exbrn,
			exbne,
			exzero,
			exjmp,
			exjr,
			dhit,
			exWEN, memWEN, wbWEN, 
			exwsel, memwsel, wbwsel, 
			rs, rt, 
			exinstr,

		output
			ifidfreeze, idexfreeze, exmemfreeze, memwbfreeze,
			ifidflush, idexflush, exmemflush, memwbflush,
			stall
	);

endinterface
`endif