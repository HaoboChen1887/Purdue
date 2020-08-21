/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Jan 29 16:54:25 2018
/////////////////////////////////////////////////////////////


module flex_pts_sr_NUM_BITS8_SHIFT_MSB1 ( clk, n_rst, parallel_in, 
        shift_enable, load_enable, serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n18, n29, n30, n31, n32, n33, n34, n35, n36, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n19, n20, n21, n22, n23, n24, n25, n26, n27;
  wire   [7:0] curr_par;

  DFFSR \curr_par_reg[0]  ( .D(n36), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[0]) );
  DFFSR \curr_par_reg[1]  ( .D(n35), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[1]) );
  DFFSR \curr_par_reg[2]  ( .D(n34), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[2]) );
  DFFSR \curr_par_reg[3]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[3]) );
  DFFSR \curr_par_reg[4]  ( .D(n32), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[4]) );
  DFFSR \curr_par_reg[5]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[5]) );
  DFFSR \curr_par_reg[6]  ( .D(n30), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[6]) );
  DFFSR \curr_par_reg[7]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[7]) );
  LATCH serial_out_reg ( .CLK(n18), .D(curr_par[7]), .Q(serial_out) );
  NAND2X1 U11 ( .A(n9), .B(n10), .Y(n36) );
  INVX1 U12 ( .A(n11), .Y(n10) );
  MUX2X1 U13 ( .B(parallel_in[0]), .A(curr_par[0]), .S(n12), .Y(n9) );
  OAI21X1 U14 ( .A(n18), .B(n13), .C(n14), .Y(n35) );
  AOI22X1 U15 ( .A(n11), .B(curr_par[0]), .C(curr_par[1]), .D(n12), .Y(n14) );
  INVX1 U16 ( .A(parallel_in[1]), .Y(n13) );
  OAI21X1 U17 ( .A(n18), .B(n15), .C(n16), .Y(n34) );
  AOI22X1 U18 ( .A(curr_par[1]), .B(n11), .C(curr_par[2]), .D(n12), .Y(n16) );
  INVX1 U19 ( .A(parallel_in[2]), .Y(n15) );
  OAI21X1 U20 ( .A(n18), .B(n17), .C(n19), .Y(n33) );
  AOI22X1 U21 ( .A(curr_par[2]), .B(n11), .C(curr_par[3]), .D(n12), .Y(n19) );
  INVX1 U22 ( .A(parallel_in[3]), .Y(n17) );
  OAI21X1 U23 ( .A(n18), .B(n20), .C(n21), .Y(n32) );
  AOI22X1 U24 ( .A(curr_par[3]), .B(n11), .C(curr_par[4]), .D(n12), .Y(n21) );
  INVX1 U25 ( .A(parallel_in[4]), .Y(n20) );
  OAI21X1 U26 ( .A(n18), .B(n22), .C(n23), .Y(n31) );
  AOI22X1 U27 ( .A(curr_par[4]), .B(n11), .C(curr_par[5]), .D(n12), .Y(n23) );
  INVX1 U28 ( .A(parallel_in[5]), .Y(n22) );
  OAI21X1 U29 ( .A(n18), .B(n24), .C(n25), .Y(n30) );
  AOI22X1 U30 ( .A(curr_par[5]), .B(n11), .C(curr_par[6]), .D(n12), .Y(n25) );
  INVX1 U31 ( .A(parallel_in[6]), .Y(n24) );
  OAI21X1 U32 ( .A(n18), .B(n26), .C(n27), .Y(n29) );
  AOI22X1 U33 ( .A(curr_par[6]), .B(n11), .C(curr_par[7]), .D(n12), .Y(n27) );
  NOR2X1 U34 ( .A(n12), .B(load_enable), .Y(n11) );
  NOR2X1 U35 ( .A(shift_enable), .B(load_enable), .Y(n12) );
  INVX1 U36 ( .A(parallel_in[7]), .Y(n26) );
  INVX1 U37 ( .A(load_enable), .Y(n18) );
endmodule


module pts_sr_8_msb ( clk, n_rst, shift_enable, load_enable, parallel_in, 
        serial_out );
  input [7:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;


  flex_pts_sr_NUM_BITS8_SHIFT_MSB1 CORE ( .clk(clk), .n_rst(n_rst), 
        .parallel_in(parallel_in), .shift_enable(shift_enable), .load_enable(
        load_enable), .serial_out(serial_out) );
endmodule

