`include "id_ex_if.vh"
`include "cpu_types_pkg.vh"

module id_ex(
	input logic CLK, nRST,
	id_ex_if.idexif idexif
	);

import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) 
begin
	if(!nRST) begin
		idexif.dREN_out <= 0;
		idexif.memreg_out<=0;
		idexif.halt_out<=0;
		idexif.dWEN_out<=0;
		idexif.luipad_out<=0; 
		idexif.jr_out<=0;
		idexif.jmp_out<=0;
		idexif.brn_out<=0;
		idexif.bne_out<=0;
		idexif.rdat2sel_out<=0;
		idexif.WEN_out<=0;
		idexif.extsel_out<=0;
		idexif.jmpaddr_out<=0;
		idexif.rs_out<=0;
		idexif.rt_out<=0;
		idexif.wsel_out<=0;
		idexif.imm16_out<=0;
		idexif.rdat1_out<=0;
		idexif.rdat2_out<=0;
		idexif.npc_out<=0;
		idexif.aluop_out<=0;
		idexif.instr_out<='0;
	end 
	else if(idexif.ihit && ~idexif.freeze)begin
		if(idexif.flush)begin
			idexif.dREN_out <= 0;
			idexif.memreg_out<=0;
			idexif.halt_out<=0;
			idexif.dWEN_out<=0;
			idexif.luipad_out<=0; 
			idexif.jr_out<=0;
			idexif.jmp_out<=0;
			idexif.brn_out<=0;
			idexif.bne_out<=0;
			idexif.rdat2sel_out<=0;
			idexif.WEN_out<=0;
			idexif.extsel_out<=0;
			idexif.jmpaddr_out<=0;
			idexif.rs_out<=0;
			idexif.rt_out<=0;
			idexif.wsel_out<=0;
			idexif.imm16_out<=0;
			idexif.rdat1_out<=0;
			idexif.rdat2_out<=0;
			idexif.npc_out<=0;
			idexif.aluop_out<=0;
			idexif.instr_out<=0;
		end
		else begin
			idexif.dREN_out <= idexif.dREN_in;
			idexif.memreg_out<= idexif.memreg_in;
			idexif.halt_out <= idexif.halt_in;
			idexif.dWEN_out<= idexif.dWEN_in;
			idexif.luipad_out<= idexif.luipad_in;
			idexif.jr_out<=idexif.jr_in;
			idexif.jmp_out<=idexif.jmp_in;
			idexif.brn_out<=idexif.brn_in;
			idexif.bne_out<=idexif.bne_in;
			idexif.rdat2sel_out<=idexif.rdat2sel_in;
			idexif.WEN_out<=idexif.WEN_in;
			idexif.extsel_out<=idexif.extsel_in;
			idexif.jmpaddr_out<=idexif.jmpaddr_in;
			idexif.rs_out<=idexif.rs_in;
			idexif.rt_out<=idexif.rt_in;
			idexif.wsel_out<=idexif.wsel_in;
			idexif.imm16_out<=idexif.imm16_in;
			idexif.rdat1_out<=idexif.rdat1_in;
			idexif.rdat2_out<=idexif.rdat2_in;
			idexif.npc_out<=idexif.npc_in;
			idexif.aluop_out<=idexif.aluop_in;
			idexif.instr_out<=idexif.instr_in;
		end // else
	end
end

endmodule