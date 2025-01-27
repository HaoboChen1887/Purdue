// $Id: $
// File name:   gauss_mcu.sv
// Created:     4/25/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .

module gauss_mcu(
	input wire clk,
	input wire n_rst,
	input wire win_buf_full,
	output reg gauss_calc_en, // enabled when gaussian blur is done for a single 3x3 matrix

	input wire gauss_blur_done, // done signal for entire 6x6 block
	input wire gauss_blur_calc_done, // done signal for single iteration
	output reg gauss_blur_en, // enabled when window buffer is full

	input wire gauss_buf_full,
	output reg gauss_buf_en,
	output reg sobel_en // enabled when sobel is done
	
);

	typedef enum bit [3:0] {IDLE, GAUSS_CALC, GAUSS_BLUR, GAUSS_FILL, CHECK_GAUSS_FULL}stateType;
	stateType state, next_state;
	reg next_gauss_calc_en;
    	reg next_gauss_blur_en;
    	reg next_gauss_buf_en;
    	reg next_sobel_en;

    
	always_ff @ (posedge clk, negedge n_rst)begin
	if(n_rst == 0)begin
		
		gauss_calc_en <= '0;
		gauss_blur_en <= '0;
		gauss_buf_en <= '0;
		sobel_en <= '0;
		state <= IDLE;
        end
        else begin
            gauss_calc_en <= next_gauss_calc_en;
            gauss_blur_en <= next_gauss_blur_en;
            gauss_buf_en <= next_gauss_buf_en;
            sobel_en <= next_sobel_en;
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case(state)
            IDLE:begin
                if(win_buf_full == 1'b1)begin
                    next_state = GAUSS_CALC;
                end
            end
            
            GAUSS_CALC:begin
                if(win_buf_full == 1'b1)begin
                    next_state = GAUSS_BLUR;
                end
            end
            GAUSS_BLUR:begin
                if(win_buf_full == 1'b1)begin
                    if(gauss_blur_calc_done == 1'b1)begin
                        next_state = GAUSS_FILL;
                    end
                end
            end
            GAUSS_FILL:begin
                if(win_buf_full == 1'b1)begin
                    next_state = CHECK_GAUSS_FULL;
                end
            end
            CHECK_GAUSS_FULL:begin
                if(gauss_buf_full == 1'b1)begin
                    next_state = IDLE;
                end
                else begin
                    next_state = GAUSS_CALC;
                end
            end
        endcase
    end
    
    always_comb begin
        next_gauss_calc_en = gauss_calc_en;
        next_gauss_blur_en = gauss_blur_en;
        next_gauss_buf_en = gauss_buf_en;
        next_sobel_en = sobel_en;
        case(state)
            IDLE:begin
                if (win_buf_full == 1'b1) begin
                	next_gauss_calc_en = 1'b1;
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
        endcase
    end
endmodule
