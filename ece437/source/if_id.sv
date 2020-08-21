`include "if_id_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module if_id(
	input logic CLK, nRST,
	if_id_if ifidif
	);


	import cpu_types_pkg::*;

	always_ff @(posedge CLK, negedge nRST)
	begin
		if(!nRST)
		begin
			ifidif.imemload_out <= 0;
			ifidif.npc_out <= 0;
		end
	    else if (ifidif.ihit && ~ifidif.freeze) begin
	    	if(ifidif.flush)begin
				ifidif.imemload_out <= 0;
				ifidif.npc_out <= 0;
			end
    		else begin
				ifidif.imemload_out <= ifidif.imemload_in;
				ifidif.npc_out <= ifidif.npc_in;
    		end // else
	    end // else if (ifidif.ihit)
	end
endmodule
