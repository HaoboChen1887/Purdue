// $Id: $
// File name:   tb_output_addr.sv
// Created:     4/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: test bench for output module

`timescale 1ns / 10ps
module tb_output_addr();
    localparam CLK_PERIOD = 1;
    
    logic tb_clk;
    logic tb_n_rst;
    logic [3:0][3:0][17:0] tb_data_in;
    logic [31:0] tb_start_addr;
    logic [31:0] tb_addr_calc_addr;
    logic tb_calc_en;
    logic [3:0][3:0][7:0] tb_data_o;
    logic [31:0] tb_calc_addr;
    logic tb_calc_done;
    
    logic [3:0][3:0][7:0] temp;
    integer testNum = 0;
    
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD / 2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD / 2.0);
    end
    
    output_addr DUT(
        .clk(tb_clk),
        .n_rst(tb_n_rst),
        .data_in(tb_data_in),
        .start_addr(tb_start_addr),
        .addr_calc_addr(tb_addr_calc_addr),
        .calc_en(tb_calc_en),
        .data_o(tb_data_o),
        .calc_addr(tb_calc_addr),
        .calc_done(tb_calc_done)
    );
    
    initial begin
        tb_n_rst = 0;
        tb_calc_en = 0;
        @(posedge tb_clk)
        @(posedge tb_clk)
        
        tb_n_rst = 1;
        tb_calc_en = 0;
        tb_start_addr = '0;
        @(posedge tb_clk)
        @(posedge tb_clk)
        tb_addr_calc_addr = 0;
        
        tb_data_in = '{'{18'd3400, 18'd0, 18'd2499, 18'd0},
                       '{18'd1200, 18'd65025, 18'd0, 18'd6},
                       '{18'd3400, 18'd0, 18'd2499, 18'd0},
                       '{18'd1200, 18'd65025, 18'd0, 18'd6}};
        tb_calc_en = 0;
        
        temp = '{'{8'd255, 8'd0, 8'd0, 8'd0},
                 '{8'd0, 8'd255, 8'd0, 8'd0},
                 '{8'd255, 8'd0, 8'd0, 8'd0},
                 '{8'd0, 8'd255, 8'd0, 8'd0}};
                 
        testNum = 1;      
        @(posedge tb_clk)
        @(posedge tb_clk)  
        assert(tb_data_o == '0) begin
            $info("Test case 1 passed!");
        end
        else begin
            $error("Test case 1 failed!");
        end
                 
        tb_calc_en = 1;
        testNum = 2;
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        
        assert(tb_data_o == temp) begin
            $info("Test case 2 passed!");
        end
        else begin
            $error("Test case 2 failed!");
        end
        
        testNum = 3;
        tb_data_in = '{'{18'd32754, 18'd37862, 18'd60000, 18'd5274},
                       '{18'd22, 18'd22222, 18'd50505, 18'd5050},
                       '{18'd7, 18'd89, 18'd2499, 18'd0},
                       '{18'd1028, 18'd7890, 18'd3245, 18'd255}};
        temp = '{'{8'd255, 8'd255, 8'd255, 8'd255},
                 '{8'd0, 8'd255, 8'd255, 8'd255},
                 '{8'd0, 8'd0, 8'd0, 8'd0},
                 '{8'd0, 8'd255, 8'd255, 8'd0}};
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        @(posedge tb_clk)
        
        assert(tb_data_o == temp) begin
            $info("Test case 3 passed!");
        end
        else begin
            $error("Test case 3 failed!");
        end
        
        testNum = 4;
        assert(tb_calc_addr == 1602) begin
            $info("Test case 4 passed!");
        end
        else begin
            $error("Test case 4 failed!");
        end
        
    end
endmodule

                       
        
