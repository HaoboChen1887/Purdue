// $Id: $
// File name:   win_buf_control.sv
// Created:     4/25/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: controller for window buffer and address calculation
// $Id: $
// File name:   MCU.sv
// Created:     4/23/2018
// Author:      Ni Kang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: main controller unit

module win_buf_control(
    input wire start,
    input wire [3:0][7:0]ram_data,
    input wire [31:0] start_addr,

    // addr_calc
    input wire clk,
    input wire n_rst,
    input wire addr_calc_done,
    input wire [31:0] addr_calc, // calculated address
    input wire addr_calc_incdec,
    input wire addr_calc_new_row,
    input wire addr_calc_init,
    output reg addr_calc_en,
    
    input wire win_buf_full,
    input wire win_buf_fill_done,
    output reg win_buf_init,
    output reg win_buf_new_row,
    output reg win_buf_incdec,
    output reg win_buf_r_en,
    output reg win_buf_w_en,
    output reg [3:0][7:0] win_buf_in_buf
);

    typedef enum bit [3:0] {IDLE, START, IN_ADDR_CALC, WIN_BUF_FILL, CHECK_FULL} stateType;
    stateType state, next_state;
    reg next_ram_in_addr;
    reg next_ram_out_addr;
    reg next_addr_calc_en;
    reg next_win_buf_init;
    reg next_win_buf_new_row;
    reg next_win_buf_incdec;
    reg next_win_buf_r_en;
    reg next_win_buf_w_en;
    reg next_win_buf_in_buf;
    
    always_ff @ (posedge clk, negedge n_rst)begin
        if(n_rst == 0)begin
            //ram_in_addr <= '0;
            //ram_out_addr <= '0;
            addr_calc_en <= '0;
            win_buf_init <= '0;
            win_buf_new_row <= '0;
            win_buf_incdec <= '0;
            win_buf_r_en <= '0;
            win_buf_w_en <= '0;
            win_buf_in_buf <= '0;
            state <= IDLE;
        end
        else begin
            //ram_in_addr <= next_ram_in_addr;
            //ram_out_addr <= next_ram_out_addr;
            addr_calc_en <= next_addr_calc_en;
            win_buf_init <= next_win_buf_init;
            win_buf_new_row <= next_win_buf_new_row;
            win_buf_incdec <= next_win_buf_incdec;
            win_buf_r_en <= next_win_buf_r_en;
            win_buf_w_en <= next_win_buf_w_en;
            win_buf_in_buf <= next_win_buf_in_buf;
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            IDLE:begin
                if(start == 1'b1)begin
                    next_state = START;
                end
            end
            START:begin
                if(start == 1'b1)begin
                    next_state = IN_ADDR_CALC;
                end
            end
            IN_ADDR_CALC:begin
                if(start == 1'b1)begin
                    if(addr_calc_done == 1'b1)begin
                        next_state = WIN_BUF_FILL;
                    end
                end
            end
            WIN_BUF_FILL:begin
                if(start == 1'b1)begin
                    if(win_buf_fill_done == 1'b1)begin
                        next_state = CHECK_FULL;
                    end
                end
            end
            CHECK_FULL:begin
                if(start == 1'b1)begin
                    if(win_buf_full == 1'b1)begin
                        next_state = IDLE;
                    end
                    else begin
                        next_state = WIN_BUF_FILL;
                    end
                end
            end
        endcase
    end    
    always_comb begin
        //next_ram_in_addr = ram_in_addr;
        //next_ram_out_addr = ram_out_addr;
        next_addr_calc_en = addr_calc_en;
        next_win_buf_init = win_buf_init;
        next_win_buf_new_row = win_buf_new_row;
        next_win_buf_incdec = win_buf_incdec;
        next_win_buf_r_en = win_buf_r_en;
        next_win_buf_w_en = win_buf_w_en;
        next_win_buf_in_buf = win_buf_in_buf;
        case(state)
            IDLE:begin
                if(win_buf_w_en == 1'b1)begin
                    next_win_buf_w_en = 1'b0;
                end
            end
            START:begin
                next_addr_calc_en = 1'b1;
            end
            IN_ADDR_CALC:begin
                if(addr_calc_done == 1'b1)begin
                    next_win_buf_r_en = 1'b1;
                    next_addr_calc_en = 1'b0;
                    next_win_buf_new_row = addr_calc_new_row;
                    next_win_buf_init = addr_calc_init;
                    next_win_buf_incdec = addr_calc_incdec;
                    next_win_buf_in_buf = ram_data;
                end
            end
            WIN_BUF_FILL:begin
                if(win_buf_fill_done == 1'b1)begin
                    next_win_buf_r_en = 1'b0;
                end
            end
            CHECK_FULL:begin
                if(win_buf_full == 1'b1)begin
                    next_win_buf_r_en = 1'b0;
                    next_win_buf_w_en = 1'b1;
                end
                else begin
                    next_win_buf_r_en = 1'b1;
                end
            end
        endcase
    end
endmodule
