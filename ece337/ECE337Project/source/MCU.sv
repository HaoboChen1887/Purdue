// $Id: $
// File name:   MCU.sv
// Created:     4/23/2018
// Author:      Ni Kang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: main controller unit

module MCU(
    input wire start,
    input wire [3:0][7:0]ram_data,
    input wire [31:0] start_addr,
    //output reg [31:0] ram_in_addr,
    //output reg [31:0] ram_out_addr,

    // addr_calc
    input wire clk,
    input wire n_rst,
    input wire addr_calc_done,
    input wire [31:0] addr_calc, // calculated address
    input wire addr_calc_incdec,
    input wire addr_calc_new_row,
    input wire addr_calc_init,
    input wire [9:0] in_row_cnt,
    input wire [9:0] in_col_cnt,
    output reg addr_calc_en,
    
    input wire win_buf_full,
    input wire win_buf_fill_done,
    output reg win_buf_init,
    output reg win_buf_new_row,
    output reg win_buf_incdec,
    output reg win_buf_r_en,
    output reg win_buf_w_en,
    output reg [3:0][7:0] win_buf_in_buf,
    
    output reg gauss_calc_en, // enabled when gaussian blur is done for a single 3x3 matrix
    
    input wire gauss_blur_done, // done signal for entire 6x6 block
    input wire gauss_blur_calc_done, // done signal for single iteration
    output reg gauss_blur_en, // enabled when window buffer is full
    
    input wire gauss_buf_full,
    output reg gauss_buf_en,
    
    input reg sobel_done,
    output reg sobel_en, // enabled when sobel is done
    
    input reg mag_done,
    output reg mag_r_en,
    
    input reg grad_done,
    output reg grad_r_en,
    
    input wire out_addr_done,
    output reg out_addr_en
);

    typedef enum bit [3:0] {IDLE, START, IN_ADDR_CALC, WIN_BUF_FILL, CHECK_FULL, GAUSS_CALC, GAUSS_BLUR, GAUSS_FILL, CHECK_GAUSS_FULL, SOBEL, MAG, GRAD, OUT_ADDR_CALC} stateType;
    stateType state, next_state;
    reg next_ram_in_addr;
    reg next_ram_out_addr;
    reg next_addr_calc_en;
    reg next_win_buf_init;
    reg next_win_buf_new_row;
    reg next_win_buf_incdec;
    reg next_win_buf_r_en;
    reg next_win_buf_w_en;
    reg next_gauss_calc_en;
    reg next_gauss_blur_en;
    reg next_gauss_buf_en;
    reg next_sobel_en;
    reg next_mag_r_en;
    reg next_grad_r_en;
    reg next_out_addr_en;
    
    reg [3:0][7:0] next_win_buf_in_buf;
    
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
            gauss_calc_en <= '0;
            gauss_blur_en <= '0;
            gauss_buf_en <= '0;
            sobel_en <= '0;
            mag_r_en <= '0;
            grad_r_en <= '0;
            out_addr_en <= '0;
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
            gauss_calc_en <= next_gauss_calc_en;
            gauss_blur_en <= next_gauss_blur_en;
            gauss_buf_en <= next_gauss_buf_en;
            sobel_en <= next_sobel_en;
            mag_r_en <= next_mag_r_en;
            grad_r_en <= next_grad_r_en;
            out_addr_en <= next_out_addr_en;
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
                        next_state = GAUSS_CALC;
                    end
                    else begin
                        next_state = WIN_BUF_FILL;
                    end
                end
            end
            GAUSS_CALC:begin
                if(start == 1'b1)begin
                    next_state = GAUSS_BLUR;
                end
            end
            GAUSS_BLUR:begin
                if(start == 1'b1)begin
                    if(gauss_blur_calc_done == 1'b1)begin
                        next_state = GAUSS_FILL;
                    end
                end
            end
            GAUSS_FILL:begin
                if(start == 1'b1)begin
                    next_state = CHECK_GAUSS_FULL;
                end
            end
            CHECK_GAUSS_FULL:begin
                if(gauss_buf_full == 1'b1)begin
                    next_state = SOBEL;
                end
                else begin
                    next_state = GAUSS_CALC;
                end
            end
            SOBEL:begin
                if(start == 1'b1)begin
                    if(sobel_done == 1'b1)begin
                        next_state = MAG;
                    end
                end
            end
            MAG:begin
                if(start == 1'b1)begin
                    if(mag_done == 1'b1)begin
                        next_state = GRAD;
                    end
                end
            end
            GRAD:begin
                if(start == 1'b1)begin
                    if(grad_done == 1'b1)begin
                        next_state = OUT_ADDR_CALC;
                    end
                end
            end
            OUT_ADDR_CALC:begin
                if(start == 1'b1)begin
                    if(out_addr_done == 1'b1)begin
                        next_state = IDLE;
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
        next_gauss_calc_en = gauss_calc_en;
        next_gauss_blur_en = gauss_blur_en;
        next_gauss_buf_en = gauss_buf_en;
        next_sobel_en = sobel_en;
        next_mag_r_en = mag_r_en;
        next_grad_r_en = grad_r_en;
        next_out_addr_en = out_addr_en;
        next_win_buf_in_buf = win_buf_in_buf;
        case(state)
            IDLE:begin
                if(out_addr_done == 1'b1)begin
                    next_out_addr_en = 1'b0;
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
                    next_gauss_calc_en = 1'b1;
                end
                else begin
                    next_win_buf_r_en = 1'b1;
                end
            end
            GAUSS_CALC:begin
                next_gauss_calc_en = 1'b0;
                next_gauss_blur_en = 1'b1;
            end
            GAUSS_BLUR:begin
                if(gauss_blur_calc_done == 1'b1)begin
                    next_gauss_blur_en = 1'b0;
                    next_gauss_buf_en = 1'b1;
                end
            end
            GAUSS_FILL:begin
                next_win_buf_w_en = 1'b0;
                next_gauss_buf_en = 1'b0;
            end
            CHECK_GAUSS_FULL:begin
                if(gauss_buf_full == 1'b1)begin
                    next_sobel_en = 1'b1;
                end
                else begin
                    next_gauss_blur_en = 1'b1;
                    next_gauss_calc_en = 1'b1;
                end
            end
            SOBEL:begin
                if(sobel_done == 1'b1)begin
                    next_sobel_en = 1'b0;
                    next_mag_r_en = 1'b1;
                end
            end
            MAG:begin
                if(mag_done == 1'b1)begin
                    next_mag_r_en = 1'b0;
                    next_grad_r_en = 1'b1;
                end
            end
            GRAD:begin
                if(grad_done == 1'b1)begin
                    next_grad_r_en = 1'b0;
                    next_out_addr_en = 1'b1;
                end
            end
            OUT_ADDR_CALC:begin
                if(out_addr_done == 1'b1)begin
                    next_out_addr_en = 1'b0;
                end
            end
        endcase
    end
endmodule
