/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Jan 29 16:57:46 2018
/////////////////////////////////////////////////////////////


module flex_pts_sr ( clk, n_rst, parallel_in, shift_enable, load_enable, 
        serial_out );
  input [3:0] parallel_in;
  input clk, n_rst, shift_enable, load_enable;
  output serial_out;
  wire   n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30;
  wire   [2:0] curr_par;

  DFFSR \curr_par_reg[0]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[0]) );
  DFFSR \curr_par_reg[1]  ( .D(n18), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[1]) );
  DFFSR \curr_par_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        curr_par[2]) );
  DFFSR \curr_par_reg[3]  ( .D(n16), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        serial_out) );
  NAND2X1 U22 ( .A(n20), .B(n21), .Y(n19) );
  INVX1 U23 ( .A(n22), .Y(n21) );
  MUX2X1 U24 ( .B(parallel_in[0]), .A(curr_par[0]), .S(n23), .Y(n20) );
  OAI21X1 U25 ( .A(n24), .B(n25), .C(n26), .Y(n18) );
  AOI22X1 U26 ( .A(n22), .B(curr_par[0]), .C(curr_par[1]), .D(n23), .Y(n26) );
  INVX1 U27 ( .A(parallel_in[1]), .Y(n25) );
  OAI21X1 U28 ( .A(n24), .B(n27), .C(n28), .Y(n17) );
  AOI22X1 U29 ( .A(curr_par[1]), .B(n22), .C(curr_par[2]), .D(n23), .Y(n28) );
  INVX1 U30 ( .A(parallel_in[2]), .Y(n27) );
  OAI21X1 U31 ( .A(n24), .B(n29), .C(n30), .Y(n16) );
  AOI22X1 U32 ( .A(curr_par[2]), .B(n22), .C(serial_out), .D(n23), .Y(n30) );
  NOR2X1 U33 ( .A(n23), .B(load_enable), .Y(n22) );
  NOR2X1 U34 ( .A(shift_enable), .B(load_enable), .Y(n23) );
  INVX1 U35 ( .A(parallel_in[3]), .Y(n29) );
  INVX1 U36 ( .A(load_enable), .Y(n24) );
endmodule

