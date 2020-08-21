/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Jan 30 02:22:24 2018
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_rollover_flag, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71;

  DFFSR \curr_count_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \curr_count_reg[1]  ( .D(n69), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \curr_count_reg[2]  ( .D(n70), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \curr_count_reg[3]  ( .D(n71), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR curr_rollover_flag_reg ( .D(next_rollover_flag), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(rollover_flag) );
  NOR2X1 U37 ( .A(n37), .B(n38), .Y(next_rollover_flag) );
  NAND3X1 U38 ( .A(n39), .B(count_enable), .C(n40), .Y(n38) );
  XOR2X1 U39 ( .A(n41), .B(rollover_val[2]), .Y(n40) );
  NAND3X1 U40 ( .A(n42), .B(n43), .C(n44), .Y(n37) );
  OAI22X1 U41 ( .A(n45), .B(n46), .C(n47), .D(n48), .Y(n69) );
  INVX1 U42 ( .A(count_out[1]), .Y(n45) );
  OAI22X1 U43 ( .A(n49), .B(n46), .C(n41), .D(n48), .Y(n70) );
  OAI22X1 U44 ( .A(n50), .B(n46), .C(n51), .D(n48), .Y(n71) );
  NAND3X1 U45 ( .A(n46), .B(n43), .C(n52), .Y(n48) );
  MUX2X1 U46 ( .B(n53), .A(n54), .S(n46), .Y(n36) );
  OR2X1 U47 ( .A(clear), .B(count_enable), .Y(n46) );
  OAI21X1 U48 ( .A(n55), .B(n53), .C(n43), .Y(n54) );
  INVX1 U49 ( .A(clear), .Y(n43) );
  INVX1 U50 ( .A(n52), .Y(n55) );
  NAND3X1 U51 ( .A(n56), .B(n57), .C(n58), .Y(n52) );
  NOR2X1 U52 ( .A(n42), .B(n59), .Y(n58) );
  XOR2X1 U53 ( .A(n60), .B(n39), .Y(n59) );
  XOR2X1 U54 ( .A(rollover_val[1]), .B(n47), .Y(n39) );
  XOR2X1 U55 ( .A(count_out[1]), .B(n53), .Y(n47) );
  XOR2X1 U56 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n42) );
  XOR2X1 U57 ( .A(n41), .B(n61), .Y(n57) );
  XNOR2X1 U58 ( .A(rollover_val[2]), .B(n62), .Y(n61) );
  NAND2X1 U59 ( .A(rollover_val[0]), .B(rollover_val[1]), .Y(n62) );
  XOR2X1 U60 ( .A(n63), .B(count_out[2]), .Y(n41) );
  MUX2X1 U61 ( .B(n64), .A(n65), .S(n66), .Y(n56) );
  NOR2X1 U62 ( .A(n60), .B(n67), .Y(n66) );
  NAND2X1 U63 ( .A(rollover_val[2]), .B(rollover_val[1]), .Y(n67) );
  INVX1 U64 ( .A(rollover_val[0]), .Y(n60) );
  OR2X1 U65 ( .A(n44), .B(rollover_val[3]), .Y(n65) );
  INVX1 U66 ( .A(n44), .Y(n64) );
  XOR2X1 U67 ( .A(n51), .B(rollover_val[3]), .Y(n44) );
  XOR2X1 U68 ( .A(n50), .B(n68), .Y(n51) );
  NOR2X1 U69 ( .A(n49), .B(n63), .Y(n68) );
  NAND2X1 U70 ( .A(count_out[0]), .B(count_out[1]), .Y(n63) );
  INVX1 U71 ( .A(count_out[2]), .Y(n49) );
  INVX1 U72 ( .A(count_out[3]), .Y(n50) );
  INVX1 U73 ( .A(count_out[0]), .Y(n53) );
endmodule

