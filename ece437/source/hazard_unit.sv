`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"

module hazard_unit
import cpu_types_pkg::*;
(
	hazard_unit_if huif
);

	r_t rtype;
	assign rtype = huif.exinstr;
	always_comb begin
		huif.stall = 0;
		huif.ifidfreeze = 0;
		huif.idexfreeze = 0;
		huif.exmemfreeze = 0;
		huif.memwbfreeze = 0;
		huif.ifidflush = 0;
		huif.idexflush = 0;
		huif.exmemflush = 0;
		huif.memwbflush = 0;
		if(huif.exbrn && huif.exzero || huif.exbne && ~huif.exzero || huif.exjmp || huif.exjr)begin
			huif.ifidflush = 1;
			huif.idexflush = 1;
		end
		else if(rtype.opcode == LW && (huif.exwsel == huif.rs || huif.exwsel == huif.rt) && huif.exwsel != 0 && huif.exWEN == 1) begin
			huif.ifidfreeze = 1;
			huif.idexflush = 1;
			huif.stall = 1;
		end
	end

endmodule // hazard_unit