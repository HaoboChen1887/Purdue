`include "cpu_types_pkg.vh"
`include "ex_mem_if.vh"

module ex_mem (
	input CLK,    // Clock
	input nRST, // reset
	ex_mem_if.emif emif
);
	always_ff @(posedge CLK, negedge nRST)begin
		if(~nRST)begin
			emif.jmp_out <= '0;
			emif.brn_out <= '0;
			emif.bne_out <= '0;
			emif.jr_out <= '0;
			emif.memreg_out <= '0;
			emif.halt_out <= '0;
			emif.WEN_out <= '0;
			emif.dREN_out <= '0;
			emif.dWEN_out <= '0;
			emif.jmpaddr_out <= '0;
			emif.npc_out <= '0;
			emif.jraddr_out <= '0;
			emif.brnaddr_out <= '0;
			emif.wsel_out <= '0;
			emif.rdat2_out <= '0;
			emif.port_o_out <= '0;
			emif.zero_out <= '0;
			emif.ov_out <= '0;
			emif.neg_out <= '0;
			emif.instr_out <= '0;
		end
		//else if((emif.ihit || emif.dhit) && ~emif.freeze)begin
		else if((emif.ihit) && ~emif.freeze)begin
			if(emif.flush)begin
				emif.jmp_out <= '0;
				emif.brn_out <= '0;
				emif.bne_out <= '0;
				emif.jr_out <= '0;
				emif.memreg_out <= '0;
				emif.halt_out <= '0;
				emif.WEN_out <= '0;
				emif.dREN_out <= '0;
				emif.dWEN_out <= '0;
				emif.jmpaddr_out <= '0;
				emif.npc_out <= '0;
				emif.jraddr_out <= '0;
				emif.brnaddr_out <= '0;
				emif.wsel_out <= '0;
				emif.rdat2_out <= '0;
				emif.port_o_out <= '0;
				emif.zero_out <= '0;
				emif.ov_out <= '0;
				emif.neg_out <= '0;
				emif.instr_out <= '0;
				emif.dmemload_out <= 0;
			end
			else begin
				emif.jmp_out <= emif.jmp_in;
				emif.brn_out <= emif.brn_in;
				emif.bne_out <= emif.bne_in;
				emif.jr_out <= emif.jr_in;
				emif.memreg_out <= emif.memreg_in;
				emif.halt_out <= emif.halt_in;
				emif.WEN_out <= emif.WEN_in;
				emif.dREN_out <= emif.dREN_in;
				emif.dWEN_out <= emif.dWEN_in;
				emif.jmpaddr_out <= emif.jmp_in;
				emif.npc_out <= emif.npc_in;
				emif.jraddr_out <= emif.jraddr_in;
				emif.brnaddr_out <= emif.brnaddr_in;
				emif.wsel_out <= emif.wsel_in;
				emif.rdat2_out <= emif.rdat2_in;
				emif.port_o_out <= emif.port_o_in;
				emif.zero_out <= emif.zero_in;
				emif.ov_out <= emif.ov_in;
				emif.neg_out <= emif.neg_in;
				emif.instr_out <= emif.instr_in;
				emif.dmemload_out <= emif.dmemload_in;
			end // else
		end
		else if(emif.dhit)begin // TODO: will cause problem in cache lab because ihit and dhit may appear at the same time
			emif.dREN_out <= '0;
			emif.dWEN_out <= '0;
			emif.dmemload_out <= emif.dmemload_in;
		end
	end

endmodule