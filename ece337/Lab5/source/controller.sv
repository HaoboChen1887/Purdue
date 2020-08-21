// $Id: $
// File name:   controller.sv
// Created:     2/12/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: controller unit.

module controller(
    input wire clk,
    input wire n_reset,
    input wire dr,
    input wire lc,
    input wire overflow,
    output reg cnt_up,
    output reg clear,
    output wire modwait,
    output reg [2:0] op,
    output reg [3:0] src1,
    output reg [3:0] src2,
    output reg [3:0] dest,
    output reg err
);

    typedef enum bit [4:0] {IDLE, EIDLE, STORE, ZERO, SORT1, SORT2, SORT3, SORT4, MUL1, ADD1, MUL2, SUB1, MUL3, ADD2, MUL4, SUB2, LOADEXT1, WAIT1, LOADEXT2, WAIT2, LOADEXT3, WAIT3, LOADEXT4} stateType;
    typedef enum bit [2:0] {NOP, COPY, LOAD1, LOAD2, ADD, SUB, MUL} opcode;
    stateType state;
    stateType next_state;
    opcode curr_op;
    reg next_modwait;
    reg curr_modwait;
    
    always_ff @(posedge clk, negedge n_reset)begin
        if(n_reset == 0)begin
            state <= IDLE;
            curr_modwait <= 0;
        end
        else begin
            state <= next_state;
            curr_modwait <= next_modwait;
        end
    end
    
    always_comb begin
        next_state = state;
	    case(state)
		    EIDLE:begin
			    if(lc == 1'b1)
				    next_state = LOADEXT1;
			    else if(dr == 1'b1)
				    next_state = STORE;
			    else
				    next_state = EIDLE;
		    end
		    IDLE:begin
			    if(lc == 1'b1)
				    next_state = LOADEXT1;
			    else if(dr == 1'b1)
				    next_state = STORE;
			    else
				    next_state = IDLE;
		    end
		    STORE:begin
			    if(dr == 1)
				    next_state = ZERO;
			    else
				    next_state = EIDLE;
		    end
		    ZERO:begin
			    next_state = SORT1;
		    end
		    SORT1:begin
			    next_state = SORT2;
		    end
		    SORT2:begin
			    next_state = SORT3;
		    end
		    SORT3:begin
			    next_state = SORT4;
		    end
		    SORT4:begin
			    next_state = MUL4;
		    end
		    MUL1:begin
			    next_state = SUB1;
		    end
		    SUB1:begin
			    if(overflow == 1)
				    next_state = EIDLE;
			    else
				    next_state = IDLE;
		    end
		    MUL2:begin
			    next_state = ADD1;
		    end
		    ADD1:begin
			    if(overflow == 1)
				    next_state = EIDLE;
			    else
				    next_state = MUL1;
		    end
		    MUL3:begin
			    next_state = SUB2;
		    end
		    SUB2:begin
			    if(overflow == 1)
				    next_state = EIDLE;
			    else
				    next_state = MUL2;
		    end
		    MUL4:begin
			    next_state = ADD2;
		    end
		    ADD2:begin
			    if(overflow == 1)
				    next_state = EIDLE;
			    else
				    next_state = MUL3;
		    end
		    LOADEXT1:begin
			    next_state = WAIT1;
		    end
		    WAIT1:begin
			    if (lc == 1'b1)
				    next_state = LOADEXT2;
			    else
				    next_state = WAIT1;
		    end
		    LOADEXT2:begin
			    next_state = WAIT2;
		    end
		    WAIT2:begin
			    if (lc == 1'b1)
				    next_state = LOADEXT3;
			    else
				    next_state = WAIT2;
		    end
		    LOADEXT3:begin
			    next_state = WAIT3;
		    end
		    WAIT3:begin
			    if(lc == 1'b1)
				    next_state = LOADEXT4;
			    else
				    next_state = WAIT3;
		    end
		    LOADEXT4:begin
			    next_state = IDLE;
		    end
	    endcase
    end

    always_comb begin	
	    cnt_up = 0;
	    clear = 0;
	    curr_op = NOP;
	    next_modwait = 1;
	    src1 = 0;
	    src2 = 0;
	    dest = 0;
	    err = 0;
	
	    if(state == IDLE)begin
		    next_modwait = 0;
	    end
	    else if(state == STORE)begin
		    curr_op = LOAD1;
		    dest = 5;
	    end
	    else if(state == ZERO)begin 
		    curr_op = SUB;
		    src1 = 0;
		    src2 = 0;
		    dest = 0;
		    cnt_up = 1;
	    end
	    else if(state == SORT1)begin
		    curr_op = COPY;
		    src1 = 2;
		    dest = 1;
	    end
	    else if(state == SORT2)begin
		    curr_op = COPY;
		    src1 = 3;
		    dest = 2;
	    end
	    else if(state == SORT3)begin
		    curr_op = COPY;
		    src1 = 4;
		    dest = 3;
	    end
	    else if(state == SORT4)begin
		    curr_op = COPY;
		    src1 = 5;
		    dest = 4;
	    end
	    else if(state == MUL1)begin
		    curr_op = MUL;
		    src1 = 1;
		    src2 = 7;
		    dest = 6;
	    end
	    else if(state == SUB1)begin
		    curr_op = SUB;
		    src1 = 0;
		    src2 = 6;
		    dest = 0;
	    end
	    else if(state == MUL2)begin
		    curr_op = MUL;
		    src1 = 2;
		    src2 = 8;
		    dest = 6;
	    end
	    else if(state == ADD1)begin
		    curr_op = ADD;
		    src1 = 0;
		    src2 = 6;
		    dest = 0;
	    end
	    else if(state == MUL3)begin
		    curr_op = MUL;
		    src1 = 3;
		    src2 = 9;
		    dest = 6;
	    end
	    else if(state == SUB2)begin
		    curr_op = SUB;
		    src1 = 0;
		    src2 = 6;
		    dest = 0;
	    end
	    else if(state == MUL4)begin
		    curr_op = MUL;
		    src1 = 4;
		    src2 = 10;
		    dest = 6;
	    end
	    else if(state == ADD2)begin
		    curr_op = ADD;
		    src1 = 0;
		    src2 = 6;
		    dest = 0;
	    end
	    else if(state == LOADEXT1)begin
		    curr_op = LOAD2;
		    dest = 7;
		    clear = 1;
	    end
	    else if(state == LOADEXT2)begin
		    curr_op = LOAD2;
		    dest = 8;
	    end
	    else if(state == LOADEXT3)begin
		    curr_op = LOAD2;
		    dest = 9;
	    end
	    else if(state == LOADEXT4)begin
		    curr_op = LOAD2;
		    dest = 10;
	    end
	    else if(state == WAIT1)begin
		    next_modwait = 0;
	    end
	    else if(state == WAIT2)begin
		    next_modwait = 0;
	    end
	    else if(state == WAIT3)begin
		    next_modwait = 0;
	    end
	    else if(state == EIDLE)begin
		    err = 1;
		    next_modwait = 0;
	    end
    end

    assign modwait = curr_modwait;
    assign op = curr_op;
endmodule

