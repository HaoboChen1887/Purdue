// interface include
`include "cache_control_if.vh"
`include "caches_if"

// memory types
`include "cpu_types_pkg.vh"

module dcache (
  input CLK, nRST,
  datapath_cache_if dcif,
  caches_if.dcache icif
);

  // type import
  import cpu_types_pkg::*;

typedef struct packed {
	logic [25:0] l_tag;
	word_t l_data1, l_data2;
	logic l_dirty, l_valid;

	logic [25:0] r_tag;
	word_t r_data1, r_data2;
	logic r_dirty, r_valid;
}dcache_t;

typedef enum logic[3:0]{
	IDLE, READ1, READ2, WRITE1, WRITE2, FLUSH1, FLUSH2, DIRTY, NEXT, HALT
}state_t

icache_t cache_body [7:0];

logic offset;
logic [25:0] tag;
logic [2:0] idx, row_dec;

logic miss, avail[7:0], next_avail[7:0];
logic [4:0] row, next_row;

word_t hit_cnt, next_hit_cnt;
state_t state, next_state;

assign row_dec = row[2:0] - 1;

assign tag = dcif.dmemaddr[31:6];
assign idx = dcif.dmemaddr[5:3];
assign offset = dcif.dmemaddr[2];

assign dcif.flushed = (state == HALT)
always_ff @(posedge CLK, negedge nRST) begin
	if(~nRST) begin
		cache_body <= '0;
	end 
	else begin
		cache_body[idx].l_data1 <= l_data1;
		cache_body[idx].l_data2 <= l_data2;
		cache_body[idx].l_dirty <= l_dirty;
		cache_body[idx].l_tag <= l_tag;
		cache_body[idx].l_valid <= l_valid;

		cache_body[idx].r_data1 <= r_data1;
		cache_body[idx].r_data2 <= r_data2;
		cache_body[idx].r_dirty <= r_dirty;
		cache_body[idx].r_tag <= r_tag;
		cache_body[idx].r_valid <= r_valid;
	end
end

always_ff @(posedge CLK, negedge nRST) begin
	if(~nRST)begin
		state <= IDLE;
		avail <= '0;
		row <= '0;
		hit_cnt <= '0;
	end // if(~nRST)
	else begin
		state <= next_state;
		avail <= next_avail;
		row <= next_row;
		hit_cnt <= next_hit_cnt;
	end // else
end // always_ff

always_comb begin
	next_state = state;
	next_row = row;
	casez(state)begin
		IDLE: begin
			if(dcif.halt) begin
				next_state = DIRTY;
			end
			else if(miss)begin
				if(avail[idx] == 0)begin
					next_state = cache_body[idx].l_dirty ? WRITE1 : READ1;
				end // if(avail[idx] == 0)
				else begin
					next_state = cache_body[idx].r_dirty ? WRITE1 : READ1;
				end // else
			end
		end
		READ1: begin
			if(~icif.dwait)begin
				next_state = READ1;
			end // if(~icif.dwait)
		end 
		READ2: begin
			if(~icif.dwait)begin
				next_state = IDLE;
			end // if(~icif.dwait)
		end
		WRITE1: begin
			if(~icif.dwait)begin
				next_state = WRITE2;
			end // if(~icif.dwait)
		end
		WRITE2: begin
			if(~icif.dwait)begin
				next_state = READ1;
			end // if(~icif.dwait)
		end
		FLUSH1: begin
			if(~icif.dwait)begin
				next_state = FLUSH2;
			end // if(~icif.dwait)
		end
		FLUSH2: begin
			if(~icif.dwait)begin
				next_state = DIRTY;
			end // if(~icif.dwait)
		end
		DIRTY: begin
			if(row < 8)begin
				if(cache_body[row[2:0].l_dirty])begin
					next_state = FLUSH1;
				end
			end // if(row < 8)
			else begin 
				if(cache_body[row[2:0].r_dirty])begin
					next_state = FLUSH1;
				end
			end
			next_row = row + 1;
			if(row == 16)begin
				next_state = NEXT;
			end // if(row == 16)
		end
		NEXT: begin
			if(~icif.dwait)begin
				next_state = HALT;
			end // if(~icif.dwait)
		end
	endcase // state
end

always_comb begin
	miss = 0;
	dcif.dhit = 0;
	dcif.dmemload = 0;
	icif.dREN = 0;
	icif.dWEN = 0;
	icif.daddr = 0;
	icif.dstore = 0;

	l_tag = cache_body[idx].l_tag
	l_data1 = cache_body[idx].l_data1;
	l_data2 = cache_body[idx].l_data2;
	l_dirty = cache_body[idx].l_dirty;
	l_valid = cache_body[idx].l_valid;

	r_tag = cache_body[idx].r_tag
	r_data1 = cache_body[idx].r_data1;
	r_data2 = cache_body[idx].r_data2;
	r_dirty = cache_body[idx].r_dirty;
	r_valid = cache_body[idx].r_valid;

	next_avail = avail;
	next_hit_cnt = hit_cnt;

	casez(state)begin
		IDLE: begin
			if(dcif.halt)begin
				next_hit_cnt = hit_cnt;
			end // if(dcif.halt)
			else if (dcif.dmemREN)begin
				if(cache_body[idx].l_tag == tag && cache_body[idx].valid)begin
					dcif.dhit = 1;
					dcif.dmemload = offset ? cache_body[idx].l_data2 : cache_body[idx].l_data1;
					next_avail[idx] = 1;
					next_hit_cnt = hit_cnt + 1;
				end // if(cache_body[idx].tag == tag && cache_body[idx].valid)
				else if(cache_body[idx].r_tag == tag && cache_body[idx].valid)begin
					dcif.dhit = 1;
					dcif.dmemload = offset ? cache_body[idx].r_data2 : cache_body[idx].r_data1;
					next_avail[idx] = 1;
					next_hit_cnt = hit_cnt + 1;
				end // if(cache_body[idx].tag == tag && cache_body[idx].valid)
				else begin
					miss = 1;
					next_hit_cnt = hit_cnt - 1;
				end
			end // else if (dcif.dmemREN)
			else if (dcif.dmemWEN)begin
				if(cache_body[idx].l_tag == tag)begin
					dcif.dhit = 1;
					dcif.l_dirty = 1;
					next_avail[idx] = 1;
					next_hit_cnt = hit_cnt + 1;
					if(offset)begin
						l_data2 = dcif.dmemstore;
					end // if(offset)
					else begin
						l_data1 = dcif.dmemstore;
					end // else
				end // if(cache_body[idx].tag == tag && cache_body[idx].valid)
				else if(cache_body[idx].r_tag == tag)begin
					dcif.dhit = 1;
					dcif.r_dirty = 1;
					next_avail[idx] = 1;
					next_hit_cnt = hit_cnt + 1;
					if(offset)begin
						l_data2 = dcif.dmemstore;
					end // if(offset)
					else begin
						l_data1 = dcif.dmemstore;
					end // else
				end // if(cache_body[idx].tag == tag && cache_body[idx].valid)
				else begin
					miss = 1;
					next_hit_cnt = hit_cnt - 1;
				end
			end // else if (dcif.dmemWEN)
		end
		READ1: begin
			icif.dREN = 1;
			icif.daddr = {tag, ind, 3'b000};
			if(avail[idx] == 0)begin
				l_data1 = icif.dload;
			end
			else begin
				r_data1 = icif.dload;
			end // else
		end 
		READ2: begin
			icif.dREN = 1;
			icif.daddr = {tag, ind, 3'b000};
			if(avail[idx] == 0)begin
				l_data1 = icif.dload;
				l_tag = tag;
				l_dirty = 0;
				l_valid = 1;
			end
			else begin
				r_data1 = icif.dload;
				r_tag = tag;
				r_dirty = 0;
				r_valid = 1;
			end // else
		end
		WRITE1: begin
			icif.dWEN = 1;
			if(avail[idx] == 0)begin
				icif.daddr = {cache_body[idx], l_tag, 3'b000};
				icif.dstore = cache_body[idx].l_data1;
			end // if(avail[idx] == 0)
			else begin
				icif.daddr = {cache_body[idx], r_tag, 3'b000};
				icif.dstore = cache_body[idx].r_data1;
			end // else
		end
		WRITE2: begin
			icif.dWEN = 1;
			if(avail[idx] == 0)begin
				icif.daddr = {cache_body[idx], l_tag, 3'b000};
				icif.dstore = cache_body[idx].l_data2;
			end // if(avail[idx] == 0)
			else begin
				icif.daddr = {cache_body[idx], r_tag, 3'b000};
				icif.dstore = cache_body[idx].r_data2;
			end // else
		end
		FLUSH1: begin
			icif.dWEN = 1;
			if(row - 1 < 8)begin
				icif.daddr = {cache_body[row_dec].l_tag, row_dec, 3'b100};
				icif.dstore = cache_body[row_dec].l_data1;
			end // if(avail[idx] == 0)
			else begin
				icif.daddr = {cache_body[row_dec].r_tag, row_dec, 3'b100};
				icif.dstore = cache_body[row_dec].r_data1;
			end // else
		end
		FLUSH2: begin
			icif.dWEN = 1;
			if(row - 1 < 8)begin
				icif.daddr = {cache_body[row_dec].l_tag, row_dec, 3'b100};
				icif.dstore = cache_body[row_dec].l_data2;
			end // if(avail[idx] == 0)
			else begin
				icif.daddr = {cache_body[row_dec].r_tag, row_dec, 3'b100};
				icif.dstore = cache_body[row_dec].r_data2;
			end // else
		end
		NEXT: begin
		end
end // always_comb
endmodule