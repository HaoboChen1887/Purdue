// $Id: $
// File name:   tb_edge_detector.sv
// Created:     3/22/2018
// Author:      Haoming Zhang
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: .
`timescale 1ns / 100ps
module tb_edge_detector ();
	localparam CLK_PERIOD = 2.5;
	localparam CHECK_DELAY = 1;
	localparam TEST_DELAY = 10;
	parameter INPUT_FILENAME = "./docs/test_data.txt";
	parameter OUTPUT_FILENAME = "./docs/test_out.txt";

	// Declare Design Under Test portmap signals
	reg [7:0]tb_ram_sim[0:479999];
	reg [7:0]tb_ram_out[0:479999];

	reg tb_clk;
	reg tb_n_rst;
	reg [31:0] tb_start_addr;
	reg tb_start;
	reg [3:0][7:0] tb_ram_data;
	reg [31:0] tb_ram_in_addr;
	reg [31:0] tb_ram_out_addr;
	reg [3:0][3:0][7:0] tb_data_out;
	reg tb_win_buf_r_en;
	reg tb_out_addr_done;
	reg tb_edge_detect_done;
	
	
	integer i;
	integer quiet;
	integer in_file;	
	integer out_file;
	
	always
	begin
		tb_clk = 1'b0;
		#(CLK_PERIOD/2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD/2.0);
	end
	
	edge_detector EDGE (
		.clk(tb_clk), 
		.n_rst(tb_n_rst),
		.start_addr(tb_start_addr),
		.start(tb_start),
		.ram_data(tb_ram_data),
		.ram_in_addr(tb_ram_in_addr),
		.ram_out_addr(tb_ram_out_addr),
		.data_out(tb_data_out),
		.win_buf_r_en(tb_win_buf_r_en),
		.out_addr_done(tb_out_addr_done),
		.edge_detect_done(tb_edge_detect_done)
	);

    //initial
    //begin
    //    $readmemh(INPUT_FILENAME, tb_ram_sim);
    //end

    initial
    begin
        in_file = $fopen(INPUT_FILENAME, "r");
        i = 0;
        while(! $feof(in_file))begin
            quiet = $fscanf(in_file, "%d,\n", tb_ram_sim[i]);
            i = i + 1;
        end
        $fclose(in_file);
    end

	initial begin
        tb_start = 0;
        tb_n_rst = 0;
        @(posedge tb_clk);
		@(posedge tb_clk);
        tb_n_rst = 1;
        tb_start = 1;
        tb_start_addr = 0;
        @(posedge tb_edge_detect_done)
        tb_start = 0;
    end
    typedef enum bit [4:0] {IDLE, FILL1, FILL2, FILL3, FILL4, FILL5, FILL6, FILL7, FILL8, FILL9, FILL10, FILL11, FILL12, FILL13, FILL14, FILL15, FILL16, DONE}stateType;
    stateType state, next_state;
    
    always_ff @(posedge tb_clk, negedge tb_n_rst)begin
        if(tb_n_rst == 1'b0)begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        next_state = state;
        case(state)
            IDLE:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        next_state = FILL1;
                    end              
                end
            end
            FILL1:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 1];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 2];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 3];
                        next_state = FILL2;  
                    end              
                end
            end
            FILL2:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 800];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 801];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 802];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 803];
                        next_state = FILL3;  
                    end              
                end
            end
            FILL3:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 1600];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 1601];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 1602];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 1603];
                        next_state = FILL4;  
                    end              
                end
            end
            FILL4:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 2400];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 2401];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 2402];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 2403];
                        if(tb_ram_in_addr != 0 && (tb_ram_in_addr % 800 == 792 || tb_ram_in_addr % 800 == 0))begin
                            next_state = FILL9;  
                        end
                        else begin
                            next_state = FILL5;
                        end
                    end              
                end
            end
            FILL5:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 3200];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 3201];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 3202];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 3203];
                        next_state = FILL6;  
                    end              
                end
            end
            FILL6:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 4000];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 4001];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 4002];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 4003];
                        next_state = FILL7;  
                    end              
                end
            end
            FILL7:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 4800];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 4801];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 4802];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 4803];
                        next_state = FILL8;  
                    end              
                end
            end
            FILL8:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 5600];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 5601];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 5602];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 5603];
                        if(tb_ram_in_addr == 0)begin
                            next_state = FILL9;  
                        end
                        else begin
                            next_state = DONE;
                        end
                    end              
                end
            end
            FILL9:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 4];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 5];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 6];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 7];
                        next_state = FILL10;  
                    end              
                end
            end
            FILL10:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 804];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 805];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 806];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 807];
                        next_state = FILL11;  
                    end              
                end
            end
            FILL11:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 1604];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 1605];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 1606];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 1607];
                        next_state = FILL12;  
                    end              
                end
            end
            FILL12:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 2404];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 2405];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 2406];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 2407];
                        if(tb_ram_in_addr != 0 && (tb_ram_in_addr % 800 == 792 || tb_ram_in_addr % 800 == 0))begin
                            next_state = DONE;  
                        end
                        else begin
                            next_state = FILL13;
                        end
                    end              
                end
            end
            FILL13:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 3204];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 3205];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 3206];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 3207];
                        next_state = FILL14;  
                    end              
                end
            end
            FILL14:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 4004];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 4005];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 4006];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 4007];
                        next_state = FILL15;  
                    end              
                end
            end
            FILL15:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 4804];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 4805];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 4806];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 4807];
                        next_state = FILL16;  
                    end              
                end
            end
            FILL16:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        tb_ram_data[3] = tb_ram_sim[tb_ram_in_addr + 5604];
                        tb_ram_data[2] = tb_ram_sim[tb_ram_in_addr + 5605];
                        tb_ram_data[1] = tb_ram_sim[tb_ram_in_addr + 5606];
                        tb_ram_data[0] = tb_ram_sim[tb_ram_in_addr + 5607];
                        next_state = DONE;  
                    end              
                end
            end
            DONE:begin
                if(tb_start == 1'b1)begin
                    if(tb_win_buf_r_en == 1'b1)begin
                        next_state = IDLE;
                    end              
                end
            end
            
            
        endcase
    end
    always_comb begin
        if(tb_out_addr_done == 1'b1)begin
            tb_ram_out[tb_ram_out_addr] = tb_data_out[0][0];
            tb_ram_out[tb_ram_out_addr+1] = tb_data_out[0][1];
            tb_ram_out[tb_ram_out_addr+2] = tb_data_out[0][2];
            tb_ram_out[tb_ram_out_addr+3] = tb_data_out[0][3];
            tb_ram_out[tb_ram_out_addr+800] = tb_data_out[1][0];
            tb_ram_out[tb_ram_out_addr+801] = tb_data_out[1][1];
            tb_ram_out[tb_ram_out_addr+802] = tb_data_out[1][2];
            tb_ram_out[tb_ram_out_addr+803] = tb_data_out[1][3];
            tb_ram_out[tb_ram_out_addr+1600] = tb_data_out[2][0];
            tb_ram_out[tb_ram_out_addr+1601] = tb_data_out[2][1];
            tb_ram_out[tb_ram_out_addr+1602] = tb_data_out[2][2];
            tb_ram_out[tb_ram_out_addr+1603] = tb_data_out[2][3];
            tb_ram_out[tb_ram_out_addr+2400] = tb_data_out[3][0];
            tb_ram_out[tb_ram_out_addr+2401] = tb_data_out[3][1];
            tb_ram_out[tb_ram_out_addr+2402] = tb_data_out[3][2];
            tb_ram_out[tb_ram_out_addr+2403] = tb_data_out[3][3];
        end
	end
	
	
endmodule

	
