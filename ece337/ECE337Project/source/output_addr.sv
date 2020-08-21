// $Id: $
// File name:   output_addr.sv
// Created:     4/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: output to SRAM

module output_addr(
    input wire clk,
    input wire n_rst,
    input wire [3:0][3:0][17:0] data_in,
    input wire [31:0] start_addr,
    input wire [31:0] addr_calc_addr,
    input wire calc_en,
    output reg [3:0][3:0][7:0] data_o,
    output reg [31:0] calc_addr,
    output reg calc_done
);

    reg [3:0][3:0][7:0] next_data_o;
    reg [31:0] next_calc_addr;
    reg next_calc_done;
    
    typedef enum bit [4:0] {IDLE, JUDGE1, JUDGE2, JUDGE3, JUDGE4, JUDGE5, JUDGE6, JUDGE7, JUDGE8, JUDGE9, JUDGE10, JUDGE11, JUDGE12, JUDGE13, JUDGE14, JUDGE15, JUDGE16, CALC, DONE} stateType;
    stateType state, next_state;
    
    always_ff @ (posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            data_o <= '0;
            calc_addr <= '0;
            calc_done <= 0;
            state <= IDLE;
        end
        else begin
            data_o <= next_data_o;
            calc_addr <= next_calc_addr;
            calc_done <= next_calc_done;
            state <= next_state;
        end
    end
    
    always_comb begin
        next_data_o = data_o;
        next_calc_addr = calc_addr;
        next_calc_done = calc_done;
        next_state = state;
        
        case(state)
            IDLE:
            begin
                if (calc_en == 1) begin
                    if (calc_done == 1) begin
                        next_calc_done = 0;
                    end
                    next_state = JUDGE1;
                end
            end
            JUDGE1:
            begin
                if (calc_en == 1) begin
                    if (data_in[0][0] > 18'd2500) begin
                        next_data_o[0][0] = 8'd255;
                    end
                    else begin
                        next_data_o[0][0] = 8'd0;
                    end
                    next_state = JUDGE2;
                end
            end
            
            JUDGE2:
            begin
                if (calc_en == 1) begin
                    if (data_in[0][1] > 18'd2500) begin
                        next_data_o[0][1] = 8'd255;
                    end
                    else begin
                        next_data_o[0][1] = 8'd0;
                    end
                    next_state = JUDGE3;
                end
            end
            
            JUDGE3:
            begin
                if (calc_en == 1) begin
                    if (data_in[0][2] > 18'd2500) begin
                        next_data_o[0][2] = 8'd255;
                    end
                    else begin
                        next_data_o[0][2] = 8'd0;
                    end
                    next_state = JUDGE4;
                end
            end
            
            JUDGE4:
            begin
                if (calc_en == 1) begin
                    if (data_in[0][3] > 18'd2500) begin
                        next_data_o[0][3] = 8'd255;
                    end
                    else begin
                        next_data_o[0][3] = 8'd0;
                    end
                    next_state = JUDGE5;
                end
            end
            
            JUDGE5:
            begin
                if (calc_en == 1) begin
                    if (data_in[1][0] > 18'd2500) begin
                        next_data_o[1][0] = 8'd255;
                    end
                    else begin
                        next_data_o[1][0] = 8'd0;
                    end
                    next_state = JUDGE6;
                end
            end
            
            JUDGE6:
            begin
                if (calc_en == 1) begin
                    if (data_in[1][1] > 18'd2500) begin
                        next_data_o[1][1] = 8'd255;
                    end
                    else begin
                        next_data_o[1][1] = 8'd0;
                    end
                    next_state = JUDGE7;
                end
            end
            
            JUDGE7:
            begin
                if (calc_en == 1) begin
                    if (data_in[1][2] > 18'd2500) begin
                        next_data_o[1][2] = 8'd255;
                    end
                    else begin
                        next_data_o[1][2] = 8'd0;
                    end
                    next_state = JUDGE8;
                end
            end
           
            JUDGE8:
            begin
                if (calc_en == 1) begin
                    if (data_in[1][3] > 18'd2500) begin
                        next_data_o[1][3] = 8'd255;
                    end
                    else begin
                        next_data_o[1][3] = 8'd0;
                    end
                    next_state = JUDGE9;
                end
            end
            
            JUDGE9:
            begin
                if (calc_en == 1) begin
                    if (data_in[2][0] > 18'd2500) begin
                        next_data_o[2][0] = 8'd255;
                    end
                    else begin
                        next_data_o[2][0] = 8'd0;
                    end
                    next_state = JUDGE10;
                end
            end
            
            JUDGE10:
            begin
                if (calc_en == 1) begin
                    if (data_in[2][1] > 18'd2500) begin
                        next_data_o[2][1] = 8'd255;
                    end
                    else begin
                        next_data_o[2][1] = 8'd0;
                    end
                    next_state = JUDGE11;
                end
            end
            
            JUDGE11:
            begin
                if (calc_en == 1) begin
                    if (data_in[2][2] > 18'd2500) begin
                        next_data_o[2][2] = 8'd255;
                    end
                    else begin
                        next_data_o[2][2] = 8'd0;
                    end
                    next_state = JUDGE12;
                end
            end
            
            JUDGE12:
            begin
                if (calc_en == 1) begin
                    if (data_in[2][3] > 18'd2500) begin
                        next_data_o[2][3] = 8'd255;
                    end
                    else begin
                        next_data_o[2][3] = 8'd0;
                    end
                    next_state = JUDGE13;
                end
            end
            
            JUDGE13:
            begin
                if (calc_en == 1) begin
                    if (data_in[3][0] > 18'd2500) begin
                        next_data_o[3][0] = 8'd255;
                    end
                    else begin
                        next_data_o[3][0] = 8'd0;
                    end
                    next_state = JUDGE14;
                end
            end
            
            JUDGE14:
            begin
                if (calc_en == 1) begin
                    if (data_in[3][1] > 18'd2500) begin
                        next_data_o[3][1] = 8'd255;
                    end
                    else begin
                        next_data_o[3][1] = 8'd0;
                    end
                    next_state = JUDGE15;
                end
            end
            
            JUDGE15:
            begin
                if (calc_en == 1) begin
                    if (data_in[3][2] > 18'd2500) begin
                        next_data_o[3][2] = 8'd255;
                    end
                    else begin
                        next_data_o[3][2] = 8'd0;
                    end
                    next_state = JUDGE16;
                end
            end
            
            JUDGE16:
            begin
                if (calc_en == 1) begin
                    if (data_in[3][3] > 18'd2500) begin
                        next_data_o[3][3] = 8'd255;
                    end
                    else begin
                        next_data_o[3][3] = 8'd0;
                    end
                    next_state = CALC;
                end
            end
  
            CALC:
            begin
                if (calc_en == 1) begin
                    next_calc_addr = start_addr + addr_calc_addr + 1602;
                    next_state = DONE;
                end
            end
            DONE:
            begin
                if (calc_en == 1) begin
                    next_calc_done = 1;
                    next_state = IDLE;
                end
            end
        endcase
    end
    
endmodule

