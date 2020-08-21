/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Feb  4 23:43:50 2018
/////////////////////////////////////////////////////////////


module test ( clk, d, q2 );
  input clk, d;
  output q2;


  DFFPOSX1 q2_reg ( .D(d), .CLK(clk), .Q(q2) );
endmodule

