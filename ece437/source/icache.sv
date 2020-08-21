// interface include
`include "cache_control_if.vh"
`include "caches_if"

// memory types
`include "cpu_types_pkg.vh"

module icache (
  input CLK, nRST,
  datapath_cache_if dcif,
  caches_if.icache icif
);

  // type import
  import cpu_types_pkg::*;

typedef struct packed {
	logic [25:0] tag;
	word_t data;
	logic valid;
}icache_t;

icache_t cache_body [15:0];

logic [25:0] tag;
logic [3:0] idx;

assign tag = dcif.imemaddr[31:6];
assign idx = dcif.imemaddr[5:2];
assign ihit = ~icif.iwait;
assign imemload = icif.iload;
assign icif.iREN = miss ? dcif.imemREN : '0;
assign icif.iaddr = miss ? dcif.imemaddr : '0;

always_ff @ (posedge CLK, negedge nRST)begin
	if(~nRST)begin
		cache_body <= '0;
	end // if(!nRST)
	else begin
		if(ihit)begin
			cache_body[idx].tag <= dcif.imemaddr[31:6];
			cache_body[idx].data <= imemload;
			cache_body[idx].valid <= 1;
		end // if(ihit)
	end // else
end // always_ff @ (posedge CLK, negedge nRST)

always_comb begin
	miss = 0;
	dcif.ihit = 0;
	dcif.imemload = 0;
	if(dcif.halt)begin
		miss = 0;
		dcif.ihit = 0;
		dcif.imemload = '0;
	end // if(dcif.halt)
	else if(dcif.imemREN && !dcif.dmemREN && !dcif.dmemWEN)begin
		if((tag == cache_body[idx].tag) && cache_body[idx].valid)begin
			miss = 0;
			dcif.ihit = 1;
			dcif.imemload = cache_body[idx].data;
		end
		else begin
			miss = 1;
			dcif.ihit = ihit;
			dcif.imemload = imemload;
		end
	end // else if(dcif.imemREN && !dcif.dmemREN && !dcif.dmemWEN)
end
endmodule