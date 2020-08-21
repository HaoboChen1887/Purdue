`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

`include "cpu_types_pkg.vh"

interface if_id_if;
	import cpu_types_pkg::*;

	word_t imemload_in, npc_in , imemload_out, npc_out;
	logic ihit;
	logic flush, freeze;

	modport ifidif (
		input imemload_in, npc_in, ihit, flush, freeze,
		output imemload_out, npc_out
	);

endinterface

`endif