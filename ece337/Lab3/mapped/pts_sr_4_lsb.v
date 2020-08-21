/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Jan 29 16:54:35 2018
/////////////////////////////////////////////////////////////


module flex_pts_sr_NUM_BITS4_SHIFT_MSB0 ( clk, n_rst, parallel_in, 
        shift_enable, load_enable, serial_out );
  input [3:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n10, n17, n18, n19, n20, n5, n6, n7, n8, n9, n11, n12, n13, n14, n15;
  wire   [3:0] curr_par;

  DFFSR \curr_par_reg[3]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[3]) );
  DFFSR \curr_par_reg[2]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[2]) );
  DFFSR \curr_par_reg[1]  ( .D(n20), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[1]) );
  DFFSR \curr_par_reg[0]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[0]) );
  LATCH serial_out_reg ( .CLK(n10), .D(curr_par[0]), .Q(serial_out) );
  OAI21X1 U7 ( .A(n10), .B(n5), .C(n6), .Y(n20) );
  AOI22X1 U8 ( .A(curr_par[2]), .B(n7), .C(curr_par[1]), .D(n8), .Y(n6) );
  INVX1 U9 ( .A(parallel_in[1]), .Y(n5) );
  OAI21X1 U10 ( .A(n10), .B(n9), .C(n11), .Y(n19) );
  AOI22X1 U11 ( .A(curr_par[3]), .B(n7), .C(n8), .D(curr_par[2]), .Y(n11) );
  INVX1 U12 ( .A(parallel_in[2]), .Y(n9) );
  NAND2X1 U13 ( .A(n12), .B(n13), .Y(n18) );
  INVX1 U14 ( .A(n7), .Y(n13) );
  MUX2X1 U15 ( .B(parallel_in[3]), .A(curr_par[3]), .S(n8), .Y(n12) );
  OAI21X1 U16 ( .A(n10), .B(n14), .C(n15), .Y(n17) );
  AOI22X1 U17 ( .A(curr_par[1]), .B(n7), .C(curr_par[0]), .D(n8), .Y(n15) );
  NOR2X1 U18 ( .A(n8), .B(load_enable), .Y(n7) );
  NOR2X1 U19 ( .A(shift_enable), .B(load_enable), .Y(n8) );
  INVX1 U20 ( .A(parallel_in[0]), .Y(n14) );
  INVX1 U21 ( .A(load_enable), .Y(n10) );
endmodule


module pts_sr_4_lsb ( clk, n_rst, shift_enable, load_enable, parallel_in, 
        serial_out );
  input [3:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;


  flex_pts_sr_NUM_BITS4_SHIFT_MSB0 CORE ( .clk(clk), .n_rst(n_rst), 
        .parallel_in(parallel_in), .shift_enable(shift_enable), .load_enable(
        load_enable), .serial_out(serial_out) );
endmodule

