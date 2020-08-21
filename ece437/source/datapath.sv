/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  register_file_if rfif();
  alu_if aluif();
 // program_counter_if pcif();
  control_unit_if cuif();
  if_id_if iiif();
  id_ex_if ieif();
  ex_mem_if emif();
  mem_wb_if mwif();
  hazard_unit_if huif();
  forward_unit_if fuif();

  register_file RF(CLK, nRST, rfif);
  alu ALU(aluif);
  control_unit CU(cuif);
  if_id IFID(CLK,nRST,iiif);
  id_ex IDEX(CLK,nRST,ieif);
  ex_mem EXMEM(CLK,nRST,emif);
  mem_wb MEMWB(CLK,nRST,mwif);
  hazard_unit HU(huif);
  forward_unit FU(fuif);

//=========================program counter====================================================
  word_t imm32, lui32, brnaddr, wdat;
  word_t cpcr, npcr, pcradd;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST)
      cpcr <= '0;
    else
      if(dpif.ihit && ~huif.stall)
        cpcr <= npcr;
      else
        cpcr <= cpcr;
  end

  assign pcradd = cpcr + 4;
  always_comb begin
    if(ieif.brn_out && aluif.zero || ieif.bne_out && ~aluif.zero)begin
      npcr = brnaddr;
    end // if(mwif.brn_out)
    else if(ieif.jmp_out)begin
      npcr = {pcradd[31:28], ieif.jmpaddr_out, 2'b0};
    end // else if(mwif.jmp_out)
    else if(ieif.jr_out)begin
      npcr = aluif.port_o; // jraddr
    end // else if(mwif.jr_out)
    else begin
      npcr = pcradd;
    end
  end // always_comb

//=========================Hazard Unit=========================================================

  assign iiif.freeze = huif.ifidfreeze;
  assign ieif.freeze = huif.idexfreeze;
  assign iiif.flush = huif.ifidflush;
  assign ieif.flush = huif.idexflush;
  assign emif.freeze = huif.exmemfreeze;
  assign emif.flush = huif.exmemflush;
  assign mwif.freeze = huif.memwbfreeze;
  assign mwif.flush = huif.memwbflush;
  assign huif.rs = cuif.rsel1;
  assign huif.rt = cuif.rsel2;
  assign huif.dhit = dpif.dhit;
  assign huif.exinstr = ieif.instr_out;

  assign huif.exwsel = ieif.wsel_out;
  assign huif.exWEN = ieif.WEN_out;

  assign huif.memwsel = emif.wsel_out;
  assign huif.memWEN = emif.WEN_out;

  assign huif.wbwsel = mwif.wsel_out;
  assign huif.wbWEN = mwif.WEN_out;

  assign huif.exbrn = ieif.brn_out;

  assign huif.exbne = ieif.bne_out;

  assign huif.exjmp = ieif.jmp_out;

  assign huif.exjr = ieif.jr_out;

  assign huif.exzero = aluif.zero;

//=========================Forward Unit===========================================================

  assign fuif.rs = ieif.rs_out;
  assign fuif.rt = ieif.rt_out;
  assign fuif.exinstr = ieif.instr_out;
  assign fuif.memwsel = emif.wsel_out;
  assign fuif.wbwsel = mwif.wsel_out;
  assign fuif.memWEN = emif.WEN_out;
  assign fuif.wbWEN = mwif.WEN_out;

//==========================IF/ID connection======================================================

  assign iiif.ihit = dpif.ihit;
  assign iiif.npc_in = npcr;
  assign iiif.imemload_in = dpif.imemload;
  assign cuif.instr = iiif.imemload_out;


//==========================ID/EX connection====================================================

  assign rfif.rsel1 = cuif.rsel1;
  assign rfif.rsel2 = cuif.rsel2;
  assign ieif.ihit = dpif.ihit;
  assign ieif.npc_in = iiif.npc_out;
  assign ieif.brn_in = cuif.brn;
  assign ieif.bne_in = cuif.bne;
  assign ieif.jmpaddr_in = cuif.jmpaddr;
  assign ieif.jmp_in = cuif.jmp;
  assign ieif.jr_in = cuif.jr;
  assign ieif.dREN_in = cuif.dREN;
  assign ieif.dWEN_in = cuif.dWEN;
  assign ieif.WEN_in = cuif.WEN;
  assign ieif.memreg_in = cuif.memreg;
  assign ieif.halt_in = cuif.halt;
  assign ieif.wsel_in = cuif.wsel;
  assign ieif.aluop_in = cuif.aluop;
  assign ieif.rdat2sel_in = cuif.rdat2sel;
  assign ieif.luipad_in = cuif.luipad;
  assign ieif.extsel_in = cuif.extsel;
  assign ieif.rdat1_in = rfif.rdat1;
  assign ieif.rdat2_in = rfif.rdat2;
  assign ieif.imm16_in = cuif.imm16;
  assign ieif.rs_in = cuif.rsel1;
  assign ieif.rt_in = cuif.rsel2;
  assign ieif.instr_in = cuif.instr;

//==============================EX/MEM connection====================================================

  always_comb begin 
    lui32 = '0;
    imm32 = {16'h0, ieif.imm16_out};
    if(ieif.luipad_out)begin
      lui32 = {ieif.imm16_out, 16'h0};
    end // if(ieif.luipad_out)
    else if(ieif.extsel_out)begin
      imm32 = (ieif.imm16_out[15] == 0) ? {16'h0, ieif.imm16_out} : {16'hffff, ieif.imm16_out};
    end // else if(ieif.extsel_out)
    else begin
      imm32 = {16'h0, ieif.imm16_out};
    end // else
  end // always_comb

  //=====================================ALU connection=============================================

  always_comb begin
    if(ieif.luipad_out)begin
      aluif.port_b = lui32;
    end // if(ieif.luipad_out)
    else if(ieif.rdat2sel_out)begin
      aluif.port_b = imm32;
    end // else if(ieif.rdat2sel_out)
    else begin
      if(fuif.forwardb == 2'b00)begin
        aluif.port_b = ieif.rdat2_out;
      end
      else if(fuif.forwardb == 2'b01)begin
        aluif.port_b = wdat;
      end
      else begin
        aluif.port_b = emif.port_o_out;
      end // else
      //aluif.port_b = ieif.rdat2_out;
    end // else
  end // always_comb

  always_comb begin
    if(fuif.forwarda == 2'b00)begin
      aluif.port_a = ieif.rdat1_out;
    end
    else if(fuif.forwarda == 2'b01)begin
      aluif.port_a = wdat;
    end
    else begin
      aluif.port_a = emif.port_o_out;
    end // else
  end // always_comb
  //assign aluif.port_a = ieif.rdat1_out;

  //=======================================branch calculation==============================================

  assign brnaddr = ieif.npc_out + {imm32[29:0], 2'b00};

  //========================================EX/MEM Latch==================================================

  assign emif.ihit = dpif.ihit;
  assign emif.dhit = dpif.dhit;
  assign emif.npc_in = ieif.npc_out;
  assign emif.brnaddr_in = brnaddr;
  assign emif.brn_in = ieif.brn_out;
  assign emif.bne_in = ieif.bne_out;
  assign emif.jmpaddr_in = ieif.jmpaddr_out;
  assign emif.jmp_in = ieif.jmp_out;
  assign emif.jraddr_in = aluif.port_o;
  assign emif.jr_in = ieif.jr_out;
  assign emif.dREN_in = ieif.dREN_out;
  assign emif.dWEN_in = ieif.dWEN_out;
  assign emif.WEN_in = ieif.WEN_out;
  assign emif.memreg_in = ieif.memreg_out;
  assign emif.halt_in = ieif.halt_out;
  assign emif.wsel_in = ieif.wsel_out;
  //assign emif.rdat2_in = ieif.rdat2_out;
  always_comb begin
      if(fuif.forwardb == 2'b00)begin
        emif.rdat2_in = ieif.rdat2_out;
      end
      else if(fuif.forwardb == 2'b01)begin
        emif.rdat2_in = wdat;
      end
      else begin
        emif.rdat2_in = emif.port_o_out;
      end // else
  end

  assign emif.port_o_in = aluif.port_o;
  assign emif.zero_in = aluif.zero;
  assign emif.ov_in = aluif.ov;
  assign emif.neg_in = aluif.neg;
  assign aluif.aluop = ieif.aluop_out;
  assign dpif.dmemstore = emif.rdat2_out;
  assign emif.instr_in = ieif.instr_out;
  assign emif.dmemload_in = dpif.dmemload;


  // ==============================================MEM/WB Connection======================================

  // =============================================cache connection=========================================

  assign dpif.imemREN = 1'b1;
  assign dpif.dmemREN = emif.dREN_out;
  assign dpif.dmemWEN = emif.dWEN_out;
  assign dpif.dmemaddr = emif.port_o_out;
  assign dpif.imemaddr = cpcr;

  assign mwif.ihit = dpif.ihit;
  assign mwif.dhit = dpif.dhit;
  assign mwif.npc_in = emif.npc_out;
  assign mwif.brnaddr_in = emif.brnaddr_out;
  assign mwif.brn_in = emif.brn_out;
  assign mwif.bne_in = emif.bne_out;
  assign mwif.jmpaddr_in = emif.jmpaddr_out;
  assign mwif.jmp_in = emif.jmp_out;
  assign mwif.jraddr_in = emif.jraddr_out;
  assign mwif.jr_in = emif.jr_out;
  assign mwif.WEN_in = emif.WEN_out;
  assign mwif.memreg_in = emif.memreg_out;
  assign mwif.halt_in = emif.halt_out;
  assign mwif.wsel_in = emif.wsel_out;
  assign mwif.port_o_in = emif.port_o_out;
  assign mwif.dmemload_in = emif.dmemload_out;
  assign mwif.zero_in = emif.zero_out;
  assign mwif.ov_in = emif.ov_out;
  assign mwif.neg_in = emif.neg_out;

  //==================================================Write back==============================================

  assign rfif.WEN = mwif.WEN_out;
  assign rfif.wsel = mwif.wsel_out;
  assign rfif.wdat = wdat;
  always_comb begin
    if(mwif.memreg_out == 2)begin
      wdat = mwif.npc_out;
    end // if(mwif.memreg_out == 0)
    else if(mwif.memreg_out == 1)begin
      wdat = mwif.dmemload_out;
    end
    else begin
      wdat = mwif.port_o_out;
    end
  end
  always_ff @(posedge CLK ,negedge nRST) begin
    if(!nRST) begin
       dpif.halt <= 0;
    end else if(mwif.halt_out)begin
      dpif.halt <= 1;
    end
    else begin
      dpif.halt <= dpif.halt;
    end
  end
endmodule
