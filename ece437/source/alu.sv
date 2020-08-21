`include "cpu_types_pkg.vh"
`include "alu_if.vh"

module alu
import cpu_types_pkg::*;
(
  alu_if.aluif myif
);

  always_comb begin
    myif.zero = '0;
    myif.ov = '0;
    myif.neg = '0;
    myif.port_o = '0;
    casez(myif.aluop)
      ALU_SLL:begin
        myif.port_o = myif.port_b << myif.port_a[4:0];
      end
      ALU_SRL:begin
        myif.port_o = myif.port_b >> myif.port_a[4:0];
      end
      ALU_ADD:begin
        myif.port_o = $signed(myif.port_a) + $signed(myif.port_b);
        if((myif.port_o[31] ^ myif.port_a[31]) && (myif.port_a[31] ~^ myif.port_b[31]))begin
          myif.ov = 1'b1;
        end
      end
      ALU_SUB:begin
        myif.port_o = $signed(myif.port_a) - $signed(myif.port_b);
        //if((myif.port_o[31] ~^ myif.port_a[31]) && (myif.port_a[31] ~^ myif.port_b[31]))begin
        if(myif.port_a[31] == 1'b1 && myif.port_o[31] == 1'b0 || myif.port_a[31] == 1'b0 && myif.port_o[31] == 1'b1) begin
          myif.ov = 1'b1;
        end
      end
      ALU_AND:begin
        myif.port_o = myif.port_a & myif.port_b;
      end
      ALU_OR:begin
        myif.port_o = myif.port_a | myif.port_b;
      end
      ALU_XOR:begin
        myif.port_o = myif.port_a ^ myif.port_b;
      end
      ALU_NOR:begin
        myif.port_o = ~(myif.port_a | myif.port_b);
      end
      ALU_SLT:begin
        myif.port_o = $signed(myif.port_a) < $signed(myif.port_b);
      end
      ALU_SLTU:begin
        myif.port_o = myif.port_a < myif.port_b;
      end
      default:begin
        myif.port_o = '0;
      end
    endcase
    if(myif.port_o == 0)begin
      myif.zero = 1'b1;
    end
    if(myif.port_o[31] == 1'b1)begin
      myif.neg = 1'b1;
    end
  end
endmodule
