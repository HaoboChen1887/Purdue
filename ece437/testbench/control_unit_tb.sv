`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"
`timescale 1 ns / 1 ns

import cpu_types_pkg::*;
module control_unit_tb;
  parameter PERIOD = 10;
  logic nRST, CLK = 0;
  control_unit_if cuif();
  test PROG(cuif);
  always #(PERIOD/2) CLK++;

`ifndef MAPPED
  control_unit DUT(cuif);
`else
  control_unit DUT(
    .\cuif.zero (cuif.zero),
    .\cuif.port_o (cuif.port_o),
    .\cuif.rdat2 (cuif.rdat2),
    .\cuif.instr (cuif.instr),
    .\cuif.brn (cuif.brn),
    .\cuif.jmp (cuif.jmp),
    .\cuif.jr (cuif.jr),
    .\cuif.jraddr (cuif.jraddr),
    .\cuif.jmpaddr (cuif.jmpaddr),
    .\cuif.aluop (cuif.aluop),
    .\cuif.WEN (cuif.WEN),
    .\cuif.wsel (cuif.wsel),
    .\cuif.rsel1 (cuif.rsel1),
    .\cuif.rsel2 (cuif.rsel2),
    .\cuif.wdat (cuif.wdat),
    .\cuif.luipad (cuif.luipad),
    .\cuif.extsel (cuif.extsel),
    .\cuif.memreg (cuif.memreg),
    .\cuif.rdat2sel (cuif.rdat2sel),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.dREN (cuif.dREN),
    .\cuif.halt (cuif.halt),
    .\cuif.imm16 (cuif.imm16),
    .\cuif.dmemaddr (cuif.dmemaddr),
    .\cuif.dmemstore (cuif.dmemstore)
  );
`endif
endmodule

program test(
  control_unit_if cuif
);

  initial begin
    parameter PERIOD = 10;

    // init set up
    cuif.instr = 32'h25080004; //ADDIU R8 R8 4
    cuif.port_o = 6;
    #(10);
    if(cuif.aluop == ALU_ADD && cuif.rsel1 == 8 && cuif.wsel == 8 && cuif.rdat2sel == 1 && cuif.imm16 == cuif.instr[15:0] && cuif.WEN == 1 && cuif.extsel == 1 && cuif.wdat == cuif.port_o)
      $display("success, aluop %b, rsel %d ,wsel %d, rdat2sel %b, imm16 %d, WEN %b, extsel %b, wdat %d",cuif.aluop, cuif.rsel1, cuif.wsel, cuif.rdat2sel, cuif.imm16, cuif.WEN, cuif.extsel, cuif.wdat);
    else
      $display("failure, aluop %b, rsel %d ,wsel %d, rdat2sel %b, imm16 %d, WEN %b, extsel %b, wdat %d",cuif.aluop, cuif.rsel1, cuif.wsel, cuif.rdat2sel, cuif.imm16, cuif.WEN, cuif.extsel, cuif.wdat);

    cuif.instr = 32'h14A00002; //BNE R5 R0 204
    cuif.zero = 1'b1;
    #(10);
    if(cuif.aluop == ALU_SUB && cuif.brn == ~cuif.zero && cuif.rsel1 == 5 && cuif.rsel2 == 0 && cuif.imm16 == cuif.instr[15:0] && cuif.extsel == 1)
      $display("success, aluop = %b, brn = %b, rsel1 = %d, rsel2 = %d, imm16 = %b, extsel =%b", cuif.aluop, cuif.brn, cuif.rsel1, cuif.rsel2, cuif.imm16,cuif.extsel);
    else
      $display("failure, aluop = %b, brn = %b, rsel1 = %d, rsel2 = %d, imm16 = %b, extsel =%b", cuif.aluop, cuif.brn, cuif.rsel1, cuif.rsel2, cuif.imm16,cuif.extsel);

    cuif.instr = 32'h012A082A; //SLT R1 R9 R10
    cuif.port_o = 1;
    #(10);
    if(cuif.aluop == ALU_SLT && cuif.rsel1 == 9 && cuif.rsel2 == 10 && cuif.wsel == 1 && cuif.wdat == cuif.port_o && cuif.WEN == 1)
      $display("success, aluop %b, rsel1 %d, rsel2 %d,wsel %d, WEN %b, wdat %d",cuif.aluop, cuif.rsel1, cuif.rsel2, cuif.wsel, cuif.WEN, cuif.wdat);
    else
      $display("failure, aluop %b, rsel1 %d, rsel2 %d,wsel %d, WEN %b, wdat %d",cuif.aluop, cuif.rsel1, cuif.rsel2, cuif.wsel, cuif.WEN, cuif.wdat);

  end
endprogram
