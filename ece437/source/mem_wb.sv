`include "cpu_types_pkg.vh"
`include "mem_wb_if.vh"

module mem_wb (
	input CLK,    // Clock
	input nRST, // Clock Enable
	mem_wb_if.mwif mwif
);

always_ff @(posedge CLK, negedge nRST) begin
	if(~nRST) begin
		mwif.dmemload_out <= '0;
		mwif.jraddr_out <= '0;
		mwif.brnaddr_out <= '0;
		mwif.npc_out <= '0;
		mwif.port_o_out <= '0;
		mwif.halt_out <= '0;
		mwif.jmpaddr_out <= '0;
		mwif.zero_out <= '0;
		mwif.neg_out <= '0;
		mwif.ov_out <= '0;
		mwif.WEN_out <= '0;
		mwif.memreg_out <= '0;
		mwif.brn_out <= '0;
		mwif.bne_out <= '0;
		mwif.jmp_out <= '0;
		mwif.jr_out <= '0;
		mwif.wsel_out <= '0;
	end 
	else if((mwif.ihit) && ~mwif.freeze)begin
		if(mwif.flush)begin
			mwif.dmemload_out <= '0;
			mwif.jraddr_out <= '0;
			mwif.brnaddr_out <= '0;
			mwif.npc_out <= '0;
			mwif.port_o_out <= '0;
			mwif.halt_out <= '0;
			mwif.jmpaddr_out <= '0;
			mwif.zero_out <= '0;
			mwif.neg_out <= '0;
			mwif.ov_out <= '0;
			mwif.WEN_out <= '0;
			mwif.memreg_out <= '0;
			mwif.brn_out <= '0;
			mwif.bne_out <= '0;
			mwif.jmp_out <= '0;
			mwif.jr_out <= '0;
			mwif.wsel_out <= '0;
		end // if(mwif.flush)
		else begin
			mwif.dmemload_out <= mwif.dmemload_in;
			mwif.jraddr_out <= mwif.jraddr_in;
			mwif.brnaddr_out <= mwif.brnaddr_in;
			mwif.npc_out <= mwif.npc_in;
			mwif.port_o_out <= mwif.port_o_in;
			mwif.halt_out <= mwif.halt_in;
			mwif.jmpaddr_out <= mwif.jmpaddr_in;
			mwif.zero_out <= mwif.zero_in;
			mwif.neg_out <= mwif.neg_in;
			mwif.ov_out <= mwif.ov_in;
			mwif.WEN_out <= mwif.WEN_in;
			mwif.memreg_out <= mwif.memreg_in;
			mwif.brn_out <= mwif.brn_in;
			mwif.bne_out <= mwif.bne_in;
			mwif.jmp_out <= mwif.jmp_in;
			mwif.jr_out <= mwif.jr_in;
			mwif.wsel_out <= mwif.wsel_in;
		end
	end
end

endmodule