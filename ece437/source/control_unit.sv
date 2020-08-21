`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

module control_unit
import cpu_types_pkg::*;
(
  control_unit_if.cuif cuif
);

r_t rtype;
i_t itype;
j_t jtype;

assign rtype = cuif.instr;
assign itype = cuif.instr;
assign jtype = cuif.instr;

always_comb begin
  cuif.brn = '0;
  cuif.bne = '0;
  cuif.jmp = '0;
  cuif.jr = '0;
  cuif.jmpaddr = '0;
  cuif.aluop = ALU_ADD;
  cuif.WEN = '0;
  cuif.wsel = '0;
  cuif.rsel1 = '0;
  cuif.rsel2 = '0;
  cuif.luipad = '0;
  cuif.extsel = '0;
  cuif.memreg = '0;
  cuif.rdat2sel = '0;
  cuif.dWEN = '0;
  cuif.dREN = '0;
  cuif.halt = '0;
  cuif.imm16 = '0;
  cuif.opcode = itype.opcode;
  casez(itype.opcode)
    BEQ:begin
      cuif.aluop = ALU_SUB;
      cuif.brn = 1;
      cuif.rsel1 = itype.rs;
      cuif.rsel2 = itype.rt;
      cuif.imm16 = itype.imm;
      cuif.extsel = 1;
    end
    BNE:begin
      cuif.aluop = ALU_SUB;
      cuif.bne = 1;
      cuif.rsel1 = itype.rs;
      cuif.rsel2 = itype.rt;
      cuif.imm16 = itype.imm;
      cuif.extsel = 1;
    end
    ADDI:begin
      // default write from ALU
      cuif.aluop = ALU_ADD;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      cuif.extsel = 1; // signed extension
    end
    ADDIU:begin
      // default write from ALU
      cuif.aluop = ALU_ADD;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      cuif.extsel = 1; // signed extension
    end
    SLTI:begin
      // default write from ALU
      cuif.aluop = ALU_SLT;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      cuif.extsel = 1; // signed extension
    end
    SLTIU:begin
      // default write from ALU
      cuif.aluop = ALU_SLTU;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      // default unsigned extension
    end
    ANDI:begin
      // default write from ALU
      cuif.aluop = ALU_AND;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      // default unsigned extension
    end
    ORI:begin
      // default write from ALU
      cuif.aluop = ALU_OR;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      // default unsigned extension
    end
    XORI:begin
      // default write from ALU
      cuif.aluop = ALU_XOR;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      // default unsigned extension
    end
    LUI:begin
      // default write from ALU
      cuif.aluop = ALU_OR;
      cuif.rsel1 = '0; // $0 reg
      cuif.wsel = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      cuif.luipad = 1; // special handle for lui
      // default unsigned extension
    end
    LW:begin
      cuif.aluop = ALU_ADD;
      cuif.rsel1 = itype.rs;
      cuif.wsel = itype.rt;
      cuif.memreg = 1; // write from memory
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      cuif.WEN = 1;
      cuif.extsel = 1; // signed extention
      cuif.dREN = 1; // enable read from memory
    end
    SW:begin
      cuif.aluop = ALU_ADD;
      cuif.rsel1 = itype.rs;
      cuif.rsel2 = itype.rt;
      cuif.rdat2sel = 1; // select imm16
      cuif.imm16 = itype.imm;
      // default disable write to reg
      cuif.extsel = 1; // signed extention
      cuif.dWEN = 1; // enable write to memory
    end
    HALT:begin
      cuif.halt = 1;
    end
    J:begin
      cuif.jmp = 1;
      cuif.aluop = ALU_ADD;
      cuif.jmpaddr = jtype.addr;
    end
    JAL:begin
      cuif.jmp = 1;
      cuif.aluop = ALU_ADD;
      cuif.memreg = 2; // write from pc
      cuif.wsel = 31; // select $31
      cuif.WEN = 1; // write current pc to $31 return addr
      cuif.jmpaddr = jtype.addr;
    end
    RTYPE:begin
      cuif.brn = '0;
      cuif.bne = '0;
      cuif.jmp = '0;
      cuif.jr = '0;
      cuif.jmpaddr = '0;
      cuif.aluop = ALU_ADD;
      cuif.WEN = '0;
      cuif.wsel = '0;
      cuif.rsel1 = '0;
      cuif.rsel2 = '0;
      cuif.luipad = '0;
      cuif.extsel = '0;
      cuif.memreg = '0;
      cuif.rdat2sel = '0;
      cuif.dWEN = '0;
      cuif.dREN = '0;
      cuif.halt = '0;
      cuif.imm16 = '0;
      cuif.opcode = itype.opcode;
      casez(rtype.funct)
        SLLV:begin
          // default write from alu
          cuif.aluop = ALU_SLL;
          cuif.WEN = 1;
          cuif.rdat2sel = 0; // select imm16(shamt)
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        SRLV:begin
          // default write from alu
          cuif.aluop = ALU_SRL;
          cuif.WEN = 1;
          cuif.rdat2sel = 0; // select imm16(shamt)
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        JR:begin
          cuif.jr = 1;
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = 0; // select $0
          cuif.wsel = rtype.rd;
          cuif.aluop = ALU_OR;
        end
        ADD:begin
          cuif.aluop = ALU_ADD;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        ADDU:begin
          cuif.aluop = ALU_ADD;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        SUB:begin
          cuif.aluop = ALU_SUB;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        SUBU:begin
          cuif.aluop = ALU_SUB;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        AND:begin
          cuif.aluop = ALU_AND;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        OR:begin
          cuif.aluop = ALU_OR;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        XOR:begin
          cuif.aluop = ALU_XOR;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        NOR:begin
          cuif.aluop = ALU_NOR;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        SLT:begin
          cuif.aluop = ALU_SLT;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
        SLTU:begin
          cuif.aluop = ALU_SLTU;
          cuif.WEN = 1;
          // default select rdat2
          cuif.rsel1 = rtype.rs;
          cuif.rsel2 = rtype.rt;
          cuif.wsel = rtype.rd;
        end
      endcase
    end
  endcase
end

endmodule
