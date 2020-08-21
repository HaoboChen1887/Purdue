// $Id: $
// File name:   rcu.sv
// Created:     2/22/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: rcu

module rcu(
    input wire clk,
    input wire n_rst,
    input wire d_edge,
    input wire [7:0] rcv_data,
    input wire eop,
    input wire shift_enable,
    input wire byte_received,
    output reg rcving,
    output reg w_enable,
    output reg r_error
);

    typedef enum bit[3:0]{IDLE, COMP_SYNC, WAIT_SYNC, READ, STORE, ERROR, EWAIT, READ_WAIT, DONE, EIDLE} stateType;
    stateType curr_state,next_state;

    always @ (posedge clk,negedge n_rst)begin   
        if(n_rst == 1'b0)
            curr_state <= IDLE;
        else
            curr_state <= next_state;
    end

    always_comb begin
        next_state=curr_state;
        r_error=0;
        rcving=0;
        w_enable=0;
        case(curr_state)
            IDLE:begin
            if(d_edge==1'b1)
                next_state=WAIT_SYNC;
            else
                next_state=IDLE;
            end
            COMP_SYNC:begin
                rcving=1'b1;
                if(rcv_data==8'b10000000)
                    next_state=READ;
                else
                    next_state=ERROR;
            end 
            WAIT_SYNC:begin
                rcving=1'b1;
                w_enable=0;
                r_error=0;
                if(byte_received==1'b1)
                    next_state=COMP_SYNC;
                else
                    next_state=WAIT_SYNC;
            end
            STORE:begin
                rcving=1'b1;
                w_enable=1'b1;
                next_state=READ_WAIT;
            end
            READ:begin
                rcving=1'b1;
                if(byte_received==1'b1)
                    next_state=STORE;
                else if(eop==1&&shift_enable==1)
                    next_state=EWAIT;
            end 
            ERROR:begin
                rcving=1'b1;
                r_error=1'b1;
                if(shift_enable==1&&eop==1)
                    next_state=EWAIT;
            end
            EWAIT:begin
                rcving=1'b1;
                r_error=1'b1;
                if(d_edge==1'b1)
                    next_state=EIDLE;
            end
            READ_WAIT:begin
                rcving=1'b1;
                if(shift_enable==1&&eop==1)
                    next_state=DONE;
                else if(shift_enable==1&&eop==0)
                    next_state=READ;
            end
            DONE:begin
                rcving=1'b1;
                if(d_edge==1'b1)
                    next_state=IDLE;
                end
            EIDLE:begin
                r_error=1'b1;
                rcving=0;
                w_enable=0;
                if(d_edge==1'b1)
                    next_state=WAIT_SYNC;
            end
        endcase
    end 
endmodule
