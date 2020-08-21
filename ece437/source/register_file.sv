`include "cpu_types_pkg.vh"
`include "register_file_if.vh"

module register_file
import cpu_types_pkg::*;
(
    input logic CLK, nRST,
    register_file_if.rf rfif
);

    word_t [31:0] val;
    always_ff @ (negedge CLK, negedge nRST) begin
        if(nRST == 1'b0)begin
            val[31:0] <= '0;
        end
        else if(rfif.WEN == 1'b1 && rfif.wsel != '0)begin
            val[rfif.wsel] <= rfif.wdat;
        end
    end

    always_comb begin
        rfif.rdat1 = val[rfif.rsel1];
        rfif.rdat2 = val[rfif.rsel2];
    end
endmodule
