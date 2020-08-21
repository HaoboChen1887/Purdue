`include "alu_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module alu_tb;
  alu_if tb();
  test PROG(tb);

`ifndef MAPPED
  alu DUT(tb);
`else
  alu DUT(
    .\myif.port_a (tb.port_a),
    .\myif.port_b (tb.port_b),
    .\myif.aluop (tb.aluop),
    .\myif.port_o (tb.port_o),
    .\myif.zero (tb.zero),
    .\myif.ov (tb.ov),
    .\myif.neg (tb.neg)
  );
`endif
endmodule

program test(
  alu_if.tb alutb
);

  initial begin
    for(alutb.aluop = 0; alutb.aluop < 12; alutb.aluop++)begin
      #(5);
      $display("");
      casez(alutb.aluop)
        ALU_SLL:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_SLL");
          alutb.port_a = 32'hAAAA;
          alutb.port_b = 32'd4;
          #(5);
          if(alutb.port_o == 32'h000AAAA0)
            $display("Success! actual: %h, expected: 000AAAA0", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 000AAAA0", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
        end
        ALU_SRL:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_SRL");
          alutb.port_a = 32'hAAAA;
          alutb.port_b = 32'd4;
          #(5);
          if(alutb.port_o == 32'h00000AAA)
            $display("Success! actual: %h, expected: 00000AAA", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 00000AAA", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
        end
        ALU_ADD:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_ADD");
          alutb.port_a = 32'd33;
          alutb.port_b = 32'd22;
          #(5);
          if(alutb.port_o == 32'd55)
            $display("Success! actual: %d, expected: 55", alutb.port_o);
          else
            $display("Fail! actual: %d, expected: 55", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
        end
        ALU_SUB:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_SUB");
          alutb.port_a = 32'd33;
          alutb.port_b = 32'd22;
          #(5);
          if(alutb.port_o == 32'd11)
            $display("Success! actual: %d, expected: 11", alutb.port_o);
          else
            $display("Fail! actual: %d, expected: 11", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 0, ov = 0");
          end
        end
        ALU_AND:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_AND");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 32'h00000000)
            $display("Success! actual: %h, expected: 00000000", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 00000000", alutb.port_o);
          if(alutb.zero == 1 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 1, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 1, neg = 0, ov = 0");
          end
        end
        ALU_OR:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_OR");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 32'hFFFFFFFF)
            $display("Success! actual: %h, expected: FFFFFFFF", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: FFFFFFFF", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 1 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 1, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 1, ov = 0");
          end
        end
        ALU_XOR:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_XOR");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 32'hFFFFFFFF)
            $display("Success! actual: %h, expected: FFFFFFFF", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: FFFFFFFF", alutb.port_o);
          if(alutb.zero == 0 && alutb.neg == 1 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 1, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 0, neg = 1, ov = 0");
          end
        end
        ALU_NOR:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_NOR");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 32'h00000000)
            $display("Success! actual: %h, expected: 00000000", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 00000000", alutb.port_o);
          if(alutb.zero == 1 && alutb.neg == 0 && alutb.ov == 0)begin
            $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 1, neg = 0, ov = 0");
          end
          else begin
            $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
            $display("Expected: zero = 1, neg = 0, ov = 0");
          end
        end
        ALU_SLT:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_SLT");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 1)
            $display("Success! actual: %h, expected: 1", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 1", alutb.port_o);
        end
        ALU_SLTU:begin
          $display("Case: %b",alutb.aluop);
          $display("Case: ALU_SLTU");
          alutb.port_a = 32'hAAAAAAAA;
          alutb.port_b = 32'h55555555;
          #(5);
          if(alutb.port_o == 0)
            $display("Success! actual: %h, expected: 0", alutb.port_o);
          else
            $display("Fail! actual: %h, expected: 0", alutb.port_o);
        end
        default:begin
          continue;
        end
      endcase
      #(5);
    end
    // =========================FLAG CHECK========================
    alutb.aluop = ALU_ADD;
    alutb.port_a = 2147483647;
    alutb.port_b = 5;
    #(5);
    $display("");
    $display("Case: ALU_ADD");
    if(alutb.port_o == 32'h80000004)
      $display("Success! actual: %h, expected: 80000004", alutb.port_o);
    else
      $display("Fail! actual: %h, expected: 80000004", alutb.port_o);
    if(alutb.zero == 0 && alutb.neg == 1 && alutb.ov == 1)begin
      $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 1, ov = 1");
    end
    else begin
      $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 1, ov = 1");
    end

    alutb.aluop = ALU_ADD;
    alutb.port_a = -2147483647;
    alutb.port_b = -5;
    #(5);
    $display("");
    $display("Case: ALU_ADD");
    if(alutb.port_o == 32'h7FFFFFFC)
      $display("Success! actual: %h, expected: 7FFFFFFC", alutb.port_o);
    else
      $display("Fail! actual: %h, expected: 7FFFFFFC", alutb.port_o);
    if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 1)begin
      $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 0, ov = 1");
    end
    else begin
      $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 0, ov = 1");
    end

    alutb.aluop = ALU_SUB;
    alutb.port_a = -2147483647;
    alutb.port_b = 5;
    #(5);
    $display("");
    $display("Case: ALU_SUB");
    if(alutb.port_o == 32'h7FFFFFFC)
      $display("Success! actual: %h, expected: 7FFFFFFC", alutb.port_o);
    else
      $display("Fail! actual: %h, expected: 7FFFFFFC", alutb.port_o);
    if(alutb.zero == 0 && alutb.neg == 0 && alutb.ov == 1)begin
      $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 0, ov = 1");
    end
    else begin
      $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 0, ov = 1");
    end

    alutb.aluop = ALU_SUB;
    alutb.port_a = 2147483647;
    alutb.port_b = -5;
    #(5);
    $display("");
    $display("Case: ALU_SUB");
    if(alutb.port_o == 32'h80000004)
      $display("Success! actual: %h, expected: 80000004", alutb.port_o);
    else
      $display("Fail! actual: %h, expected: 80000004", alutb.port_o);
    if(alutb.zero == 0 && alutb.neg == 1 && alutb.ov == 1)begin
      $display("Flag check success! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 1, ov = 1");
    end
    else begin
      $display("Flag check failed! actual: zero = %b, neg = %b, ov = %b",alutb.zero, alutb.neg, alutb.ov);
      $display("Expected: zero = 0, neg = 1, ov = 1");
    end
  end
endprogram
