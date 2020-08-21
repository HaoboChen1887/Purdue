// $Id: $
// File name:   window_buffer.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: window buffer.

module addr_calc(
	input wire clk,
	input wire n_rst,
	input wire [31:0] start_addr,
	input wire addr_calc_en,
	output reg addr_done,
	output reg incdec,
	output reg new_row,
	output reg [9:0] row_cnt,
	output reg [9:0] col_cnt,
	output reg [31:0] calc_addr,
	output reg init,
	output reg finish
);

	typedef enum bit [2:0] {INIT, IDLE, DEC, INC, NEW_ROW, WAIT, SINGLE, DONE}stateType;
	stateType state, next_state;
	
	reg next_incdec;
	reg [9:0] next_row_cnt;
	reg [9:0] next_col_cnt;
	reg [31:0] next_calc_addr;
	reg next_addr_done;
	reg first_row, next_first_row;
	reg edge_det, next_edge_det;
	reg next_new_row;
	reg next_init;
	reg next_finish;

	always_ff @ (posedge clk, negedge n_rst) begin:REG
		if(n_rst == 1'b0) begin
			incdec <= '1;
			row_cnt <= '0;
			col_cnt <= '0;
			addr_done <= '0;
			calc_addr <= '0;
			first_row <= '1;
			new_row = '0;
			edge_det <= '0;
			init <= '0;
			finish <= '0;
			state <= INIT;
		end
		else begin
			incdec <= next_incdec;
			row_cnt <= next_row_cnt;
			col_cnt <= next_col_cnt;
			addr_done <= next_addr_done;
			calc_addr <= next_calc_addr;
			first_row <= next_first_row;
			new_row = next_new_row;
            edge_det <= next_edge_det;
            init <= next_init;
            finish <= next_finish;
			state <= next_state;
		end
	end

	always_comb begin
		next_incdec = incdec;
		next_row_cnt = row_cnt;
		next_col_cnt = col_cnt;
		next_addr_done = addr_done;
		next_calc_addr = calc_addr;
		next_state = state;
		next_first_row = first_row;
		next_new_row = new_row;
		next_edge_det = edge_det;
		next_finish = finish;
		next_init = init;

		case(state)
			INIT:begin
				if(addr_calc_en == 1'b1)begin
				    next_init = 1'b1;
					next_calc_addr = start_addr;
					next_state = SINGLE;
				end
			end
			IDLE:begin
				if(addr_calc_en == 1'b1)begin
				    if(addr_done == 1'b1)begin
				        next_addr_done = 1'b0;
				    end
			        if(init == 1'b1 && col_cnt != 10'd4)begin
			            next_col_cnt = col_cnt + 10'd8;
			            next_init = 1'b0;
			            next_state = SINGLE;
			        end
				    if(new_row == 1'b1)begin
				        next_new_row = 1'b0;
				    end
					if(edge_det == 1'b1 && incdec == 1'b1 && row_cnt < 10'd596)begin
					    next_new_row = 1'b1;
						next_incdec = 1'b0;
						next_state = NEW_ROW;
					end
					else if(edge_det == 1'b1 && incdec == 1'b0 && row_cnt < 10'd596)begin
					    next_new_row = 1'b1;
						next_incdec = 1'b1;
						next_state = NEW_ROW;
					end
					else if(col_cnt == 10'd792 && row_cnt == 10'd596)begin
						next_state = WAIT;
					end
					else if(col_cnt <= 10'd792 && incdec == 1'b1)begin
						next_state = INC;
					end
					else if(col_cnt >= 10'd0 && incdec == 1'b0)begin
						next_state = DEC;
					end
				end
			end
			INC:begin
				if(addr_calc_en == 1'b1)begin
					if(col_cnt == 10'd792) begin
					    next_edge_det = 1'b1;
					end
					else begin
						next_col_cnt = col_cnt + 10'd4;
					end
					next_calc_addr = start_addr + row_cnt * 32'd800 + col_cnt;
					next_state = SINGLE;
				end
			end
			DEC:begin
				if(addr_calc_en == 1'b1)begin
					if(col_cnt == 10'd0)begin
					    next_edge_det = 1'b1;
					end
					else begin
						next_col_cnt = col_cnt - 10'd4;
					end
					next_calc_addr = start_addr + row_cnt * 32'd800 + col_cnt;
					next_state = SINGLE;
				end
			end
			NEW_ROW:begin
				if(addr_calc_en == 1'b1)begin
				    next_edge_det = 1'b0;
					if(first_row == 1'b1)begin
						next_row_cnt = row_cnt + 10'd8;
						next_first_row = 1'b0;
					end
					else
						next_row_cnt = row_cnt + 10'd4;
					next_calc_addr = start_addr + row_cnt * 32'd800 + col_cnt;
					next_state = SINGLE;
				end
			end
			SINGLE:begin
			    if(addr_calc_en == 1'b1)begin
			        next_addr_done = 1'b1;
			        next_state = IDLE;
			    end
			end
			WAIT:begin
				if(addr_calc_en == 1'b1)begin
					next_addr_done = 1'b1;
					next_state = DONE;
			    end
			end
			DONE:begin
				if(addr_calc_en == 1'b1)begin
					next_addr_done = 1'b0;
					next_finish = 1'b1;
					next_calc_addr = start_addr + row_cnt * 32'd800 + col_cnt;
					next_state = IDLE;
				end
			end
		endcase		
	end
endmodule
