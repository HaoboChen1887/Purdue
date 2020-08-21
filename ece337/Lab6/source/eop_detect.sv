// $Id: $
// File name:   eop_detect.sv
// Created:     2/19/2018
// Author:      Haobo Chen
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: eop detect.

module eop_detect(
    input wire d_plus,
    input wire d_minus,
    output wire eop
);
    assign eop = ~(d_plus | d_minus);
endmodule



