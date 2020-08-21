`ifndef FORWARD_UNIT_VH
`define FORWARD_UNIT_VH

`include "cpu_types_pkg.vh"

interface forward_unit_if;

	import cpu_types_pkg::*;
    
	logic [REG_W - 1:0] rs, rt;
	logic [REG_W - 1:0] memwsel, wbwsel;
	logic memWEN;
	logic wbWEN;
	word_t exinstr;
	
	logic [1:0] forwarda;
	logic [1:0] forwardb;
    

	

	modport fuif(
		input 
			memwsel,wbwsel,memWEN,wbWEN,
			rs,rt,
			exinstr,

		output
			forwardb,forwarda	
		);

endinterface
`endif