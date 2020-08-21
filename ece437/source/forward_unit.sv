`include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"

module forward_unit
import cpu_types_pkg::*;
(
	forward_unit_if fuif
);

	r_t rtype;
	i_t itype;
	assign rtype = fuif.exinstr;
	assign itype = fuif.exinstr;
	
	always_comb begin
		fuif.forwarda = 0;
		fuif.forwardb = 0;

		if(fuif.memWEN && (fuif.memwsel != 0) && (fuif.memwsel == fuif.rs))begin
			fuif.forwarda = 2'b10;
		end
		else if(fuif.wbWEN && (fuif.wbwsel != 0) && fuif.wbwsel == fuif.rs)begin
			fuif.forwarda = 2'b01;
		end

		if(fuif.memWEN && (fuif.memwsel != 0) && (fuif.memwsel == fuif.rt))begin
			if(fuif.memwsel == fuif.rt && (itype.opcode == SW || itype.opcode == BEQ || itype.opcode == BNE || rtype.opcode == RTYPE))begin
				fuif.forwardb = 2'b10;
			end
		end
		else if(fuif.wbWEN && (fuif.wbwsel != 0) && fuif.wbwsel == fuif.rt)begin
			if(fuif.wbwsel == fuif.rt && (itype.opcode == SW || itype.opcode == BEQ || itype.opcode == BNE || rtype.opcode == RTYPE))begin
				fuif.forwardb = 2'b01;
			end
		end
	end

endmodule // hazard_unit