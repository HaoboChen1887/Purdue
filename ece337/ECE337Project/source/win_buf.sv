// $Id: $
// File name:   win_buf.sv
// Created:     4/22/2018
// Author:      Ni Kang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: window buffer
// 
module win_buf(
    input wire clk,
    input wire n_rst,
    input wire [3:0][7:0] in_buf,
    input wire [2:0] row_in_buf,
    input wire [2:0] col_in_buf,
    input wire new_row,
    input wire incdec,
    input wire r_enable,
    input wire w_enable,
    input wire init,
    output reg full,
    output reg fill_done,
    output reg [2:0][2:0][7:0] out_buf
);

    typedef enum bit [5:0] {IDLE, SHIFTL, SHIFTR, SHIFTU, FILL1, FILL2, FILL3, FILL4, FILL5, FILL6, FILL7, FILL8, FILL9, FILL10, FILL11, FILL12, FILL13, FILL14, FILL15, FILL16, FILLDONE, WAIT1, WAIT2, WAIT3, WAIT4, WAIT5, WAIT6, WAIT7, WAIT8, WAIT9, WAIT10, WAIT11, WAIT12, WAIT13, WAIT14, WAIT15, WAIT16}stateType;
    stateType state, next_state;
    
    reg next_full;
    reg next_fill_done; // single fill done
    reg [2:0][2:0][7:0] next_out_buf;
    reg [7:0][7:0][7:0] buffer, next_buffer;

    
    always_ff @ (posedge clk, negedge n_rst)begin
        if(n_rst == 1'b0)begin
            full <= '0;
            out_buf <= '0;
            buffer <= '0;
            fill_done <= '0;
            state <= IDLE;
        end
        else begin
            full <= next_full;
            out_buf <= next_out_buf;
            buffer <= next_buffer;
            fill_done <= next_fill_done;
            state <= next_state;
        end
    end
    
    always_comb begin
        next_full = full;
        next_out_buf = out_buf;
        next_buffer = buffer;
        next_fill_done = fill_done;
        next_state = state;
        case(state)
            IDLE:begin
                if(r_enable == 1'b1)begin
                    if(full == 1'b1)begin
                        next_full = 1'b0;
                    end
                    if(fill_done == 1'b1)begin
                        next_fill_done = 1'b0;
                    end
                    if(init == 1'b1)
                        next_state = FILL1;
                    else if(incdec == 1'b0 && new_row == 1'b0)
                        next_state = SHIFTL;
                    else if(incdec == 1'b1 && new_row == 1'b0)
                        next_state = SHIFTR;
                    else if(new_row == 1'b1)
                        next_state = SHIFTU;
                end
            end
            SHIFTL:begin
                if(r_enable == 1'b1)begin
                    //next_buffer[7:0][7:4][7:0] = buffer[7:0][3:0][7:0];
                    //next_buffer[7:0][3:0][7:0] = '0;
                    next_buffer[7][7] = buffer[7][3];
                    next_buffer[7][6] = buffer[7][2];
                    next_buffer[7][5] = buffer[7][1];
                    next_buffer[7][4] = buffer[7][0];
	                          
                    next_buffer[6][7] = buffer[6][3];
                    next_buffer[6][6] = buffer[6][2];
                    next_buffer[6][5] = buffer[6][1];
                    next_buffer[6][4] = buffer[6][0];
	                           
                    next_buffer[5][7] = buffer[5][3];
                    next_buffer[5][6] = buffer[5][2];
                    next_buffer[5][5] = buffer[5][1];
                    next_buffer[5][4] = buffer[5][0];
	                           
                    next_buffer[4][7] = buffer[4][3];
                    next_buffer[4][6] = buffer[4][2];
                    next_buffer[4][5] = buffer[4][1];
                    next_buffer[4][4] = buffer[4][0];
			                        
                    next_buffer[3][7] = buffer[3][3];
                    next_buffer[3][6] = buffer[3][2];
                    next_buffer[3][5] = buffer[3][1];
                    next_buffer[3][4] = buffer[3][0];
	                           
                    next_buffer[2][7] = buffer[2][3];
                    next_buffer[2][6] = buffer[2][2];
                    next_buffer[2][5] = buffer[2][1];
                    next_buffer[2][4] = buffer[2][0];
	                           
                    next_buffer[1][7] = buffer[1][3];
                    next_buffer[1][6] = buffer[1][2];
                    next_buffer[1][5] = buffer[1][1];
                    next_buffer[1][4] = buffer[1][0];
	                           
                    next_buffer[0][7] = buffer[0][3];
                    next_buffer[0][6] = buffer[0][2];
                    next_buffer[0][5] = buffer[0][1];
                    next_buffer[0][4] = buffer[0][0];
                    next_state = FILL9;
                end
            end
            SHIFTR:begin
                if(r_enable == 1'b1)begin
                    //next_buffer[7:0][3:0][7:0] = buffer[7:0][7:4][7:0];
                    next_buffer[7][3] = buffer[7][7];
                    next_buffer[7][2] = buffer[7][6];
                    next_buffer[7][1] = buffer[7][5];
                    next_buffer[7][0] = buffer[7][4];
                    
                    next_buffer[6][3] = buffer[6][7];
                    next_buffer[6][2] = buffer[6][6];
                    next_buffer[6][1] = buffer[6][5];
                    next_buffer[6][0] = buffer[6][4];
                    
                    next_buffer[5][3] = buffer[5][7];
                    next_buffer[5][2] = buffer[5][6];
                    next_buffer[5][1] = buffer[5][5];
                    next_buffer[5][0] = buffer[5][4];
                    
                    next_buffer[4][3] = buffer[4][7];
                    next_buffer[4][2] = buffer[4][6];
                    next_buffer[4][1] = buffer[4][5];
                    next_buffer[4][0] = buffer[4][4];
                   
                    next_buffer[3][3] = buffer[3][7];
                    next_buffer[3][2] = buffer[3][6];
                    next_buffer[3][1] = buffer[3][5];
                    next_buffer[3][0] = buffer[3][4];
                    
                    next_buffer[2][3] = buffer[2][7];
                    next_buffer[2][2] = buffer[2][6];
                    next_buffer[2][1] = buffer[2][5];
                    next_buffer[2][0] = buffer[2][4];
                    
                    next_buffer[1][3] = buffer[1][7];
                    next_buffer[1][2] = buffer[1][6];
                    next_buffer[1][1] = buffer[1][5];
                    next_buffer[1][0] = buffer[1][4];
                    
                    next_buffer[0][3] = buffer[0][7];
                    next_buffer[0][2] = buffer[0][6];
                    next_buffer[0][1] = buffer[0][5];
                    next_buffer[0][0] = buffer[0][4];
                    //next_buffer[7:0][7:4][7:0] = '0;
                    next_state = FILL1;
                end
            end
            SHIFTU:begin
                if(r_enable == 1'b1)begin
                    //next_buffer[3:0][7:0][7:0] = buffer[7:4][7:0][7:0];
                    next_buffer[7] = buffer[3];
                    next_buffer[6] = buffer[2];
                    next_buffer[5] = buffer[1];
                    next_buffer[4] = buffer[0];
                    //next_buffer[7:4][7:0] = '0;
                    next_state = FILL5;
                end
            end
            FILL1:begin
                if(r_enable == 1'b1)begin
                    next_buffer[7][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT1;
                end
            end
            FILL2:begin
                if(r_enable == 1'b1)begin
                    next_buffer[6][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT2;
                end
            end
            FILL3:begin
                if(r_enable == 1'b1)begin
                    next_buffer[5][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT3;
                end
            end
            FILL4:begin
                if(r_enable == 1'b1)begin
                    next_buffer[4][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT4;
                end
            end
            FILL5:begin
                if(r_enable == 1'b1)begin
                    next_buffer[3][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT5;
                end
            end
            FILL6:begin
                if(r_enable == 1'b1)begin
                    next_buffer[2][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT6;
                end
            end
            FILL7:begin
                if(r_enable == 1'b1)begin
                    next_buffer[1][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT7;
                end
            end
            FILL8:begin
                if(r_enable == 1'b1)begin
                    next_buffer[0][7:4] = in_buf;
                    next_fill_done = 1'b1;
                    if(init == 1'b1)
                        next_state = WAIT8;
                    else if(new_row == 1'b1)
                        next_state = WAIT12;
                    else
                        next_state = WAIT16;
                end
            end
            FILL9:begin
                if(r_enable == 1'b1)begin
                    next_buffer[7][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT9;
                end
            end
            FILL10:begin
                if(r_enable == 1'b1)begin
                    next_buffer[6][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT10;
                end
            end
            FILL11:begin
                if(r_enable == 1'b1)begin
                    next_buffer[5][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT11;
                end
            end
            FILL12:begin
                if(r_enable == 1'b1)begin
                    next_buffer[4][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT12;
                end
            end
            FILL13:begin
                if(r_enable == 1'b1)begin
                    next_buffer[3][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT13;
                end
            end
            FILL14:begin
                if(r_enable == 1'b1)begin
                    next_buffer[2][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT14;
                end
            end
            FILL15:begin
                if(r_enable == 1'b1)begin
                    next_buffer[1][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT15;
                end
            end
            FILL16:begin
                if(r_enable == 1'b1)begin
                    next_buffer[0][3:0] = in_buf;
                    next_fill_done = 1'b1;
                    next_state = WAIT16;
                end
            end
            WAIT1:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL2;
                end
            end
            WAIT2:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL3;
                end
            end
            WAIT3:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL4;
                end
            end
            WAIT4:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL5;
                end
            end
            WAIT5:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL6;
                end
            end
            WAIT6:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL7;
                end
            end
            WAIT7:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL8;
                end
            end
            WAIT8:begin
                if(r_enable == 1'b1)begin
                    if(new_row == 1'b0 && init == 1'b0)begin
                        next_fill_done = 1'b0;
                    end
                    else begin
                        next_fill_done = 1'b1;
                    end
                    next_state = FILL9;
                end
            end
            WAIT9:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL10;
                end
            end
            WAIT10:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL11;
                end
            end
            WAIT11:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL12;
                end
            end
            WAIT12:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL13;
                end
            end
            WAIT13:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL14;
                end
            end
            WAIT14:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL15;
                end
            end
            WAIT15:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b0;
                    next_state = FILL16;
                end
            end
            WAIT16:begin
                if(r_enable == 1'b1)begin
                    next_fill_done = 1'b1;
                    next_state = FILLDONE;
                end
            end
            FILLDONE:begin
                if(r_enable == 1'b1)begin
                    next_full = 1'b1;
                    if(w_enable == 1'b1)begin
                        next_out_buf[2][2] = buffer[row_in_buf][col_in_buf - 0];
                        next_out_buf[2][1] = buffer[row_in_buf][col_in_buf - 1];
                        next_out_buf[2][0] = buffer[row_in_buf][col_in_buf - 2];
                        next_out_buf[1][2] = buffer[row_in_buf - 1][col_in_buf - 0];
                        next_out_buf[1][1] = buffer[row_in_buf - 1][col_in_buf - 1];
                        next_out_buf[1][0] = buffer[row_in_buf - 1][col_in_buf - 2];
                        next_out_buf[0][2] = buffer[row_in_buf - 2][col_in_buf - 0];
                        next_out_buf[0][1] = buffer[row_in_buf - 2][col_in_buf - 1];
                        next_out_buf[0][0] = buffer[row_in_buf - 2][col_in_buf - 2];
                    end
                    next_state = IDLE;
                end
            end
        endcase
    end
endmodule
