/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Feb 14 22:22:59 2018
/////////////////////////////////////////////////////////////


module sync_low_1 ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp_out;

  DFFSR temp_out_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        temp_out) );
  DFFSR sync_out_reg ( .D(temp_out), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sync_out) );
endmodule


module sync_low_0 ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   temp_out;

  DFFSR temp_out_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        temp_out) );
  DFFSR sync_out_reg ( .D(temp_out), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        sync_out) );
endmodule


module controller ( clk, n_reset, dr, lc, overflow, cnt_up, clear, modwait, op, 
        src1, src2, dest, err );
  output [2:0] op;
  output [3:0] src1;
  output [3:0] src2;
  output [3:0] dest;
  input clk, n_reset, dr, lc, overflow;
  output cnt_up, clear, modwait, err;
  wire   n149, next_modwait, n43, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n44, n45,
         n46, n47, n48, n49, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144;
  wire   [4:0] state;
  wire   [4:0] next_state;
  assign src1[3] = 1'b0;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[4]  ( .D(next_state[4]), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(state[4]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(state[3]) );
  DFFSR curr_modwait_reg ( .D(next_modwait), .CLK(clk), .R(n_reset), .S(1'b1), 
        .Q(modwait) );
  OR2X1 U48 ( .A(n43), .B(dest[3]), .Y(op[1]) );
  INVX4 U9 ( .A(n95), .Y(n30) );
  INVX2 U10 ( .A(n51), .Y(n29) );
  BUFX2 U11 ( .A(state[0]), .Y(n53) );
  INVX4 U12 ( .A(n53), .Y(n95) );
  BUFX2 U13 ( .A(n41), .Y(n7) );
  INVX1 U14 ( .A(n89), .Y(n8) );
  BUFX2 U15 ( .A(n134), .Y(n38) );
  NAND2X1 U16 ( .A(n95), .B(n51), .Y(n9) );
  NAND2X1 U17 ( .A(n37), .B(n10), .Y(n127) );
  INVX2 U18 ( .A(n9), .Y(n10) );
  INVX1 U19 ( .A(overflow), .Y(n11) );
  INVX2 U20 ( .A(overflow), .Y(n112) );
  NAND2X1 U21 ( .A(n114), .B(n103), .Y(n12) );
  NAND2X1 U22 ( .A(n102), .B(n13), .Y(n104) );
  INVX2 U23 ( .A(n12), .Y(n13) );
  AND2X2 U24 ( .A(n52), .B(n19), .Y(n27) );
  INVX2 U25 ( .A(n51), .Y(n80) );
  INVX2 U26 ( .A(n127), .Y(n130) );
  INVX1 U27 ( .A(n34), .Y(n14) );
  INVX1 U28 ( .A(n29), .Y(n15) );
  INVX2 U29 ( .A(n15), .Y(n16) );
  NOR2X1 U30 ( .A(n29), .B(n17), .Y(n21) );
  NAND2X1 U31 ( .A(n141), .B(n53), .Y(n17) );
  INVX1 U32 ( .A(n19), .Y(n18) );
  INVX1 U33 ( .A(state[4]), .Y(n19) );
  INVX1 U34 ( .A(state[4]), .Y(n60) );
  NAND2X1 U35 ( .A(n48), .B(n36), .Y(n20) );
  INVX1 U36 ( .A(n21), .Y(n78) );
  NAND2X1 U37 ( .A(n41), .B(n126), .Y(src2[2]) );
  BUFX2 U38 ( .A(n52), .Y(n23) );
  BUFX2 U39 ( .A(state[1]), .Y(n52) );
  NAND2X1 U40 ( .A(n34), .B(n44), .Y(n24) );
  NAND2X1 U41 ( .A(n48), .B(n36), .Y(n25) );
  INVX2 U42 ( .A(n25), .Y(n37) );
  AND2X2 U43 ( .A(n60), .B(state[3]), .Y(n36) );
  INVX1 U44 ( .A(n130), .Y(n26) );
  OR2X1 U45 ( .A(n16), .B(n95), .Y(n28) );
  INVX2 U46 ( .A(n28), .Y(n39) );
  AND2X2 U47 ( .A(n41), .B(n126), .Y(n31) );
  BUFX2 U49 ( .A(n63), .Y(n32) );
  AND2X2 U50 ( .A(n58), .B(n95), .Y(n33) );
  INVX2 U51 ( .A(n33), .Y(n132) );
  INVX1 U52 ( .A(n129), .Y(n136) );
  INVX1 U53 ( .A(n91), .Y(n119) );
  INVX4 U54 ( .A(n149), .Y(n49) );
  INVX2 U55 ( .A(n141), .Y(n34) );
  INVX1 U56 ( .A(n58), .Y(n35) );
  AND2X1 U57 ( .A(n126), .B(n59), .Y(n40) );
  AND2X1 U58 ( .A(n99), .B(n143), .Y(n42) );
  AND2X1 U59 ( .A(n18), .B(n46), .Y(n47) );
  AND2X2 U60 ( .A(n70), .B(n133), .Y(n41) );
  AND2X2 U61 ( .A(n52), .B(n60), .Y(n44) );
  AND2X2 U62 ( .A(n48), .B(n19), .Y(n45) );
  AND2X2 U63 ( .A(n80), .B(n14), .Y(n46) );
  INVX1 U64 ( .A(n70), .Y(n71) );
  BUFX4 U65 ( .A(n62), .Y(n48) );
  INVX1 U66 ( .A(state[1]), .Y(n62) );
  INVX8 U67 ( .A(n49), .Y(src1[2]) );
  BUFX4 U68 ( .A(state[2]), .Y(n51) );
  INVX1 U69 ( .A(src1[2]), .Y(n74) );
  INVX1 U70 ( .A(src1[0]), .Y(n103) );
  NAND2X1 U71 ( .A(n34), .B(n44), .Y(n98) );
  INVX2 U72 ( .A(n98), .Y(n58) );
  NAND2X1 U73 ( .A(n132), .B(n26), .Y(src2[3]) );
  INVX2 U74 ( .A(state[3]), .Y(n141) );
  NAND3X1 U75 ( .A(n51), .B(n141), .C(n95), .Y(n54) );
  INVX2 U76 ( .A(n54), .Y(n63) );
  NAND2X1 U77 ( .A(n63), .B(n27), .Y(n99) );
  NAND3X1 U78 ( .A(n47), .B(n95), .C(n48), .Y(n143) );
  NAND2X1 U79 ( .A(n45), .B(n63), .Y(n73) );
  NAND3X1 U80 ( .A(n32), .B(n18), .C(n48), .Y(n124) );
  INVX2 U81 ( .A(n124), .Y(n55) );
  NAND3X1 U82 ( .A(n46), .B(n27), .C(n95), .Y(n121) );
  INVX2 U83 ( .A(n121), .Y(n139) );
  NOR2X1 U84 ( .A(n55), .B(n139), .Y(n56) );
  NAND3X1 U85 ( .A(n42), .B(n73), .C(n56), .Y(dest[0]) );
  OAI21X1 U86 ( .A(n80), .B(n24), .C(n20), .Y(n57) );
  NAND2X1 U87 ( .A(n57), .B(n30), .Y(n70) );
  NAND2X1 U88 ( .A(n58), .B(n30), .Y(n133) );
  NAND3X1 U89 ( .A(n37), .B(n95), .C(n16), .Y(n126) );
  INVX2 U90 ( .A(src2[3]), .Y(n59) );
  NAND3X1 U91 ( .A(n30), .B(n27), .C(n46), .Y(n144) );
  NAND3X1 U92 ( .A(n59), .B(n31), .C(n144), .Y(op[2]) );
  NAND2X1 U93 ( .A(n21), .B(n27), .Y(n134) );
  NOR2X1 U94 ( .A(n34), .B(n19), .Y(n61) );
  NAND3X1 U95 ( .A(n30), .B(n48), .C(n61), .Y(n107) );
  NAND3X1 U96 ( .A(n18), .B(n23), .C(n32), .Y(n123) );
  NAND2X1 U97 ( .A(n21), .B(n45), .Y(n91) );
  INVX2 U98 ( .A(n134), .Y(n89) );
  NOR2X1 U99 ( .A(n119), .B(n89), .Y(n64) );
  NAND3X1 U100 ( .A(n107), .B(n123), .C(n64), .Y(n69) );
  INVX2 U101 ( .A(dest[0]), .Y(n113) );
  INVX2 U102 ( .A(op[2]), .Y(n67) );
  NAND2X1 U103 ( .A(n45), .B(n46), .Y(n92) );
  INVX2 U104 ( .A(n92), .Y(n106) );
  NAND3X1 U105 ( .A(n30), .B(n23), .C(n47), .Y(n96) );
  INVX2 U106 ( .A(n96), .Y(n65) );
  NOR2X1 U107 ( .A(n106), .B(n65), .Y(n66) );
  NAND3X1 U108 ( .A(n113), .B(n67), .C(n66), .Y(n68) );
  OR2X1 U109 ( .A(n69), .B(n68), .Y(n79) );
  INVX2 U110 ( .A(n79), .Y(n108) );
  AOI22X1 U111 ( .A(n108), .B(n34), .C(n71), .D(n11), .Y(n72) );
  NAND3X1 U112 ( .A(n40), .B(n38), .C(n72), .Y(next_state[3]) );
  NAND2X1 U113 ( .A(n33), .B(n51), .Y(n128) );
  NAND3X1 U114 ( .A(n128), .B(n99), .C(n8), .Y(n149) );
  NAND2X1 U115 ( .A(n26), .B(n144), .Y(n76) );
  NAND2X1 U116 ( .A(n91), .B(n73), .Y(n129) );
  NAND3X1 U117 ( .A(n136), .B(n74), .C(n124), .Y(n75) );
  NOR2X1 U118 ( .A(n76), .B(n75), .Y(n84) );
  INVX2 U119 ( .A(lc), .Y(n109) );
  NAND3X1 U120 ( .A(n37), .B(n39), .C(n112), .Y(n77) );
  OAI21X1 U121 ( .A(n96), .B(n109), .C(n77), .Y(n82) );
  OAI21X1 U122 ( .A(n80), .B(n79), .C(n78), .Y(n81) );
  NOR2X1 U123 ( .A(n82), .B(n81), .Y(n83) );
  NAND2X1 U124 ( .A(n84), .B(n83), .Y(next_state[2]) );
  INVX2 U125 ( .A(n107), .Y(n85) );
  NOR2X1 U126 ( .A(n85), .B(n108), .Y(n86) );
  OAI21X1 U127 ( .A(n109), .B(n92), .C(n86), .Y(n88) );
  NAND3X1 U128 ( .A(n124), .B(n143), .C(n96), .Y(n87) );
  OR2X1 U129 ( .A(n88), .B(n87), .Y(next_state[4]) );
  NOR2X1 U130 ( .A(n89), .B(n130), .Y(n90) );
  NAND3X1 U131 ( .A(n126), .B(n91), .C(n90), .Y(src1[0]) );
  OAI21X1 U132 ( .A(lc), .B(n92), .C(n121), .Y(n93) );
  AOI22X1 U133 ( .A(dr), .B(n93), .C(n108), .D(n23), .Y(n94) );
  OAI21X1 U134 ( .A(n107), .B(n109), .C(n94), .Y(n105) );
  NAND3X1 U135 ( .A(n47), .B(n23), .C(n95), .Y(n125) );
  OAI21X1 U136 ( .A(lc), .B(n96), .C(n125), .Y(n97) );
  INVX2 U137 ( .A(n97), .Y(n114) );
  NOR2X1 U138 ( .A(n28), .B(n35), .Y(n101) );
  INVX2 U139 ( .A(n99), .Y(n100) );
  AOI21X1 U140 ( .A(n101), .B(n112), .C(n100), .Y(n102) );
  OR2X1 U141 ( .A(n105), .B(n104), .Y(next_state[1]) );
  NAND2X1 U142 ( .A(n106), .B(n30), .Y(n117) );
  OAI21X1 U143 ( .A(dr), .B(n117), .C(n107), .Y(n110) );
  AOI22X1 U144 ( .A(n110), .B(n109), .C(n108), .D(n30), .Y(n111) );
  OAI21X1 U145 ( .A(n7), .B(n11), .C(n111), .Y(n116) );
  NAND3X1 U146 ( .A(n114), .B(n113), .C(n40), .Y(n115) );
  OR2X1 U147 ( .A(n116), .B(n115), .Y(next_state[0]) );
  INVX2 U148 ( .A(n117), .Y(err) );
  INVX2 U149 ( .A(n123), .Y(n118) );
  NOR2X1 U150 ( .A(n119), .B(n118), .Y(n120) );
  NAND3X1 U151 ( .A(n40), .B(n42), .C(n120), .Y(dest[1]) );
  NAND3X1 U152 ( .A(n40), .B(n121), .C(n143), .Y(n43) );
  INVX2 U153 ( .A(n43), .Y(n122) );
  NAND2X1 U154 ( .A(n38), .B(n122), .Y(dest[2]) );
  NAND3X1 U155 ( .A(n125), .B(n124), .C(n123), .Y(dest[3]) );
  NAND2X1 U156 ( .A(n127), .B(n126), .Y(src2[0]) );
  NAND2X1 U157 ( .A(n128), .B(n31), .Y(src2[1]) );
  NOR2X1 U158 ( .A(n130), .B(n129), .Y(n131) );
  OAI21X1 U159 ( .A(n51), .B(n132), .C(n131), .Y(src1[1]) );
  NAND3X1 U160 ( .A(n38), .B(n144), .C(n133), .Y(n138) );
  INVX2 U161 ( .A(dest[3]), .Y(n135) );
  NAND3X1 U162 ( .A(n42), .B(n136), .C(n135), .Y(n137) );
  OR2X1 U163 ( .A(n138), .B(n137), .Y(op[0]) );
  INVX2 U164 ( .A(op[0]), .Y(n142) );
  AOI21X1 U165 ( .A(n39), .B(n23), .C(n139), .Y(n140) );
  NAND3X1 U166 ( .A(n142), .B(n14), .C(n140), .Y(next_modwait) );
  INVX2 U167 ( .A(n143), .Y(clear) );
  INVX2 U168 ( .A(n144), .Y(cnt_up) );
endmodule


module datapath_decode ( op, w_en, w_data_sel, alu_op );
  input [2:0] op;
  output [1:0] w_data_sel;
  output [1:0] alu_op;
  output w_en;
  wire   n4, n5, n1, n2, n3;

  NAND3X1 U6 ( .A(n2), .B(n3), .C(n1), .Y(w_en) );
  NOR2X1 U7 ( .A(n1), .B(w_data_sel[1]), .Y(w_data_sel[0]) );
  NAND2X1 U8 ( .A(op[1]), .B(n3), .Y(w_data_sel[1]) );
  OAI21X1 U9 ( .A(n3), .B(n4), .C(n5), .Y(alu_op[1]) );
  NAND3X1 U10 ( .A(op[0]), .B(n2), .C(op[2]), .Y(n5) );
  NAND2X1 U11 ( .A(op[1]), .B(n1), .Y(n4) );
  NOR2X1 U12 ( .A(op[0]), .B(n3), .Y(alu_op[0]) );
  INVX2 U3 ( .A(op[0]), .Y(n1) );
  INVX2 U4 ( .A(op[1]), .Y(n2) );
  INVX2 U5 ( .A(op[2]), .Y(n3) );
endmodule


module alu_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [17:0] A;
  input [17:0] B;
  output [17:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n22, n24, n25, n26, n27, n28, n30, n32, n33, n34,
         n35, n36, n38, n40, n41, n42, n43, n44, n46, n48, n49, n50, n51, n52,
         n54, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n75, n77, n79, n81, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n103, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171;

  FAX1 U2 ( .A(n103), .B(B[16]), .C(n16), .YC(n15), .YS(DIFF[16]) );
  FAX1 U3 ( .A(A[15]), .B(n87), .C(n17), .YC(n16), .YS(DIFF[15]) );
  XOR2X1 U4 ( .A(n162), .B(n1), .Y(DIFF[14]) );
  OAI21X1 U5 ( .A(n20), .B(n18), .C(n19), .Y(n17) );
  NAND2X1 U6 ( .A(n19), .B(n73), .Y(n1) );
  NOR2X1 U8 ( .A(A[14]), .B(n88), .Y(n18) );
  NAND2X1 U9 ( .A(A[14]), .B(n88), .Y(n19) );
  XNOR2X1 U10 ( .A(n163), .B(n2), .Y(DIFF[13]) );
  AOI21X1 U11 ( .A(n169), .B(n25), .C(n22), .Y(n20) );
  NAND2X1 U14 ( .A(n24), .B(n169), .Y(n2) );
  NAND2X1 U17 ( .A(A[13]), .B(n89), .Y(n24) );
  XOR2X1 U18 ( .A(n28), .B(n3), .Y(DIFF[12]) );
  OAI21X1 U19 ( .A(n28), .B(n26), .C(n27), .Y(n25) );
  NAND2X1 U20 ( .A(n27), .B(n75), .Y(n3) );
  NOR2X1 U22 ( .A(A[12]), .B(n90), .Y(n26) );
  NAND2X1 U23 ( .A(A[12]), .B(n90), .Y(n27) );
  XNOR2X1 U24 ( .A(n33), .B(n4), .Y(DIFF[11]) );
  AOI21X1 U25 ( .A(n170), .B(n33), .C(n30), .Y(n28) );
  NAND2X1 U28 ( .A(n32), .B(n170), .Y(n4) );
  NAND2X1 U31 ( .A(A[11]), .B(n91), .Y(n32) );
  XOR2X1 U32 ( .A(n36), .B(n5), .Y(DIFF[10]) );
  OAI21X1 U33 ( .A(n36), .B(n34), .C(n35), .Y(n33) );
  NAND2X1 U34 ( .A(n35), .B(n77), .Y(n5) );
  NOR2X1 U36 ( .A(A[10]), .B(n92), .Y(n34) );
  NAND2X1 U37 ( .A(A[10]), .B(n92), .Y(n35) );
  XNOR2X1 U38 ( .A(n41), .B(n6), .Y(DIFF[9]) );
  AOI21X1 U39 ( .A(n168), .B(n41), .C(n38), .Y(n36) );
  NAND2X1 U42 ( .A(n40), .B(n168), .Y(n6) );
  NAND2X1 U45 ( .A(A[9]), .B(n93), .Y(n40) );
  XOR2X1 U46 ( .A(n44), .B(n7), .Y(DIFF[8]) );
  OAI21X1 U47 ( .A(n44), .B(n42), .C(n43), .Y(n41) );
  NAND2X1 U48 ( .A(n43), .B(n79), .Y(n7) );
  NOR2X1 U50 ( .A(A[8]), .B(n94), .Y(n42) );
  NAND2X1 U51 ( .A(A[8]), .B(n94), .Y(n43) );
  XNOR2X1 U52 ( .A(n49), .B(n8), .Y(DIFF[7]) );
  AOI21X1 U53 ( .A(n166), .B(n49), .C(n46), .Y(n44) );
  NAND2X1 U56 ( .A(n48), .B(n166), .Y(n8) );
  NAND2X1 U59 ( .A(A[7]), .B(n95), .Y(n48) );
  XOR2X1 U60 ( .A(n52), .B(n9), .Y(DIFF[6]) );
  OAI21X1 U61 ( .A(n52), .B(n50), .C(n51), .Y(n49) );
  NAND2X1 U62 ( .A(n51), .B(n81), .Y(n9) );
  NOR2X1 U64 ( .A(A[6]), .B(n96), .Y(n50) );
  NAND2X1 U65 ( .A(A[6]), .B(n96), .Y(n51) );
  XNOR2X1 U66 ( .A(n164), .B(n10), .Y(DIFF[5]) );
  AOI21X1 U67 ( .A(n167), .B(n57), .C(n54), .Y(n52) );
  NAND2X1 U70 ( .A(n56), .B(n167), .Y(n10) );
  NAND2X1 U73 ( .A(A[5]), .B(n97), .Y(n56) );
  XOR2X1 U74 ( .A(n60), .B(n11), .Y(DIFF[4]) );
  OAI21X1 U75 ( .A(n60), .B(n58), .C(n59), .Y(n57) );
  NAND2X1 U76 ( .A(n59), .B(n83), .Y(n11) );
  NOR2X1 U78 ( .A(A[4]), .B(n98), .Y(n58) );
  NAND2X1 U79 ( .A(A[4]), .B(n98), .Y(n59) );
  XNOR2X1 U80 ( .A(n65), .B(n12), .Y(DIFF[3]) );
  AOI21X1 U81 ( .A(n69), .B(n61), .C(n62), .Y(n60) );
  NOR2X1 U82 ( .A(n63), .B(n66), .Y(n61) );
  OAI21X1 U83 ( .A(n63), .B(n67), .C(n64), .Y(n62) );
  NAND2X1 U84 ( .A(n64), .B(n84), .Y(n12) );
  NOR2X1 U86 ( .A(A[3]), .B(n99), .Y(n63) );
  NAND2X1 U87 ( .A(A[3]), .B(n99), .Y(n64) );
  XOR2X1 U88 ( .A(n68), .B(n13), .Y(DIFF[2]) );
  OAI21X1 U89 ( .A(n68), .B(n66), .C(n67), .Y(n65) );
  NAND2X1 U90 ( .A(n67), .B(n85), .Y(n13) );
  NOR2X1 U92 ( .A(A[2]), .B(n100), .Y(n66) );
  NAND2X1 U93 ( .A(A[2]), .B(n100), .Y(n67) );
  XOR2X1 U94 ( .A(n14), .B(n165), .Y(DIFF[1]) );
  OAI21X1 U96 ( .A(n70), .B(n72), .C(n71), .Y(n69) );
  NAND2X1 U97 ( .A(n71), .B(n86), .Y(n14) );
  NOR2X1 U99 ( .A(A[1]), .B(n101), .Y(n70) );
  NAND2X1 U100 ( .A(A[1]), .B(n101), .Y(n71) );
  XNOR2X1 U101 ( .A(n171), .B(A[0]), .Y(DIFF[0]) );
  NOR2X1 U102 ( .A(A[0]), .B(n171), .Y(n72) );
  INVX1 U123 ( .A(B[3]), .Y(n99) );
  INVX1 U124 ( .A(B[7]), .Y(n95) );
  INVX1 U125 ( .A(B[4]), .Y(n98) );
  INVX1 U126 ( .A(B[11]), .Y(n91) );
  INVX1 U127 ( .A(B[12]), .Y(n90) );
  INVX1 U128 ( .A(B[0]), .Y(n171) );
  INVX1 U129 ( .A(B[2]), .Y(n100) );
  BUFX2 U130 ( .A(n20), .Y(n162) );
  BUFX2 U131 ( .A(n25), .Y(n163) );
  BUFX2 U132 ( .A(n57), .Y(n164) );
  INVX1 U133 ( .A(n63), .Y(n84) );
  INVX1 U134 ( .A(B[15]), .Y(n87) );
  INVX1 U135 ( .A(B[6]), .Y(n96) );
  INVX1 U136 ( .A(B[9]), .Y(n93) );
  INVX1 U137 ( .A(B[8]), .Y(n94) );
  NOR2X1 U138 ( .A(A[0]), .B(n171), .Y(n165) );
  OR2X2 U139 ( .A(A[5]), .B(n97), .Y(n167) );
  OR2X2 U140 ( .A(A[7]), .B(n95), .Y(n166) );
  OR2X2 U141 ( .A(A[9]), .B(n93), .Y(n168) );
  OR2X2 U142 ( .A(A[11]), .B(n91), .Y(n170) );
  OR2X2 U143 ( .A(A[13]), .B(n89), .Y(n169) );
  INVX1 U144 ( .A(B[1]), .Y(n101) );
  INVX2 U145 ( .A(B[5]), .Y(n97) );
  INVX2 U146 ( .A(B[10]), .Y(n92) );
  INVX2 U147 ( .A(B[13]), .Y(n89) );
  INVX2 U148 ( .A(B[14]), .Y(n88) );
  INVX2 U149 ( .A(n70), .Y(n86) );
  INVX2 U150 ( .A(n66), .Y(n85) );
  INVX2 U151 ( .A(n58), .Y(n83) );
  INVX2 U152 ( .A(n50), .Y(n81) );
  INVX2 U153 ( .A(n42), .Y(n79) );
  INVX2 U154 ( .A(n34), .Y(n77) );
  INVX2 U155 ( .A(n26), .Y(n75) );
  INVX2 U156 ( .A(n18), .Y(n73) );
  INVX2 U157 ( .A(n69), .Y(n68) );
  INVX2 U158 ( .A(n56), .Y(n54) );
  INVX2 U159 ( .A(n48), .Y(n46) );
  INVX2 U160 ( .A(n40), .Y(n38) );
  INVX2 U161 ( .A(n32), .Y(n30) );
  INVX2 U162 ( .A(n24), .Y(n22) );
  INVX2 U163 ( .A(A[17]), .Y(n103) );
  INVX2 U164 ( .A(n15), .Y(DIFF[17]) );
endmodule


module alu_DW01_add_1 ( A, B, CI, SUM, CO );
  input [17:0] A;
  input [17:0] B;
  output [17:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n16, n17,
         n18, n20, n22, n23, n24, n25, n26, n28, n30, n31, n32, n33, n34, n36,
         n38, n39, n40, n41, n42, n44, n46, n47, n48, n49, n50, n52, n54, n55,
         n56, n57, n58, n60, n62, n63, n64, n65, n66, n68, n70, n71, n72, n73,
         n75, n76, n78, n80, n82, n84, n86, n88, n90, n92, n93, n152, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169;

  XNOR2X1 U5 ( .A(n23), .B(n1), .Y(SUM[14]) );
  AOI21X1 U6 ( .A(n168), .B(n23), .C(n20), .Y(n18) );
  NAND2X1 U9 ( .A(n22), .B(n168), .Y(n1) );
  NAND2X1 U12 ( .A(A[14]), .B(B[14]), .Y(n22) );
  XOR2X1 U13 ( .A(n26), .B(n2), .Y(SUM[13]) );
  OAI21X1 U14 ( .A(n26), .B(n24), .C(n25), .Y(n23) );
  NAND2X1 U15 ( .A(n25), .B(n78), .Y(n2) );
  NOR2X1 U17 ( .A(A[13]), .B(B[13]), .Y(n24) );
  NAND2X1 U18 ( .A(A[13]), .B(B[13]), .Y(n25) );
  XNOR2X1 U19 ( .A(n31), .B(n3), .Y(SUM[12]) );
  AOI21X1 U20 ( .A(n167), .B(n31), .C(n28), .Y(n26) );
  NAND2X1 U23 ( .A(n30), .B(n167), .Y(n3) );
  NAND2X1 U26 ( .A(A[12]), .B(B[12]), .Y(n30) );
  XOR2X1 U27 ( .A(n34), .B(n4), .Y(SUM[11]) );
  OAI21X1 U28 ( .A(n34), .B(n32), .C(n33), .Y(n31) );
  NAND2X1 U29 ( .A(n33), .B(n80), .Y(n4) );
  NOR2X1 U31 ( .A(A[11]), .B(B[11]), .Y(n32) );
  NAND2X1 U32 ( .A(A[11]), .B(B[11]), .Y(n33) );
  XNOR2X1 U33 ( .A(n152), .B(n5), .Y(SUM[10]) );
  AOI21X1 U34 ( .A(n166), .B(n39), .C(n36), .Y(n34) );
  NAND2X1 U37 ( .A(n38), .B(n166), .Y(n5) );
  NAND2X1 U40 ( .A(A[10]), .B(B[10]), .Y(n38) );
  XOR2X1 U41 ( .A(n42), .B(n6), .Y(SUM[9]) );
  OAI21X1 U42 ( .A(n42), .B(n40), .C(n41), .Y(n39) );
  NAND2X1 U43 ( .A(n41), .B(n82), .Y(n6) );
  NOR2X1 U45 ( .A(A[9]), .B(B[9]), .Y(n40) );
  NAND2X1 U46 ( .A(A[9]), .B(B[9]), .Y(n41) );
  XNOR2X1 U47 ( .A(n47), .B(n7), .Y(SUM[8]) );
  AOI21X1 U48 ( .A(n165), .B(n47), .C(n44), .Y(n42) );
  NAND2X1 U51 ( .A(n46), .B(n165), .Y(n7) );
  NAND2X1 U54 ( .A(A[8]), .B(B[8]), .Y(n46) );
  XOR2X1 U55 ( .A(n50), .B(n8), .Y(SUM[7]) );
  OAI21X1 U56 ( .A(n50), .B(n48), .C(n49), .Y(n47) );
  NAND2X1 U57 ( .A(n49), .B(n84), .Y(n8) );
  NOR2X1 U59 ( .A(A[7]), .B(B[7]), .Y(n48) );
  NAND2X1 U60 ( .A(A[7]), .B(B[7]), .Y(n49) );
  XNOR2X1 U61 ( .A(n55), .B(n9), .Y(SUM[6]) );
  AOI21X1 U62 ( .A(n163), .B(n55), .C(n52), .Y(n50) );
  NAND2X1 U65 ( .A(n54), .B(n163), .Y(n9) );
  NAND2X1 U68 ( .A(A[6]), .B(B[6]), .Y(n54) );
  XOR2X1 U69 ( .A(n58), .B(n10), .Y(SUM[5]) );
  OAI21X1 U70 ( .A(n58), .B(n56), .C(n57), .Y(n55) );
  NAND2X1 U71 ( .A(n57), .B(n86), .Y(n10) );
  NOR2X1 U73 ( .A(A[5]), .B(B[5]), .Y(n56) );
  NAND2X1 U74 ( .A(A[5]), .B(B[5]), .Y(n57) );
  XNOR2X1 U75 ( .A(n63), .B(n11), .Y(SUM[4]) );
  AOI21X1 U76 ( .A(n164), .B(n63), .C(n60), .Y(n58) );
  NAND2X1 U79 ( .A(n62), .B(n164), .Y(n11) );
  NAND2X1 U82 ( .A(A[4]), .B(B[4]), .Y(n62) );
  XOR2X1 U83 ( .A(n66), .B(n12), .Y(SUM[3]) );
  OAI21X1 U84 ( .A(n66), .B(n64), .C(n65), .Y(n63) );
  NAND2X1 U85 ( .A(n65), .B(n88), .Y(n12) );
  NOR2X1 U87 ( .A(A[3]), .B(B[3]), .Y(n64) );
  NAND2X1 U88 ( .A(A[3]), .B(B[3]), .Y(n65) );
  XNOR2X1 U89 ( .A(n71), .B(n13), .Y(SUM[2]) );
  AOI21X1 U90 ( .A(n162), .B(n71), .C(n68), .Y(n66) );
  NAND2X1 U93 ( .A(n70), .B(n162), .Y(n13) );
  NAND2X1 U96 ( .A(A[2]), .B(B[2]), .Y(n70) );
  XOR2X1 U97 ( .A(n14), .B(n75), .Y(SUM[1]) );
  OAI21X1 U98 ( .A(n72), .B(n75), .C(n73), .Y(n71) );
  NAND2X1 U99 ( .A(n73), .B(n90), .Y(n14) );
  NOR2X1 U101 ( .A(A[1]), .B(B[1]), .Y(n72) );
  NAND2X1 U102 ( .A(A[1]), .B(B[1]), .Y(n73) );
  NAND2X1 U107 ( .A(A[0]), .B(B[0]), .Y(n75) );
  BUFX2 U113 ( .A(n39), .Y(n152) );
  OR2X1 U114 ( .A(A[0]), .B(B[0]), .Y(n169) );
  INVX1 U115 ( .A(n72), .Y(n90) );
  AND2X1 U116 ( .A(n75), .B(n169), .Y(SUM[0]) );
  XOR2X1 U117 ( .A(A[15]), .B(B[15]), .Y(n154) );
  XOR2X1 U118 ( .A(n154), .B(n76), .Y(SUM[15]) );
  NAND2X1 U119 ( .A(A[15]), .B(B[15]), .Y(n155) );
  NAND2X1 U120 ( .A(A[15]), .B(n76), .Y(n156) );
  NAND2X1 U121 ( .A(B[15]), .B(n76), .Y(n157) );
  NAND3X1 U122 ( .A(n155), .B(n156), .C(n157), .Y(n17) );
  XOR2X1 U123 ( .A(n93), .B(n92), .Y(n158) );
  XOR2X1 U124 ( .A(n158), .B(n17), .Y(SUM[16]) );
  NAND2X1 U125 ( .A(n93), .B(n92), .Y(n159) );
  NAND2X1 U126 ( .A(n93), .B(n17), .Y(n160) );
  NAND2X1 U127 ( .A(n92), .B(n17), .Y(n161) );
  NAND3X1 U128 ( .A(n159), .B(n160), .C(n161), .Y(n16) );
  OR2X1 U129 ( .A(A[8]), .B(B[8]), .Y(n165) );
  OR2X2 U130 ( .A(A[6]), .B(B[6]), .Y(n163) );
  OR2X2 U131 ( .A(A[4]), .B(B[4]), .Y(n164) );
  OR2X2 U132 ( .A(A[2]), .B(B[2]), .Y(n162) );
  OR2X2 U133 ( .A(A[10]), .B(B[10]), .Y(n166) );
  OR2X2 U134 ( .A(A[12]), .B(B[12]), .Y(n167) );
  OR2X2 U135 ( .A(A[14]), .B(B[14]), .Y(n168) );
  INVX2 U136 ( .A(A[17]), .Y(n93) );
  INVX2 U137 ( .A(B[17]), .Y(n92) );
  INVX2 U138 ( .A(n64), .Y(n88) );
  INVX2 U139 ( .A(n56), .Y(n86) );
  INVX2 U140 ( .A(n48), .Y(n84) );
  INVX2 U141 ( .A(n40), .Y(n82) );
  INVX2 U142 ( .A(n32), .Y(n80) );
  INVX2 U143 ( .A(n24), .Y(n78) );
  INVX2 U144 ( .A(n18), .Y(n76) );
  INVX2 U145 ( .A(n70), .Y(n68) );
  INVX2 U146 ( .A(n62), .Y(n60) );
  INVX2 U147 ( .A(n54), .Y(n52) );
  INVX2 U148 ( .A(n46), .Y(n44) );
  INVX2 U149 ( .A(n38), .Y(n36) );
  INVX2 U150 ( .A(n30), .Y(n28) );
  INVX2 U151 ( .A(n22), .Y(n20) );
  INVX2 U152 ( .A(n16), .Y(SUM[17]) );
endmodule


module alu_DW_mult_uns_3 ( a, b, product );
  input [30:0] a;
  input [15:0] b;
  output [46:0] product;
  wire   n1, n6, n7, n9, n13, n16, n19, n24, n25, n31, n37, n40, n49, n51, n52,
         n53, n54, n56, n57, n58, n59, n60, n61, n62, n65, n66, n67, n68, n69,
         n70, n72, n73, n74, n75, n77, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n109, n111, n112, n113,
         n114, n115, n116, n120, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n133, n134, n135, n136, n137, n140, n142, n144, n145,
         n146, n147, n148, n149, n151, n154, n155, n156, n159, n160, n161,
         n162, n163, n164, n165, n166, n169, n170, n171, n172, n173, n174,
         n177, n178, n179, n181, n182, n183, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n197, n198, n199, n200, n201, n202,
         n205, n206, n207, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n248, n249, n250,
         n251, n256, n257, n258, n259, n264, n265, n266, n267, n275, n279,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314,
         n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479,
         n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n543, n545, n548,
         n551, n552, n554, n555, n557, n560, n561, n563, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578,
         n579, n580, n581, n582, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n606, n607, n608, n609, n610, n611, n612,
         n613, n614, n615, n616, n617, n618, n619, n620, n621, n622, n623,
         n624, n625, n626, n627, n628, n629, n630, n631, n632, n633, n634,
         n635, n636, n637, n638, n639, n640, n641, n642, n643, n644, n645,
         n646, n647, n648, n649, n650, n651, n652, n653, n654, n655, n656,
         n657, n658, n659, n660, n661, n662, n663, n664, n665, n666, n667,
         n668, n669, n670, n671, n672, n673, n674, n675, n676, n677, n678,
         n679, n680, n681, n682, n683, n684, n685, n686, n687, n688, n689,
         n690, n691, n692, n693, n694, n695, n696, n697, n698, n699, n700,
         n701, n702, n703, n704, n705, n706, n707, n708, n710, n711, n712,
         n713, n714, n715, n716, n717, n718, n719, n720, n721, n722, n723,
         n724, n725, n730, n732, n733, n734, n738, n741, n742, n743, n744,
         n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755,
         n756, n757, n758, n759, n760, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n810,
         n811, n812, n813, n814, n815, n816, n817, n818, n819, n820, n821,
         n822, n823, n824, n825, n826, n827, n828, n829, n830, n831, n832,
         n833, n834, n835, n836, n837, n838, n839, n840, n841, n842, n843,
         n844, n845, n846, n847, n848, n849, n850, n851, n852, n853, n854,
         n855, n856, n857, n858, n859, n860, n861, n862, n863, n864, n865,
         n866, n867, n868, n869, n870, n871, n872, n873, n874, n875, n876,
         n877, n878, n879, n880, n881, n882, n883, n884, n885, n886, n887,
         n888, n889, n890, n891, n893, n894, n895, n896, n897, n898, n900,
         n917, n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234,
         n1235, n1236, n1237, n1238;
  assign n1 = a[16];
  assign n7 = a[18];
  assign n13 = a[20];
  assign n19 = a[22];
  assign n25 = a[24];
  assign n31 = a[26];
  assign n37 = a[28];
  assign n49 = b[0];
  assign n541 = a[30];
  assign n877 = b[15];
  assign n878 = b[14];
  assign n879 = b[13];
  assign n880 = b[12];
  assign n881 = b[11];
  assign n882 = b[10];
  assign n883 = b[9];
  assign n884 = b[8];
  assign n885 = b[7];
  assign n886 = b[6];
  assign n887 = b[5];
  assign n888 = b[4];
  assign n889 = b[3];
  assign n890 = b[2];
  assign n891 = b[1];

  XOR2X1 U54 ( .A(n73), .B(n54), .Y(product[46]) );
  NAND2X1 U55 ( .A(n72), .B(n1021), .Y(n54) );
  NAND2X1 U58 ( .A(n292), .B(n293), .Y(n72) );
  AOI21X1 U60 ( .A(n1100), .B(n74), .C(n75), .Y(n73) );
  NOR2X1 U61 ( .A(n1117), .B(n1143), .Y(n74) );
  OAI21X1 U62 ( .A(n1147), .B(n1117), .C(n77), .Y(n75) );
  OAI21X1 U66 ( .A(n80), .B(n140), .C(n81), .Y(n79) );
  NAND2X1 U67 ( .A(n82), .B(n104), .Y(n80) );
  AOI21X1 U68 ( .A(n82), .B(n105), .C(n83), .Y(n81) );
  NOR2X1 U69 ( .A(n84), .B(n93), .Y(n82) );
  OAI21X1 U70 ( .A(n94), .B(n84), .C(n85), .Y(n83) );
  NOR2X1 U73 ( .A(n294), .B(n297), .Y(n84) );
  NAND2X1 U74 ( .A(n294), .B(n297), .Y(n85) );
  XOR2X1 U75 ( .A(n95), .B(n56), .Y(product[44]) );
  AOI21X1 U76 ( .A(n1189), .B(n87), .C(n88), .Y(n86) );
  NOR2X1 U77 ( .A(n89), .B(n1143), .Y(n87) );
  OAI21X1 U78 ( .A(n89), .B(n1147), .C(n90), .Y(n88) );
  NAND2X1 U79 ( .A(n91), .B(n100), .Y(n89) );
  AOI21X1 U80 ( .A(n91), .B(n101), .C(n92), .Y(n90) );
  NAND2X1 U83 ( .A(n94), .B(n91), .Y(n56) );
  NOR2X1 U85 ( .A(n298), .B(n301), .Y(n93) );
  NAND2X1 U86 ( .A(n298), .B(n301), .Y(n94) );
  XOR2X1 U87 ( .A(n112), .B(n57), .Y(product[43]) );
  AOI21X1 U88 ( .A(n1189), .B(n96), .C(n97), .Y(n95) );
  NOR2X1 U89 ( .A(n98), .B(n1142), .Y(n96) );
  OAI21X1 U90 ( .A(n1146), .B(n98), .C(n99), .Y(n97) );
  NOR2X1 U93 ( .A(n102), .B(n137), .Y(n100) );
  OAI21X1 U94 ( .A(n140), .B(n102), .C(n103), .Y(n101) );
  NOR2X1 U97 ( .A(n106), .B(n130), .Y(n104) );
  OAI21X1 U98 ( .A(n106), .B(n133), .C(n107), .Y(n105) );
  NAND2X1 U99 ( .A(n1121), .B(n1016), .Y(n106) );
  AOI21X1 U100 ( .A(n120), .B(n1121), .C(n109), .Y(n107) );
  NAND2X1 U103 ( .A(n111), .B(n1121), .Y(n57) );
  NAND2X1 U106 ( .A(n302), .B(n307), .Y(n111) );
  XOR2X1 U107 ( .A(n123), .B(n58), .Y(product[42]) );
  AOI21X1 U108 ( .A(n1189), .B(n113), .C(n114), .Y(n112) );
  NOR2X1 U109 ( .A(n115), .B(n1143), .Y(n113) );
  OAI21X1 U110 ( .A(n115), .B(n1147), .C(n116), .Y(n114) );
  NAND2X1 U111 ( .A(n1016), .B(n128), .Y(n115) );
  AOI21X1 U112 ( .A(n1016), .B(n129), .C(n120), .Y(n116) );
  NAND2X1 U117 ( .A(n122), .B(n1016), .Y(n58) );
  NAND2X1 U120 ( .A(n308), .B(n313), .Y(n122) );
  XOR2X1 U121 ( .A(n134), .B(n59), .Y(product[41]) );
  AOI21X1 U122 ( .A(n1189), .B(n124), .C(n125), .Y(n123) );
  NOR2X1 U123 ( .A(n126), .B(n1142), .Y(n124) );
  OAI21X1 U124 ( .A(n1146), .B(n126), .C(n127), .Y(n125) );
  NOR2X1 U127 ( .A(n130), .B(n137), .Y(n128) );
  OAI21X1 U128 ( .A(n140), .B(n130), .C(n133), .Y(n129) );
  NAND2X1 U131 ( .A(n133), .B(n279), .Y(n59) );
  NOR2X1 U133 ( .A(n314), .B(n321), .Y(n130) );
  NAND2X1 U134 ( .A(n314), .B(n321), .Y(n133) );
  XOR2X1 U135 ( .A(n145), .B(n60), .Y(product[40]) );
  AOI21X1 U136 ( .A(n1189), .B(n135), .C(n136), .Y(n134) );
  NOR2X1 U137 ( .A(n1139), .B(n1143), .Y(n135) );
  OAI21X1 U138 ( .A(n1147), .B(n1139), .C(n140), .Y(n136) );
  NAND2X1 U141 ( .A(n1118), .B(n1106), .Y(n137) );
  AOI21X1 U142 ( .A(n151), .B(n1118), .C(n142), .Y(n140) );
  NAND2X1 U145 ( .A(n144), .B(n1118), .Y(n60) );
  NAND2X1 U148 ( .A(n322), .B(n329), .Y(n144) );
  XOR2X1 U149 ( .A(n154), .B(n61), .Y(product[39]) );
  AOI21X1 U150 ( .A(n1189), .B(n146), .C(n147), .Y(n145) );
  NOR2X1 U151 ( .A(n148), .B(n1142), .Y(n146) );
  OAI21X1 U152 ( .A(n1146), .B(n148), .C(n149), .Y(n147) );
  NAND2X1 U157 ( .A(n149), .B(n1106), .Y(n61) );
  NAND2X1 U160 ( .A(n339), .B(n330), .Y(n149) );
  XOR2X1 U161 ( .A(n163), .B(n62), .Y(product[38]) );
  AOI21X1 U162 ( .A(n1189), .B(n155), .C(n156), .Y(n154) );
  NAND2X1 U165 ( .A(n159), .B(n171), .Y(n53) );
  AOI21X1 U166 ( .A(n172), .B(n159), .C(n160), .Y(n52) );
  NOR2X1 U167 ( .A(n161), .B(n166), .Y(n159) );
  OAI21X1 U168 ( .A(n161), .B(n169), .C(n162), .Y(n160) );
  NAND2X1 U169 ( .A(n162), .B(n282), .Y(n62) );
  NOR2X1 U171 ( .A(n349), .B(n340), .Y(n161) );
  NAND2X1 U172 ( .A(n340), .B(n349), .Y(n162) );
  AOI21X1 U174 ( .A(n164), .B(n1189), .C(n165), .Y(n163) );
  NOR2X1 U175 ( .A(n1111), .B(n173), .Y(n164) );
  OAI21X1 U176 ( .A(n174), .B(n1111), .C(n169), .Y(n165) );
  NOR2X1 U181 ( .A(n361), .B(n350), .Y(n166) );
  NAND2X1 U182 ( .A(n361), .B(n350), .Y(n169) );
  AOI21X1 U184 ( .A(n171), .B(n1189), .C(n172), .Y(n170) );
  NOR2X1 U189 ( .A(n177), .B(n182), .Y(n171) );
  OAI21X1 U190 ( .A(n177), .B(n183), .C(n178), .Y(n172) );
  NOR2X1 U193 ( .A(n373), .B(n362), .Y(n177) );
  NAND2X1 U194 ( .A(n373), .B(n1004), .Y(n178) );
  XNOR2X1 U195 ( .A(n1100), .B(n65), .Y(product[35]) );
  AOI21X1 U196 ( .A(n285), .B(n1189), .C(n181), .Y(n179) );
  NAND2X1 U199 ( .A(n183), .B(n285), .Y(n65) );
  NOR2X1 U201 ( .A(n387), .B(n374), .Y(n182) );
  NAND2X1 U202 ( .A(n387), .B(n374), .Y(n183) );
  XOR2X1 U203 ( .A(n191), .B(n66), .Y(product[34]) );
  OAI21X1 U204 ( .A(n213), .B(n185), .C(n186), .Y(n51) );
  NAND2X1 U205 ( .A(n187), .B(n199), .Y(n185) );
  AOI21X1 U206 ( .A(n200), .B(n187), .C(n188), .Y(n186) );
  NOR2X1 U207 ( .A(n189), .B(n194), .Y(n187) );
  OAI21X1 U208 ( .A(n189), .B(n197), .C(n190), .Y(n188) );
  NAND2X1 U209 ( .A(n190), .B(n286), .Y(n66) );
  NOR2X1 U211 ( .A(n401), .B(n388), .Y(n189) );
  NAND2X1 U212 ( .A(n401), .B(n388), .Y(n190) );
  XOR2X1 U213 ( .A(n198), .B(n67), .Y(product[33]) );
  AOI21X1 U214 ( .A(n212), .B(n192), .C(n193), .Y(n191) );
  NOR2X1 U215 ( .A(n194), .B(n201), .Y(n192) );
  OAI21X1 U216 ( .A(n194), .B(n202), .C(n197), .Y(n193) );
  NAND2X1 U219 ( .A(n197), .B(n287), .Y(n67) );
  NOR2X1 U221 ( .A(n415), .B(n402), .Y(n194) );
  NAND2X1 U222 ( .A(n415), .B(n402), .Y(n197) );
  XOR2X1 U223 ( .A(n207), .B(n68), .Y(product[32]) );
  AOI21X1 U224 ( .A(n199), .B(n212), .C(n200), .Y(n198) );
  NOR2X1 U229 ( .A(n210), .B(n1101), .Y(n199) );
  OAI21X1 U230 ( .A(n205), .B(n211), .C(n206), .Y(n200) );
  NAND2X1 U231 ( .A(n206), .B(n288), .Y(n68) );
  NOR2X1 U233 ( .A(n429), .B(n416), .Y(n205) );
  NAND2X1 U234 ( .A(n429), .B(n416), .Y(n206) );
  XNOR2X1 U235 ( .A(n212), .B(n69), .Y(product[31]) );
  AOI21X1 U236 ( .A(n289), .B(n212), .C(n209), .Y(n207) );
  NAND2X1 U239 ( .A(n211), .B(n289), .Y(n69) );
  NOR2X1 U241 ( .A(n443), .B(n430), .Y(n210) );
  NAND2X1 U242 ( .A(n443), .B(n430), .Y(n211) );
  XNOR2X1 U243 ( .A(n218), .B(n70), .Y(product[30]) );
  AOI21X1 U245 ( .A(n222), .B(n214), .C(n215), .Y(n213) );
  NOR2X1 U246 ( .A(n219), .B(n216), .Y(n214) );
  OAI21X1 U247 ( .A(n216), .B(n220), .C(n217), .Y(n215) );
  NAND2X1 U248 ( .A(n217), .B(n290), .Y(n70) );
  NOR2X1 U250 ( .A(n457), .B(n444), .Y(n216) );
  NAND2X1 U251 ( .A(n457), .B(n444), .Y(n217) );
  OAI21X1 U252 ( .A(n221), .B(n219), .C(n220), .Y(n218) );
  NOR2X1 U253 ( .A(n469), .B(n458), .Y(n219) );
  NAND2X1 U254 ( .A(n469), .B(n458), .Y(n220) );
  OAI21X1 U256 ( .A(n223), .B(n233), .C(n224), .Y(n222) );
  NAND2X1 U257 ( .A(n1125), .B(n1119), .Y(n223) );
  AOI21X1 U258 ( .A(n1124), .B(n1119), .C(n1120), .Y(n224) );
  AOI21X1 U267 ( .A(n240), .B(n234), .C(n235), .Y(n233) );
  NOR2X1 U268 ( .A(n238), .B(n236), .Y(n234) );
  OAI21X1 U269 ( .A(n236), .B(n239), .C(n237), .Y(n235) );
  NOR2X1 U270 ( .A(n501), .B(n492), .Y(n236) );
  NAND2X1 U271 ( .A(n501), .B(n492), .Y(n237) );
  NOR2X1 U272 ( .A(n509), .B(n502), .Y(n238) );
  NAND2X1 U273 ( .A(n509), .B(n502), .Y(n239) );
  OAI21X1 U274 ( .A(n243), .B(n241), .C(n242), .Y(n240) );
  NOR2X1 U275 ( .A(n517), .B(n510), .Y(n241) );
  NAND2X1 U276 ( .A(n517), .B(n510), .Y(n242) );
  AOI21X1 U277 ( .A(n1123), .B(n248), .C(n1126), .Y(n243) );
  OAI21X1 U282 ( .A(n251), .B(n249), .C(n250), .Y(n248) );
  NOR2X1 U283 ( .A(n529), .B(n524), .Y(n249) );
  NAND2X1 U284 ( .A(n529), .B(n524), .Y(n250) );
  AOI21X1 U285 ( .A(n256), .B(n1122), .C(n1127), .Y(n251) );
  OAI21X1 U290 ( .A(n257), .B(n259), .C(n258), .Y(n256) );
  NOR2X1 U291 ( .A(n537), .B(n534), .Y(n257) );
  NAND2X1 U292 ( .A(n537), .B(n534), .Y(n258) );
  AOI21X1 U293 ( .A(n264), .B(n1128), .C(n1131), .Y(n259) );
  OAI21X1 U298 ( .A(n265), .B(n267), .C(n266), .Y(n264) );
  NOR2X1 U299 ( .A(n707), .B(n540), .Y(n265) );
  NAND2X1 U300 ( .A(n707), .B(n540), .Y(n266) );
  AOI21X1 U301 ( .A(n1132), .B(n1129), .C(n1130), .Y(n267) );
  XOR2X1 U308 ( .A(n295), .B(n291), .Y(n292) );
  FAX1 U310 ( .A(n296), .B(n584), .C(n299), .YC(n293), .YS(n294) );
  FAX1 U312 ( .A(n585), .B(n300), .C(n303), .YC(n297), .YS(n298) );
  FAX1 U313 ( .A(n305), .B(n574), .C(n601), .YC(n299), .YS(n300) );
  FAX1 U314 ( .A(n311), .B(n304), .C(n309), .YC(n301), .YS(n302) );
  FAX1 U315 ( .A(n306), .B(n586), .C(n602), .YC(n303), .YS(n304) );
  FAX1 U317 ( .A(n317), .B(n315), .C(n310), .YC(n307), .YS(n308) );
  FAX1 U318 ( .A(n587), .B(n603), .C(n312), .YC(n309), .YS(n310) );
  FAX1 U319 ( .A(n319), .B(n575), .C(n619), .YC(n311), .YS(n312) );
  FAX1 U320 ( .A(n318), .B(n316), .C(n323), .YC(n313), .YS(n314) );
  FAX1 U321 ( .A(n588), .B(n327), .C(n325), .YC(n315), .YS(n316) );
  FAX1 U322 ( .A(n320), .B(n604), .C(n620), .YC(n317), .YS(n318) );
  FAX1 U324 ( .A(n333), .B(n324), .C(n331), .YC(n321), .YS(n322) );
  FAX1 U325 ( .A(n328), .B(n335), .C(n326), .YC(n323), .YS(n324) );
  FAX1 U326 ( .A(n589), .B(n605), .C(n621), .YC(n325), .YS(n326) );
  FAX1 U327 ( .A(n337), .B(n576), .C(n637), .YC(n327), .YS(n328) );
  FAX1 U328 ( .A(n343), .B(n332), .C(n341), .YC(n329), .YS(n330) );
  FAX1 U330 ( .A(n606), .B(n590), .C(n347), .YC(n333), .YS(n334) );
  FAX1 U331 ( .A(n338), .B(n622), .C(n638), .YC(n335), .YS(n336) );
  FAX1 U333 ( .A(n344), .B(n351), .C(n342), .YC(n339), .YS(n340) );
  FAX1 U334 ( .A(n355), .B(n346), .C(n353), .YC(n341), .YS(n342) );
  FAX1 U335 ( .A(n623), .B(n348), .C(n357), .YC(n343), .YS(n344) );
  FAX1 U336 ( .A(n607), .B(n591), .C(n639), .YC(n345), .YS(n346) );
  FAX1 U337 ( .A(n1112), .B(n577), .C(n655), .YC(n347), .YS(n348) );
  FAX1 U338 ( .A(n354), .B(n363), .C(n352), .YC(n349), .YS(n350) );
  FAX1 U339 ( .A(n356), .B(n367), .C(n365), .YC(n351), .YS(n352) );
  FAX1 U340 ( .A(n371), .B(n369), .C(n358), .YC(n353), .YS(n354) );
  FAX1 U341 ( .A(n592), .B(n608), .C(n640), .YC(n355), .YS(n356) );
  FAX1 U342 ( .A(n360), .B(n624), .C(n656), .YC(n357), .YS(n358) );
  FAX1 U346 ( .A(n997), .B(n381), .C(n370), .YC(n365), .YS(n366) );
  FAX1 U347 ( .A(n625), .B(n593), .C(n372), .YC(n367), .YS(n368) );
  FAX1 U348 ( .A(n609), .B(n641), .C(n657), .YC(n369), .YS(n370) );
  FAX1 U349 ( .A(n385), .B(n578), .C(n673), .YC(n371), .YS(n372) );
  FAX1 U350 ( .A(n378), .B(n389), .C(n376), .YC(n373), .YS(n374) );
  FAX1 U351 ( .A(n996), .B(n380), .C(n391), .YC(n375), .YS(n376) );
  FAX1 U352 ( .A(n395), .B(n384), .C(n382), .YC(n377), .YS(n378) );
  FAX1 U353 ( .A(n610), .B(n399), .C(n397), .YC(n379), .YS(n380) );
  FAX1 U354 ( .A(n658), .B(n594), .C(n626), .YC(n381), .YS(n382) );
  FAX1 U355 ( .A(n386), .B(n642), .C(n674), .YC(n383), .YS(n384) );
  FAX1 U358 ( .A(n407), .B(n394), .C(n405), .YC(n389), .YS(n390) );
  FAX1 U359 ( .A(n400), .B(n1081), .C(n398), .YC(n391), .YS(n392) );
  FAX1 U360 ( .A(n413), .B(n411), .C(n409), .YC(n393), .YS(n394) );
  FAX1 U361 ( .A(n659), .B(n611), .C(n643), .YC(n395), .YS(n396) );
  FAX1 U362 ( .A(n627), .B(n595), .C(n675), .YC(n397), .YS(n398) );
  FAX1 U363 ( .A(n579), .B(n1144), .C(n691), .YC(n399), .YS(n400) );
  FAX1 U366 ( .A(n423), .B(n410), .C(n412), .YC(n405), .YS(n406) );
  FAX1 U367 ( .A(n427), .B(n414), .C(n425), .YC(n407), .YS(n408) );
  FAX1 U368 ( .A(n676), .B(n612), .C(n660), .YC(n409), .YS(n410) );
  FAX1 U369 ( .A(n628), .B(n596), .C(n692), .YC(n411), .YS(n412) );
  FAX1 U371 ( .A(n420), .B(n1013), .C(n418), .YC(n415), .YS(n416) );
  FAX1 U372 ( .A(n435), .B(n422), .C(n433), .YC(n417), .YS(n418) );
  FAX1 U375 ( .A(n677), .B(n613), .C(n661), .YC(n423), .YS(n424) );
  FAX1 U376 ( .A(n629), .B(n597), .C(n693), .YC(n425), .YS(n426) );
  FAX1 U377 ( .A(n1145), .B(n581), .C(n645), .YC(n427), .YS(n428) );
  FAX1 U378 ( .A(n434), .B(n445), .C(n432), .YC(n429), .YS(n430) );
  FAX1 U379 ( .A(n1029), .B(n449), .C(n447), .YC(n431), .YS(n432) );
  FAX1 U380 ( .A(n442), .B(n1015), .C(n440), .YC(n433), .YS(n434) );
  FAX1 U381 ( .A(n455), .B(n453), .C(n451), .YC(n435), .YS(n436) );
  FAX1 U382 ( .A(n646), .B(n694), .C(n678), .YC(n437), .YS(n438) );
  FAX1 U383 ( .A(n662), .B(n598), .C(n710), .YC(n439), .YS(n440) );
  FAX1 U386 ( .A(n463), .B(n450), .C(n461), .YC(n445), .YS(n446) );
  FAX1 U387 ( .A(n465), .B(n995), .C(n454), .YC(n447), .YS(n448) );
  FAX1 U388 ( .A(n647), .B(n467), .C(n456), .YC(n449), .YS(n450) );
  FAX1 U389 ( .A(n615), .B(n679), .C(n565), .YC(n451), .YS(n452) );
  FAX1 U390 ( .A(n631), .B(n695), .C(n599), .YC(n453), .YS(n454) );
  HAX1 U391 ( .A(n663), .B(n711), .YC(n455), .YS(n456) );
  FAX1 U392 ( .A(n462), .B(n471), .C(n460), .YC(n457), .YS(n458) );
  FAX1 U393 ( .A(n468), .B(n464), .C(n473), .YC(n459), .YS(n460) );
  FAX1 U394 ( .A(n477), .B(n475), .C(n466), .YC(n461), .YS(n462) );
  FAX1 U395 ( .A(n696), .B(n680), .C(n479), .YC(n463), .YS(n464) );
  FAX1 U396 ( .A(n664), .B(n648), .C(n712), .YC(n465), .YS(n466) );
  FAX1 U397 ( .A(n600), .B(n632), .C(n616), .YC(n467), .YS(n468) );
  FAX1 U398 ( .A(n474), .B(n483), .C(n472), .YC(n469), .YS(n470) );
  FAX1 U400 ( .A(n480), .B(n489), .C(n487), .YC(n473), .YS(n474) );
  FAX1 U401 ( .A(n665), .B(n649), .C(n566), .YC(n475), .YS(n476) );
  FAX1 U402 ( .A(n633), .B(n681), .C(n617), .YC(n477), .YS(n478) );
  HAX1 U403 ( .A(n713), .B(n697), .YC(n479), .YS(n480) );
  FAX1 U404 ( .A(n486), .B(n493), .C(n484), .YC(n481), .YS(n482) );
  FAX1 U405 ( .A(n490), .B(n488), .C(n495), .YC(n483), .YS(n484) );
  FAX1 U407 ( .A(n714), .B(n666), .C(n682), .YC(n487), .YS(n488) );
  FAX1 U408 ( .A(n618), .B(n650), .C(n634), .YC(n489), .YS(n490) );
  FAX1 U409 ( .A(n496), .B(n998), .C(n494), .YC(n491), .YS(n492) );
  FAX1 U410 ( .A(n507), .B(n505), .C(n498), .YC(n493), .YS(n494) );
  FAX1 U411 ( .A(n699), .B(n567), .C(n500), .YC(n495), .YS(n496) );
  FAX1 U412 ( .A(n667), .B(n683), .C(n635), .YC(n497), .YS(n498) );
  HAX1 U413 ( .A(n715), .B(n651), .YC(n499), .YS(n500) );
  FAX1 U414 ( .A(n506), .B(n511), .C(n504), .YC(n501), .YS(n502) );
  FAX1 U415 ( .A(n515), .B(n513), .C(n508), .YC(n503), .YS(n504) );
  FAX1 U416 ( .A(n716), .B(n684), .C(n700), .YC(n505), .YS(n506) );
  FAX1 U417 ( .A(n636), .B(n668), .C(n652), .YC(n507), .YS(n508) );
  FAX1 U418 ( .A(n514), .B(n519), .C(n512), .YC(n509), .YS(n510) );
  FAX1 U419 ( .A(n568), .B(n516), .C(n521), .YC(n511), .YS(n512) );
  FAX1 U420 ( .A(n685), .B(n669), .C(n653), .YC(n513), .YS(n514) );
  HAX1 U421 ( .A(n717), .B(n701), .YC(n515), .YS(n516) );
  FAX1 U422 ( .A(n525), .B(n522), .C(n520), .YC(n517), .YS(n518) );
  FAX1 U423 ( .A(n718), .B(n702), .C(n527), .YC(n519), .YS(n520) );
  FAX1 U424 ( .A(n654), .B(n686), .C(n670), .YC(n521), .YS(n522) );
  FAX1 U425 ( .A(n528), .B(n531), .C(n526), .YC(n523), .YS(n524) );
  FAX1 U426 ( .A(n719), .B(n569), .C(n671), .YC(n525), .YS(n526) );
  HAX1 U427 ( .A(n703), .B(n687), .YC(n527), .YS(n528) );
  FAX1 U428 ( .A(n704), .B(n535), .C(n532), .YC(n529), .YS(n530) );
  FAX1 U429 ( .A(n672), .B(n720), .C(n688), .YC(n531), .YS(n532) );
  FAX1 U430 ( .A(n570), .B(n689), .C(n536), .YC(n533), .YS(n534) );
  HAX1 U431 ( .A(n705), .B(n721), .YC(n535), .YS(n536) );
  FAX1 U432 ( .A(n690), .B(n722), .C(n706), .YC(n537), .YS(n538) );
  HAX1 U433 ( .A(n723), .B(n571), .YC(n539), .YS(n540) );
  NOR2X1 U434 ( .A(n1116), .B(n1218), .Y(n573) );
  NOR2X1 U435 ( .A(n1116), .B(n1216), .Y(n295) );
  NOR2X1 U436 ( .A(n1116), .B(n1214), .Y(n574) );
  NOR2X1 U437 ( .A(n1116), .B(n1212), .Y(n305) );
  NOR2X1 U438 ( .A(n1116), .B(n730), .Y(n575) );
  NOR2X1 U439 ( .A(n1116), .B(n1208), .Y(n319) );
  NOR2X1 U440 ( .A(n1116), .B(n732), .Y(n576) );
  NOR2X1 U441 ( .A(n1116), .B(n733), .Y(n337) );
  NOR2X1 U442 ( .A(n1116), .B(n734), .Y(n577) );
  NOR2X1 U443 ( .A(n1116), .B(n1200), .Y(n359) );
  NOR2X1 U444 ( .A(n1116), .B(n1198), .Y(n578) );
  NOR2X1 U446 ( .A(n1116), .B(n738), .Y(n579) );
  NOR2X1 U447 ( .A(n1116), .B(n1192), .Y(n580) );
  NOR2X1 U448 ( .A(n1116), .B(n1190), .Y(n581) );
  OAI22X1 U466 ( .A(n1116), .B(n1186), .C(n1077), .D(n757), .Y(n565) );
  OAI22X1 U469 ( .A(n1116), .B(n1026), .C(n1022), .D(n741), .Y(n584) );
  OAI22X1 U470 ( .A(n1022), .B(n742), .C(n1026), .D(n741), .Y(n585) );
  OAI22X1 U471 ( .A(n1186), .B(n743), .C(n1026), .D(n742), .Y(n586) );
  OAI22X1 U472 ( .A(n1186), .B(n744), .C(n1026), .D(n743), .Y(n587) );
  OAI22X1 U473 ( .A(n1186), .B(n745), .C(n1026), .D(n744), .Y(n588) );
  OAI22X1 U474 ( .A(n1186), .B(n746), .C(n1077), .D(n745), .Y(n589) );
  OAI22X1 U475 ( .A(n1186), .B(n747), .C(n1026), .D(n746), .Y(n590) );
  OAI22X1 U476 ( .A(n1186), .B(n748), .C(n1077), .D(n747), .Y(n591) );
  OAI22X1 U477 ( .A(n1186), .B(n749), .C(n1077), .D(n748), .Y(n592) );
  OAI22X1 U478 ( .A(n1186), .B(n750), .C(n1026), .D(n749), .Y(n593) );
  OAI22X1 U480 ( .A(n1187), .B(n752), .C(n1077), .D(n751), .Y(n595) );
  OAI22X1 U481 ( .A(n1187), .B(n753), .C(n1077), .D(n752), .Y(n596) );
  OAI22X1 U482 ( .A(n1187), .B(n754), .C(n1077), .D(n753), .Y(n597) );
  OAI22X1 U483 ( .A(n1186), .B(n755), .C(n1077), .D(n754), .Y(n598) );
  OAI22X1 U484 ( .A(n1077), .B(n755), .C(n1187), .D(n756), .Y(n599) );
  AND2X1 U485 ( .A(n1223), .B(n543), .Y(n600) );
  XNOR2X1 U487 ( .A(n1219), .B(n1222), .Y(n741) );
  XNOR2X1 U488 ( .A(n1217), .B(n1222), .Y(n742) );
  XNOR2X1 U489 ( .A(n1215), .B(n1222), .Y(n743) );
  XNOR2X1 U490 ( .A(n1213), .B(n1222), .Y(n744) );
  XNOR2X1 U491 ( .A(n1211), .B(n1222), .Y(n745) );
  XNOR2X1 U492 ( .A(n1209), .B(n1222), .Y(n746) );
  XNOR2X1 U493 ( .A(n1207), .B(n1222), .Y(n747) );
  XNOR2X1 U494 ( .A(n1205), .B(n1221), .Y(n748) );
  XNOR2X1 U495 ( .A(n1203), .B(n1221), .Y(n749) );
  XNOR2X1 U496 ( .A(n1201), .B(n1221), .Y(n750) );
  XNOR2X1 U497 ( .A(n1199), .B(n1221), .Y(n751) );
  XNOR2X1 U498 ( .A(n1197), .B(n1221), .Y(n752) );
  XNOR2X1 U499 ( .A(n1195), .B(n1221), .Y(n753) );
  XNOR2X1 U500 ( .A(n1193), .B(n1221), .Y(n754) );
  XNOR2X1 U501 ( .A(n1191), .B(n1221), .Y(n755) );
  OR2X1 U503 ( .A(n1008), .B(n1116), .Y(n757) );
  OAI22X1 U505 ( .A(n1238), .B(n1183), .C(n1182), .D(n774), .Y(n566) );
  OAI22X1 U508 ( .A(n1238), .B(n1182), .C(n1183), .D(n758), .Y(n602) );
  OAI22X1 U509 ( .A(n1183), .B(n759), .C(n1182), .D(n758), .Y(n603) );
  OAI22X1 U510 ( .A(n1183), .B(n760), .C(n1182), .D(n759), .Y(n604) );
  OAI22X1 U511 ( .A(n1183), .B(n761), .C(n1182), .D(n760), .Y(n605) );
  OAI22X1 U512 ( .A(n1183), .B(n762), .C(n1182), .D(n761), .Y(n606) );
  OAI22X1 U513 ( .A(n1183), .B(n763), .C(n1182), .D(n762), .Y(n607) );
  OAI22X1 U514 ( .A(n1183), .B(n764), .C(n1182), .D(n763), .Y(n608) );
  OAI22X1 U516 ( .A(n1183), .B(n766), .C(n1182), .D(n765), .Y(n610) );
  OAI22X1 U517 ( .A(n1183), .B(n767), .C(n1182), .D(n766), .Y(n611) );
  OAI22X1 U518 ( .A(n1183), .B(n768), .C(n1182), .D(n767), .Y(n612) );
  OAI22X1 U519 ( .A(n1183), .B(n769), .C(n1182), .D(n768), .Y(n613) );
  OAI22X1 U520 ( .A(n1183), .B(n770), .C(n1182), .D(n769), .Y(n614) );
  OAI22X1 U521 ( .A(n1183), .B(n771), .C(n770), .D(n1182), .Y(n615) );
  OAI22X1 U522 ( .A(n1183), .B(n772), .C(n1182), .D(n771), .Y(n616) );
  OAI22X1 U523 ( .A(n1182), .B(n772), .C(n1183), .D(n773), .Y(n617) );
  XNOR2X1 U526 ( .A(n1219), .B(n1082), .Y(n758) );
  XNOR2X1 U527 ( .A(n1217), .B(n1082), .Y(n759) );
  XNOR2X1 U528 ( .A(n1215), .B(n1082), .Y(n760) );
  XNOR2X1 U529 ( .A(n1213), .B(n1237), .Y(n761) );
  XNOR2X1 U530 ( .A(n1211), .B(n1237), .Y(n762) );
  XNOR2X1 U531 ( .A(n1209), .B(n1237), .Y(n763) );
  XNOR2X1 U532 ( .A(n1207), .B(n1237), .Y(n764) );
  XNOR2X1 U533 ( .A(n1205), .B(n1237), .Y(n765) );
  XNOR2X1 U534 ( .A(n1203), .B(n1237), .Y(n766) );
  XNOR2X1 U535 ( .A(n1201), .B(n1237), .Y(n767) );
  XNOR2X1 U536 ( .A(n1199), .B(n1237), .Y(n768) );
  XNOR2X1 U537 ( .A(n1197), .B(n1237), .Y(n769) );
  XNOR2X1 U539 ( .A(n1193), .B(n1237), .Y(n771) );
  XNOR2X1 U540 ( .A(n1191), .B(n1237), .Y(n772) );
  XNOR2X1 U541 ( .A(n1008), .B(n1237), .Y(n773) );
  OAI22X1 U544 ( .A(n1048), .B(n1179), .C(n1178), .D(n791), .Y(n567) );
  OAI22X1 U547 ( .A(n1048), .B(n1178), .C(n1179), .D(n775), .Y(n620) );
  OAI22X1 U548 ( .A(n1179), .B(n776), .C(n1178), .D(n775), .Y(n621) );
  OAI22X1 U549 ( .A(n1179), .B(n777), .C(n1178), .D(n776), .Y(n622) );
  OAI22X1 U550 ( .A(n1179), .B(n778), .C(n1178), .D(n777), .Y(n623) );
  OAI22X1 U551 ( .A(n1180), .B(n779), .C(n1178), .D(n778), .Y(n624) );
  OAI22X1 U552 ( .A(n1179), .B(n780), .C(n1178), .D(n779), .Y(n625) );
  OAI22X1 U553 ( .A(n1179), .B(n781), .C(n1178), .D(n780), .Y(n626) );
  OAI22X1 U554 ( .A(n1180), .B(n782), .C(n1178), .D(n781), .Y(n627) );
  OAI22X1 U555 ( .A(n1180), .B(n783), .C(n1178), .D(n782), .Y(n628) );
  OAI22X1 U556 ( .A(n1180), .B(n784), .C(n1178), .D(n783), .Y(n629) );
  OAI22X1 U557 ( .A(n1180), .B(n785), .C(n1178), .D(n784), .Y(n630) );
  OAI22X1 U558 ( .A(n1180), .B(n786), .C(n1178), .D(n785), .Y(n631) );
  OAI22X1 U559 ( .A(n1180), .B(n787), .C(n1178), .D(n786), .Y(n632) );
  OAI22X1 U560 ( .A(n1180), .B(n788), .C(n1178), .D(n787), .Y(n633) );
  OAI22X1 U561 ( .A(n1180), .B(n789), .C(n1178), .D(n788), .Y(n634) );
  OAI22X1 U562 ( .A(n1178), .B(n789), .C(n1179), .D(n790), .Y(n635) );
  AND2X1 U563 ( .A(n1223), .B(n1135), .Y(n636) );
  XNOR2X1 U565 ( .A(n1219), .B(n1074), .Y(n775) );
  XNOR2X1 U566 ( .A(n1217), .B(n1235), .Y(n776) );
  XNOR2X1 U567 ( .A(n1215), .B(n1075), .Y(n777) );
  XNOR2X1 U568 ( .A(n1213), .B(n1074), .Y(n778) );
  XNOR2X1 U569 ( .A(n1211), .B(n1074), .Y(n779) );
  XNOR2X1 U570 ( .A(n1209), .B(n1235), .Y(n780) );
  XNOR2X1 U571 ( .A(n1207), .B(n1235), .Y(n781) );
  XNOR2X1 U572 ( .A(n1205), .B(n1075), .Y(n782) );
  XNOR2X1 U573 ( .A(n1203), .B(n1235), .Y(n783) );
  XNOR2X1 U574 ( .A(n1201), .B(n1075), .Y(n784) );
  XNOR2X1 U575 ( .A(n1199), .B(n1235), .Y(n785) );
  XNOR2X1 U576 ( .A(n1197), .B(n1074), .Y(n786) );
  XNOR2X1 U577 ( .A(n1195), .B(n1075), .Y(n787) );
  XNOR2X1 U578 ( .A(n1193), .B(n1235), .Y(n788) );
  XNOR2X1 U579 ( .A(n1191), .B(n1075), .Y(n789) );
  XNOR2X1 U580 ( .A(n1007), .B(n1074), .Y(n790) );
  OAI22X1 U583 ( .A(n1078), .B(n1049), .C(n1177), .D(n808), .Y(n568) );
  OAI22X1 U586 ( .A(n1078), .B(n1177), .C(n1047), .D(n792), .Y(n638) );
  OAI22X1 U587 ( .A(n1049), .B(n793), .C(n1177), .D(n792), .Y(n639) );
  OAI22X1 U588 ( .A(n1049), .B(n794), .C(n1177), .D(n793), .Y(n640) );
  OAI22X1 U589 ( .A(n1056), .B(n795), .C(n1177), .D(n794), .Y(n641) );
  OAI22X1 U591 ( .A(n1056), .B(n797), .C(n1177), .D(n796), .Y(n643) );
  OAI22X1 U592 ( .A(n1056), .B(n798), .C(n1177), .D(n797), .Y(n644) );
  OAI22X1 U593 ( .A(n1056), .B(n799), .C(n798), .D(n1020), .Y(n645) );
  OAI22X1 U594 ( .A(n800), .B(n1047), .C(n1177), .D(n799), .Y(n646) );
  OAI22X1 U595 ( .A(n1049), .B(n801), .C(n1177), .D(n800), .Y(n647) );
  OAI22X1 U596 ( .A(n1049), .B(n802), .C(n1177), .D(n801), .Y(n648) );
  OAI22X1 U597 ( .A(n1047), .B(n803), .C(n1177), .D(n802), .Y(n649) );
  OAI22X1 U598 ( .A(n1049), .B(n804), .C(n1177), .D(n803), .Y(n650) );
  OAI22X1 U599 ( .A(n1049), .B(n805), .C(n1177), .D(n804), .Y(n651) );
  OAI22X1 U600 ( .A(n1047), .B(n806), .C(n1177), .D(n805), .Y(n652) );
  OAI22X1 U601 ( .A(n1177), .B(n806), .C(n1047), .D(n807), .Y(n653) );
  AND2X1 U602 ( .A(n1223), .B(n552), .Y(n654) );
  XNOR2X1 U604 ( .A(n1219), .B(n1233), .Y(n792) );
  XNOR2X1 U605 ( .A(n1217), .B(n1233), .Y(n793) );
  XNOR2X1 U606 ( .A(n1215), .B(n1233), .Y(n794) );
  XNOR2X1 U607 ( .A(n1213), .B(n1233), .Y(n795) );
  XNOR2X1 U608 ( .A(n1211), .B(n1233), .Y(n796) );
  XNOR2X1 U609 ( .A(n1209), .B(n1233), .Y(n797) );
  XNOR2X1 U610 ( .A(n1207), .B(n1233), .Y(n798) );
  XNOR2X1 U611 ( .A(n1205), .B(n1233), .Y(n799) );
  XNOR2X1 U612 ( .A(n1203), .B(n1233), .Y(n800) );
  XNOR2X1 U613 ( .A(n1201), .B(n1233), .Y(n801) );
  XNOR2X1 U614 ( .A(n1199), .B(n1233), .Y(n802) );
  XNOR2X1 U615 ( .A(n1197), .B(n1233), .Y(n803) );
  XNOR2X1 U616 ( .A(n1195), .B(n1233), .Y(n804) );
  XNOR2X1 U617 ( .A(n1193), .B(n1233), .Y(n805) );
  XNOR2X1 U618 ( .A(n1191), .B(n1233), .Y(n806) );
  XNOR2X1 U619 ( .A(n1008), .B(n1233), .Y(n807) );
  OAI22X1 U622 ( .A(n1027), .B(n1151), .C(n1173), .D(n825), .Y(n569) );
  OAI22X1 U625 ( .A(n1027), .B(n1174), .C(n1176), .D(n809), .Y(n656) );
  OAI22X1 U626 ( .A(n1176), .B(n810), .C(n1174), .D(n809), .Y(n657) );
  OAI22X1 U627 ( .A(n1176), .B(n811), .C(n1173), .D(n810), .Y(n658) );
  OAI22X1 U628 ( .A(n1044), .B(n812), .C(n1174), .D(n811), .Y(n659) );
  OAI22X1 U629 ( .A(n1176), .B(n813), .C(n1173), .D(n812), .Y(n660) );
  OAI22X1 U630 ( .A(n1176), .B(n814), .C(n1174), .D(n813), .Y(n661) );
  OAI22X1 U631 ( .A(n1176), .B(n815), .C(n1173), .D(n814), .Y(n662) );
  OAI22X1 U632 ( .A(n1176), .B(n816), .C(n1174), .D(n815), .Y(n663) );
  OAI22X1 U633 ( .A(n1176), .B(n817), .C(n1173), .D(n816), .Y(n664) );
  OAI22X1 U634 ( .A(n1176), .B(n818), .C(n1174), .D(n817), .Y(n665) );
  OAI22X1 U635 ( .A(n1176), .B(n819), .C(n1173), .D(n818), .Y(n666) );
  OAI22X1 U636 ( .A(n1176), .B(n820), .C(n1174), .D(n819), .Y(n667) );
  OAI22X1 U637 ( .A(n1176), .B(n821), .C(n1173), .D(n820), .Y(n668) );
  OAI22X1 U638 ( .A(n1176), .B(n822), .C(n1174), .D(n821), .Y(n669) );
  OAI22X1 U639 ( .A(n1151), .B(n823), .C(n1173), .D(n822), .Y(n670) );
  OAI22X1 U640 ( .A(n1174), .B(n823), .C(n1151), .D(n824), .Y(n671) );
  AND2X1 U641 ( .A(n1223), .B(n555), .Y(n672) );
  XNOR2X1 U643 ( .A(n1219), .B(n1231), .Y(n809) );
  XNOR2X1 U644 ( .A(n1217), .B(n1231), .Y(n810) );
  XNOR2X1 U645 ( .A(n1215), .B(n1231), .Y(n811) );
  XNOR2X1 U646 ( .A(n1213), .B(n1231), .Y(n812) );
  XNOR2X1 U647 ( .A(n1211), .B(n1231), .Y(n813) );
  XNOR2X1 U648 ( .A(n1209), .B(n1231), .Y(n814) );
  XNOR2X1 U649 ( .A(n1207), .B(n1231), .Y(n815) );
  XNOR2X1 U650 ( .A(n1205), .B(n1231), .Y(n816) );
  XNOR2X1 U651 ( .A(n1203), .B(n1231), .Y(n817) );
  XNOR2X1 U652 ( .A(n1201), .B(n1231), .Y(n818) );
  XNOR2X1 U653 ( .A(n1199), .B(n1231), .Y(n819) );
  XNOR2X1 U654 ( .A(n1197), .B(n1231), .Y(n820) );
  XNOR2X1 U655 ( .A(n1023), .B(n1231), .Y(n821) );
  XNOR2X1 U656 ( .A(n1193), .B(n1231), .Y(n822) );
  XNOR2X1 U657 ( .A(n1191), .B(n1231), .Y(n823) );
  XNOR2X1 U658 ( .A(n1007), .B(n1231), .Y(n824) );
  OAI22X1 U661 ( .A(n1162), .B(n1171), .C(n1087), .D(n842), .Y(n570) );
  OAI22X1 U664 ( .A(n1162), .B(n1087), .C(n1171), .D(n826), .Y(n674) );
  OAI22X1 U665 ( .A(n1171), .B(n827), .C(n1087), .D(n826), .Y(n675) );
  OAI22X1 U666 ( .A(n1172), .B(n828), .C(n1087), .D(n827), .Y(n676) );
  OAI22X1 U667 ( .A(n1172), .B(n829), .C(n1087), .D(n828), .Y(n677) );
  OAI22X1 U668 ( .A(n1172), .B(n830), .C(n1087), .D(n829), .Y(n678) );
  OAI22X1 U669 ( .A(n1172), .B(n831), .C(n830), .D(n1087), .Y(n679) );
  OAI22X1 U670 ( .A(n1171), .B(n832), .C(n1087), .D(n831), .Y(n680) );
  OAI22X1 U671 ( .A(n1172), .B(n833), .C(n1087), .D(n832), .Y(n681) );
  OAI22X1 U672 ( .A(n1171), .B(n834), .C(n1087), .D(n833), .Y(n682) );
  OAI22X1 U673 ( .A(n1172), .B(n835), .C(n1087), .D(n834), .Y(n683) );
  OAI22X1 U674 ( .A(n1171), .B(n836), .C(n1087), .D(n835), .Y(n684) );
  OAI22X1 U675 ( .A(n1171), .B(n837), .C(n1087), .D(n836), .Y(n685) );
  OAI22X1 U676 ( .A(n1171), .B(n838), .C(n1087), .D(n837), .Y(n686) );
  OAI22X1 U677 ( .A(n1171), .B(n839), .C(n1087), .D(n838), .Y(n687) );
  OAI22X1 U678 ( .A(n1171), .B(n840), .C(n1087), .D(n839), .Y(n688) );
  OAI22X1 U679 ( .A(n1087), .B(n840), .C(n1171), .D(n841), .Y(n689) );
  AND2X1 U680 ( .A(n1223), .B(n1170), .Y(n690) );
  XNOR2X1 U682 ( .A(n1219), .B(n1229), .Y(n826) );
  XNOR2X1 U683 ( .A(n1217), .B(n1115), .Y(n827) );
  XNOR2X1 U684 ( .A(n1215), .B(n1229), .Y(n828) );
  XNOR2X1 U685 ( .A(n1213), .B(n1229), .Y(n829) );
  XNOR2X1 U687 ( .A(n1209), .B(n1115), .Y(n831) );
  XNOR2X1 U688 ( .A(n1207), .B(n1114), .Y(n832) );
  XNOR2X1 U689 ( .A(n1205), .B(n1114), .Y(n833) );
  XNOR2X1 U690 ( .A(n1203), .B(n1229), .Y(n834) );
  XNOR2X1 U691 ( .A(n1201), .B(n1115), .Y(n835) );
  XNOR2X1 U692 ( .A(n1199), .B(n1114), .Y(n836) );
  XNOR2X1 U693 ( .A(n1197), .B(n1115), .Y(n837) );
  XNOR2X1 U694 ( .A(n1023), .B(n1115), .Y(n838) );
  XNOR2X1 U695 ( .A(n1193), .B(n1114), .Y(n839) );
  XNOR2X1 U696 ( .A(n1191), .B(n1229), .Y(n840) );
  XNOR2X1 U697 ( .A(n1007), .B(n1229), .Y(n841) );
  OAI22X1 U700 ( .A(n1228), .B(n1168), .C(n1166), .D(n859), .Y(n571) );
  OAI22X1 U703 ( .A(n1228), .B(n1167), .C(n1169), .D(n843), .Y(n692) );
  OAI22X1 U704 ( .A(n1169), .B(n844), .C(n1167), .D(n843), .Y(n693) );
  OAI22X1 U705 ( .A(n1169), .B(n845), .C(n1166), .D(n844), .Y(n694) );
  OAI22X1 U706 ( .A(n1169), .B(n846), .C(n1167), .D(n845), .Y(n695) );
  OAI22X1 U707 ( .A(n1168), .B(n847), .C(n1166), .D(n846), .Y(n696) );
  OAI22X1 U708 ( .A(n1168), .B(n848), .C(n1167), .D(n847), .Y(n697) );
  OAI22X1 U709 ( .A(n1168), .B(n849), .C(n1166), .D(n848), .Y(n698) );
  OAI22X1 U710 ( .A(n1168), .B(n850), .C(n1167), .D(n849), .Y(n699) );
  OAI22X1 U711 ( .A(n1168), .B(n851), .C(n1166), .D(n850), .Y(n700) );
  OAI22X1 U712 ( .A(n1168), .B(n852), .C(n1167), .D(n851), .Y(n701) );
  OAI22X1 U713 ( .A(n1168), .B(n853), .C(n1166), .D(n852), .Y(n702) );
  OAI22X1 U714 ( .A(n1168), .B(n854), .C(n1167), .D(n853), .Y(n703) );
  OAI22X1 U715 ( .A(n1168), .B(n855), .C(n1166), .D(n854), .Y(n704) );
  OAI22X1 U716 ( .A(n1168), .B(n856), .C(n1167), .D(n855), .Y(n705) );
  OAI22X1 U717 ( .A(n1168), .B(n857), .C(n1166), .D(n856), .Y(n706) );
  OAI22X1 U718 ( .A(n1166), .B(n857), .C(n1168), .D(n858), .Y(n707) );
  AND2X1 U719 ( .A(n1223), .B(n561), .Y(n708) );
  XNOR2X1 U721 ( .A(n1219), .B(n1000), .Y(n843) );
  XNOR2X1 U722 ( .A(n1217), .B(n1000), .Y(n844) );
  XNOR2X1 U723 ( .A(n1215), .B(n1000), .Y(n845) );
  XNOR2X1 U724 ( .A(n1213), .B(n1000), .Y(n846) );
  XNOR2X1 U725 ( .A(n1211), .B(n1001), .Y(n847) );
  XNOR2X1 U726 ( .A(n1209), .B(n1001), .Y(n848) );
  XNOR2X1 U727 ( .A(n1207), .B(n1001), .Y(n849) );
  XNOR2X1 U728 ( .A(n1205), .B(n1001), .Y(n850) );
  XNOR2X1 U729 ( .A(n1203), .B(n1001), .Y(n851) );
  XNOR2X1 U730 ( .A(n1201), .B(n1001), .Y(n852) );
  XNOR2X1 U731 ( .A(n1199), .B(n1001), .Y(n853) );
  XNOR2X1 U732 ( .A(n1197), .B(n1001), .Y(n854) );
  XNOR2X1 U733 ( .A(n1023), .B(n1001), .Y(n855) );
  XNOR2X1 U734 ( .A(n1193), .B(n1001), .Y(n856) );
  XNOR2X1 U735 ( .A(n1191), .B(n1001), .Y(n857) );
  XNOR2X1 U736 ( .A(n1008), .B(n1001), .Y(n858) );
  OAI22X1 U739 ( .A(n1226), .B(n1073), .C(n917), .D(n876), .Y(n572) );
  OAI22X1 U742 ( .A(n917), .B(n1226), .C(n1164), .D(n860), .Y(n710) );
  OAI22X1 U743 ( .A(n1164), .B(n861), .C(n917), .D(n860), .Y(n711) );
  OAI22X1 U744 ( .A(n1073), .B(n862), .C(n917), .D(n861), .Y(n712) );
  OAI22X1 U745 ( .A(n1164), .B(n863), .C(n917), .D(n862), .Y(n713) );
  OAI22X1 U746 ( .A(n1164), .B(n864), .C(n917), .D(n863), .Y(n714) );
  OAI22X1 U747 ( .A(n1164), .B(n865), .C(n917), .D(n864), .Y(n715) );
  OAI22X1 U748 ( .A(n1073), .B(n866), .C(n917), .D(n865), .Y(n716) );
  OAI22X1 U749 ( .A(n1164), .B(n867), .C(n917), .D(n866), .Y(n717) );
  OAI22X1 U750 ( .A(n1050), .B(n868), .C(n917), .D(n867), .Y(n718) );
  OAI22X1 U751 ( .A(n1050), .B(n869), .C(n917), .D(n868), .Y(n719) );
  OAI22X1 U752 ( .A(n1164), .B(n870), .C(n917), .D(n869), .Y(n720) );
  OAI22X1 U753 ( .A(n1073), .B(n871), .C(n917), .D(n870), .Y(n721) );
  OAI22X1 U754 ( .A(n1050), .B(n872), .C(n917), .D(n871), .Y(n722) );
  OAI22X1 U755 ( .A(n1050), .B(n873), .C(n917), .D(n872), .Y(n723) );
  OAI22X1 U756 ( .A(n1050), .B(n874), .C(n917), .D(n873), .Y(n724) );
  OAI22X1 U757 ( .A(n917), .B(n874), .C(n1050), .D(n875), .Y(n725) );
  XNOR2X1 U758 ( .A(n1219), .B(n1152), .Y(n860) );
  XNOR2X1 U759 ( .A(n1217), .B(n1152), .Y(n861) );
  XNOR2X1 U760 ( .A(n1215), .B(n1152), .Y(n862) );
  XNOR2X1 U761 ( .A(n1213), .B(n1152), .Y(n863) );
  XNOR2X1 U762 ( .A(n1211), .B(n1152), .Y(n864) );
  XNOR2X1 U763 ( .A(n1209), .B(n1152), .Y(n865) );
  XNOR2X1 U764 ( .A(n1207), .B(n1225), .Y(n866) );
  XNOR2X1 U765 ( .A(n1205), .B(n1225), .Y(n867) );
  XNOR2X1 U766 ( .A(n1203), .B(n1225), .Y(n868) );
  XNOR2X1 U767 ( .A(n1201), .B(n1225), .Y(n869) );
  XNOR2X1 U768 ( .A(n1199), .B(n1225), .Y(n870) );
  XNOR2X1 U769 ( .A(n1197), .B(n1225), .Y(n871) );
  XNOR2X1 U770 ( .A(n1023), .B(n1225), .Y(n872) );
  XNOR2X1 U771 ( .A(n1193), .B(n1225), .Y(n873) );
  XNOR2X1 U772 ( .A(n1191), .B(n1225), .Y(n874) );
  XNOR2X1 U773 ( .A(n1007), .B(n1225), .Y(n875) );
  XOR2X1 U805 ( .A(n37), .B(a[27]), .Y(n894) );
  XOR2X1 U811 ( .A(n25), .B(a[23]), .Y(n896) );
  NAND2X1 U813 ( .A(n897), .B(n1150), .Y(n24) );
  XOR2X1 U814 ( .A(n19), .B(a[21]), .Y(n897) );
  XOR2X1 U817 ( .A(n13), .B(a[19]), .Y(n898) );
  XNOR2X1 U818 ( .A(n7), .B(a[19]), .Y(n16) );
  XNOR2X1 U821 ( .A(n1), .B(a[17]), .Y(n9) );
  NAND2X1 U822 ( .A(n917), .B(n900), .Y(n6) );
  INVX8 U828 ( .A(n1214), .Y(n1215) );
  INVX8 U829 ( .A(n1170), .Y(n1087) );
  INVX4 U830 ( .A(n1079), .Y(n1187) );
  BUFX4 U831 ( .A(n452), .Y(n995) );
  INVX4 U832 ( .A(n1045), .Y(n1169) );
  INVX8 U833 ( .A(n1134), .Y(n1186) );
  INVX4 U834 ( .A(n24), .Y(n1175) );
  INVX4 U835 ( .A(n40), .Y(n1181) );
  INVX2 U836 ( .A(n1136), .Y(n1150) );
  BUFX2 U837 ( .A(n393), .Y(n996) );
  BUFX2 U838 ( .A(n383), .Y(n997) );
  INVX8 U839 ( .A(n1200), .Y(n1201) );
  INVX4 U840 ( .A(n886), .Y(n1200) );
  INVX8 U841 ( .A(n1148), .Y(n1183) );
  INVX4 U842 ( .A(n738), .Y(n1023) );
  INVX4 U843 ( .A(n1195), .Y(n738) );
  BUFX4 U844 ( .A(n503), .Y(n998) );
  INVX8 U845 ( .A(n1230), .Y(n1229) );
  INVX4 U846 ( .A(n13), .Y(n1230) );
  INVX8 U847 ( .A(n1227), .Y(n999) );
  INVX8 U848 ( .A(n999), .Y(n1000) );
  INVX8 U849 ( .A(n999), .Y(n1001) );
  INVX8 U850 ( .A(n1212), .Y(n1213) );
  INVX4 U851 ( .A(n880), .Y(n1212) );
  INVX8 U852 ( .A(n1238), .Y(n1237) );
  INVX8 U853 ( .A(n37), .Y(n1238) );
  INVX4 U854 ( .A(n1144), .Y(n1145) );
  INVX2 U855 ( .A(n385), .Y(n386) );
  INVX2 U856 ( .A(n541), .Y(n1220) );
  INVX2 U857 ( .A(n19), .Y(n1232) );
  INVX4 U858 ( .A(n1228), .Y(n1227) );
  INVX4 U859 ( .A(n7), .Y(n1228) );
  INVX2 U860 ( .A(n563), .Y(n1144) );
  BUFX2 U861 ( .A(n1232), .Y(n1027) );
  INVX2 U862 ( .A(n1221), .Y(n1088) );
  INVX4 U863 ( .A(n1206), .Y(n1207) );
  INVX4 U864 ( .A(n1204), .Y(n1205) );
  INVX2 U865 ( .A(n884), .Y(n1204) );
  BUFX2 U866 ( .A(n439), .Y(n1140) );
  BUFX2 U867 ( .A(n424), .Y(n1137) );
  BUFX2 U868 ( .A(n417), .Y(n1141) );
  INVX2 U869 ( .A(n1235), .Y(n1048) );
  INVX2 U870 ( .A(n881), .Y(n1210) );
  INVX4 U871 ( .A(n1017), .Y(n1180) );
  INVX2 U872 ( .A(n1060), .Y(n1172) );
  BUFX2 U873 ( .A(n368), .Y(n1138) );
  INVX2 U874 ( .A(n366), .Y(n1005) );
  INVX2 U875 ( .A(n1025), .Y(n1026) );
  BUFX2 U876 ( .A(n437), .Y(n1002) );
  INVX1 U877 ( .A(n362), .Y(n1003) );
  INVX1 U878 ( .A(n1003), .Y(n1004) );
  XNOR2X1 U879 ( .A(n1064), .B(n364), .Y(n362) );
  XOR2X1 U880 ( .A(n1005), .B(n1014), .Y(n1064) );
  INVX8 U881 ( .A(n1113), .Y(n1006) );
  INVX8 U882 ( .A(n1006), .Y(n1007) );
  INVX8 U883 ( .A(n1006), .Y(n1008) );
  XOR2X1 U884 ( .A(n437), .B(n441), .Y(n1009) );
  XOR2X1 U885 ( .A(n428), .B(n1009), .Y(n422) );
  NAND2X1 U886 ( .A(n428), .B(n1002), .Y(n1010) );
  NAND2X1 U887 ( .A(n428), .B(n441), .Y(n1011) );
  NAND2X1 U888 ( .A(n1002), .B(n441), .Y(n1012) );
  NAND3X1 U889 ( .A(n1011), .B(n1010), .C(n1012), .Y(n421) );
  BUFX4 U890 ( .A(n431), .Y(n1013) );
  BUFX4 U891 ( .A(n375), .Y(n1014) );
  BUFX4 U892 ( .A(n438), .Y(n1015) );
  INVX2 U893 ( .A(n1163), .Y(n1164) );
  INVX2 U894 ( .A(n1063), .Y(n1047) );
  INVX2 U895 ( .A(n1063), .Y(n1049) );
  OR2X2 U896 ( .A(n308), .B(n313), .Y(n1016) );
  AND2X2 U897 ( .A(n895), .B(n1058), .Y(n1017) );
  AND2X2 U898 ( .A(n169), .B(n283), .Y(n1018) );
  AND2X2 U899 ( .A(n178), .B(n284), .Y(n1019) );
  XNOR2X1 U900 ( .A(n19), .B(a[23]), .Y(n1020) );
  INVX4 U901 ( .A(n1192), .Y(n1193) );
  INVX2 U902 ( .A(n890), .Y(n1192) );
  INVX4 U903 ( .A(n1198), .Y(n1199) );
  INVX2 U904 ( .A(n887), .Y(n1198) );
  INVX4 U905 ( .A(n1208), .Y(n1209) );
  INVX2 U906 ( .A(n882), .Y(n1208) );
  INVX4 U907 ( .A(n1076), .Y(n1077) );
  INVX2 U908 ( .A(n1184), .Y(n1076) );
  INVX4 U909 ( .A(n1190), .Y(n1191) );
  INVX2 U910 ( .A(n879), .Y(n1214) );
  INVX4 U911 ( .A(n1216), .Y(n1217) );
  INVX4 U912 ( .A(n1218), .Y(n1219) );
  INVX2 U913 ( .A(n877), .Y(n1218) );
  OR2X2 U914 ( .A(n292), .B(n293), .Y(n1021) );
  OR2X2 U915 ( .A(n1007), .B(n1238), .Y(n774) );
  OR2X2 U916 ( .A(n1007), .B(n1048), .Y(n791) );
  OR2X2 U917 ( .A(n1008), .B(n1027), .Y(n825) );
  XOR2X1 U918 ( .A(n1211), .B(n1230), .Y(n830) );
  XNOR2X1 U919 ( .A(n1236), .B(a[25]), .Y(n895) );
  INVX4 U920 ( .A(n31), .Y(n1236) );
  BUFX2 U921 ( .A(n1186), .Y(n1022) );
  BUFX2 U922 ( .A(n137), .Y(n1139) );
  INVX4 U923 ( .A(n1194), .Y(n1195) );
  XOR2X1 U924 ( .A(n1195), .B(n1238), .Y(n770) );
  INVX4 U925 ( .A(n1230), .Y(n1115) );
  INVX2 U926 ( .A(n1017), .Y(n1179) );
  XNOR2X1 U927 ( .A(n1024), .B(n404), .Y(n402) );
  XNOR2X1 U928 ( .A(n1141), .B(n406), .Y(n1024) );
  INVX1 U929 ( .A(n1077), .Y(n1025) );
  INVX1 U930 ( .A(n182), .Y(n285) );
  AND2X2 U931 ( .A(n1223), .B(n1181), .Y(n618) );
  INVX8 U932 ( .A(n1181), .Y(n1182) );
  INVX2 U933 ( .A(n436), .Y(n1028) );
  INVX4 U934 ( .A(n1028), .Y(n1029) );
  INVX1 U935 ( .A(n1205), .Y(n733) );
  XNOR2X1 U936 ( .A(n86), .B(n1030), .Y(product[45]) );
  AND2X2 U937 ( .A(n85), .B(n275), .Y(n1030) );
  XOR2X1 U938 ( .A(n421), .B(n408), .Y(n1031) );
  XOR2X1 U939 ( .A(n1031), .B(n419), .Y(n404) );
  NAND2X1 U940 ( .A(n421), .B(n408), .Y(n1032) );
  NAND2X1 U941 ( .A(n421), .B(n419), .Y(n1033) );
  NAND2X1 U942 ( .A(n408), .B(n419), .Y(n1034) );
  NAND3X1 U943 ( .A(n1032), .B(n1033), .C(n1034), .Y(n403) );
  NAND2X1 U944 ( .A(n1141), .B(n406), .Y(n1035) );
  NAND2X1 U945 ( .A(n1141), .B(n404), .Y(n1036) );
  NAND2X1 U946 ( .A(n406), .B(n404), .Y(n1037) );
  NAND3X1 U947 ( .A(n1035), .B(n1036), .C(n1037), .Y(n401) );
  XOR2X1 U948 ( .A(n426), .B(n1140), .Y(n1038) );
  XOR2X1 U949 ( .A(n1137), .B(n1038), .Y(n420) );
  NAND2X1 U950 ( .A(n1137), .B(n426), .Y(n1039) );
  NAND2X1 U951 ( .A(n1137), .B(n1140), .Y(n1040) );
  NAND2X1 U952 ( .A(n426), .B(n1140), .Y(n1041) );
  NAND3X1 U953 ( .A(n1040), .B(n1039), .C(n1041), .Y(n419) );
  INVX1 U954 ( .A(n1185), .Y(n543) );
  XNOR2X1 U955 ( .A(a[15]), .B(n1042), .Y(n900) );
  INVX2 U956 ( .A(n1), .Y(n1042) );
  XNOR2X1 U957 ( .A(n1220), .B(a[29]), .Y(n893) );
  INVX2 U958 ( .A(n1220), .Y(n1222) );
  XOR2X1 U959 ( .A(n19), .B(a[23]), .Y(n1043) );
  INVX1 U960 ( .A(n1175), .Y(n1044) );
  AND2X2 U961 ( .A(n1046), .B(n9), .Y(n1045) );
  XNOR2X1 U962 ( .A(n7), .B(n1059), .Y(n1046) );
  INVX2 U963 ( .A(n9), .Y(n1165) );
  INVX4 U964 ( .A(n885), .Y(n1202) );
  INVX4 U965 ( .A(n1226), .Y(n1152) );
  INVX2 U966 ( .A(n1236), .Y(n1074) );
  INVX1 U967 ( .A(n896), .Y(n1057) );
  INVX4 U968 ( .A(n25), .Y(n1234) );
  INVX1 U969 ( .A(n161), .Y(n282) );
  BUFX2 U970 ( .A(n1164), .Y(n1050) );
  XOR2X1 U971 ( .A(n630), .B(n582), .Y(n1051) );
  XOR2X1 U972 ( .A(n614), .B(n1051), .Y(n442) );
  NAND2X1 U973 ( .A(n614), .B(n630), .Y(n1052) );
  NAND2X1 U974 ( .A(n614), .B(n582), .Y(n1053) );
  NAND2X1 U975 ( .A(n630), .B(n582), .Y(n1054) );
  NAND3X1 U976 ( .A(n1053), .B(n1052), .C(n1054), .Y(n441) );
  AND2X2 U977 ( .A(n1223), .B(n1222), .Y(n582) );
  INVX1 U978 ( .A(n1144), .Y(n1055) );
  OR2X2 U979 ( .A(n1057), .B(n1043), .Y(n1056) );
  INVX1 U980 ( .A(n1056), .Y(n1062) );
  XNOR2X1 U981 ( .A(n25), .B(a[25]), .Y(n1058) );
  INVX2 U982 ( .A(n1058), .Y(n1135) );
  INVX1 U983 ( .A(a[17]), .Y(n1059) );
  INVX2 U984 ( .A(n796), .Y(n1160) );
  INVX1 U985 ( .A(n210), .Y(n289) );
  AND2X2 U986 ( .A(n898), .B(n16), .Y(n1060) );
  AND2X2 U987 ( .A(n898), .B(n16), .Y(n1061) );
  INVX1 U988 ( .A(n1143), .Y(n155) );
  AND2X2 U989 ( .A(n896), .B(n1020), .Y(n1063) );
  INVX2 U990 ( .A(n1165), .Y(n1167) );
  XOR2X1 U991 ( .A(n698), .B(n499), .Y(n1065) );
  XOR2X1 U992 ( .A(n1065), .B(n497), .Y(n486) );
  NAND2X1 U993 ( .A(n698), .B(n499), .Y(n1066) );
  NAND2X1 U994 ( .A(n698), .B(n497), .Y(n1067) );
  NAND2X1 U995 ( .A(n499), .B(n497), .Y(n1068) );
  NAND3X1 U996 ( .A(n1066), .B(n1067), .C(n1068), .Y(n485) );
  XOR2X1 U997 ( .A(n476), .B(n478), .Y(n1069) );
  XOR2X1 U998 ( .A(n1069), .B(n485), .Y(n472) );
  NAND2X1 U999 ( .A(n476), .B(n478), .Y(n1070) );
  NAND2X1 U1000 ( .A(n476), .B(n485), .Y(n1071) );
  NAND2X1 U1001 ( .A(n478), .B(n485), .Y(n1072) );
  NAND3X1 U1002 ( .A(n1070), .B(n1071), .C(n1072), .Y(n471) );
  INVX2 U1003 ( .A(n1), .Y(n1226) );
  OR2X2 U1004 ( .A(n1008), .B(n1226), .Y(n876) );
  OR2X2 U1005 ( .A(n1008), .B(n1078), .Y(n808) );
  OR2X2 U1006 ( .A(n1007), .B(n1162), .Y(n842) );
  OR2X2 U1007 ( .A(n1008), .B(n1228), .Y(n859) );
  XNOR2X1 U1008 ( .A(n179), .B(n1019), .Y(product[36]) );
  INVX2 U1009 ( .A(n1115), .Y(n1162) );
  INVX1 U1010 ( .A(n1163), .Y(n1073) );
  INVX2 U1011 ( .A(n6), .Y(n1163) );
  INVX4 U1012 ( .A(n1226), .Y(n1225) );
  INVX2 U1013 ( .A(n1133), .Y(n1185) );
  INVX2 U1014 ( .A(n1236), .Y(n1075) );
  INVX2 U1015 ( .A(n891), .Y(n1190) );
  INVX8 U1016 ( .A(n1234), .Y(n1233) );
  INVX1 U1017 ( .A(n1133), .Y(n1184) );
  INVX2 U1018 ( .A(n16), .Y(n1170) );
  INVX1 U1019 ( .A(n1233), .Y(n1078) );
  AND2X2 U1020 ( .A(n1185), .B(n893), .Y(n1079) );
  INVX2 U1021 ( .A(n396), .Y(n1080) );
  INVX4 U1022 ( .A(n1080), .Y(n1081) );
  BUFX2 U1023 ( .A(n37), .Y(n1082) );
  INVX1 U1024 ( .A(n222), .Y(n221) );
  INVX4 U1025 ( .A(n1043), .Y(n1177) );
  XOR2X1 U1026 ( .A(n403), .B(n392), .Y(n1083) );
  XOR2X1 U1027 ( .A(n390), .B(n1083), .Y(n388) );
  NAND2X1 U1028 ( .A(n390), .B(n403), .Y(n1084) );
  NAND2X1 U1029 ( .A(n390), .B(n392), .Y(n1085) );
  NAND2X1 U1030 ( .A(n403), .B(n392), .Y(n1086) );
  NAND3X1 U1031 ( .A(n1085), .B(n1084), .C(n1086), .Y(n387) );
  XOR2X1 U1032 ( .A(n1007), .B(n1088), .Y(n756) );
  INVX4 U1033 ( .A(n1220), .Y(n1221) );
  XNOR2X1 U1034 ( .A(a[27]), .B(n31), .Y(n40) );
  XOR2X1 U1035 ( .A(n459), .B(n448), .Y(n1089) );
  XOR2X1 U1036 ( .A(n1089), .B(n446), .Y(n444) );
  NAND2X1 U1037 ( .A(n446), .B(n459), .Y(n1090) );
  NAND2X1 U1038 ( .A(n446), .B(n448), .Y(n1091) );
  NAND2X1 U1039 ( .A(n459), .B(n448), .Y(n1092) );
  NAND3X1 U1040 ( .A(n1091), .B(n1090), .C(n1092), .Y(n443) );
  XNOR2X1 U1041 ( .A(n170), .B(n1018), .Y(product[37]) );
  XOR2X1 U1042 ( .A(n1138), .B(n379), .Y(n1093) );
  XOR2X1 U1043 ( .A(n1093), .B(n377), .Y(n364) );
  NAND2X1 U1044 ( .A(n1138), .B(n379), .Y(n1094) );
  NAND2X1 U1045 ( .A(n1138), .B(n377), .Y(n1095) );
  NAND2X1 U1046 ( .A(n379), .B(n377), .Y(n1096) );
  NAND3X1 U1047 ( .A(n1094), .B(n1095), .C(n1096), .Y(n363) );
  NAND2X1 U1048 ( .A(n366), .B(n1014), .Y(n1097) );
  NAND2X1 U1049 ( .A(n366), .B(n364), .Y(n1098) );
  NAND2X1 U1050 ( .A(n1014), .B(n364), .Y(n1099) );
  NAND3X1 U1051 ( .A(n1097), .B(n1098), .C(n1099), .Y(n361) );
  INVX1 U1052 ( .A(n1188), .Y(n1100) );
  NOR2X1 U1053 ( .A(n416), .B(n429), .Y(n1101) );
  XOR2X1 U1054 ( .A(n336), .B(n345), .Y(n1102) );
  XOR2X1 U1055 ( .A(n334), .B(n1102), .Y(n332) );
  NAND2X1 U1056 ( .A(n334), .B(n336), .Y(n1103) );
  NAND2X1 U1057 ( .A(n334), .B(n345), .Y(n1104) );
  NAND2X1 U1058 ( .A(n336), .B(n345), .Y(n1105) );
  NAND3X1 U1059 ( .A(n1104), .B(n1103), .C(n1105), .Y(n331) );
  OR2X2 U1060 ( .A(n339), .B(n330), .Y(n1106) );
  INVX1 U1061 ( .A(n1106), .Y(n148) );
  INVX2 U1062 ( .A(n883), .Y(n1206) );
  XOR2X1 U1063 ( .A(n1145), .B(n580), .Y(n1107) );
  XOR2X1 U1064 ( .A(n644), .B(n1107), .Y(n414) );
  NAND2X1 U1065 ( .A(n644), .B(n1055), .Y(n1108) );
  NAND2X1 U1066 ( .A(n644), .B(n580), .Y(n1109) );
  NAND2X1 U1067 ( .A(n1055), .B(n580), .Y(n1110) );
  NAND3X1 U1068 ( .A(n1109), .B(n1108), .C(n1110), .Y(n413) );
  BUFX4 U1069 ( .A(n53), .Y(n1143) );
  BUFX2 U1070 ( .A(n359), .Y(n1112) );
  INVX2 U1071 ( .A(n283), .Y(n1111) );
  BUFX4 U1072 ( .A(n49), .Y(n1113) );
  INVX1 U1073 ( .A(n49), .Y(n1224) );
  INVX2 U1074 ( .A(n1230), .Y(n1114) );
  OR2X2 U1075 ( .A(n481), .B(n470), .Y(n1119) );
  OR2X2 U1076 ( .A(n137), .B(n80), .Y(n1117) );
  INVX4 U1077 ( .A(n1135), .Y(n1178) );
  INVX8 U1078 ( .A(n1175), .Y(n1176) );
  OR2X2 U1079 ( .A(n322), .B(n329), .Y(n1118) );
  INVX2 U1080 ( .A(n765), .Y(n1154) );
  INVX8 U1081 ( .A(a[15]), .Y(n917) );
  OR2X2 U1082 ( .A(n302), .B(n307), .Y(n1121) );
  INVX2 U1083 ( .A(n878), .Y(n1216) );
  INVX1 U1084 ( .A(n1207), .Y(n732) );
  INVX1 U1085 ( .A(n1211), .Y(n730) );
  BUFX4 U1086 ( .A(n1220), .Y(n1116) );
  AND2X2 U1087 ( .A(n481), .B(n470), .Y(n1120) );
  OR2X1 U1088 ( .A(n533), .B(n530), .Y(n1122) );
  OR2X1 U1089 ( .A(n523), .B(n518), .Y(n1123) );
  AND2X2 U1090 ( .A(n491), .B(n482), .Y(n1124) );
  OR2X1 U1091 ( .A(n491), .B(n482), .Y(n1125) );
  AND2X2 U1092 ( .A(n523), .B(n518), .Y(n1126) );
  AND2X2 U1093 ( .A(n533), .B(n530), .Y(n1127) );
  INVX2 U1094 ( .A(n1159), .Y(n642) );
  INVX2 U1095 ( .A(n1156), .Y(n594) );
  OR2X1 U1096 ( .A(n539), .B(n538), .Y(n1128) );
  OR2X1 U1097 ( .A(n708), .B(n724), .Y(n1129) );
  AND2X2 U1098 ( .A(n708), .B(n724), .Y(n1130) );
  AND2X2 U1099 ( .A(n539), .B(n538), .Y(n1131) );
  XNOR2X1 U1100 ( .A(n542), .B(n573), .Y(n291) );
  AND2X2 U1101 ( .A(n1221), .B(n1197), .Y(n385) );
  INVX2 U1102 ( .A(n551), .Y(n637) );
  INVX2 U1103 ( .A(n545), .Y(n601) );
  INVX2 U1104 ( .A(n548), .Y(n619) );
  INVX2 U1105 ( .A(n795), .Y(n1161) );
  INVX2 U1106 ( .A(n750), .Y(n1158) );
  INVX2 U1107 ( .A(n751), .Y(n1157) );
  INVX2 U1108 ( .A(n764), .Y(n1155) );
  INVX4 U1109 ( .A(n1045), .Y(n1168) );
  INVX2 U1110 ( .A(n1224), .Y(n1223) );
  AND2X2 U1111 ( .A(n572), .B(n725), .Y(n1132) );
  INVX4 U1112 ( .A(n888), .Y(n1196) );
  INVX2 U1113 ( .A(n889), .Y(n1194) );
  XOR2X1 U1114 ( .A(n37), .B(a[29]), .Y(n1133) );
  AND2X2 U1115 ( .A(n1185), .B(n893), .Y(n1134) );
  XOR2X1 U1116 ( .A(n13), .B(a[21]), .Y(n1136) );
  INVX2 U1117 ( .A(n1165), .Y(n1166) );
  INVX2 U1118 ( .A(n1136), .Y(n1173) );
  INVX1 U1119 ( .A(n100), .Y(n98) );
  INVX1 U1120 ( .A(n128), .Y(n126) );
  INVX2 U1121 ( .A(n554), .Y(n655) );
  INVX8 U1122 ( .A(n1232), .Y(n1231) );
  INVX1 U1123 ( .A(n189), .Y(n286) );
  INVX1 U1124 ( .A(n200), .Y(n202) );
  INVX1 U1125 ( .A(n199), .Y(n201) );
  INVX1 U1126 ( .A(n216), .Y(n290) );
  INVX1 U1127 ( .A(n205), .Y(n288) );
  BUFX2 U1128 ( .A(n53), .Y(n1142) );
  BUFX2 U1129 ( .A(n52), .Y(n1146) );
  BUFX4 U1130 ( .A(n52), .Y(n1147) );
  INVX4 U1131 ( .A(n1236), .Y(n1235) );
  AND2X2 U1132 ( .A(n894), .B(n40), .Y(n1148) );
  AND2X2 U1133 ( .A(n894), .B(n1182), .Y(n1149) );
  INVX2 U1134 ( .A(n1136), .Y(n1174) );
  INVX4 U1135 ( .A(n51), .Y(n1188) );
  BUFX2 U1136 ( .A(n1176), .Y(n1151) );
  INVX2 U1137 ( .A(n1177), .Y(n552) );
  INVX2 U1138 ( .A(n1153), .Y(n609) );
  INVX2 U1139 ( .A(n560), .Y(n691) );
  AOI22X1 U1140 ( .A(n1149), .B(n1154), .C(n1181), .D(n1155), .Y(n1153) );
  AOI22X1 U1141 ( .A(n1079), .B(n1157), .C(n1076), .D(n1158), .Y(n1156) );
  INVX4 U1142 ( .A(n1061), .Y(n1171) );
  AOI22X1 U1143 ( .A(n1062), .B(n1160), .C(n552), .D(n1161), .Y(n1159) );
  INVX2 U1144 ( .A(n557), .Y(n673) );
  INVX1 U1145 ( .A(n172), .Y(n174) );
  INVX1 U1146 ( .A(n166), .Y(n283) );
  INVX1 U1147 ( .A(n171), .Y(n173) );
  INVX1 U1148 ( .A(n194), .Y(n287) );
  INVX1 U1149 ( .A(n177), .Y(n284) );
  INVX1 U1150 ( .A(n1147), .Y(n156) );
  INVX8 U1151 ( .A(n1188), .Y(n1189) );
  INVX8 U1152 ( .A(n1196), .Y(n1197) );
  INVX8 U1153 ( .A(n1202), .Y(n1203) );
  INVX8 U1154 ( .A(n1210), .Y(n1211) );
  INVX2 U1155 ( .A(n101), .Y(n99) );
  INVX2 U1156 ( .A(n94), .Y(n92) );
  INVX2 U1157 ( .A(n79), .Y(n77) );
  INVX2 U1158 ( .A(n1203), .Y(n734) );
  OAI22X1 U1159 ( .A(n917), .B(n1226), .C(n1226), .D(n6), .Y(n563) );
  INVX2 U1160 ( .A(n1166), .Y(n561) );
  OAI22X1 U1161 ( .A(n1167), .B(n1228), .C(n1169), .D(n1228), .Y(n560) );
  OAI22X1 U1162 ( .A(n1087), .B(n1162), .C(n1172), .D(n1162), .Y(n557) );
  INVX2 U1163 ( .A(n1173), .Y(n555) );
  OAI22X1 U1164 ( .A(n1173), .B(n1027), .C(n1176), .D(n1027), .Y(n554) );
  OAI22X1 U1165 ( .A(n1177), .B(n1078), .C(n1047), .D(n1078), .Y(n551) );
  OAI22X1 U1166 ( .A(n1178), .B(n1048), .C(n1179), .D(n1048), .Y(n548) );
  OAI22X1 U1167 ( .A(n1182), .B(n1238), .C(n1183), .D(n1238), .Y(n545) );
  OAI22X1 U1168 ( .A(n1026), .B(n1116), .C(n1022), .D(n1116), .Y(n542) );
  INVX2 U1169 ( .A(n359), .Y(n360) );
  INVX2 U1170 ( .A(n337), .Y(n338) );
  INVX2 U1171 ( .A(n319), .Y(n320) );
  INVX2 U1172 ( .A(n305), .Y(n306) );
  INVX2 U1173 ( .A(n295), .Y(n296) );
  INVX2 U1174 ( .A(n130), .Y(n279) );
  INVX2 U1175 ( .A(n93), .Y(n91) );
  INVX2 U1176 ( .A(n84), .Y(n275) );
  INVX2 U1177 ( .A(n213), .Y(n212) );
  INVX2 U1178 ( .A(n211), .Y(n209) );
  INVX2 U1179 ( .A(n183), .Y(n181) );
  INVX2 U1180 ( .A(n149), .Y(n151) );
  INVX2 U1181 ( .A(n144), .Y(n142) );
  INVX2 U1182 ( .A(n129), .Y(n127) );
  INVX2 U1183 ( .A(n122), .Y(n120) );
  INVX2 U1184 ( .A(n111), .Y(n109) );
  INVX2 U1185 ( .A(n105), .Y(n103) );
  INVX2 U1186 ( .A(n104), .Y(n102) );
endmodule


module alu ( src1_data, src2_data, alu_op, result, overflow );
  input [16:0] src1_data;
  input [16:0] src2_data;
  input [1:0] alu_op;
  output [16:0] result;
  output overflow;
  wire   N26, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75;
  wire   [46:30] full_mult;
  wire   [17:0] large_sum;
  wire   [17:0] large_dif;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29;

  alu_DW01_sub_1 sub_44 ( .A({src1_data[16], src1_data[16], n22, 
        src1_data[14:13], n10, n33, n19, n31, n20, n29, n9, src1_data[5:4], n5, 
        n21, src1_data[1:0]}), .B({src2_data[16], src2_data[16], n23, n16, n12, 
        src2_data[12:11], n8, n18, n7, src2_data[7:6], n14, src2_data[4:2], n2, 
        src2_data[0]}), .CI(1'b0), .DIFF(large_dif) );
  alu_DW01_add_1 add_41 ( .A({src1_data[16], src1_data[16], n22, 
        src1_data[14:13], n10, n33, n19, n31, n20, n29, n9, src1_data[5:4], n5, 
        n21, src1_data[1:0]}), .B({src2_data[16], src2_data[16], n23, n16, n12, 
        n4, src2_data[11], n8, n18, n7, src2_data[7], n3, n14, src2_data[4:3], 
        n13, n2, src2_data[0]}), .CI(1'b0), .SUM(large_sum) );
  alu_DW_mult_uns_3 mult_35 ( .a({src1_data[15:0], 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .b(src2_data[15:0]), .product({N26, full_mult[45:30], 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29}) );
  INVX2 U3 ( .A(n30), .Y(n29) );
  INVX2 U4 ( .A(src2_data[1]), .Y(n1) );
  INVX2 U6 ( .A(n1), .Y(n2) );
  BUFX2 U7 ( .A(src2_data[6]), .Y(n3) );
  BUFX2 U9 ( .A(src2_data[12]), .Y(n4) );
  BUFX2 U10 ( .A(src1_data[3]), .Y(n5) );
  INVX1 U11 ( .A(src2_data[8]), .Y(n6) );
  INVX2 U12 ( .A(n6), .Y(n7) );
  BUFX2 U13 ( .A(src2_data[10]), .Y(n8) );
  BUFX2 U14 ( .A(src1_data[6]), .Y(n9) );
  BUFX2 U15 ( .A(src1_data[12]), .Y(n10) );
  INVX1 U16 ( .A(src2_data[13]), .Y(n11) );
  INVX2 U17 ( .A(n11), .Y(n12) );
  BUFX2 U18 ( .A(src2_data[2]), .Y(n13) );
  BUFX2 U19 ( .A(src2_data[5]), .Y(n14) );
  INVX1 U20 ( .A(src2_data[14]), .Y(n15) );
  INVX2 U21 ( .A(n15), .Y(n16) );
  INVX1 U22 ( .A(src1_data[7]), .Y(n30) );
  INVX1 U23 ( .A(src2_data[9]), .Y(n17) );
  INVX2 U24 ( .A(n17), .Y(n18) );
  BUFX2 U25 ( .A(src1_data[10]), .Y(n19) );
  BUFX2 U26 ( .A(src1_data[8]), .Y(n20) );
  BUFX2 U27 ( .A(src1_data[2]), .Y(n21) );
  INVX1 U28 ( .A(src1_data[11]), .Y(n34) );
  INVX1 U29 ( .A(src1_data[9]), .Y(n32) );
  BUFX2 U30 ( .A(src1_data[15]), .Y(n22) );
  INVX2 U31 ( .A(n34), .Y(n33) );
  INVX2 U32 ( .A(n32), .Y(n31) );
  BUFX2 U33 ( .A(src2_data[15]), .Y(n23) );
  INVX2 U34 ( .A(n75), .Y(n70) );
  AND2X2 U35 ( .A(n39), .B(n38), .Y(n24) );
  AND2X2 U36 ( .A(alu_op[1]), .B(n38), .Y(n25) );
  AND2X2 U37 ( .A(alu_op[0]), .B(alu_op[1]), .Y(n26) );
  INVX2 U38 ( .A(large_sum[16]), .Y(n74) );
  XOR2X1 U39 ( .A(n74), .B(large_sum[17]), .Y(n37) );
  INVX2 U40 ( .A(alu_op[1]), .Y(n39) );
  NAND2X1 U41 ( .A(alu_op[0]), .B(n39), .Y(n75) );
  INVX2 U42 ( .A(alu_op[0]), .Y(n38) );
  XOR2X1 U43 ( .A(large_dif[17]), .B(large_dif[16]), .Y(n35) );
  AOI22X1 U44 ( .A(N26), .B(n26), .C(n25), .D(n35), .Y(n36) );
  OAI21X1 U45 ( .A(n37), .B(n75), .C(n36), .Y(overflow) );
  AOI22X1 U46 ( .A(src1_data[0]), .B(n24), .C(full_mult[30]), .D(n26), .Y(n41)
         );
  AOI22X1 U47 ( .A(large_dif[0]), .B(n25), .C(large_sum[0]), .D(n70), .Y(n40)
         );
  NAND2X1 U48 ( .A(n41), .B(n40), .Y(result[0]) );
  AOI22X1 U49 ( .A(src1_data[1]), .B(n24), .C(full_mult[31]), .D(n26), .Y(n43)
         );
  AOI22X1 U50 ( .A(large_dif[1]), .B(n25), .C(large_sum[1]), .D(n70), .Y(n42)
         );
  NAND2X1 U51 ( .A(n43), .B(n42), .Y(result[1]) );
  AOI22X1 U52 ( .A(n21), .B(n24), .C(full_mult[32]), .D(n26), .Y(n45) );
  AOI22X1 U53 ( .A(large_dif[2]), .B(n25), .C(large_sum[2]), .D(n70), .Y(n44)
         );
  NAND2X1 U54 ( .A(n45), .B(n44), .Y(result[2]) );
  AOI22X1 U55 ( .A(n5), .B(n24), .C(full_mult[33]), .D(n26), .Y(n47) );
  AOI22X1 U56 ( .A(large_dif[3]), .B(n25), .C(large_sum[3]), .D(n70), .Y(n46)
         );
  NAND2X1 U57 ( .A(n47), .B(n46), .Y(result[3]) );
  AOI22X1 U58 ( .A(src1_data[4]), .B(n24), .C(full_mult[34]), .D(n26), .Y(n49)
         );
  AOI22X1 U59 ( .A(large_dif[4]), .B(n25), .C(large_sum[4]), .D(n70), .Y(n48)
         );
  NAND2X1 U60 ( .A(n49), .B(n48), .Y(result[4]) );
  AOI22X1 U61 ( .A(src1_data[5]), .B(n24), .C(full_mult[35]), .D(n26), .Y(n51)
         );
  AOI22X1 U62 ( .A(large_dif[5]), .B(n25), .C(large_sum[5]), .D(n70), .Y(n50)
         );
  NAND2X1 U63 ( .A(n51), .B(n50), .Y(result[5]) );
  AOI22X1 U64 ( .A(n9), .B(n24), .C(full_mult[36]), .D(n26), .Y(n53) );
  AOI22X1 U65 ( .A(large_dif[6]), .B(n25), .C(large_sum[6]), .D(n70), .Y(n52)
         );
  NAND2X1 U66 ( .A(n52), .B(n53), .Y(result[6]) );
  AOI22X1 U67 ( .A(n29), .B(n24), .C(full_mult[37]), .D(n26), .Y(n55) );
  AOI22X1 U68 ( .A(large_dif[7]), .B(n25), .C(large_sum[7]), .D(n70), .Y(n54)
         );
  NAND2X1 U69 ( .A(n54), .B(n55), .Y(result[7]) );
  AOI22X1 U70 ( .A(n20), .B(n24), .C(full_mult[38]), .D(n26), .Y(n57) );
  AOI22X1 U71 ( .A(large_dif[8]), .B(n25), .C(large_sum[8]), .D(n70), .Y(n56)
         );
  NAND2X1 U72 ( .A(n56), .B(n57), .Y(result[8]) );
  AOI22X1 U73 ( .A(n31), .B(n24), .C(full_mult[39]), .D(n26), .Y(n59) );
  AOI22X1 U74 ( .A(large_dif[9]), .B(n25), .C(large_sum[9]), .D(n70), .Y(n58)
         );
  NAND2X1 U75 ( .A(n58), .B(n59), .Y(result[9]) );
  AOI22X1 U76 ( .A(n19), .B(n24), .C(full_mult[40]), .D(n26), .Y(n61) );
  AOI22X1 U77 ( .A(large_dif[10]), .B(n25), .C(large_sum[10]), .D(n70), .Y(n60) );
  NAND2X1 U78 ( .A(n60), .B(n61), .Y(result[10]) );
  AOI22X1 U79 ( .A(n33), .B(n24), .C(full_mult[41]), .D(n26), .Y(n63) );
  AOI22X1 U80 ( .A(large_dif[11]), .B(n25), .C(large_sum[11]), .D(n70), .Y(n62) );
  NAND2X1 U81 ( .A(n62), .B(n63), .Y(result[11]) );
  AOI22X1 U82 ( .A(n10), .B(n24), .C(full_mult[42]), .D(n26), .Y(n65) );
  AOI22X1 U83 ( .A(large_dif[12]), .B(n25), .C(large_sum[12]), .D(n70), .Y(n64) );
  NAND2X1 U84 ( .A(n64), .B(n65), .Y(result[12]) );
  AOI22X1 U85 ( .A(src1_data[13]), .B(n24), .C(full_mult[43]), .D(n26), .Y(n67) );
  AOI22X1 U86 ( .A(large_dif[13]), .B(n25), .C(large_sum[13]), .D(n70), .Y(n66) );
  NAND2X1 U87 ( .A(n66), .B(n67), .Y(result[13]) );
  AOI22X1 U88 ( .A(src1_data[14]), .B(n24), .C(full_mult[44]), .D(n26), .Y(n69) );
  AOI22X1 U89 ( .A(large_dif[14]), .B(n25), .C(large_sum[14]), .D(n70), .Y(n68) );
  NAND2X1 U90 ( .A(n68), .B(n69), .Y(result[14]) );
  AOI22X1 U91 ( .A(n22), .B(n24), .C(full_mult[45]), .D(n26), .Y(n72) );
  AOI22X1 U92 ( .A(large_dif[15]), .B(n25), .C(large_sum[15]), .D(n70), .Y(n71) );
  NAND2X1 U93 ( .A(n72), .B(n71), .Y(result[15]) );
  AOI22X1 U94 ( .A(src1_data[16]), .B(n24), .C(large_dif[16]), .D(n25), .Y(n73) );
  OAI21X1 U95 ( .A(n75), .B(n74), .C(n73), .Y(result[16]) );
endmodule


module flex_sreg_NUM_BITS17_15 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX2 U2 ( .A(n1), .Y(n2) );
  INVX2 U3 ( .A(write_enable), .Y(n1) );
  INVX2 U4 ( .A(n4), .Y(n3) );
  INVX2 U5 ( .A(n_reset), .Y(n4) );
  INVX1 U6 ( .A(n14), .Y(n40) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n17), .Y(n34) );
  INVX1 U10 ( .A(n12), .Y(n44) );
  INVX1 U11 ( .A(n15), .Y(n38) );
  INVX1 U12 ( .A(n20), .Y(n30) );
  INVX1 U13 ( .A(n16), .Y(n36) );
  INVX1 U14 ( .A(n18), .Y(n32) );
  INVX1 U15 ( .A(n22), .Y(n28) );
  MUX2X1 U16 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U17 ( .A(n5), .Y(n55) );
  MUX2X1 U18 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U19 ( .A(n6), .Y(n54) );
  MUX2X1 U20 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U21 ( .A(n7), .Y(n53) );
  MUX2X1 U22 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U23 ( .A(n8), .Y(n52) );
  MUX2X1 U24 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U25 ( .A(n9), .Y(n50) );
  MUX2X1 U26 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U27 ( .A(n10), .Y(n48) );
  MUX2X1 U28 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U29 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U30 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U31 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U32 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U33 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U34 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U35 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U36 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_14 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX2 U2 ( .A(n1), .Y(n2) );
  INVX2 U3 ( .A(write_enable), .Y(n1) );
  INVX2 U4 ( .A(n4), .Y(n3) );
  INVX2 U5 ( .A(n_reset), .Y(n4) );
  INVX1 U6 ( .A(n13), .Y(n42) );
  INVX1 U7 ( .A(n12), .Y(n44) );
  INVX1 U8 ( .A(n17), .Y(n34) );
  INVX1 U9 ( .A(n14), .Y(n40) );
  INVX1 U10 ( .A(n11), .Y(n46) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n18), .Y(n32) );
  INVX1 U13 ( .A(n22), .Y(n28) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_13 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n14), .Y(n40) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n18), .Y(n32) );
  INVX1 U13 ( .A(n22), .Y(n28) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_12 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_11 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n14), .Y(n40) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n13), .Y(n42) );
  INVX1 U10 ( .A(n12), .Y(n44) );
  INVX1 U11 ( .A(n17), .Y(n34) );
  INVX1 U12 ( .A(n16), .Y(n36) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_10 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_9 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n14), .Y(n40) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n22), .Y(n28) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_8 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_7 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n14), .Y(n40) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n13), .Y(n42) );
  INVX1 U10 ( .A(n12), .Y(n44) );
  INVX1 U11 ( .A(n17), .Y(n34) );
  INVX1 U12 ( .A(n16), .Y(n36) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_6 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX2 U2 ( .A(n1), .Y(n2) );
  INVX2 U3 ( .A(write_enable), .Y(n1) );
  INVX2 U4 ( .A(n4), .Y(n3) );
  INVX2 U5 ( .A(n_reset), .Y(n4) );
  INVX1 U6 ( .A(n11), .Y(n46) );
  INVX1 U7 ( .A(n13), .Y(n42) );
  INVX1 U8 ( .A(n12), .Y(n44) );
  INVX1 U9 ( .A(n17), .Y(n34) );
  INVX1 U10 ( .A(n16), .Y(n36) );
  INVX1 U11 ( .A(n14), .Y(n40) );
  INVX1 U12 ( .A(n18), .Y(n32) );
  INVX1 U13 ( .A(n22), .Y(n28) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_5 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n14), .Y(n40) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n22), .Y(n28) );
  INVX1 U11 ( .A(n17), .Y(n34) );
  INVX1 U12 ( .A(n16), .Y(n36) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_4 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_3 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_2 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_1 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n14), .Y(n40) );
  INVX2 U3 ( .A(n1), .Y(n2) );
  INVX2 U4 ( .A(write_enable), .Y(n1) );
  INVX2 U5 ( .A(n4), .Y(n3) );
  INVX2 U6 ( .A(n_reset), .Y(n4) );
  INVX1 U7 ( .A(n11), .Y(n46) );
  INVX1 U8 ( .A(n13), .Y(n42) );
  INVX1 U9 ( .A(n12), .Y(n44) );
  INVX1 U10 ( .A(n22), .Y(n28) );
  INVX1 U11 ( .A(n17), .Y(n34) );
  INVX1 U12 ( .A(n16), .Y(n36) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_0 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX2 U2 ( .A(n1), .Y(n2) );
  INVX2 U3 ( .A(write_enable), .Y(n1) );
  INVX2 U4 ( .A(n4), .Y(n3) );
  INVX2 U5 ( .A(n_reset), .Y(n4) );
  INVX1 U6 ( .A(n11), .Y(n46) );
  INVX1 U7 ( .A(n13), .Y(n42) );
  INVX1 U8 ( .A(n12), .Y(n44) );
  INVX1 U9 ( .A(n22), .Y(n28) );
  INVX1 U10 ( .A(n17), .Y(n34) );
  INVX1 U11 ( .A(n16), .Y(n36) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n18), .Y(n32) );
  MUX2X1 U14 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U15 ( .A(n5), .Y(n55) );
  MUX2X1 U16 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U17 ( .A(n6), .Y(n54) );
  MUX2X1 U18 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U19 ( .A(n7), .Y(n53) );
  MUX2X1 U20 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U21 ( .A(n8), .Y(n52) );
  MUX2X1 U22 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U23 ( .A(n9), .Y(n50) );
  MUX2X1 U24 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U25 ( .A(n10), .Y(n48) );
  MUX2X1 U26 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U27 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U28 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U29 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U30 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  INVX2 U31 ( .A(n15), .Y(n38) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module register_file ( clk, n_reset, w_en, r1_sel, r2_sel, w_sel, w_data, 
        r1_data, r2_data, outreg_data );
  input [3:0] r1_sel;
  input [3:0] r2_sel;
  input [3:0] w_sel;
  input [16:0] w_data;
  output [16:0] r1_data;
  output [16:0] r2_data;
  output [16:0] outreg_data;
  input clk, n_reset, w_en;
  wire   N10, N11, N12, N13, N14, N15, N16, N17, \regs_matrix[15][16] ,
         \regs_matrix[15][15] , \regs_matrix[15][14] , \regs_matrix[15][13] ,
         \regs_matrix[15][12] , \regs_matrix[15][11] , \regs_matrix[15][10] ,
         \regs_matrix[15][9] , \regs_matrix[15][8] , \regs_matrix[15][7] ,
         \regs_matrix[15][6] , \regs_matrix[15][5] , \regs_matrix[15][4] ,
         \regs_matrix[15][3] , \regs_matrix[15][2] , \regs_matrix[15][1] ,
         \regs_matrix[15][0] , \regs_matrix[14][16] , \regs_matrix[14][15] ,
         \regs_matrix[14][14] , \regs_matrix[14][13] , \regs_matrix[14][12] ,
         \regs_matrix[14][11] , \regs_matrix[14][10] , \regs_matrix[14][9] ,
         \regs_matrix[14][8] , \regs_matrix[14][7] , \regs_matrix[14][6] ,
         \regs_matrix[14][5] , \regs_matrix[14][4] , \regs_matrix[14][3] ,
         \regs_matrix[14][2] , \regs_matrix[14][1] , \regs_matrix[14][0] ,
         \regs_matrix[13][16] , \regs_matrix[13][15] , \regs_matrix[13][14] ,
         \regs_matrix[13][13] , \regs_matrix[13][12] , \regs_matrix[13][11] ,
         \regs_matrix[13][10] , \regs_matrix[13][9] , \regs_matrix[13][8] ,
         \regs_matrix[13][7] , \regs_matrix[13][6] , \regs_matrix[13][5] ,
         \regs_matrix[13][4] , \regs_matrix[13][3] , \regs_matrix[13][2] ,
         \regs_matrix[13][1] , \regs_matrix[13][0] , \regs_matrix[12][16] ,
         \regs_matrix[12][15] , \regs_matrix[12][14] , \regs_matrix[12][13] ,
         \regs_matrix[12][12] , \regs_matrix[12][11] , \regs_matrix[12][10] ,
         \regs_matrix[12][9] , \regs_matrix[12][8] , \regs_matrix[12][7] ,
         \regs_matrix[12][6] , \regs_matrix[12][5] , \regs_matrix[12][4] ,
         \regs_matrix[12][3] , \regs_matrix[12][2] , \regs_matrix[12][1] ,
         \regs_matrix[12][0] , \regs_matrix[11][16] , \regs_matrix[11][15] ,
         \regs_matrix[11][14] , \regs_matrix[11][13] , \regs_matrix[11][12] ,
         \regs_matrix[11][11] , \regs_matrix[11][10] , \regs_matrix[11][9] ,
         \regs_matrix[11][8] , \regs_matrix[11][7] , \regs_matrix[11][6] ,
         \regs_matrix[11][5] , \regs_matrix[11][4] , \regs_matrix[11][3] ,
         \regs_matrix[11][2] , \regs_matrix[11][1] , \regs_matrix[11][0] ,
         \regs_matrix[10][16] , \regs_matrix[10][15] , \regs_matrix[10][14] ,
         \regs_matrix[10][13] , \regs_matrix[10][12] , \regs_matrix[10][11] ,
         \regs_matrix[10][10] , \regs_matrix[10][9] , \regs_matrix[10][8] ,
         \regs_matrix[10][7] , \regs_matrix[10][6] , \regs_matrix[10][5] ,
         \regs_matrix[10][4] , \regs_matrix[10][3] , \regs_matrix[10][2] ,
         \regs_matrix[10][1] , \regs_matrix[10][0] , \regs_matrix[9][16] ,
         \regs_matrix[9][15] , \regs_matrix[9][14] , \regs_matrix[9][13] ,
         \regs_matrix[9][12] , \regs_matrix[9][11] , \regs_matrix[9][10] ,
         \regs_matrix[9][9] , \regs_matrix[9][8] , \regs_matrix[9][7] ,
         \regs_matrix[9][6] , \regs_matrix[9][5] , \regs_matrix[9][4] ,
         \regs_matrix[9][3] , \regs_matrix[9][2] , \regs_matrix[9][1] ,
         \regs_matrix[9][0] , \regs_matrix[8][16] , \regs_matrix[8][15] ,
         \regs_matrix[8][14] , \regs_matrix[8][13] , \regs_matrix[8][12] ,
         \regs_matrix[8][11] , \regs_matrix[8][10] , \regs_matrix[8][9] ,
         \regs_matrix[8][8] , \regs_matrix[8][7] , \regs_matrix[8][6] ,
         \regs_matrix[8][5] , \regs_matrix[8][4] , \regs_matrix[8][3] ,
         \regs_matrix[8][2] , \regs_matrix[8][1] , \regs_matrix[8][0] ,
         \regs_matrix[7][16] , \regs_matrix[7][15] , \regs_matrix[7][14] ,
         \regs_matrix[7][13] , \regs_matrix[7][12] , \regs_matrix[7][11] ,
         \regs_matrix[7][10] , \regs_matrix[7][9] , \regs_matrix[7][8] ,
         \regs_matrix[7][7] , \regs_matrix[7][6] , \regs_matrix[7][5] ,
         \regs_matrix[7][4] , \regs_matrix[7][3] , \regs_matrix[7][2] ,
         \regs_matrix[7][1] , \regs_matrix[7][0] , \regs_matrix[6][16] ,
         \regs_matrix[6][15] , \regs_matrix[6][14] , \regs_matrix[6][13] ,
         \regs_matrix[6][12] , \regs_matrix[6][11] , \regs_matrix[6][10] ,
         \regs_matrix[6][9] , \regs_matrix[6][8] , \regs_matrix[6][7] ,
         \regs_matrix[6][6] , \regs_matrix[6][5] , \regs_matrix[6][4] ,
         \regs_matrix[6][3] , \regs_matrix[6][2] , \regs_matrix[6][1] ,
         \regs_matrix[6][0] , \regs_matrix[5][16] , \regs_matrix[5][15] ,
         \regs_matrix[5][14] , \regs_matrix[5][13] , \regs_matrix[5][12] ,
         \regs_matrix[5][11] , \regs_matrix[5][10] , \regs_matrix[5][9] ,
         \regs_matrix[5][8] , \regs_matrix[5][7] , \regs_matrix[5][6] ,
         \regs_matrix[5][5] , \regs_matrix[5][4] , \regs_matrix[5][3] ,
         \regs_matrix[5][2] , \regs_matrix[5][1] , \regs_matrix[5][0] ,
         \regs_matrix[4][16] , \regs_matrix[4][15] , \regs_matrix[4][14] ,
         \regs_matrix[4][13] , \regs_matrix[4][12] , \regs_matrix[4][11] ,
         \regs_matrix[4][10] , \regs_matrix[4][9] , \regs_matrix[4][8] ,
         \regs_matrix[4][7] , \regs_matrix[4][6] , \regs_matrix[4][5] ,
         \regs_matrix[4][4] , \regs_matrix[4][3] , \regs_matrix[4][2] ,
         \regs_matrix[4][1] , \regs_matrix[4][0] , \regs_matrix[3][16] ,
         \regs_matrix[3][15] , \regs_matrix[3][14] , \regs_matrix[3][13] ,
         \regs_matrix[3][12] , \regs_matrix[3][11] , \regs_matrix[3][10] ,
         \regs_matrix[3][9] , \regs_matrix[3][8] , \regs_matrix[3][7] ,
         \regs_matrix[3][6] , \regs_matrix[3][5] , \regs_matrix[3][4] ,
         \regs_matrix[3][3] , \regs_matrix[3][2] , \regs_matrix[3][1] ,
         \regs_matrix[3][0] , \regs_matrix[2][16] , \regs_matrix[2][15] ,
         \regs_matrix[2][14] , \regs_matrix[2][13] , \regs_matrix[2][12] ,
         \regs_matrix[2][11] , \regs_matrix[2][10] , \regs_matrix[2][9] ,
         \regs_matrix[2][8] , \regs_matrix[2][7] , \regs_matrix[2][6] ,
         \regs_matrix[2][5] , \regs_matrix[2][4] , \regs_matrix[2][3] ,
         \regs_matrix[2][2] , \regs_matrix[2][1] , \regs_matrix[2][0] ,
         \regs_matrix[1][16] , \regs_matrix[1][15] , \regs_matrix[1][14] ,
         \regs_matrix[1][13] , \regs_matrix[1][12] , \regs_matrix[1][11] ,
         \regs_matrix[1][10] , \regs_matrix[1][9] , \regs_matrix[1][8] ,
         \regs_matrix[1][7] , \regs_matrix[1][6] , \regs_matrix[1][5] ,
         \regs_matrix[1][4] , \regs_matrix[1][3] , \regs_matrix[1][2] ,
         \regs_matrix[1][1] , \regs_matrix[1][0] , n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n1, n2, n3, n4, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434,
         n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445,
         n446, n447, n448, n449, n450, n451, n452, n453, n454, n455, n456,
         n457, n458, n459, n460, n461, n462, n463, n464, n465, n466, n467,
         n468, n469, n470, n471, n472, n473, n474, n475, n476, n477, n478,
         n479, n480, n481, n482, n483, n484, n485, n486, n487, n488, n489,
         n490, n491, n492, n493, n494, n495, n496, n497, n498, n499, n500,
         n501, n502, n503, n504, n505, n506, n507, n508, n509, n510, n511,
         n512, n513, n514, n515, n516, n517, n518, n519, n520, n521, n522,
         n523, n524, n525, n526, n527, n528, n529, n530, n531, n532, n533,
         n534, n535, n536, n537, n538, n539, n540, n541, n542, n543, n544,
         n545, n546, n547, n548, n549, n550, n551, n552, n553, n554, n555,
         n556, n557, n558, n559, n560, n561, n562, n563, n564, n565, n566,
         n567, n568, n569, n570, n571, n572, n573, n574, n575, n576, n577,
         n578, n579, n580, n581, n582, n583, n584, n585, n586, n587, n588,
         n589, n590, n591, n592, n593, n594, n595, n596, n597, n598, n599,
         n600, n601, n602, n603, n604, n605, n606, n607, n608, n609, n610,
         n611, n612, n613, n614, n615, n616, n617, n618, n619, n620, n621,
         n622, n623, n624, n625, n626, n627, n628, n629, n630, n631, n632,
         n633, n634, n635, n636, n637, n638, n639, n640, n641, n642, n643,
         n644, n645, n646, n647, n648, n649, n650, n651, n652, n653, n654,
         n655, n656, n657, n658, n659, n660, n661, n662, n663, n664, n665,
         n666, n667, n668, n669, n670, n671, n672, n673, n674, n675, n676,
         n677, n678, n679, n680, n681, n682, n683, n684, n685, n686, n687,
         n688, n689, n690, n691, n692, n693, n694, n695, n696, n697, n698,
         n699, n700, n701, n702, n703, n704, n705, n706, n707, n708, n709,
         n710, n711, n712, n713, n714, n715, n716;
  wire   [15:0] write_enables;
  assign N10 = r1_sel[0];
  assign N11 = r1_sel[1];
  assign N12 = r1_sel[2];
  assign N13 = r1_sel[3];
  assign N14 = r2_sel[0];
  assign N15 = r2_sel[1];
  assign N16 = r2_sel[2];
  assign N17 = r2_sel[3];

  NOR2X1 U6 ( .A(n5), .B(n6), .Y(write_enables[9]) );
  NOR2X1 U7 ( .A(n6), .B(n7), .Y(write_enables[8]) );
  NOR2X1 U8 ( .A(n8), .B(n9), .Y(write_enables[7]) );
  NOR2X1 U9 ( .A(n8), .B(n10), .Y(write_enables[6]) );
  NOR2X1 U10 ( .A(n9), .B(n11), .Y(write_enables[5]) );
  NOR2X1 U11 ( .A(n10), .B(n11), .Y(write_enables[4]) );
  NOR2X1 U12 ( .A(n9), .B(n12), .Y(write_enables[3]) );
  NOR2X1 U13 ( .A(n10), .B(n12), .Y(write_enables[2]) );
  NOR2X1 U14 ( .A(n6), .B(n9), .Y(write_enables[1]) );
  NAND3X1 U15 ( .A(w_en), .B(n716), .C(w_sel[0]), .Y(n9) );
  NOR2X1 U16 ( .A(n5), .B(n8), .Y(write_enables[15]) );
  NOR2X1 U17 ( .A(n7), .B(n8), .Y(write_enables[14]) );
  NAND2X1 U18 ( .A(w_sel[2]), .B(w_sel[1]), .Y(n8) );
  NOR2X1 U19 ( .A(n5), .B(n11), .Y(write_enables[13]) );
  NOR2X1 U20 ( .A(n7), .B(n11), .Y(write_enables[12]) );
  NAND2X1 U21 ( .A(w_sel[2]), .B(n714), .Y(n11) );
  NOR2X1 U22 ( .A(n5), .B(n12), .Y(write_enables[11]) );
  NAND3X1 U23 ( .A(w_sel[0]), .B(w_en), .C(w_sel[3]), .Y(n5) );
  NOR2X1 U24 ( .A(n7), .B(n12), .Y(write_enables[10]) );
  NAND2X1 U25 ( .A(w_sel[1]), .B(n715), .Y(n12) );
  NAND2X1 U26 ( .A(n13), .B(w_sel[3]), .Y(n7) );
  NOR2X1 U27 ( .A(n6), .B(n10), .Y(write_enables[0]) );
  NAND2X1 U28 ( .A(n13), .B(n716), .Y(n10) );
  NOR2X1 U29 ( .A(n713), .B(w_sel[0]), .Y(n13) );
  NAND2X1 U30 ( .A(n714), .B(n715), .Y(n6) );
  flex_sreg_NUM_BITS17_15 \genblk1[0].REGX  ( .clk(clk), .n_reset(n712), 
        .write_enable(write_enables[0]), .new_value({n704, n701, n699, n696, 
        n694, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        n662}), .current_value(outreg_data) );
  flex_sreg_NUM_BITS17_14 \genblk1[1].REGX  ( .clk(clk), .n_reset(n705), 
        .write_enable(write_enables[1]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[1][16] , \regs_matrix[1][15] , 
        \regs_matrix[1][14] , \regs_matrix[1][13] , \regs_matrix[1][12] , 
        \regs_matrix[1][11] , \regs_matrix[1][10] , \regs_matrix[1][9] , 
        \regs_matrix[1][8] , \regs_matrix[1][7] , \regs_matrix[1][6] , 
        \regs_matrix[1][5] , \regs_matrix[1][4] , \regs_matrix[1][3] , 
        \regs_matrix[1][2] , \regs_matrix[1][1] , \regs_matrix[1][0] }) );
  flex_sreg_NUM_BITS17_13 \genblk1[2].REGX  ( .clk(clk), .n_reset(n705), 
        .write_enable(write_enables[2]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[2][16] , 
        \regs_matrix[2][15] , \regs_matrix[2][14] , \regs_matrix[2][13] , 
        \regs_matrix[2][12] , \regs_matrix[2][11] , \regs_matrix[2][10] , 
        \regs_matrix[2][9] , \regs_matrix[2][8] , \regs_matrix[2][7] , 
        \regs_matrix[2][6] , \regs_matrix[2][5] , \regs_matrix[2][4] , 
        \regs_matrix[2][3] , \regs_matrix[2][2] , \regs_matrix[2][1] , 
        \regs_matrix[2][0] }) );
  flex_sreg_NUM_BITS17_12 \genblk1[3].REGX  ( .clk(clk), .n_reset(n706), 
        .write_enable(write_enables[3]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[3][16] , \regs_matrix[3][15] , 
        \regs_matrix[3][14] , \regs_matrix[3][13] , \regs_matrix[3][12] , 
        \regs_matrix[3][11] , \regs_matrix[3][10] , \regs_matrix[3][9] , 
        \regs_matrix[3][8] , \regs_matrix[3][7] , \regs_matrix[3][6] , 
        \regs_matrix[3][5] , \regs_matrix[3][4] , \regs_matrix[3][3] , 
        \regs_matrix[3][2] , \regs_matrix[3][1] , \regs_matrix[3][0] }) );
  flex_sreg_NUM_BITS17_11 \genblk1[4].REGX  ( .clk(clk), .n_reset(n706), 
        .write_enable(write_enables[4]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[4][16] , 
        \regs_matrix[4][15] , \regs_matrix[4][14] , \regs_matrix[4][13] , 
        \regs_matrix[4][12] , \regs_matrix[4][11] , \regs_matrix[4][10] , 
        \regs_matrix[4][9] , \regs_matrix[4][8] , \regs_matrix[4][7] , 
        \regs_matrix[4][6] , \regs_matrix[4][5] , \regs_matrix[4][4] , 
        \regs_matrix[4][3] , \regs_matrix[4][2] , \regs_matrix[4][1] , 
        \regs_matrix[4][0] }) );
  flex_sreg_NUM_BITS17_10 \genblk1[5].REGX  ( .clk(clk), .n_reset(n707), 
        .write_enable(write_enables[5]), .new_value({n703, n701, n698, n696, 
        n693, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[5][16] , \regs_matrix[5][15] , 
        \regs_matrix[5][14] , \regs_matrix[5][13] , \regs_matrix[5][12] , 
        \regs_matrix[5][11] , \regs_matrix[5][10] , \regs_matrix[5][9] , 
        \regs_matrix[5][8] , \regs_matrix[5][7] , \regs_matrix[5][6] , 
        \regs_matrix[5][5] , \regs_matrix[5][4] , \regs_matrix[5][3] , 
        \regs_matrix[5][2] , \regs_matrix[5][1] , \regs_matrix[5][0] }) );
  flex_sreg_NUM_BITS17_9 \genblk1[6].REGX  ( .clk(clk), .n_reset(n707), 
        .write_enable(write_enables[6]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[6][16] , 
        \regs_matrix[6][15] , \regs_matrix[6][14] , \regs_matrix[6][13] , 
        \regs_matrix[6][12] , \regs_matrix[6][11] , \regs_matrix[6][10] , 
        \regs_matrix[6][9] , \regs_matrix[6][8] , \regs_matrix[6][7] , 
        \regs_matrix[6][6] , \regs_matrix[6][5] , \regs_matrix[6][4] , 
        \regs_matrix[6][3] , \regs_matrix[6][2] , \regs_matrix[6][1] , 
        \regs_matrix[6][0] }) );
  flex_sreg_NUM_BITS17_8 \genblk1[7].REGX  ( .clk(clk), .n_reset(n708), 
        .write_enable(write_enables[7]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[7][16] , \regs_matrix[7][15] , 
        \regs_matrix[7][14] , \regs_matrix[7][13] , \regs_matrix[7][12] , 
        \regs_matrix[7][11] , \regs_matrix[7][10] , \regs_matrix[7][9] , 
        \regs_matrix[7][8] , \regs_matrix[7][7] , \regs_matrix[7][6] , 
        \regs_matrix[7][5] , \regs_matrix[7][4] , \regs_matrix[7][3] , 
        \regs_matrix[7][2] , \regs_matrix[7][1] , \regs_matrix[7][0] }) );
  flex_sreg_NUM_BITS17_7 \genblk1[8].REGX  ( .clk(clk), .n_reset(n708), 
        .write_enable(write_enables[8]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[8][16] , 
        \regs_matrix[8][15] , \regs_matrix[8][14] , \regs_matrix[8][13] , 
        \regs_matrix[8][12] , \regs_matrix[8][11] , \regs_matrix[8][10] , 
        \regs_matrix[8][9] , \regs_matrix[8][8] , \regs_matrix[8][7] , 
        \regs_matrix[8][6] , \regs_matrix[8][5] , \regs_matrix[8][4] , 
        \regs_matrix[8][3] , \regs_matrix[8][2] , \regs_matrix[8][1] , 
        \regs_matrix[8][0] }) );
  flex_sreg_NUM_BITS17_6 \genblk1[9].REGX  ( .clk(clk), .n_reset(n709), 
        .write_enable(write_enables[9]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[9][16] , \regs_matrix[9][15] , 
        \regs_matrix[9][14] , \regs_matrix[9][13] , \regs_matrix[9][12] , 
        \regs_matrix[9][11] , \regs_matrix[9][10] , \regs_matrix[9][9] , 
        \regs_matrix[9][8] , \regs_matrix[9][7] , \regs_matrix[9][6] , 
        \regs_matrix[9][5] , \regs_matrix[9][4] , \regs_matrix[9][3] , 
        \regs_matrix[9][2] , \regs_matrix[9][1] , \regs_matrix[9][0] }) );
  flex_sreg_NUM_BITS17_5 \genblk1[10].REGX  ( .clk(clk), .n_reset(n709), 
        .write_enable(write_enables[10]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[10][16] , 
        \regs_matrix[10][15] , \regs_matrix[10][14] , \regs_matrix[10][13] , 
        \regs_matrix[10][12] , \regs_matrix[10][11] , \regs_matrix[10][10] , 
        \regs_matrix[10][9] , \regs_matrix[10][8] , \regs_matrix[10][7] , 
        \regs_matrix[10][6] , \regs_matrix[10][5] , \regs_matrix[10][4] , 
        \regs_matrix[10][3] , \regs_matrix[10][2] , \regs_matrix[10][1] , 
        \regs_matrix[10][0] }) );
  flex_sreg_NUM_BITS17_4 \genblk1[11].REGX  ( .clk(clk), .n_reset(n710), 
        .write_enable(write_enables[11]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[11][16] , \regs_matrix[11][15] , 
        \regs_matrix[11][14] , \regs_matrix[11][13] , \regs_matrix[11][12] , 
        \regs_matrix[11][11] , \regs_matrix[11][10] , \regs_matrix[11][9] , 
        \regs_matrix[11][8] , \regs_matrix[11][7] , \regs_matrix[11][6] , 
        \regs_matrix[11][5] , \regs_matrix[11][4] , \regs_matrix[11][3] , 
        \regs_matrix[11][2] , \regs_matrix[11][1] , \regs_matrix[11][0] }) );
  flex_sreg_NUM_BITS17_3 \genblk1[12].REGX  ( .clk(clk), .n_reset(n710), 
        .write_enable(write_enables[12]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n685, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[12][16] , 
        \regs_matrix[12][15] , \regs_matrix[12][14] , \regs_matrix[12][13] , 
        \regs_matrix[12][12] , \regs_matrix[12][11] , \regs_matrix[12][10] , 
        \regs_matrix[12][9] , \regs_matrix[12][8] , \regs_matrix[12][7] , 
        \regs_matrix[12][6] , \regs_matrix[12][5] , \regs_matrix[12][4] , 
        \regs_matrix[12][3] , \regs_matrix[12][2] , \regs_matrix[12][1] , 
        \regs_matrix[12][0] }) );
  flex_sreg_NUM_BITS17_2 \genblk1[13].REGX  ( .clk(clk), .n_reset(n711), 
        .write_enable(write_enables[13]), .new_value({n703, n701, n698, n696, 
        n693, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[13][16] , \regs_matrix[13][15] , 
        \regs_matrix[13][14] , \regs_matrix[13][13] , \regs_matrix[13][12] , 
        \regs_matrix[13][11] , \regs_matrix[13][10] , \regs_matrix[13][9] , 
        \regs_matrix[13][8] , \regs_matrix[13][7] , \regs_matrix[13][6] , 
        \regs_matrix[13][5] , \regs_matrix[13][4] , \regs_matrix[13][3] , 
        \regs_matrix[13][2] , \regs_matrix[13][1] , \regs_matrix[13][0] }) );
  flex_sreg_NUM_BITS17_1 \genblk1[14].REGX  ( .clk(clk), .n_reset(n711), 
        .write_enable(write_enables[14]), .new_value({n704, n701, n699, n696, 
        n693, n691, n689, n686, n683, n681, n679, n677, n674, n671, n668, n665, 
        w_data[0]}), .current_value({\regs_matrix[14][16] , 
        \regs_matrix[14][15] , \regs_matrix[14][14] , \regs_matrix[14][13] , 
        \regs_matrix[14][12] , \regs_matrix[14][11] , \regs_matrix[14][10] , 
        \regs_matrix[14][9] , \regs_matrix[14][8] , \regs_matrix[14][7] , 
        \regs_matrix[14][6] , \regs_matrix[14][5] , \regs_matrix[14][4] , 
        \regs_matrix[14][3] , \regs_matrix[14][2] , \regs_matrix[14][1] , 
        \regs_matrix[14][0] }) );
  flex_sreg_NUM_BITS17_0 \genblk1[15].REGX  ( .clk(clk), .n_reset(n712), 
        .write_enable(write_enables[15]), .new_value({n703, n701, n698, n696, 
        n694, n691, n688, n685, n683, n681, n679, n676, n673, n670, n667, n664, 
        n662}), .current_value({\regs_matrix[15][16] , \regs_matrix[15][15] , 
        \regs_matrix[15][14] , \regs_matrix[15][13] , \regs_matrix[15][12] , 
        \regs_matrix[15][11] , \regs_matrix[15][10] , \regs_matrix[15][9] , 
        \regs_matrix[15][8] , \regs_matrix[15][7] , \regs_matrix[15][6] , 
        \regs_matrix[15][5] , \regs_matrix[15][4] , \regs_matrix[15][3] , 
        \regs_matrix[15][2] , \regs_matrix[15][1] , \regs_matrix[15][0] }) );
  INVX4 U2 ( .A(n392), .Y(n647) );
  INVX4 U3 ( .A(n298), .Y(r1_data[14]) );
  INVX8 U4 ( .A(n651), .Y(n652) );
  INVX8 U5 ( .A(n359), .Y(n360) );
  BUFX4 U31 ( .A(n373), .Y(n1) );
  INVX4 U32 ( .A(w_data[9]), .Y(n684) );
  INVX4 U33 ( .A(w_data[12]), .Y(n692) );
  AND2X1 U34 ( .A(N15), .B(N14), .Y(n44) );
  BUFX2 U35 ( .A(n632), .Y(n635) );
  INVX2 U36 ( .A(n387), .Y(n632) );
  INVX2 U37 ( .A(n34), .Y(n35) );
  INVX2 U38 ( .A(n69), .Y(n359) );
  INVX4 U39 ( .A(n32), .Y(n33) );
  INVX2 U40 ( .A(n213), .Y(r1_data[9]) );
  INVX2 U41 ( .A(n230), .Y(r1_data[10]) );
  INVX2 U42 ( .A(n264), .Y(r1_data[12]) );
  INVX2 U43 ( .A(n60), .Y(n350) );
  INVX2 U44 ( .A(n162), .Y(r1_data[6]) );
  INVX2 U45 ( .A(n247), .Y(r1_data[11]) );
  INVX2 U46 ( .A(n315), .Y(r1_data[15]) );
  INVX2 U47 ( .A(w_data[5]), .Y(n675) );
  INVX2 U48 ( .A(n363), .Y(n367) );
  INVX2 U49 ( .A(n386), .Y(n626) );
  BUFX2 U50 ( .A(n369), .Y(n372) );
  INVX2 U51 ( .A(n626), .Y(n629) );
  INVX1 U52 ( .A(n631), .Y(n2) );
  INVX4 U53 ( .A(n352), .Y(n353) );
  INVX2 U54 ( .A(n374), .Y(n32) );
  INVX2 U55 ( .A(n61), .Y(n352) );
  BUFX2 U56 ( .A(n632), .Y(n634) );
  INVX2 U57 ( .A(n352), .Y(n354) );
  INVX2 U58 ( .A(n347), .Y(n348) );
  INVX2 U59 ( .A(n359), .Y(n361) );
  INVX2 U60 ( .A(n43), .Y(n39) );
  INVX4 U61 ( .A(N12), .Y(n34) );
  INVX4 U62 ( .A(n281), .Y(r1_data[13]) );
  INVX2 U63 ( .A(n640), .Y(n642) );
  INVX2 U64 ( .A(n640), .Y(n643) );
  BUFX2 U65 ( .A(n351), .Y(n3) );
  INVX2 U66 ( .A(N10), .Y(n344) );
  BUFX2 U67 ( .A(N11), .Y(n4) );
  INVX4 U68 ( .A(n372), .Y(n14) );
  INVX2 U69 ( .A(n372), .Y(n365) );
  BUFX4 U70 ( .A(n626), .Y(n627) );
  INVX8 U71 ( .A(n627), .Y(n631) );
  BUFX4 U72 ( .A(n369), .Y(n362) );
  INVX8 U73 ( .A(n628), .Y(n630) );
  BUFX4 U74 ( .A(n626), .Y(n628) );
  INVX4 U75 ( .A(n675), .Y(n677) );
  INVX4 U76 ( .A(n675), .Y(n676) );
  INVX1 U77 ( .A(n632), .Y(n15) );
  INVX1 U78 ( .A(n632), .Y(n16) );
  INVX1 U79 ( .A(n632), .Y(n17) );
  INVX1 U80 ( .A(n632), .Y(n18) );
  INVX1 U81 ( .A(n632), .Y(n19) );
  INVX1 U82 ( .A(n635), .Y(n20) );
  INVX1 U83 ( .A(n635), .Y(n21) );
  INVX1 U84 ( .A(n635), .Y(n22) );
  INVX1 U85 ( .A(n635), .Y(n23) );
  INVX1 U86 ( .A(n634), .Y(n24) );
  INVX1 U87 ( .A(n634), .Y(n25) );
  INVX1 U88 ( .A(n634), .Y(n26) );
  INVX1 U89 ( .A(n633), .Y(n27) );
  INVX1 U90 ( .A(n633), .Y(n28) );
  INVX1 U91 ( .A(n633), .Y(n29) );
  INVX1 U92 ( .A(n633), .Y(n30) );
  INVX2 U93 ( .A(n622), .Y(n31) );
  INVX4 U94 ( .A(n128), .Y(r1_data[4]) );
  INVX2 U95 ( .A(n41), .Y(n644) );
  INVX4 U96 ( .A(n692), .Y(n694) );
  INVX4 U97 ( .A(n692), .Y(n693) );
  INVX2 U98 ( .A(n94), .Y(r1_data[2]) );
  INVX4 U99 ( .A(n684), .Y(n685) );
  INVX4 U100 ( .A(n684), .Y(n686) );
  INVX2 U101 ( .A(n359), .Y(n38) );
  INVX8 U102 ( .A(n347), .Y(n349) );
  INVX4 U103 ( .A(n43), .Y(n40) );
  INVX4 U104 ( .A(n179), .Y(r1_data[7]) );
  AND2X2 U105 ( .A(N11), .B(N10), .Y(n45) );
  INVX4 U106 ( .A(n145), .Y(r1_data[5]) );
  INVX4 U107 ( .A(N16), .Y(n622) );
  INVX4 U108 ( .A(n636), .Y(n637) );
  INVX4 U109 ( .A(N12), .Y(n343) );
  INVX4 U110 ( .A(n77), .Y(r1_data[1]) );
  INVX4 U111 ( .A(n647), .Y(n650) );
  INVX4 U112 ( .A(n647), .Y(n649) );
  INVX4 U113 ( .A(n647), .Y(n648) );
  INVX4 U114 ( .A(n42), .Y(n655) );
  INVX4 U115 ( .A(n42), .Y(n656) );
  INVX4 U116 ( .A(n388), .Y(n636) );
  INVX4 U117 ( .A(n636), .Y(n639) );
  INVX4 U118 ( .A(n636), .Y(n638) );
  INVX8 U119 ( .A(n651), .Y(n654) );
  INVX4 U120 ( .A(n393), .Y(n651) );
  INVX8 U121 ( .A(n651), .Y(n653) );
  INVX4 U122 ( .A(n42), .Y(n657) );
  INVX4 U123 ( .A(n41), .Y(n645) );
  INVX4 U124 ( .A(n646), .Y(n36) );
  INVX8 U125 ( .A(n36), .Y(n37) );
  AND2X2 U126 ( .A(n45), .B(N12), .Y(n43) );
  AND2X2 U127 ( .A(n31), .B(n44), .Y(n42) );
  INVX2 U128 ( .A(n389), .Y(n640) );
  INVX2 U129 ( .A(w_data[16]), .Y(n702) );
  INVX2 U130 ( .A(w_data[4]), .Y(n672) );
  INVX2 U131 ( .A(w_data[3]), .Y(n669) );
  INVX2 U132 ( .A(w_data[2]), .Y(n666) );
  INVX2 U133 ( .A(w_data[1]), .Y(n663) );
  INVX2 U134 ( .A(w_data[0]), .Y(n661) );
  INVX2 U135 ( .A(n41), .Y(n646) );
  INVX2 U136 ( .A(n43), .Y(n355) );
  AND2X2 U137 ( .A(n44), .B(n622), .Y(n41) );
  INVX2 U138 ( .A(n640), .Y(n641) );
  BUFX2 U139 ( .A(n632), .Y(n633) );
  INVX2 U140 ( .A(n660), .Y(n659) );
  INVX2 U141 ( .A(n660), .Y(n658) );
  BUFX2 U142 ( .A(n369), .Y(n363) );
  INVX2 U143 ( .A(N17), .Y(n660) );
  INVX2 U144 ( .A(n702), .Y(n704) );
  INVX2 U145 ( .A(n702), .Y(n703) );
  INVX4 U146 ( .A(n697), .Y(n698) );
  INVX4 U147 ( .A(n687), .Y(n688) );
  INVX4 U148 ( .A(n697), .Y(n699) );
  INVX4 U149 ( .A(n687), .Y(n689) );
  INVX4 U150 ( .A(n52), .Y(r1_data[0]) );
  INVX2 U151 ( .A(n672), .Y(n674) );
  INVX2 U152 ( .A(n672), .Y(n673) );
  INVX2 U153 ( .A(n669), .Y(n671) );
  INVX2 U154 ( .A(n666), .Y(n668) );
  INVX2 U155 ( .A(n669), .Y(n670) );
  INVX2 U156 ( .A(n666), .Y(n667) );
  INVX2 U157 ( .A(n663), .Y(n665) );
  INVX2 U158 ( .A(n663), .Y(n664) );
  INVX2 U159 ( .A(n661), .Y(n662) );
  BUFX2 U160 ( .A(n_reset), .Y(n705) );
  BUFX2 U161 ( .A(n_reset), .Y(n706) );
  BUFX2 U162 ( .A(n_reset), .Y(n707) );
  BUFX2 U163 ( .A(n_reset), .Y(n708) );
  BUFX2 U164 ( .A(n_reset), .Y(n709) );
  BUFX2 U165 ( .A(n_reset), .Y(n710) );
  BUFX2 U166 ( .A(n_reset), .Y(n711) );
  BUFX2 U167 ( .A(n_reset), .Y(n712) );
  AOI22X1 U168 ( .A(n49), .B(n48), .C(n47), .D(n46), .Y(n50) );
  INVX2 U169 ( .A(N13), .Y(n51) );
  INVX2 U170 ( .A(n50), .Y(r1_data[16]) );
  AOI22X1 U171 ( .A(n53), .B(n54), .C(n55), .D(n56), .Y(n52) );
  NOR2X1 U172 ( .A(n57), .B(n58), .Y(n56) );
  OAI22X1 U173 ( .A(\regs_matrix[6][0] ), .B(n349), .C(outreg_data[0]), .D(
        n351), .Y(n58) );
  OAI21X1 U174 ( .A(\regs_matrix[4][0] ), .B(n353), .C(n51), .Y(n57) );
  NOR2X1 U175 ( .A(n62), .B(n63), .Y(n55) );
  OAI21X1 U176 ( .A(\regs_matrix[7][0] ), .B(n40), .C(n64), .Y(n63) );
  AOI22X1 U177 ( .A(n65), .B(n66), .C(n363), .D(n67), .Y(n64) );
  INVX2 U178 ( .A(\regs_matrix[3][0] ), .Y(n67) );
  INVX2 U179 ( .A(\regs_matrix[1][0] ), .Y(n66) );
  OAI22X1 U180 ( .A(\regs_matrix[2][0] ), .B(n33), .C(\regs_matrix[5][0] ), 
        .D(n360), .Y(n62) );
  NOR2X1 U181 ( .A(n70), .B(n71), .Y(n54) );
  OAI22X1 U182 ( .A(\regs_matrix[14][0] ), .B(n348), .C(\regs_matrix[8][0] ), 
        .D(n3), .Y(n71) );
  OAI21X1 U183 ( .A(\regs_matrix[12][0] ), .B(n354), .C(N13), .Y(n70) );
  NOR2X1 U184 ( .A(n72), .B(n73), .Y(n53) );
  OAI21X1 U185 ( .A(\regs_matrix[15][0] ), .B(n39), .C(n74), .Y(n73) );
  AOI22X1 U186 ( .A(n366), .B(n75), .C(n362), .D(n76), .Y(n74) );
  INVX2 U187 ( .A(\regs_matrix[11][0] ), .Y(n76) );
  INVX2 U188 ( .A(\regs_matrix[9][0] ), .Y(n75) );
  OAI22X1 U189 ( .A(\regs_matrix[10][0] ), .B(n358), .C(\regs_matrix[13][0] ), 
        .D(n361), .Y(n72) );
  AOI22X1 U190 ( .A(n78), .B(n79), .C(n80), .D(n81), .Y(n77) );
  NOR2X1 U191 ( .A(n82), .B(n83), .Y(n81) );
  OAI22X1 U192 ( .A(outreg_data[1]), .B(n351), .C(\regs_matrix[2][1] ), .D(n68), .Y(n83) );
  OAI22X1 U193 ( .A(\regs_matrix[4][1] ), .B(n1), .C(\regs_matrix[6][1] ), .D(
        n349), .Y(n82) );
  NOR2X1 U194 ( .A(n84), .B(n85), .Y(n80) );
  OAI21X1 U195 ( .A(\regs_matrix[3][1] ), .B(n14), .C(n86), .Y(n85) );
  AOI21X1 U196 ( .A(n65), .B(n87), .C(N13), .Y(n86) );
  INVX2 U197 ( .A(\regs_matrix[1][1] ), .Y(n87) );
  OAI22X1 U198 ( .A(\regs_matrix[5][1] ), .B(n360), .C(\regs_matrix[7][1] ), 
        .D(n355), .Y(n84) );
  NOR2X1 U199 ( .A(n88), .B(n89), .Y(n79) );
  OAI22X1 U200 ( .A(\regs_matrix[8][1] ), .B(n371), .C(\regs_matrix[10][1] ), 
        .D(n358), .Y(n89) );
  OAI22X1 U201 ( .A(\regs_matrix[12][1] ), .B(n354), .C(\regs_matrix[14][1] ), 
        .D(n348), .Y(n88) );
  NOR2X1 U202 ( .A(n90), .B(n91), .Y(n78) );
  OAI21X1 U203 ( .A(\regs_matrix[11][1] ), .B(n368), .C(n92), .Y(n91) );
  AOI21X1 U204 ( .A(n366), .B(n93), .C(n51), .Y(n92) );
  INVX2 U205 ( .A(\regs_matrix[9][1] ), .Y(n93) );
  OAI22X1 U206 ( .A(\regs_matrix[13][1] ), .B(n361), .C(\regs_matrix[15][1] ), 
        .D(n39), .Y(n90) );
  AOI22X1 U207 ( .A(n95), .B(n96), .C(n97), .D(n98), .Y(n94) );
  NOR2X1 U208 ( .A(n99), .B(n100), .Y(n98) );
  OAI22X1 U209 ( .A(outreg_data[2]), .B(n351), .C(\regs_matrix[2][2] ), .D(n33), .Y(n100) );
  OAI22X1 U210 ( .A(\regs_matrix[4][2] ), .B(n353), .C(\regs_matrix[6][2] ), 
        .D(n349), .Y(n99) );
  NOR2X1 U211 ( .A(n101), .B(n102), .Y(n97) );
  OAI21X1 U212 ( .A(\regs_matrix[3][2] ), .B(n367), .C(n103), .Y(n102) );
  AOI21X1 U213 ( .A(n65), .B(n104), .C(N13), .Y(n103) );
  INVX2 U214 ( .A(\regs_matrix[1][2] ), .Y(n104) );
  OAI22X1 U215 ( .A(\regs_matrix[5][2] ), .B(n360), .C(\regs_matrix[7][2] ), 
        .D(n355), .Y(n101) );
  NOR2X1 U216 ( .A(n105), .B(n106), .Y(n96) );
  OAI22X1 U217 ( .A(\regs_matrix[8][2] ), .B(n371), .C(\regs_matrix[10][2] ), 
        .D(n358), .Y(n106) );
  OAI22X1 U218 ( .A(\regs_matrix[12][2] ), .B(n354), .C(\regs_matrix[14][2] ), 
        .D(n348), .Y(n105) );
  NOR2X1 U219 ( .A(n107), .B(n108), .Y(n95) );
  OAI21X1 U220 ( .A(\regs_matrix[11][2] ), .B(n368), .C(n109), .Y(n108) );
  AOI21X1 U221 ( .A(n366), .B(n110), .C(n51), .Y(n109) );
  INVX2 U222 ( .A(\regs_matrix[9][2] ), .Y(n110) );
  OAI22X1 U223 ( .A(\regs_matrix[13][2] ), .B(n361), .C(\regs_matrix[15][2] ), 
        .D(n39), .Y(n107) );
  AOI22X1 U224 ( .A(n112), .B(n113), .C(n114), .D(n115), .Y(n111) );
  NOR2X1 U225 ( .A(n116), .B(n117), .Y(n115) );
  OAI22X1 U226 ( .A(outreg_data[3]), .B(n351), .C(\regs_matrix[2][3] ), .D(n68), .Y(n117) );
  OAI22X1 U227 ( .A(\regs_matrix[4][3] ), .B(n1), .C(\regs_matrix[6][3] ), .D(
        n349), .Y(n116) );
  NOR2X1 U228 ( .A(n118), .B(n119), .Y(n114) );
  OAI21X1 U229 ( .A(\regs_matrix[3][3] ), .B(n367), .C(n120), .Y(n119) );
  AOI21X1 U230 ( .A(n65), .B(n121), .C(N13), .Y(n120) );
  INVX2 U231 ( .A(\regs_matrix[1][3] ), .Y(n121) );
  OAI22X1 U232 ( .A(\regs_matrix[5][3] ), .B(n360), .C(\regs_matrix[7][3] ), 
        .D(n355), .Y(n118) );
  NOR2X1 U233 ( .A(n122), .B(n123), .Y(n113) );
  OAI22X1 U234 ( .A(\regs_matrix[8][3] ), .B(n371), .C(\regs_matrix[10][3] ), 
        .D(n358), .Y(n123) );
  OAI22X1 U235 ( .A(\regs_matrix[12][3] ), .B(n354), .C(\regs_matrix[14][3] ), 
        .D(n348), .Y(n122) );
  NOR2X1 U236 ( .A(n124), .B(n125), .Y(n112) );
  OAI21X1 U237 ( .A(\regs_matrix[11][3] ), .B(n368), .C(n126), .Y(n125) );
  AOI21X1 U238 ( .A(n366), .B(n127), .C(n51), .Y(n126) );
  INVX2 U239 ( .A(\regs_matrix[9][3] ), .Y(n127) );
  OAI22X1 U240 ( .A(\regs_matrix[13][3] ), .B(n361), .C(\regs_matrix[15][3] ), 
        .D(n39), .Y(n124) );
  AOI22X1 U241 ( .A(n129), .B(n130), .C(n131), .D(n132), .Y(n128) );
  NOR2X1 U242 ( .A(n133), .B(n134), .Y(n132) );
  OAI22X1 U243 ( .A(outreg_data[4]), .B(n351), .C(\regs_matrix[2][4] ), .D(n33), .Y(n134) );
  OAI22X1 U244 ( .A(\regs_matrix[4][4] ), .B(n353), .C(\regs_matrix[6][4] ), 
        .D(n349), .Y(n133) );
  NOR2X1 U245 ( .A(n135), .B(n136), .Y(n131) );
  OAI21X1 U246 ( .A(\regs_matrix[3][4] ), .B(n367), .C(n137), .Y(n136) );
  AOI21X1 U247 ( .A(n65), .B(n138), .C(N13), .Y(n137) );
  INVX2 U248 ( .A(\regs_matrix[1][4] ), .Y(n138) );
  OAI22X1 U249 ( .A(\regs_matrix[5][4] ), .B(n38), .C(\regs_matrix[7][4] ), 
        .D(n40), .Y(n135) );
  NOR2X1 U250 ( .A(n139), .B(n140), .Y(n130) );
  OAI22X1 U251 ( .A(\regs_matrix[8][4] ), .B(n371), .C(\regs_matrix[10][4] ), 
        .D(n358), .Y(n140) );
  OAI22X1 U252 ( .A(\regs_matrix[12][4] ), .B(n354), .C(\regs_matrix[14][4] ), 
        .D(n348), .Y(n139) );
  NOR2X1 U253 ( .A(n141), .B(n142), .Y(n129) );
  OAI21X1 U254 ( .A(\regs_matrix[11][4] ), .B(n368), .C(n143), .Y(n142) );
  AOI21X1 U255 ( .A(n366), .B(n144), .C(n51), .Y(n143) );
  INVX2 U256 ( .A(\regs_matrix[9][4] ), .Y(n144) );
  OAI22X1 U257 ( .A(\regs_matrix[13][4] ), .B(n361), .C(\regs_matrix[15][4] ), 
        .D(n39), .Y(n141) );
  AOI22X1 U258 ( .A(n146), .B(n147), .C(n148), .D(n149), .Y(n145) );
  NOR2X1 U259 ( .A(n150), .B(n151), .Y(n149) );
  OAI22X1 U260 ( .A(outreg_data[5]), .B(n351), .C(\regs_matrix[2][5] ), .D(n68), .Y(n151) );
  OAI22X1 U261 ( .A(\regs_matrix[4][5] ), .B(n1), .C(\regs_matrix[6][5] ), .D(
        n349), .Y(n150) );
  NOR2X1 U262 ( .A(n152), .B(n153), .Y(n148) );
  OAI21X1 U263 ( .A(\regs_matrix[3][5] ), .B(n364), .C(n154), .Y(n153) );
  AOI21X1 U264 ( .A(n370), .B(n155), .C(N13), .Y(n154) );
  INVX2 U265 ( .A(\regs_matrix[1][5] ), .Y(n155) );
  OAI22X1 U266 ( .A(\regs_matrix[5][5] ), .B(n38), .C(\regs_matrix[7][5] ), 
        .D(n40), .Y(n152) );
  NOR2X1 U267 ( .A(n156), .B(n157), .Y(n147) );
  OAI22X1 U268 ( .A(\regs_matrix[8][5] ), .B(n3), .C(\regs_matrix[10][5] ), 
        .D(n358), .Y(n157) );
  OAI22X1 U269 ( .A(\regs_matrix[12][5] ), .B(n354), .C(\regs_matrix[14][5] ), 
        .D(n348), .Y(n156) );
  NOR2X1 U270 ( .A(n158), .B(n159), .Y(n146) );
  OAI21X1 U271 ( .A(\regs_matrix[11][5] ), .B(n368), .C(n160), .Y(n159) );
  AOI21X1 U272 ( .A(n366), .B(n161), .C(n51), .Y(n160) );
  INVX2 U273 ( .A(\regs_matrix[9][5] ), .Y(n161) );
  OAI22X1 U274 ( .A(\regs_matrix[13][5] ), .B(n361), .C(\regs_matrix[15][5] ), 
        .D(n39), .Y(n158) );
  AOI22X1 U275 ( .A(n163), .B(n164), .C(n165), .D(n166), .Y(n162) );
  NOR2X1 U276 ( .A(n167), .B(n168), .Y(n166) );
  OAI22X1 U277 ( .A(outreg_data[6]), .B(n351), .C(\regs_matrix[2][6] ), .D(n68), .Y(n168) );
  OAI22X1 U278 ( .A(\regs_matrix[4][6] ), .B(n353), .C(\regs_matrix[6][6] ), 
        .D(n349), .Y(n167) );
  NOR2X1 U279 ( .A(n169), .B(n170), .Y(n165) );
  OAI21X1 U280 ( .A(\regs_matrix[3][6] ), .B(n367), .C(n171), .Y(n170) );
  AOI21X1 U281 ( .A(n65), .B(n172), .C(N13), .Y(n171) );
  INVX2 U282 ( .A(\regs_matrix[1][6] ), .Y(n172) );
  OAI22X1 U283 ( .A(\regs_matrix[5][6] ), .B(n360), .C(\regs_matrix[7][6] ), 
        .D(n40), .Y(n169) );
  NOR2X1 U284 ( .A(n173), .B(n174), .Y(n164) );
  OAI22X1 U285 ( .A(\regs_matrix[8][6] ), .B(n3), .C(\regs_matrix[10][6] ), 
        .D(n358), .Y(n174) );
  OAI22X1 U286 ( .A(\regs_matrix[12][6] ), .B(n354), .C(\regs_matrix[14][6] ), 
        .D(n348), .Y(n173) );
  NOR2X1 U287 ( .A(n175), .B(n176), .Y(n163) );
  OAI21X1 U288 ( .A(\regs_matrix[11][6] ), .B(n368), .C(n177), .Y(n176) );
  AOI21X1 U289 ( .A(n366), .B(n178), .C(n51), .Y(n177) );
  INVX2 U290 ( .A(\regs_matrix[9][6] ), .Y(n178) );
  OAI22X1 U291 ( .A(\regs_matrix[13][6] ), .B(n361), .C(\regs_matrix[15][6] ), 
        .D(n39), .Y(n175) );
  AOI22X1 U292 ( .A(n180), .B(n181), .C(n182), .D(n183), .Y(n179) );
  NOR2X1 U293 ( .A(n184), .B(n185), .Y(n183) );
  OAI22X1 U294 ( .A(outreg_data[7]), .B(n351), .C(\regs_matrix[2][7] ), .D(n68), .Y(n185) );
  OAI22X1 U295 ( .A(\regs_matrix[4][7] ), .B(n1), .C(\regs_matrix[6][7] ), .D(
        n349), .Y(n184) );
  NOR2X1 U296 ( .A(n186), .B(n187), .Y(n182) );
  OAI21X1 U297 ( .A(\regs_matrix[3][7] ), .B(n365), .C(n188), .Y(n187) );
  AOI21X1 U298 ( .A(n65), .B(n189), .C(N13), .Y(n188) );
  INVX2 U299 ( .A(\regs_matrix[1][7] ), .Y(n189) );
  OAI22X1 U300 ( .A(\regs_matrix[5][7] ), .B(n360), .C(\regs_matrix[7][7] ), 
        .D(n355), .Y(n186) );
  NOR2X1 U301 ( .A(n190), .B(n191), .Y(n181) );
  OAI22X1 U302 ( .A(\regs_matrix[8][7] ), .B(n3), .C(\regs_matrix[10][7] ), 
        .D(n358), .Y(n191) );
  OAI22X1 U303 ( .A(\regs_matrix[12][7] ), .B(n354), .C(\regs_matrix[14][7] ), 
        .D(n348), .Y(n190) );
  NOR2X1 U304 ( .A(n192), .B(n193), .Y(n180) );
  OAI21X1 U305 ( .A(\regs_matrix[11][7] ), .B(n368), .C(n194), .Y(n193) );
  AOI21X1 U306 ( .A(n366), .B(n195), .C(n51), .Y(n194) );
  INVX2 U307 ( .A(\regs_matrix[9][7] ), .Y(n195) );
  OAI22X1 U308 ( .A(\regs_matrix[13][7] ), .B(n361), .C(\regs_matrix[15][7] ), 
        .D(n39), .Y(n192) );
  AOI22X1 U309 ( .A(n197), .B(n198), .C(n199), .D(n200), .Y(n196) );
  NOR2X1 U310 ( .A(n201), .B(n202), .Y(n200) );
  OAI22X1 U311 ( .A(outreg_data[8]), .B(n351), .C(\regs_matrix[2][8] ), .D(n68), .Y(n202) );
  OAI22X1 U312 ( .A(\regs_matrix[4][8] ), .B(n353), .C(\regs_matrix[6][8] ), 
        .D(n349), .Y(n201) );
  NOR2X1 U313 ( .A(n203), .B(n204), .Y(n199) );
  OAI21X1 U314 ( .A(\regs_matrix[3][8] ), .B(n14), .C(n205), .Y(n204) );
  AOI21X1 U315 ( .A(n65), .B(n206), .C(N13), .Y(n205) );
  INVX2 U316 ( .A(\regs_matrix[1][8] ), .Y(n206) );
  OAI22X1 U317 ( .A(\regs_matrix[5][8] ), .B(n360), .C(\regs_matrix[7][8] ), 
        .D(n40), .Y(n203) );
  NOR2X1 U318 ( .A(n207), .B(n208), .Y(n198) );
  OAI22X1 U319 ( .A(\regs_matrix[8][8] ), .B(n3), .C(\regs_matrix[10][8] ), 
        .D(n358), .Y(n208) );
  OAI22X1 U320 ( .A(\regs_matrix[12][8] ), .B(n354), .C(\regs_matrix[14][8] ), 
        .D(n348), .Y(n207) );
  NOR2X1 U321 ( .A(n209), .B(n210), .Y(n197) );
  OAI21X1 U322 ( .A(\regs_matrix[11][8] ), .B(n368), .C(n211), .Y(n210) );
  AOI21X1 U323 ( .A(n366), .B(n212), .C(n51), .Y(n211) );
  INVX2 U324 ( .A(\regs_matrix[9][8] ), .Y(n212) );
  OAI22X1 U325 ( .A(\regs_matrix[13][8] ), .B(n361), .C(\regs_matrix[15][8] ), 
        .D(n39), .Y(n209) );
  AOI22X1 U326 ( .A(n214), .B(n215), .C(n216), .D(n217), .Y(n213) );
  NOR2X1 U327 ( .A(n218), .B(n219), .Y(n217) );
  OAI22X1 U328 ( .A(outreg_data[9]), .B(n351), .C(\regs_matrix[2][9] ), .D(n33), .Y(n219) );
  OAI22X1 U329 ( .A(\regs_matrix[4][9] ), .B(n1), .C(\regs_matrix[6][9] ), .D(
        n349), .Y(n218) );
  NOR2X1 U330 ( .A(n220), .B(n221), .Y(n216) );
  OAI21X1 U331 ( .A(\regs_matrix[3][9] ), .B(n365), .C(n222), .Y(n221) );
  AOI21X1 U332 ( .A(n65), .B(n223), .C(N13), .Y(n222) );
  INVX2 U333 ( .A(\regs_matrix[1][9] ), .Y(n223) );
  OAI22X1 U334 ( .A(\regs_matrix[5][9] ), .B(n360), .C(\regs_matrix[7][9] ), 
        .D(n40), .Y(n220) );
  NOR2X1 U335 ( .A(n224), .B(n225), .Y(n215) );
  OAI22X1 U336 ( .A(\regs_matrix[8][9] ), .B(n351), .C(\regs_matrix[10][9] ), 
        .D(n358), .Y(n225) );
  OAI22X1 U337 ( .A(\regs_matrix[12][9] ), .B(n354), .C(\regs_matrix[14][9] ), 
        .D(n348), .Y(n224) );
  NOR2X1 U338 ( .A(n226), .B(n227), .Y(n214) );
  OAI21X1 U339 ( .A(\regs_matrix[11][9] ), .B(n368), .C(n228), .Y(n227) );
  AOI21X1 U340 ( .A(n366), .B(n229), .C(n51), .Y(n228) );
  INVX2 U341 ( .A(\regs_matrix[9][9] ), .Y(n229) );
  OAI22X1 U342 ( .A(\regs_matrix[13][9] ), .B(n361), .C(\regs_matrix[15][9] ), 
        .D(n39), .Y(n226) );
  AOI22X1 U343 ( .A(n231), .B(n232), .C(n233), .D(n234), .Y(n230) );
  NOR2X1 U344 ( .A(n235), .B(n236), .Y(n234) );
  OAI22X1 U345 ( .A(outreg_data[10]), .B(n351), .C(\regs_matrix[2][10] ), .D(
        n33), .Y(n236) );
  OAI22X1 U346 ( .A(\regs_matrix[4][10] ), .B(n353), .C(\regs_matrix[6][10] ), 
        .D(n349), .Y(n235) );
  NOR2X1 U347 ( .A(n237), .B(n238), .Y(n233) );
  OAI21X1 U348 ( .A(\regs_matrix[3][10] ), .B(n14), .C(n239), .Y(n238) );
  AOI21X1 U349 ( .A(n370), .B(n240), .C(N13), .Y(n239) );
  INVX2 U350 ( .A(\regs_matrix[1][10] ), .Y(n240) );
  OAI22X1 U351 ( .A(\regs_matrix[5][10] ), .B(n360), .C(\regs_matrix[7][10] ), 
        .D(n355), .Y(n237) );
  NOR2X1 U352 ( .A(n241), .B(n242), .Y(n232) );
  OAI22X1 U353 ( .A(\regs_matrix[8][10] ), .B(n3), .C(\regs_matrix[10][10] ), 
        .D(n358), .Y(n242) );
  OAI22X1 U354 ( .A(\regs_matrix[12][10] ), .B(n354), .C(\regs_matrix[14][10] ), .D(n348), .Y(n241) );
  NOR2X1 U355 ( .A(n243), .B(n244), .Y(n231) );
  OAI21X1 U356 ( .A(\regs_matrix[11][10] ), .B(n368), .C(n245), .Y(n244) );
  AOI21X1 U357 ( .A(n366), .B(n246), .C(n51), .Y(n245) );
  INVX2 U358 ( .A(\regs_matrix[9][10] ), .Y(n246) );
  OAI22X1 U359 ( .A(\regs_matrix[13][10] ), .B(n361), .C(\regs_matrix[15][10] ), .D(n39), .Y(n243) );
  AOI22X1 U360 ( .A(n248), .B(n249), .C(n250), .D(n251), .Y(n247) );
  NOR2X1 U361 ( .A(n252), .B(n253), .Y(n251) );
  OAI22X1 U362 ( .A(outreg_data[11]), .B(n351), .C(\regs_matrix[2][11] ), .D(
        n33), .Y(n253) );
  OAI22X1 U363 ( .A(\regs_matrix[4][11] ), .B(n1), .C(\regs_matrix[6][11] ), 
        .D(n349), .Y(n252) );
  NOR2X1 U364 ( .A(n254), .B(n255), .Y(n250) );
  OAI21X1 U365 ( .A(\regs_matrix[3][11] ), .B(n14), .C(n256), .Y(n255) );
  AOI21X1 U366 ( .A(n65), .B(n257), .C(N13), .Y(n256) );
  INVX2 U367 ( .A(\regs_matrix[1][11] ), .Y(n257) );
  OAI22X1 U368 ( .A(\regs_matrix[5][11] ), .B(n360), .C(\regs_matrix[7][11] ), 
        .D(n40), .Y(n254) );
  NOR2X1 U369 ( .A(n258), .B(n259), .Y(n249) );
  OAI22X1 U370 ( .A(\regs_matrix[8][11] ), .B(n371), .C(\regs_matrix[10][11] ), 
        .D(n358), .Y(n259) );
  OAI22X1 U371 ( .A(\regs_matrix[12][11] ), .B(n354), .C(\regs_matrix[14][11] ), .D(n348), .Y(n258) );
  NOR2X1 U372 ( .A(n260), .B(n261), .Y(n248) );
  OAI21X1 U373 ( .A(\regs_matrix[11][11] ), .B(n368), .C(n262), .Y(n261) );
  AOI21X1 U374 ( .A(n366), .B(n263), .C(n51), .Y(n262) );
  INVX2 U375 ( .A(\regs_matrix[9][11] ), .Y(n263) );
  OAI22X1 U376 ( .A(\regs_matrix[13][11] ), .B(n361), .C(\regs_matrix[15][11] ), .D(n39), .Y(n260) );
  AOI22X1 U377 ( .A(n265), .B(n266), .C(n267), .D(n268), .Y(n264) );
  NOR2X1 U378 ( .A(n269), .B(n270), .Y(n268) );
  OAI22X1 U379 ( .A(outreg_data[12]), .B(n351), .C(\regs_matrix[2][12] ), .D(
        n33), .Y(n270) );
  OAI22X1 U380 ( .A(\regs_matrix[4][12] ), .B(n353), .C(\regs_matrix[6][12] ), 
        .D(n349), .Y(n269) );
  NOR2X1 U381 ( .A(n272), .B(n271), .Y(n267) );
  OAI21X1 U382 ( .A(\regs_matrix[3][12] ), .B(n14), .C(n273), .Y(n272) );
  AOI21X1 U383 ( .A(n370), .B(n274), .C(N13), .Y(n273) );
  INVX2 U384 ( .A(\regs_matrix[1][12] ), .Y(n274) );
  OAI22X1 U385 ( .A(\regs_matrix[5][12] ), .B(n360), .C(\regs_matrix[7][12] ), 
        .D(n40), .Y(n271) );
  NOR2X1 U386 ( .A(n275), .B(n276), .Y(n266) );
  OAI22X1 U387 ( .A(\regs_matrix[8][12] ), .B(n3), .C(\regs_matrix[10][12] ), 
        .D(n358), .Y(n276) );
  OAI22X1 U388 ( .A(\regs_matrix[12][12] ), .B(n354), .C(\regs_matrix[14][12] ), .D(n348), .Y(n275) );
  NOR2X1 U389 ( .A(n277), .B(n278), .Y(n265) );
  OAI21X1 U390 ( .A(\regs_matrix[11][12] ), .B(n364), .C(n279), .Y(n278) );
  AOI21X1 U391 ( .A(n366), .B(n280), .C(n51), .Y(n279) );
  INVX2 U392 ( .A(\regs_matrix[9][12] ), .Y(n280) );
  OAI22X1 U393 ( .A(\regs_matrix[13][12] ), .B(n361), .C(\regs_matrix[15][12] ), .D(n39), .Y(n277) );
  AOI22X1 U394 ( .A(n282), .B(n283), .C(n284), .D(n285), .Y(n281) );
  NOR2X1 U395 ( .A(n286), .B(n287), .Y(n285) );
  OAI22X1 U396 ( .A(outreg_data[13]), .B(n351), .C(\regs_matrix[2][13] ), .D(
        n68), .Y(n287) );
  OAI22X1 U397 ( .A(\regs_matrix[4][13] ), .B(n1), .C(\regs_matrix[6][13] ), 
        .D(n349), .Y(n286) );
  NOR2X1 U398 ( .A(n288), .B(n289), .Y(n284) );
  OAI21X1 U399 ( .A(\regs_matrix[3][13] ), .B(n364), .C(n290), .Y(n289) );
  AOI21X1 U400 ( .A(n65), .B(n291), .C(N13), .Y(n290) );
  INVX2 U401 ( .A(\regs_matrix[1][13] ), .Y(n291) );
  OAI22X1 U402 ( .A(\regs_matrix[5][13] ), .B(n360), .C(\regs_matrix[7][13] ), 
        .D(n40), .Y(n288) );
  NOR2X1 U403 ( .A(n292), .B(n293), .Y(n283) );
  OAI22X1 U404 ( .A(\regs_matrix[8][13] ), .B(n371), .C(\regs_matrix[10][13] ), 
        .D(n358), .Y(n293) );
  OAI22X1 U405 ( .A(\regs_matrix[12][13] ), .B(n354), .C(\regs_matrix[14][13] ), .D(n348), .Y(n292) );
  NOR2X1 U406 ( .A(n294), .B(n295), .Y(n282) );
  OAI21X1 U407 ( .A(\regs_matrix[11][13] ), .B(n364), .C(n296), .Y(n295) );
  AOI21X1 U408 ( .A(n366), .B(n297), .C(n51), .Y(n296) );
  INVX2 U409 ( .A(\regs_matrix[9][13] ), .Y(n297) );
  OAI22X1 U410 ( .A(\regs_matrix[13][13] ), .B(n361), .C(\regs_matrix[15][13] ), .D(n39), .Y(n294) );
  AOI22X1 U411 ( .A(n299), .B(n300), .C(n301), .D(n302), .Y(n298) );
  NOR2X1 U412 ( .A(n303), .B(n304), .Y(n302) );
  OAI22X1 U413 ( .A(outreg_data[14]), .B(n351), .C(\regs_matrix[2][14] ), .D(
        n33), .Y(n304) );
  OAI22X1 U414 ( .A(\regs_matrix[4][14] ), .B(n353), .C(\regs_matrix[6][14] ), 
        .D(n349), .Y(n303) );
  NOR2X1 U415 ( .A(n305), .B(n306), .Y(n301) );
  OAI21X1 U416 ( .A(\regs_matrix[3][14] ), .B(n364), .C(n307), .Y(n306) );
  AOI21X1 U417 ( .A(n65), .B(n308), .C(N13), .Y(n307) );
  INVX2 U418 ( .A(\regs_matrix[1][14] ), .Y(n308) );
  OAI22X1 U419 ( .A(\regs_matrix[5][14] ), .B(n360), .C(\regs_matrix[7][14] ), 
        .D(n40), .Y(n305) );
  NOR2X1 U420 ( .A(n309), .B(n310), .Y(n300) );
  OAI22X1 U421 ( .A(\regs_matrix[8][14] ), .B(n3), .C(\regs_matrix[10][14] ), 
        .D(n358), .Y(n310) );
  OAI22X1 U422 ( .A(\regs_matrix[12][14] ), .B(n354), .C(\regs_matrix[14][14] ), .D(n348), .Y(n309) );
  NOR2X1 U423 ( .A(n311), .B(n312), .Y(n299) );
  OAI21X1 U424 ( .A(\regs_matrix[11][14] ), .B(n364), .C(n313), .Y(n312) );
  AOI21X1 U425 ( .A(n366), .B(n314), .C(n51), .Y(n313) );
  INVX2 U426 ( .A(\regs_matrix[9][14] ), .Y(n314) );
  OAI22X1 U427 ( .A(\regs_matrix[13][14] ), .B(n361), .C(\regs_matrix[15][14] ), .D(n39), .Y(n311) );
  AOI22X1 U428 ( .A(n316), .B(n317), .C(n318), .D(n319), .Y(n315) );
  NOR2X1 U429 ( .A(n320), .B(n321), .Y(n319) );
  OAI22X1 U430 ( .A(outreg_data[15]), .B(n351), .C(\regs_matrix[2][15] ), .D(
        n33), .Y(n321) );
  OAI22X1 U431 ( .A(\regs_matrix[4][15] ), .B(n353), .C(\regs_matrix[6][15] ), 
        .D(n349), .Y(n320) );
  NOR2X1 U432 ( .A(n322), .B(n323), .Y(n318) );
  OAI21X1 U433 ( .A(\regs_matrix[3][15] ), .B(n364), .C(n324), .Y(n323) );
  AOI21X1 U434 ( .A(n65), .B(n325), .C(N13), .Y(n324) );
  INVX2 U435 ( .A(\regs_matrix[1][15] ), .Y(n325) );
  OAI22X1 U436 ( .A(\regs_matrix[5][15] ), .B(n38), .C(\regs_matrix[7][15] ), 
        .D(n40), .Y(n322) );
  NOR2X1 U437 ( .A(n326), .B(n327), .Y(n317) );
  OAI22X1 U438 ( .A(\regs_matrix[8][15] ), .B(n371), .C(\regs_matrix[10][15] ), 
        .D(n358), .Y(n327) );
  OAI22X1 U439 ( .A(\regs_matrix[12][15] ), .B(n354), .C(\regs_matrix[14][15] ), .D(n348), .Y(n326) );
  NOR2X1 U440 ( .A(n328), .B(n329), .Y(n316) );
  OAI21X1 U441 ( .A(\regs_matrix[11][15] ), .B(n364), .C(n330), .Y(n329) );
  AOI21X1 U442 ( .A(n366), .B(n331), .C(n51), .Y(n330) );
  INVX2 U443 ( .A(\regs_matrix[9][15] ), .Y(n331) );
  OAI22X1 U444 ( .A(\regs_matrix[13][15] ), .B(n361), .C(\regs_matrix[15][15] ), .D(n39), .Y(n328) );
  NOR2X1 U445 ( .A(n333), .B(n334), .Y(n46) );
  OAI21X1 U446 ( .A(outreg_data[16]), .B(n3), .C(n335), .Y(n334) );
  AOI21X1 U447 ( .A(n357), .B(n336), .C(N13), .Y(n335) );
  INVX2 U448 ( .A(\regs_matrix[2][16] ), .Y(n336) );
  OAI22X1 U449 ( .A(\regs_matrix[4][16] ), .B(n353), .C(\regs_matrix[6][16] ), 
        .D(n348), .Y(n333) );
  NOR2X1 U450 ( .A(n337), .B(n338), .Y(n47) );
  OAI22X1 U451 ( .A(\regs_matrix[3][16] ), .B(n364), .C(\regs_matrix[1][16] ), 
        .D(n356), .Y(n338) );
  OAI22X1 U452 ( .A(\regs_matrix[5][16] ), .B(n38), .C(\regs_matrix[7][16] ), 
        .D(n39), .Y(n337) );
  NOR3X1 U453 ( .A(n339), .B(n340), .C(n341), .Y(n48) );
  OAI22X1 U454 ( .A(\regs_matrix[10][16] ), .B(n358), .C(\regs_matrix[8][16] ), 
        .D(n371), .Y(n341) );
  NAND3X1 U455 ( .A(n342), .B(n34), .C(n344), .Y(n60) );
  NAND3X1 U456 ( .A(n4), .B(n34), .C(n344), .Y(n68) );
  NOR2X1 U457 ( .A(\regs_matrix[12][16] ), .B(n354), .Y(n340) );
  NAND3X1 U458 ( .A(n35), .B(n342), .C(n344), .Y(n61) );
  OAI22X1 U459 ( .A(\regs_matrix[9][16] ), .B(n356), .C(\regs_matrix[14][16] ), 
        .D(n348), .Y(n339) );
  NAND3X1 U460 ( .A(N12), .B(n4), .C(n344), .Y(n59) );
  NAND3X1 U461 ( .A(N10), .B(n343), .C(n342), .Y(n332) );
  NOR2X1 U462 ( .A(n345), .B(n346), .Y(n49) );
  OAI21X1 U463 ( .A(\regs_matrix[11][16] ), .B(n368), .C(N13), .Y(n346) );
  OAI22X1 U464 ( .A(\regs_matrix[15][16] ), .B(n39), .C(\regs_matrix[13][16] ), 
        .D(n361), .Y(n345) );
  NAND3X1 U465 ( .A(N12), .B(N10), .C(n342), .Y(n69) );
  INVX2 U466 ( .A(N11), .Y(n342) );
  INVX8 U467 ( .A(n350), .Y(n351) );
  INVX8 U468 ( .A(n362), .Y(n364) );
  INVX1 U469 ( .A(n65), .Y(n356) );
  INVX2 U470 ( .A(n356), .Y(n366) );
  INVX1 U471 ( .A(n362), .Y(n368) );
  AND2X2 U472 ( .A(n45), .B(n343), .Y(n369) );
  INVX4 U473 ( .A(n332), .Y(n65) );
  INVX1 U474 ( .A(n332), .Y(n370) );
  BUFX2 U475 ( .A(n3), .Y(n371) );
  INVX4 U476 ( .A(n59), .Y(n347) );
  INVX4 U477 ( .A(n111), .Y(r1_data[3]) );
  NAND3X1 U478 ( .A(n35), .B(n344), .C(n342), .Y(n373) );
  BUFX2 U479 ( .A(n32), .Y(n357) );
  INVX2 U480 ( .A(n357), .Y(n358) );
  NAND3X1 U481 ( .A(n4), .B(n34), .C(n344), .Y(n374) );
  INVX4 U482 ( .A(n196), .Y(r1_data[8]) );
  AOI22X1 U483 ( .A(n378), .B(n377), .C(n376), .D(n375), .Y(n379) );
  INVX2 U484 ( .A(n379), .Y(r2_data[16]) );
  MUX2X1 U485 ( .B(n380), .A(n381), .S(n658), .Y(r2_data[0]) );
  NAND2X1 U486 ( .A(n382), .B(n383), .Y(n381) );
  NOR2X1 U487 ( .A(n385), .B(n384), .Y(n383) );
  OAI22X1 U488 ( .A(\regs_matrix[8][0] ), .B(n629), .C(\regs_matrix[10][0] ), 
        .D(n15), .Y(n385) );
  OAI22X1 U489 ( .A(\regs_matrix[12][0] ), .B(n639), .C(\regs_matrix[14][0] ), 
        .D(n642), .Y(n384) );
  NOR2X1 U490 ( .A(n390), .B(n391), .Y(n382) );
  OAI22X1 U491 ( .A(\regs_matrix[11][0] ), .B(n644), .C(\regs_matrix[9][0] ), 
        .D(n650), .Y(n391) );
  OAI22X1 U492 ( .A(\regs_matrix[13][0] ), .B(n652), .C(\regs_matrix[15][0] ), 
        .D(n657), .Y(n390) );
  NAND2X1 U493 ( .A(n394), .B(n395), .Y(n380) );
  NOR2X1 U494 ( .A(n396), .B(n397), .Y(n395) );
  OAI22X1 U495 ( .A(outreg_data[0]), .B(n629), .C(\regs_matrix[2][0] ), .D(n24), .Y(n397) );
  OAI22X1 U496 ( .A(\regs_matrix[4][0] ), .B(n637), .C(\regs_matrix[6][0] ), 
        .D(n643), .Y(n396) );
  NOR2X1 U497 ( .A(n398), .B(n399), .Y(n394) );
  OAI22X1 U498 ( .A(\regs_matrix[3][0] ), .B(n645), .C(\regs_matrix[1][0] ), 
        .D(n650), .Y(n399) );
  OAI22X1 U499 ( .A(\regs_matrix[5][0] ), .B(n652), .C(\regs_matrix[7][0] ), 
        .D(n657), .Y(n398) );
  MUX2X1 U500 ( .B(n400), .A(n401), .S(n659), .Y(r2_data[1]) );
  NAND2X1 U501 ( .A(n402), .B(n403), .Y(n401) );
  NOR2X1 U502 ( .A(n404), .B(n405), .Y(n403) );
  OAI22X1 U503 ( .A(\regs_matrix[8][1] ), .B(n629), .C(\regs_matrix[10][1] ), 
        .D(n20), .Y(n405) );
  OAI22X1 U504 ( .A(\regs_matrix[12][1] ), .B(n639), .C(\regs_matrix[14][1] ), 
        .D(n643), .Y(n404) );
  NOR2X1 U505 ( .A(n406), .B(n407), .Y(n402) );
  OAI22X1 U506 ( .A(\regs_matrix[11][1] ), .B(n644), .C(\regs_matrix[9][1] ), 
        .D(n650), .Y(n407) );
  OAI22X1 U507 ( .A(\regs_matrix[13][1] ), .B(n652), .C(\regs_matrix[15][1] ), 
        .D(n657), .Y(n406) );
  NAND2X1 U508 ( .A(n408), .B(n409), .Y(n400) );
  NOR2X1 U509 ( .A(n410), .B(n411), .Y(n409) );
  OAI22X1 U510 ( .A(outreg_data[1]), .B(n629), .C(\regs_matrix[2][1] ), .D(n18), .Y(n411) );
  OAI22X1 U511 ( .A(\regs_matrix[4][1] ), .B(n637), .C(\regs_matrix[6][1] ), 
        .D(n643), .Y(n410) );
  NOR2X1 U512 ( .A(n412), .B(n413), .Y(n408) );
  OAI22X1 U513 ( .A(\regs_matrix[3][1] ), .B(n645), .C(\regs_matrix[1][1] ), 
        .D(n650), .Y(n413) );
  OAI22X1 U514 ( .A(\regs_matrix[5][1] ), .B(n652), .C(\regs_matrix[7][1] ), 
        .D(n657), .Y(n412) );
  MUX2X1 U515 ( .B(n414), .A(n415), .S(n658), .Y(r2_data[2]) );
  NAND2X1 U516 ( .A(n416), .B(n417), .Y(n415) );
  NOR2X1 U517 ( .A(n418), .B(n419), .Y(n417) );
  OAI22X1 U518 ( .A(\regs_matrix[8][2] ), .B(n629), .C(\regs_matrix[10][2] ), 
        .D(n19), .Y(n419) );
  OAI22X1 U519 ( .A(\regs_matrix[12][2] ), .B(n639), .C(\regs_matrix[14][2] ), 
        .D(n643), .Y(n418) );
  NOR2X1 U520 ( .A(n420), .B(n421), .Y(n416) );
  OAI22X1 U521 ( .A(\regs_matrix[11][2] ), .B(n645), .C(\regs_matrix[9][2] ), 
        .D(n650), .Y(n421) );
  OAI22X1 U522 ( .A(\regs_matrix[13][2] ), .B(n652), .C(\regs_matrix[15][2] ), 
        .D(n657), .Y(n420) );
  NAND2X1 U523 ( .A(n422), .B(n423), .Y(n414) );
  NOR2X1 U524 ( .A(n424), .B(n425), .Y(n423) );
  OAI22X1 U525 ( .A(outreg_data[2]), .B(n629), .C(\regs_matrix[2][2] ), .D(n17), .Y(n425) );
  OAI22X1 U526 ( .A(\regs_matrix[4][2] ), .B(n638), .C(\regs_matrix[6][2] ), 
        .D(n643), .Y(n424) );
  NOR2X1 U527 ( .A(n426), .B(n427), .Y(n422) );
  OAI22X1 U528 ( .A(\regs_matrix[3][2] ), .B(n645), .C(\regs_matrix[1][2] ), 
        .D(n650), .Y(n427) );
  OAI22X1 U529 ( .A(\regs_matrix[5][2] ), .B(n652), .C(\regs_matrix[7][2] ), 
        .D(n657), .Y(n426) );
  MUX2X1 U530 ( .B(n428), .A(n429), .S(n659), .Y(r2_data[3]) );
  NAND2X1 U531 ( .A(n430), .B(n431), .Y(n429) );
  NOR2X1 U532 ( .A(n432), .B(n433), .Y(n431) );
  OAI22X1 U533 ( .A(\regs_matrix[8][3] ), .B(n629), .C(\regs_matrix[10][3] ), 
        .D(n25), .Y(n433) );
  OAI22X1 U534 ( .A(\regs_matrix[12][3] ), .B(n638), .C(\regs_matrix[14][3] ), 
        .D(n643), .Y(n432) );
  NOR2X1 U535 ( .A(n434), .B(n435), .Y(n430) );
  OAI22X1 U536 ( .A(\regs_matrix[11][3] ), .B(n644), .C(\regs_matrix[9][3] ), 
        .D(n650), .Y(n435) );
  OAI22X1 U537 ( .A(\regs_matrix[13][3] ), .B(n652), .C(\regs_matrix[15][3] ), 
        .D(n655), .Y(n434) );
  NAND2X1 U538 ( .A(n436), .B(n437), .Y(n428) );
  NOR2X1 U539 ( .A(n438), .B(n439), .Y(n437) );
  OAI22X1 U540 ( .A(outreg_data[3]), .B(n629), .C(\regs_matrix[2][3] ), .D(n21), .Y(n439) );
  OAI22X1 U541 ( .A(\regs_matrix[4][3] ), .B(n638), .C(\regs_matrix[6][3] ), 
        .D(n643), .Y(n438) );
  NOR2X1 U542 ( .A(n440), .B(n441), .Y(n436) );
  OAI22X1 U543 ( .A(\regs_matrix[3][3] ), .B(n645), .C(\regs_matrix[1][3] ), 
        .D(n650), .Y(n441) );
  OAI22X1 U544 ( .A(\regs_matrix[5][3] ), .B(n652), .C(\regs_matrix[7][3] ), 
        .D(n656), .Y(n440) );
  MUX2X1 U545 ( .B(n442), .A(n443), .S(n658), .Y(r2_data[4]) );
  NAND2X1 U546 ( .A(n444), .B(n445), .Y(n443) );
  NOR2X1 U547 ( .A(n446), .B(n447), .Y(n445) );
  OAI22X1 U548 ( .A(\regs_matrix[8][4] ), .B(n630), .C(\regs_matrix[10][4] ), 
        .D(n21), .Y(n447) );
  OAI22X1 U549 ( .A(\regs_matrix[12][4] ), .B(n639), .C(\regs_matrix[14][4] ), 
        .D(n643), .Y(n446) );
  NOR2X1 U550 ( .A(n448), .B(n449), .Y(n444) );
  OAI22X1 U551 ( .A(\regs_matrix[11][4] ), .B(n645), .C(\regs_matrix[9][4] ), 
        .D(n650), .Y(n449) );
  OAI22X1 U552 ( .A(\regs_matrix[13][4] ), .B(n653), .C(\regs_matrix[15][4] ), 
        .D(n655), .Y(n448) );
  NAND2X1 U553 ( .A(n450), .B(n451), .Y(n442) );
  NOR2X1 U554 ( .A(n452), .B(n453), .Y(n451) );
  OAI22X1 U555 ( .A(outreg_data[4]), .B(n630), .C(\regs_matrix[2][4] ), .D(n16), .Y(n453) );
  OAI22X1 U556 ( .A(\regs_matrix[4][4] ), .B(n639), .C(\regs_matrix[6][4] ), 
        .D(n643), .Y(n452) );
  NOR2X1 U557 ( .A(n454), .B(n455), .Y(n450) );
  OAI22X1 U558 ( .A(\regs_matrix[3][4] ), .B(n644), .C(\regs_matrix[1][4] ), 
        .D(n650), .Y(n455) );
  OAI22X1 U559 ( .A(\regs_matrix[5][4] ), .B(n653), .C(\regs_matrix[7][4] ), 
        .D(n655), .Y(n454) );
  MUX2X1 U560 ( .B(n456), .A(n457), .S(n659), .Y(r2_data[5]) );
  NAND2X1 U561 ( .A(n458), .B(n459), .Y(n457) );
  NOR2X1 U562 ( .A(n460), .B(n461), .Y(n459) );
  OAI22X1 U563 ( .A(\regs_matrix[8][5] ), .B(n630), .C(\regs_matrix[10][5] ), 
        .D(n17), .Y(n461) );
  OAI22X1 U564 ( .A(\regs_matrix[12][5] ), .B(n639), .C(\regs_matrix[14][5] ), 
        .D(n643), .Y(n460) );
  NOR2X1 U565 ( .A(n462), .B(n463), .Y(n458) );
  OAI22X1 U566 ( .A(\regs_matrix[11][5] ), .B(n644), .C(\regs_matrix[9][5] ), 
        .D(n650), .Y(n463) );
  OAI22X1 U567 ( .A(\regs_matrix[13][5] ), .B(n653), .C(\regs_matrix[15][5] ), 
        .D(n655), .Y(n462) );
  NAND2X1 U568 ( .A(n464), .B(n465), .Y(n456) );
  NOR2X1 U569 ( .A(n466), .B(n467), .Y(n465) );
  OAI22X1 U570 ( .A(outreg_data[5]), .B(n630), .C(\regs_matrix[2][5] ), .D(n29), .Y(n467) );
  OAI22X1 U571 ( .A(\regs_matrix[4][5] ), .B(n638), .C(\regs_matrix[6][5] ), 
        .D(n643), .Y(n466) );
  NOR2X1 U572 ( .A(n468), .B(n469), .Y(n464) );
  OAI22X1 U573 ( .A(\regs_matrix[3][5] ), .B(n645), .C(\regs_matrix[1][5] ), 
        .D(n650), .Y(n469) );
  OAI22X1 U574 ( .A(\regs_matrix[5][5] ), .B(n653), .C(\regs_matrix[7][5] ), 
        .D(n657), .Y(n468) );
  MUX2X1 U575 ( .B(n470), .A(n471), .S(n658), .Y(r2_data[6]) );
  NAND2X1 U576 ( .A(n472), .B(n473), .Y(n471) );
  NOR2X1 U577 ( .A(n474), .B(n475), .Y(n473) );
  OAI22X1 U578 ( .A(\regs_matrix[8][6] ), .B(n630), .C(\regs_matrix[10][6] ), 
        .D(n22), .Y(n475) );
  OAI22X1 U579 ( .A(\regs_matrix[12][6] ), .B(n637), .C(\regs_matrix[14][6] ), 
        .D(n642), .Y(n474) );
  NOR2X1 U580 ( .A(n476), .B(n477), .Y(n472) );
  OAI22X1 U581 ( .A(\regs_matrix[11][6] ), .B(n645), .C(\regs_matrix[9][6] ), 
        .D(n649), .Y(n477) );
  OAI22X1 U582 ( .A(\regs_matrix[13][6] ), .B(n653), .C(\regs_matrix[15][6] ), 
        .D(n656), .Y(n476) );
  NAND2X1 U583 ( .A(n478), .B(n479), .Y(n470) );
  NOR2X1 U584 ( .A(n480), .B(n481), .Y(n479) );
  OAI22X1 U585 ( .A(outreg_data[6]), .B(n630), .C(\regs_matrix[2][6] ), .D(n19), .Y(n481) );
  OAI22X1 U586 ( .A(\regs_matrix[4][6] ), .B(n639), .C(\regs_matrix[6][6] ), 
        .D(n642), .Y(n480) );
  NOR2X1 U587 ( .A(n482), .B(n483), .Y(n478) );
  OAI22X1 U588 ( .A(\regs_matrix[3][6] ), .B(n645), .C(\regs_matrix[1][6] ), 
        .D(n649), .Y(n483) );
  OAI22X1 U589 ( .A(\regs_matrix[5][6] ), .B(n653), .C(\regs_matrix[7][6] ), 
        .D(n655), .Y(n482) );
  MUX2X1 U590 ( .B(n484), .A(n485), .S(n659), .Y(r2_data[7]) );
  NAND2X1 U591 ( .A(n486), .B(n487), .Y(n485) );
  NOR2X1 U592 ( .A(n489), .B(n488), .Y(n487) );
  OAI22X1 U593 ( .A(\regs_matrix[8][7] ), .B(n630), .C(\regs_matrix[10][7] ), 
        .D(n25), .Y(n489) );
  OAI22X1 U594 ( .A(\regs_matrix[12][7] ), .B(n637), .C(\regs_matrix[14][7] ), 
        .D(n642), .Y(n488) );
  NOR2X1 U595 ( .A(n490), .B(n491), .Y(n486) );
  OAI22X1 U596 ( .A(\regs_matrix[11][7] ), .B(n645), .C(\regs_matrix[9][7] ), 
        .D(n649), .Y(n491) );
  OAI22X1 U597 ( .A(\regs_matrix[13][7] ), .B(n653), .C(\regs_matrix[15][7] ), 
        .D(n657), .Y(n490) );
  NAND2X1 U598 ( .A(n492), .B(n493), .Y(n484) );
  NOR2X1 U599 ( .A(n494), .B(n495), .Y(n493) );
  OAI22X1 U600 ( .A(outreg_data[7]), .B(n630), .C(\regs_matrix[2][7] ), .D(n23), .Y(n495) );
  OAI22X1 U601 ( .A(\regs_matrix[4][7] ), .B(n639), .C(\regs_matrix[6][7] ), 
        .D(n642), .Y(n494) );
  NOR2X1 U602 ( .A(n496), .B(n497), .Y(n492) );
  OAI22X1 U603 ( .A(\regs_matrix[3][7] ), .B(n645), .C(\regs_matrix[1][7] ), 
        .D(n649), .Y(n497) );
  OAI22X1 U604 ( .A(\regs_matrix[5][7] ), .B(n653), .C(\regs_matrix[7][7] ), 
        .D(n657), .Y(n496) );
  MUX2X1 U605 ( .B(n498), .A(n499), .S(n658), .Y(r2_data[8]) );
  NAND2X1 U606 ( .A(n500), .B(n501), .Y(n499) );
  NOR2X1 U607 ( .A(n502), .B(n503), .Y(n501) );
  OAI22X1 U608 ( .A(\regs_matrix[8][8] ), .B(n630), .C(\regs_matrix[10][8] ), 
        .D(n23), .Y(n503) );
  OAI22X1 U609 ( .A(\regs_matrix[12][8] ), .B(n637), .C(\regs_matrix[14][8] ), 
        .D(n642), .Y(n502) );
  NOR2X1 U610 ( .A(n504), .B(n505), .Y(n500) );
  OAI22X1 U611 ( .A(\regs_matrix[11][8] ), .B(n644), .C(\regs_matrix[9][8] ), 
        .D(n649), .Y(n505) );
  OAI22X1 U612 ( .A(\regs_matrix[13][8] ), .B(n653), .C(\regs_matrix[15][8] ), 
        .D(n655), .Y(n504) );
  NAND2X1 U613 ( .A(n506), .B(n507), .Y(n498) );
  NOR2X1 U614 ( .A(n508), .B(n509), .Y(n507) );
  OAI22X1 U615 ( .A(outreg_data[8]), .B(n630), .C(\regs_matrix[2][8] ), .D(n18), .Y(n509) );
  OAI22X1 U616 ( .A(\regs_matrix[4][8] ), .B(n638), .C(\regs_matrix[6][8] ), 
        .D(n642), .Y(n508) );
  NOR2X1 U617 ( .A(n511), .B(n510), .Y(n506) );
  OAI22X1 U618 ( .A(\regs_matrix[3][8] ), .B(n645), .C(\regs_matrix[1][8] ), 
        .D(n649), .Y(n511) );
  OAI22X1 U619 ( .A(\regs_matrix[5][8] ), .B(n653), .C(\regs_matrix[7][8] ), 
        .D(n655), .Y(n510) );
  MUX2X1 U620 ( .B(n512), .A(n513), .S(n659), .Y(r2_data[9]) );
  NAND2X1 U621 ( .A(n514), .B(n515), .Y(n513) );
  NOR2X1 U622 ( .A(n516), .B(n517), .Y(n515) );
  OAI22X1 U623 ( .A(\regs_matrix[8][9] ), .B(n630), .C(\regs_matrix[10][9] ), 
        .D(n27), .Y(n517) );
  OAI22X1 U624 ( .A(\regs_matrix[12][9] ), .B(n639), .C(\regs_matrix[14][9] ), 
        .D(n642), .Y(n516) );
  NOR2X1 U625 ( .A(n518), .B(n519), .Y(n514) );
  OAI22X1 U626 ( .A(\regs_matrix[11][9] ), .B(n644), .C(\regs_matrix[9][9] ), 
        .D(n649), .Y(n519) );
  OAI22X1 U627 ( .A(\regs_matrix[13][9] ), .B(n653), .C(\regs_matrix[15][9] ), 
        .D(n656), .Y(n518) );
  NAND2X1 U628 ( .A(n520), .B(n521), .Y(n512) );
  NOR2X1 U629 ( .A(n522), .B(n523), .Y(n521) );
  OAI22X1 U630 ( .A(outreg_data[9]), .B(n630), .C(\regs_matrix[2][9] ), .D(n24), .Y(n523) );
  OAI22X1 U631 ( .A(\regs_matrix[4][9] ), .B(n637), .C(\regs_matrix[6][9] ), 
        .D(n642), .Y(n522) );
  NOR2X1 U632 ( .A(n524), .B(n525), .Y(n520) );
  OAI22X1 U633 ( .A(\regs_matrix[3][9] ), .B(n645), .C(\regs_matrix[1][9] ), 
        .D(n649), .Y(n525) );
  OAI22X1 U634 ( .A(\regs_matrix[5][9] ), .B(n653), .C(\regs_matrix[7][9] ), 
        .D(n656), .Y(n524) );
  MUX2X1 U635 ( .B(n526), .A(n527), .S(n658), .Y(r2_data[10]) );
  NAND2X1 U636 ( .A(n528), .B(n529), .Y(n527) );
  NOR2X1 U637 ( .A(n530), .B(n531), .Y(n529) );
  OAI22X1 U638 ( .A(\regs_matrix[8][10] ), .B(n631), .C(\regs_matrix[10][10] ), 
        .D(n16), .Y(n531) );
  OAI22X1 U639 ( .A(\regs_matrix[12][10] ), .B(n638), .C(\regs_matrix[14][10] ), .D(n642), .Y(n530) );
  NOR2X1 U640 ( .A(n532), .B(n533), .Y(n528) );
  OAI22X1 U641 ( .A(\regs_matrix[11][10] ), .B(n645), .C(\regs_matrix[9][10] ), 
        .D(n649), .Y(n533) );
  OAI22X1 U642 ( .A(\regs_matrix[13][10] ), .B(n653), .C(\regs_matrix[15][10] ), .D(n656), .Y(n532) );
  NAND2X1 U643 ( .A(n534), .B(n535), .Y(n526) );
  NOR2X1 U644 ( .A(n536), .B(n537), .Y(n535) );
  OAI22X1 U645 ( .A(outreg_data[10]), .B(n631), .C(\regs_matrix[2][10] ), .D(
        n22), .Y(n537) );
  OAI22X1 U646 ( .A(\regs_matrix[4][10] ), .B(n638), .C(\regs_matrix[6][10] ), 
        .D(n642), .Y(n536) );
  NOR2X1 U647 ( .A(n538), .B(n539), .Y(n534) );
  OAI22X1 U648 ( .A(\regs_matrix[3][10] ), .B(n37), .C(\regs_matrix[1][10] ), 
        .D(n649), .Y(n539) );
  OAI22X1 U649 ( .A(\regs_matrix[5][10] ), .B(n654), .C(\regs_matrix[7][10] ), 
        .D(n656), .Y(n538) );
  MUX2X1 U650 ( .B(n540), .A(n541), .S(n659), .Y(r2_data[11]) );
  NAND2X1 U651 ( .A(n542), .B(n543), .Y(n541) );
  NOR2X1 U652 ( .A(n544), .B(n545), .Y(n543) );
  OAI22X1 U653 ( .A(\regs_matrix[8][11] ), .B(n631), .C(\regs_matrix[10][11] ), 
        .D(n20), .Y(n545) );
  OAI22X1 U654 ( .A(\regs_matrix[12][11] ), .B(n638), .C(\regs_matrix[14][11] ), .D(n642), .Y(n544) );
  NOR2X1 U655 ( .A(n546), .B(n547), .Y(n542) );
  OAI22X1 U656 ( .A(\regs_matrix[11][11] ), .B(n37), .C(\regs_matrix[9][11] ), 
        .D(n649), .Y(n547) );
  OAI22X1 U657 ( .A(\regs_matrix[13][11] ), .B(n654), .C(\regs_matrix[15][11] ), .D(n655), .Y(n546) );
  NAND2X1 U658 ( .A(n548), .B(n549), .Y(n540) );
  NOR2X1 U659 ( .A(n550), .B(n551), .Y(n549) );
  OAI22X1 U660 ( .A(outreg_data[11]), .B(n631), .C(\regs_matrix[2][11] ), .D(
        n26), .Y(n551) );
  OAI22X1 U661 ( .A(\regs_matrix[4][11] ), .B(n637), .C(\regs_matrix[6][11] ), 
        .D(n641), .Y(n550) );
  NOR2X1 U662 ( .A(n552), .B(n553), .Y(n548) );
  OAI22X1 U663 ( .A(\regs_matrix[3][11] ), .B(n37), .C(\regs_matrix[1][11] ), 
        .D(n649), .Y(n553) );
  OAI22X1 U664 ( .A(\regs_matrix[5][11] ), .B(n654), .C(\regs_matrix[7][11] ), 
        .D(n656), .Y(n552) );
  MUX2X1 U665 ( .B(n554), .A(n555), .S(n658), .Y(r2_data[12]) );
  NAND2X1 U666 ( .A(n556), .B(n557), .Y(n555) );
  NOR2X1 U667 ( .A(n558), .B(n559), .Y(n557) );
  OAI22X1 U668 ( .A(\regs_matrix[8][12] ), .B(n631), .C(\regs_matrix[10][12] ), 
        .D(n17), .Y(n559) );
  OAI22X1 U669 ( .A(\regs_matrix[12][12] ), .B(n637), .C(\regs_matrix[14][12] ), .D(n641), .Y(n558) );
  NOR2X1 U670 ( .A(n560), .B(n561), .Y(n556) );
  OAI22X1 U671 ( .A(\regs_matrix[11][12] ), .B(n37), .C(\regs_matrix[9][12] ), 
        .D(n648), .Y(n561) );
  OAI22X1 U672 ( .A(\regs_matrix[13][12] ), .B(n654), .C(\regs_matrix[15][12] ), .D(n655), .Y(n560) );
  NAND2X1 U673 ( .A(n562), .B(n563), .Y(n554) );
  NOR2X1 U674 ( .A(n564), .B(n565), .Y(n563) );
  OAI22X1 U675 ( .A(outreg_data[12]), .B(n631), .C(\regs_matrix[2][12] ), .D(
        n17), .Y(n565) );
  OAI22X1 U676 ( .A(\regs_matrix[4][12] ), .B(n638), .C(\regs_matrix[6][12] ), 
        .D(n641), .Y(n564) );
  NOR2X1 U677 ( .A(n566), .B(n567), .Y(n562) );
  OAI22X1 U678 ( .A(\regs_matrix[3][12] ), .B(n37), .C(\regs_matrix[1][12] ), 
        .D(n648), .Y(n567) );
  OAI22X1 U679 ( .A(\regs_matrix[5][12] ), .B(n654), .C(\regs_matrix[7][12] ), 
        .D(n656), .Y(n566) );
  MUX2X1 U680 ( .B(n568), .A(n569), .S(n659), .Y(r2_data[13]) );
  NAND2X1 U681 ( .A(n570), .B(n571), .Y(n569) );
  NOR2X1 U682 ( .A(n572), .B(n573), .Y(n571) );
  OAI22X1 U683 ( .A(\regs_matrix[8][13] ), .B(n631), .C(\regs_matrix[10][13] ), 
        .D(n19), .Y(n573) );
  OAI22X1 U684 ( .A(\regs_matrix[12][13] ), .B(n637), .C(\regs_matrix[14][13] ), .D(n641), .Y(n572) );
  NOR2X1 U685 ( .A(n574), .B(n575), .Y(n570) );
  OAI22X1 U686 ( .A(\regs_matrix[11][13] ), .B(n37), .C(\regs_matrix[9][13] ), 
        .D(n648), .Y(n575) );
  OAI22X1 U687 ( .A(\regs_matrix[13][13] ), .B(n654), .C(\regs_matrix[15][13] ), .D(n656), .Y(n574) );
  NAND2X1 U688 ( .A(n577), .B(n576), .Y(n568) );
  NOR2X1 U689 ( .A(n578), .B(n579), .Y(n577) );
  OAI22X1 U690 ( .A(outreg_data[13]), .B(n631), .C(\regs_matrix[2][13] ), .D(
        n16), .Y(n579) );
  OAI22X1 U691 ( .A(\regs_matrix[4][13] ), .B(n637), .C(\regs_matrix[6][13] ), 
        .D(n641), .Y(n578) );
  NOR2X1 U692 ( .A(n580), .B(n581), .Y(n576) );
  OAI22X1 U693 ( .A(\regs_matrix[3][13] ), .B(n37), .C(\regs_matrix[1][13] ), 
        .D(n648), .Y(n581) );
  OAI22X1 U694 ( .A(\regs_matrix[5][13] ), .B(n654), .C(\regs_matrix[7][13] ), 
        .D(n657), .Y(n580) );
  MUX2X1 U695 ( .B(n582), .A(n583), .S(n658), .Y(r2_data[14]) );
  NAND2X1 U696 ( .A(n584), .B(n585), .Y(n583) );
  NOR2X1 U697 ( .A(n586), .B(n587), .Y(n585) );
  OAI22X1 U698 ( .A(\regs_matrix[8][14] ), .B(n631), .C(\regs_matrix[10][14] ), 
        .D(n16), .Y(n587) );
  OAI22X1 U699 ( .A(\regs_matrix[12][14] ), .B(n639), .C(\regs_matrix[14][14] ), .D(n641), .Y(n586) );
  NOR2X1 U700 ( .A(n588), .B(n589), .Y(n584) );
  OAI22X1 U701 ( .A(\regs_matrix[11][14] ), .B(n37), .C(\regs_matrix[9][14] ), 
        .D(n648), .Y(n589) );
  OAI22X1 U702 ( .A(\regs_matrix[13][14] ), .B(n654), .C(\regs_matrix[15][14] ), .D(n655), .Y(n588) );
  NAND2X1 U703 ( .A(n590), .B(n591), .Y(n582) );
  NOR2X1 U704 ( .A(n592), .B(n593), .Y(n591) );
  OAI22X1 U705 ( .A(outreg_data[14]), .B(n631), .C(\regs_matrix[2][14] ), .D(
        n15), .Y(n593) );
  OAI22X1 U706 ( .A(\regs_matrix[4][14] ), .B(n638), .C(\regs_matrix[6][14] ), 
        .D(n641), .Y(n592) );
  NOR2X1 U707 ( .A(n594), .B(n595), .Y(n590) );
  OAI22X1 U708 ( .A(\regs_matrix[3][14] ), .B(n37), .C(\regs_matrix[1][14] ), 
        .D(n648), .Y(n595) );
  OAI22X1 U709 ( .A(\regs_matrix[5][14] ), .B(n654), .C(\regs_matrix[7][14] ), 
        .D(n656), .Y(n594) );
  MUX2X1 U710 ( .B(n596), .A(n597), .S(n659), .Y(r2_data[15]) );
  NAND2X1 U711 ( .A(n598), .B(n599), .Y(n597) );
  NOR2X1 U712 ( .A(n600), .B(n601), .Y(n599) );
  OAI22X1 U713 ( .A(\regs_matrix[8][15] ), .B(n631), .C(\regs_matrix[10][15] ), 
        .D(n30), .Y(n601) );
  OAI22X1 U714 ( .A(\regs_matrix[12][15] ), .B(n637), .C(\regs_matrix[14][15] ), .D(n641), .Y(n600) );
  NOR2X1 U715 ( .A(n602), .B(n603), .Y(n598) );
  OAI22X1 U716 ( .A(\regs_matrix[11][15] ), .B(n37), .C(\regs_matrix[9][15] ), 
        .D(n648), .Y(n603) );
  OAI22X1 U717 ( .A(\regs_matrix[13][15] ), .B(n654), .C(\regs_matrix[15][15] ), .D(n656), .Y(n602) );
  NAND2X1 U718 ( .A(n604), .B(n605), .Y(n596) );
  NOR2X1 U719 ( .A(n606), .B(n607), .Y(n605) );
  OAI22X1 U720 ( .A(outreg_data[15]), .B(n631), .C(\regs_matrix[2][15] ), .D(
        n28), .Y(n607) );
  OAI22X1 U721 ( .A(\regs_matrix[4][15] ), .B(n638), .C(\regs_matrix[6][15] ), 
        .D(n641), .Y(n606) );
  NOR2X1 U722 ( .A(n608), .B(n609), .Y(n604) );
  OAI22X1 U723 ( .A(\regs_matrix[3][15] ), .B(n37), .C(\regs_matrix[1][15] ), 
        .D(n648), .Y(n609) );
  OAI22X1 U724 ( .A(\regs_matrix[5][15] ), .B(n654), .C(\regs_matrix[7][15] ), 
        .D(n655), .Y(n608) );
  NOR2X1 U725 ( .A(n610), .B(n611), .Y(n375) );
  OAI21X1 U726 ( .A(\regs_matrix[6][16] ), .B(n641), .C(n612), .Y(n611) );
  AOI22X1 U727 ( .A(n633), .B(n336), .C(n2), .D(n613), .Y(n612) );
  INVX2 U728 ( .A(outreg_data[16]), .Y(n613) );
  OAI21X1 U729 ( .A(\regs_matrix[4][16] ), .B(n639), .C(n660), .Y(n610) );
  NOR2X1 U730 ( .A(n614), .B(n615), .Y(n376) );
  OAI22X1 U731 ( .A(\regs_matrix[3][16] ), .B(n37), .C(\regs_matrix[1][16] ), 
        .D(n648), .Y(n615) );
  OAI22X1 U732 ( .A(\regs_matrix[5][16] ), .B(n654), .C(\regs_matrix[7][16] ), 
        .D(n655), .Y(n614) );
  NOR2X1 U733 ( .A(n616), .B(n617), .Y(n377) );
  OAI21X1 U734 ( .A(\regs_matrix[12][16] ), .B(n638), .C(n618), .Y(n617) );
  AOI22X1 U735 ( .A(n633), .B(n619), .C(n2), .D(n620), .Y(n618) );
  INVX2 U736 ( .A(\regs_matrix[8][16] ), .Y(n620) );
  NAND3X1 U737 ( .A(n621), .B(n622), .C(n623), .Y(n386) );
  INVX2 U738 ( .A(\regs_matrix[10][16] ), .Y(n619) );
  NAND3X1 U739 ( .A(N15), .B(n622), .C(n623), .Y(n387) );
  NAND3X1 U740 ( .A(n31), .B(n621), .C(n623), .Y(n388) );
  OAI22X1 U741 ( .A(\regs_matrix[9][16] ), .B(n648), .C(\regs_matrix[14][16] ), 
        .D(n643), .Y(n616) );
  NAND3X1 U742 ( .A(N15), .B(N16), .C(n623), .Y(n389) );
  INVX2 U743 ( .A(N14), .Y(n623) );
  NAND3X1 U744 ( .A(N14), .B(n622), .C(n621), .Y(n392) );
  NOR2X1 U745 ( .A(n624), .B(n625), .Y(n378) );
  OAI21X1 U746 ( .A(\regs_matrix[11][16] ), .B(n37), .C(n658), .Y(n625) );
  OAI22X1 U747 ( .A(\regs_matrix[15][16] ), .B(n656), .C(\regs_matrix[13][16] ), .D(n654), .Y(n624) );
  NAND3X1 U748 ( .A(n31), .B(N14), .C(n621), .Y(n393) );
  INVX2 U749 ( .A(N15), .Y(n621) );
  INVX4 U750 ( .A(w_data[6]), .Y(n678) );
  INVX4 U751 ( .A(w_data[7]), .Y(n680) );
  INVX4 U752 ( .A(w_data[8]), .Y(n682) );
  INVX4 U753 ( .A(w_data[11]), .Y(n690) );
  INVX4 U754 ( .A(w_data[10]), .Y(n687) );
  INVX4 U755 ( .A(w_data[14]), .Y(n697) );
  INVX4 U756 ( .A(w_data[13]), .Y(n695) );
  INVX4 U757 ( .A(w_data[15]), .Y(n700) );
  INVX8 U758 ( .A(n678), .Y(n679) );
  INVX8 U759 ( .A(n680), .Y(n681) );
  INVX8 U760 ( .A(n682), .Y(n683) );
  INVX8 U761 ( .A(n690), .Y(n691) );
  INVX8 U762 ( .A(n695), .Y(n696) );
  INVX8 U763 ( .A(n700), .Y(n701) );
  INVX2 U764 ( .A(w_en), .Y(n713) );
  INVX2 U765 ( .A(w_sel[1]), .Y(n714) );
  INVX2 U766 ( .A(w_sel[2]), .Y(n715) );
  INVX2 U767 ( .A(w_sel[3]), .Y(n716) );
endmodule


module datapath ( clk, n_reset, op, src1, src2, dest, ext_data1, ext_data2, 
        outreg_data, overflow );
  input [2:0] op;
  input [3:0] src1;
  input [3:0] src2;
  input [3:0] dest;
  input [15:0] ext_data1;
  input [15:0] ext_data2;
  output [16:0] outreg_data;
  input clk, n_reset;
  output overflow;
  wire   w_en, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36;
  wire   [1:0] w_data_sel;
  wire   [1:0] alu_op;
  wire   [16:0] src1_data;
  wire   [16:0] src2_data;
  wire   [16:0] alu_result;
  wire   [16:0] dest_data;

  datapath_decode DEC ( .op(op), .w_en(w_en), .w_data_sel(w_data_sel), 
        .alu_op(alu_op) );
  alu CORE ( .src1_data(src1_data), .src2_data(src2_data), .alu_op(alu_op), 
        .result(alu_result), .overflow(overflow) );
  register_file RF ( .clk(clk), .n_reset(n_reset), .w_en(w_en), .r1_sel(src1), 
        .r2_sel(src2), .w_sel(dest), .w_data(dest_data), .r1_data(src1_data), 
        .r2_data(src2_data), .outreg_data(outreg_data) );
  INVX2 U2 ( .A(w_data_sel[1]), .Y(n36) );
  AND2X2 U3 ( .A(n36), .B(n3), .Y(n1) );
  AND2X2 U4 ( .A(w_data_sel[0]), .B(n36), .Y(n2) );
  AND2X2 U5 ( .A(alu_result[16]), .B(w_data_sel[1]), .Y(dest_data[16]) );
  INVX2 U6 ( .A(alu_result[15]), .Y(n5) );
  INVX2 U7 ( .A(w_data_sel[0]), .Y(n3) );
  AOI22X1 U8 ( .A(ext_data2[15]), .B(n2), .C(ext_data1[15]), .D(n1), .Y(n4) );
  OAI21X1 U9 ( .A(n36), .B(n5), .C(n4), .Y(dest_data[15]) );
  INVX2 U10 ( .A(alu_result[14]), .Y(n7) );
  AOI22X1 U11 ( .A(ext_data2[14]), .B(n2), .C(ext_data1[14]), .D(n1), .Y(n6)
         );
  OAI21X1 U12 ( .A(n36), .B(n7), .C(n6), .Y(dest_data[14]) );
  INVX2 U13 ( .A(alu_result[13]), .Y(n9) );
  AOI22X1 U14 ( .A(ext_data2[13]), .B(n2), .C(ext_data1[13]), .D(n1), .Y(n8)
         );
  OAI21X1 U15 ( .A(n36), .B(n9), .C(n8), .Y(dest_data[13]) );
  INVX2 U16 ( .A(alu_result[12]), .Y(n11) );
  AOI22X1 U17 ( .A(ext_data2[12]), .B(n2), .C(ext_data1[12]), .D(n1), .Y(n10)
         );
  OAI21X1 U18 ( .A(n36), .B(n11), .C(n10), .Y(dest_data[12]) );
  INVX2 U19 ( .A(alu_result[11]), .Y(n13) );
  AOI22X1 U20 ( .A(ext_data2[11]), .B(n2), .C(ext_data1[11]), .D(n1), .Y(n12)
         );
  OAI21X1 U21 ( .A(n36), .B(n13), .C(n12), .Y(dest_data[11]) );
  INVX2 U22 ( .A(alu_result[10]), .Y(n15) );
  AOI22X1 U23 ( .A(ext_data2[10]), .B(n2), .C(ext_data1[10]), .D(n1), .Y(n14)
         );
  OAI21X1 U24 ( .A(n36), .B(n15), .C(n14), .Y(dest_data[10]) );
  INVX2 U25 ( .A(alu_result[9]), .Y(n17) );
  AOI22X1 U26 ( .A(ext_data2[9]), .B(n2), .C(ext_data1[9]), .D(n1), .Y(n16) );
  OAI21X1 U27 ( .A(n36), .B(n17), .C(n16), .Y(dest_data[9]) );
  INVX2 U28 ( .A(alu_result[8]), .Y(n19) );
  AOI22X1 U29 ( .A(ext_data2[8]), .B(n2), .C(ext_data1[8]), .D(n1), .Y(n18) );
  OAI21X1 U30 ( .A(n36), .B(n19), .C(n18), .Y(dest_data[8]) );
  INVX2 U31 ( .A(alu_result[7]), .Y(n21) );
  AOI22X1 U32 ( .A(ext_data2[7]), .B(n2), .C(ext_data1[7]), .D(n1), .Y(n20) );
  OAI21X1 U33 ( .A(n36), .B(n21), .C(n20), .Y(dest_data[7]) );
  INVX2 U34 ( .A(alu_result[6]), .Y(n23) );
  AOI22X1 U35 ( .A(ext_data2[6]), .B(n2), .C(ext_data1[6]), .D(n1), .Y(n22) );
  OAI21X1 U36 ( .A(n36), .B(n23), .C(n22), .Y(dest_data[6]) );
  INVX2 U37 ( .A(alu_result[5]), .Y(n25) );
  AOI22X1 U38 ( .A(ext_data2[5]), .B(n2), .C(ext_data1[5]), .D(n1), .Y(n24) );
  OAI21X1 U39 ( .A(n36), .B(n25), .C(n24), .Y(dest_data[5]) );
  INVX2 U40 ( .A(alu_result[4]), .Y(n27) );
  AOI22X1 U41 ( .A(ext_data2[4]), .B(n2), .C(ext_data1[4]), .D(n1), .Y(n26) );
  OAI21X1 U42 ( .A(n36), .B(n27), .C(n26), .Y(dest_data[4]) );
  INVX2 U43 ( .A(alu_result[3]), .Y(n29) );
  AOI22X1 U44 ( .A(ext_data2[3]), .B(n2), .C(ext_data1[3]), .D(n1), .Y(n28) );
  OAI21X1 U45 ( .A(n36), .B(n29), .C(n28), .Y(dest_data[3]) );
  INVX2 U46 ( .A(alu_result[2]), .Y(n31) );
  AOI22X1 U47 ( .A(ext_data2[2]), .B(n2), .C(ext_data1[2]), .D(n1), .Y(n30) );
  OAI21X1 U48 ( .A(n36), .B(n31), .C(n30), .Y(dest_data[2]) );
  INVX2 U49 ( .A(alu_result[1]), .Y(n33) );
  AOI22X1 U50 ( .A(ext_data2[1]), .B(n2), .C(ext_data1[1]), .D(n1), .Y(n32) );
  OAI21X1 U51 ( .A(n36), .B(n33), .C(n32), .Y(dest_data[1]) );
  INVX2 U52 ( .A(alu_result[0]), .Y(n35) );
  AOI22X1 U53 ( .A(ext_data2[0]), .B(n2), .C(ext_data1[0]), .D(n1), .Y(n34) );
  OAI21X1 U54 ( .A(n36), .B(n35), .C(n34), .Y(dest_data[0]) );
endmodule


module magnitude ( in, out );
  input [16:0] in;
  output [15:0] out;
  wire   n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, \sub_add_17_b0/carry[15] , \sub_add_17_b0/carry[14] ,
         \sub_add_17_b0/carry[13] , \sub_add_17_b0/carry[12] ,
         \sub_add_17_b0/carry[11] , \sub_add_17_b0/carry[10] ,
         \sub_add_17_b0/carry[9] , \sub_add_17_b0/carry[8] ,
         \sub_add_17_b0/carry[7] , \sub_add_17_b0/carry[6] ,
         \sub_add_17_b0/carry[5] , \sub_add_17_b0/carry[4] ,
         \sub_add_17_b0/carry[3] , \sub_add_17_b0/carry[2] , n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18;
  wire   [15:0] comp;
  assign comp[0] = in[0];

  AOI22X1 U22 ( .A(n2), .B(comp[9]), .C(in[9]), .D(n1), .Y(n22) );
  AOI22X1 U23 ( .A(comp[8]), .B(in[16]), .C(in[8]), .D(n1), .Y(n23) );
  AOI22X1 U24 ( .A(comp[7]), .B(in[16]), .C(in[7]), .D(n1), .Y(n24) );
  AOI22X1 U25 ( .A(comp[6]), .B(in[16]), .C(in[6]), .D(n1), .Y(n25) );
  AOI22X1 U26 ( .A(comp[5]), .B(in[16]), .C(in[5]), .D(n1), .Y(n26) );
  AOI22X1 U27 ( .A(comp[4]), .B(n2), .C(in[4]), .D(n1), .Y(n27) );
  AOI22X1 U28 ( .A(comp[3]), .B(in[16]), .C(in[3]), .D(n1), .Y(n28) );
  AOI22X1 U29 ( .A(comp[2]), .B(n2), .C(in[2]), .D(n1), .Y(n29) );
  AOI22X1 U30 ( .A(comp[1]), .B(n2), .C(in[1]), .D(n1), .Y(n30) );
  AOI22X1 U31 ( .A(comp[15]), .B(n2), .C(in[15]), .D(n1), .Y(n31) );
  AOI22X1 U32 ( .A(comp[14]), .B(n2), .C(in[14]), .D(n1), .Y(n32) );
  AOI22X1 U33 ( .A(comp[13]), .B(n2), .C(in[13]), .D(n1), .Y(n33) );
  AOI22X1 U34 ( .A(comp[12]), .B(n2), .C(in[12]), .D(n1), .Y(n34) );
  AOI22X1 U35 ( .A(comp[11]), .B(n2), .C(in[11]), .D(n1), .Y(n35) );
  AOI22X1 U36 ( .A(comp[10]), .B(n2), .C(in[10]), .D(n1), .Y(n36) );
  AOI22X1 U37 ( .A(comp[0]), .B(n2), .C(comp[0]), .D(n1), .Y(n37) );
  INVX2 U2 ( .A(n1), .Y(n2) );
  INVX2 U3 ( .A(in[16]), .Y(n1) );
  XOR2X1 U4 ( .A(n18), .B(\sub_add_17_b0/carry[15] ), .Y(comp[15]) );
  AND2X1 U5 ( .A(n17), .B(\sub_add_17_b0/carry[14] ), .Y(
        \sub_add_17_b0/carry[15] ) );
  XOR2X1 U6 ( .A(\sub_add_17_b0/carry[14] ), .B(n17), .Y(comp[14]) );
  AND2X1 U7 ( .A(n16), .B(\sub_add_17_b0/carry[13] ), .Y(
        \sub_add_17_b0/carry[14] ) );
  XOR2X1 U8 ( .A(\sub_add_17_b0/carry[13] ), .B(n16), .Y(comp[13]) );
  AND2X1 U9 ( .A(n15), .B(\sub_add_17_b0/carry[12] ), .Y(
        \sub_add_17_b0/carry[13] ) );
  XOR2X1 U10 ( .A(\sub_add_17_b0/carry[12] ), .B(n15), .Y(comp[12]) );
  AND2X1 U11 ( .A(n14), .B(\sub_add_17_b0/carry[11] ), .Y(
        \sub_add_17_b0/carry[12] ) );
  XOR2X1 U12 ( .A(\sub_add_17_b0/carry[11] ), .B(n14), .Y(comp[11]) );
  AND2X1 U13 ( .A(n13), .B(\sub_add_17_b0/carry[10] ), .Y(
        \sub_add_17_b0/carry[11] ) );
  XOR2X1 U14 ( .A(\sub_add_17_b0/carry[10] ), .B(n13), .Y(comp[10]) );
  AND2X1 U15 ( .A(n12), .B(\sub_add_17_b0/carry[9] ), .Y(
        \sub_add_17_b0/carry[10] ) );
  XOR2X1 U16 ( .A(\sub_add_17_b0/carry[9] ), .B(n12), .Y(comp[9]) );
  AND2X1 U17 ( .A(n11), .B(\sub_add_17_b0/carry[8] ), .Y(
        \sub_add_17_b0/carry[9] ) );
  XOR2X1 U18 ( .A(\sub_add_17_b0/carry[8] ), .B(n11), .Y(comp[8]) );
  AND2X1 U19 ( .A(n10), .B(\sub_add_17_b0/carry[7] ), .Y(
        \sub_add_17_b0/carry[8] ) );
  XOR2X1 U20 ( .A(\sub_add_17_b0/carry[7] ), .B(n10), .Y(comp[7]) );
  AND2X1 U21 ( .A(n9), .B(\sub_add_17_b0/carry[6] ), .Y(
        \sub_add_17_b0/carry[7] ) );
  XOR2X1 U38 ( .A(\sub_add_17_b0/carry[6] ), .B(n9), .Y(comp[6]) );
  AND2X1 U39 ( .A(n8), .B(\sub_add_17_b0/carry[5] ), .Y(
        \sub_add_17_b0/carry[6] ) );
  XOR2X1 U40 ( .A(\sub_add_17_b0/carry[5] ), .B(n8), .Y(comp[5]) );
  AND2X1 U41 ( .A(n7), .B(\sub_add_17_b0/carry[4] ), .Y(
        \sub_add_17_b0/carry[5] ) );
  XOR2X1 U42 ( .A(\sub_add_17_b0/carry[4] ), .B(n7), .Y(comp[4]) );
  AND2X1 U43 ( .A(n6), .B(\sub_add_17_b0/carry[3] ), .Y(
        \sub_add_17_b0/carry[4] ) );
  XOR2X1 U44 ( .A(\sub_add_17_b0/carry[3] ), .B(n6), .Y(comp[3]) );
  AND2X1 U45 ( .A(n5), .B(\sub_add_17_b0/carry[2] ), .Y(
        \sub_add_17_b0/carry[3] ) );
  XOR2X1 U46 ( .A(\sub_add_17_b0/carry[2] ), .B(n5), .Y(comp[2]) );
  AND2X1 U47 ( .A(n4), .B(n3), .Y(\sub_add_17_b0/carry[2] ) );
  XOR2X1 U48 ( .A(n3), .B(n4), .Y(comp[1]) );
  INVX2 U49 ( .A(comp[0]), .Y(n3) );
  INVX2 U50 ( .A(in[1]), .Y(n4) );
  INVX2 U51 ( .A(in[2]), .Y(n5) );
  INVX2 U52 ( .A(in[3]), .Y(n6) );
  INVX2 U53 ( .A(in[4]), .Y(n7) );
  INVX2 U54 ( .A(in[5]), .Y(n8) );
  INVX2 U55 ( .A(in[6]), .Y(n9) );
  INVX2 U56 ( .A(in[7]), .Y(n10) );
  INVX2 U57 ( .A(in[8]), .Y(n11) );
  INVX2 U58 ( .A(in[9]), .Y(n12) );
  INVX2 U59 ( .A(in[10]), .Y(n13) );
  INVX2 U60 ( .A(in[11]), .Y(n14) );
  INVX2 U61 ( .A(in[12]), .Y(n15) );
  INVX2 U62 ( .A(in[13]), .Y(n16) );
  INVX2 U63 ( .A(in[14]), .Y(n17) );
  INVX2 U64 ( .A(in[15]), .Y(n18) );
  INVX2 U65 ( .A(n31), .Y(out[15]) );
  INVX2 U66 ( .A(n32), .Y(out[14]) );
  INVX2 U67 ( .A(n33), .Y(out[13]) );
  INVX2 U68 ( .A(n34), .Y(out[12]) );
  INVX2 U69 ( .A(n35), .Y(out[11]) );
  INVX2 U70 ( .A(n36), .Y(out[10]) );
  INVX2 U71 ( .A(n22), .Y(out[9]) );
  INVX2 U72 ( .A(n23), .Y(out[8]) );
  INVX2 U73 ( .A(n24), .Y(out[7]) );
  INVX2 U74 ( .A(n25), .Y(out[6]) );
  INVX2 U75 ( .A(n26), .Y(out[5]) );
  INVX2 U76 ( .A(n27), .Y(out[4]) );
  INVX2 U77 ( .A(n28), .Y(out[3]) );
  INVX2 U78 ( .A(n29), .Y(out[2]) );
  INVX2 U79 ( .A(n30), .Y(out[1]) );
  INVX2 U80 ( .A(n37), .Y(out[0]) );
endmodule


module flex_counter_NUM_CNT_BITS10_DW01_inc_0 ( A, SUM );
  input [10:0] A;
  output [10:0] SUM;

  wire   [10:2] carry;

  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(SUM[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module flex_counter_NUM_CNT_BITS10_DW01_inc_1 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
endmodule


module flex_counter_NUM_CNT_BITS10 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [9:0] rollover_val;
  output [9:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_rollover_flag, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N15,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n1, n2, n4, n5,
         n6, n7, n8, n9, n10, n22, n23, n24, n25, n26;

  DFFSR \curr_count_reg[0]  ( .D(n91), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \curr_count_reg[8]  ( .D(n83), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \curr_count_reg[7]  ( .D(n84), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \curr_count_reg[6]  ( .D(n85), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \curr_count_reg[5]  ( .D(n86), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \curr_count_reg[4]  ( .D(n87), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \curr_count_reg[3]  ( .D(n88), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \curr_count_reg[2]  ( .D(n89), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \curr_count_reg[1]  ( .D(n90), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR curr_rollover_flag_reg ( .D(next_rollover_flag), .CLK(clk), .R(n_rst), 
        .S(1'b1), .Q(rollover_flag) );
  DFFSR \curr_count_reg[9]  ( .D(n82), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  AND2X2 U15 ( .A(n35), .B(n36), .Y(next_rollover_flag) );
  NOR2X1 U29 ( .A(n37), .B(n38), .Y(n36) );
  NAND3X1 U30 ( .A(n39), .B(n40), .C(n41), .Y(n38) );
  XNOR2X1 U31 ( .A(N11), .B(rollover_val[7]), .Y(n41) );
  XNOR2X1 U32 ( .A(N12), .B(rollover_val[8]), .Y(n40) );
  XNOR2X1 U33 ( .A(N13), .B(rollover_val[9]), .Y(n39) );
  NAND3X1 U34 ( .A(count_enable), .B(n25), .C(n42), .Y(n37) );
  XNOR2X1 U35 ( .A(N7), .B(rollover_val[3]), .Y(n42) );
  NOR2X1 U36 ( .A(n43), .B(n44), .Y(n35) );
  NAND3X1 U37 ( .A(n45), .B(n46), .C(n47), .Y(n44) );
  XNOR2X1 U38 ( .A(N5), .B(rollover_val[1]), .Y(n47) );
  XNOR2X1 U39 ( .A(N4), .B(rollover_val[0]), .Y(n46) );
  XNOR2X1 U40 ( .A(N8), .B(rollover_val[4]), .Y(n45) );
  NAND3X1 U41 ( .A(n48), .B(n49), .C(n50), .Y(n43) );
  XNOR2X1 U42 ( .A(N9), .B(rollover_val[5]), .Y(n50) );
  XNOR2X1 U43 ( .A(N6), .B(rollover_val[2]), .Y(n49) );
  XNOR2X1 U44 ( .A(N10), .B(rollover_val[6]), .Y(n48) );
  OAI21X1 U45 ( .A(n4), .B(n51), .C(n52), .Y(n82) );
  NAND2X1 U46 ( .A(count_out[9]), .B(n1), .Y(n52) );
  OAI21X1 U47 ( .A(n5), .B(n51), .C(n54), .Y(n83) );
  NAND2X1 U48 ( .A(count_out[8]), .B(n1), .Y(n54) );
  OAI21X1 U49 ( .A(n6), .B(n51), .C(n55), .Y(n84) );
  NAND2X1 U50 ( .A(count_out[7]), .B(n1), .Y(n55) );
  OAI21X1 U51 ( .A(n7), .B(n51), .C(n56), .Y(n85) );
  NAND2X1 U52 ( .A(count_out[6]), .B(n1), .Y(n56) );
  OAI21X1 U53 ( .A(n8), .B(n51), .C(n57), .Y(n86) );
  NAND2X1 U54 ( .A(count_out[5]), .B(n1), .Y(n57) );
  OAI21X1 U55 ( .A(n9), .B(n51), .C(n58), .Y(n87) );
  NAND2X1 U56 ( .A(count_out[4]), .B(n1), .Y(n58) );
  OAI21X1 U57 ( .A(n10), .B(n51), .C(n59), .Y(n88) );
  NAND2X1 U58 ( .A(count_out[3]), .B(n1), .Y(n59) );
  OAI21X1 U59 ( .A(n22), .B(n51), .C(n60), .Y(n89) );
  NAND2X1 U60 ( .A(count_out[2]), .B(n1), .Y(n60) );
  OAI21X1 U61 ( .A(n23), .B(n51), .C(n61), .Y(n90) );
  NAND2X1 U62 ( .A(count_out[1]), .B(n1), .Y(n61) );
  NAND3X1 U63 ( .A(n62), .B(n25), .C(n26), .Y(n51) );
  OAI21X1 U64 ( .A(n26), .B(n24), .C(n63), .Y(n91) );
  OAI21X1 U65 ( .A(n2), .B(N4), .C(n64), .Y(n63) );
  NOR2X1 U66 ( .A(clear), .B(n1), .Y(n64) );
  NAND3X1 U67 ( .A(n65), .B(n66), .C(n67), .Y(n62) );
  NOR2X1 U68 ( .A(n68), .B(n69), .Y(n67) );
  NAND3X1 U69 ( .A(n70), .B(n71), .C(n72), .Y(n69) );
  XNOR2X1 U70 ( .A(N7), .B(N18), .Y(n72) );
  XNOR2X1 U71 ( .A(N12), .B(N23), .Y(n71) );
  XNOR2X1 U72 ( .A(N9), .B(N20), .Y(n70) );
  NAND2X1 U73 ( .A(n73), .B(n74), .Y(n68) );
  XNOR2X1 U74 ( .A(N13), .B(N24), .Y(n74) );
  NOR2X1 U75 ( .A(N25), .B(n75), .Y(n73) );
  XNOR2X1 U76 ( .A(N22), .B(n6), .Y(n75) );
  NOR2X1 U77 ( .A(n76), .B(n77), .Y(n66) );
  NAND2X1 U78 ( .A(n78), .B(n79), .Y(n77) );
  XNOR2X1 U79 ( .A(N8), .B(N19), .Y(n79) );
  XNOR2X1 U80 ( .A(N10), .B(N21), .Y(n78) );
  XNOR2X1 U81 ( .A(n22), .B(N17), .Y(n76) );
  NOR2X1 U82 ( .A(n80), .B(n81), .Y(n65) );
  XOR2X1 U83 ( .A(N4), .B(N15), .Y(n81) );
  XNOR2X1 U84 ( .A(n23), .B(N16), .Y(n80) );
  NOR2X1 U85 ( .A(count_enable), .B(clear), .Y(n53) );
  flex_counter_NUM_CNT_BITS10_DW01_inc_0 add_54 ( .A({1'b0, rollover_val}), 
        .SUM({N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15}) );
  flex_counter_NUM_CNT_BITS10_DW01_inc_1 add_49 ( .A(count_out), .SUM({N13, 
        N12, N11, N10, N9, N8, N7, N6, N5, N4}) );
  BUFX2 U16 ( .A(n53), .Y(n1) );
  INVX2 U17 ( .A(n62), .Y(n2) );
  INVX2 U18 ( .A(N13), .Y(n4) );
  INVX2 U19 ( .A(N12), .Y(n5) );
  INVX2 U20 ( .A(N11), .Y(n6) );
  INVX2 U21 ( .A(N10), .Y(n7) );
  INVX2 U22 ( .A(N9), .Y(n8) );
  INVX2 U23 ( .A(N8), .Y(n9) );
  INVX2 U24 ( .A(N7), .Y(n10) );
  INVX2 U25 ( .A(N6), .Y(n22) );
  INVX2 U26 ( .A(N5), .Y(n23) );
  INVX2 U27 ( .A(count_out[0]), .Y(n24) );
  INVX2 U28 ( .A(clear), .Y(n25) );
  INVX2 U86 ( .A(n1), .Y(n26) );
endmodule


module counter ( clk, n_reset, cnt_up, clear, one_k_samples );
  input clk, n_reset, cnt_up, clear;
  output one_k_samples;


  flex_counter_NUM_CNT_BITS10 COUNTER ( .clk(clk), .n_rst(n_reset), .clear(
        clear), .count_enable(cnt_up), .rollover_val({1'b1, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0}), .rollover_flag(one_k_samples) );
endmodule


module fir_filter ( clk, n_reset, sample_data, fir_coefficient, load_coeff, 
        data_ready, one_k_samples, modwait, fir_out, err );
  input [15:0] sample_data;
  input [15:0] fir_coefficient;
  output [15:0] fir_out;
  input clk, n_reset, load_coeff, data_ready;
  output one_k_samples, modwait, err;
  wire   dr, lc, overflow, cnt_up, clear;
  wire   [2:0] op;
  wire   [3:0] src1;
  wire   [3:0] src2;
  wire   [3:0] dest;
  wire   [16:0] outreg_data;
  wire   SYNOPSYS_UNCONNECTED__0;

  sync_low_1 SYNC_DR ( .clk(clk), .n_rst(n_reset), .async_in(data_ready), 
        .sync_out(dr) );
  sync_low_0 SYNC_LC ( .clk(clk), .n_rst(n_reset), .async_in(load_coeff), 
        .sync_out(lc) );
  controller CTRL ( .clk(clk), .n_reset(n_reset), .dr(dr), .lc(lc), .overflow(
        overflow), .cnt_up(cnt_up), .clear(clear), .modwait(modwait), .op(op), 
        .src1({SYNOPSYS_UNCONNECTED__0, src1[2:0]}), .src2(src2), .dest(dest), 
        .err(err) );
  datapath DATAPATH ( .clk(clk), .n_reset(n_reset), .op(op), .src1({1'b0, 
        src1[2:0]}), .src2(src2), .dest(dest), .ext_data1(sample_data), 
        .ext_data2(fir_coefficient), .outreg_data(outreg_data), .overflow(
        overflow) );
  magnitude MAG ( .in(outreg_data), .out(fir_out) );
  counter CNT ( .clk(clk), .n_reset(n_reset), .cnt_up(cnt_up), .clear(clear), 
        .one_k_samples(one_k_samples) );
endmodule

