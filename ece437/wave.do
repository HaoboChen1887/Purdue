onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/cpcr
add wave -noupdate /system_tb/DUT/CPU/DP/npcr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/port_a
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/port_b
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/port_o
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/ov
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/neg
add wave -noupdate -group alu /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/brn
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/bne
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/jmp
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/jr
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/jmpaddr
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/opcode
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/WEN
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/wsel
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/rsel1
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/rsel2
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/extsel
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/luipad
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/memreg
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/rdat2sel
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/imm16
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {control unit} /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/imemload_in
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/npc_in
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/imemload_out
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/npc_out
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/ihit
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/flush
add wave -noupdate -group ifid /system_tb/DUT/CPU/DP/iiif/freeze
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/ihit
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/dREN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/halt_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/dWEN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/luipad_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jr_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jmp_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/brn_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/bne_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat2sel_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/WEN_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/extsel_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/memreg_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jmpaddr_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat1_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat2_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/npc_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/aluop_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rs_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rt_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/wsel_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/imm16_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/flush
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/freeze
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/instr_in
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/dREN_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/halt_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/dWEN_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/luipad_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jr_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jmp_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/brn_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/bne_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat2sel_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/WEN_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/extsel_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/memreg_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/jmpaddr_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat1_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rdat2_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/npc_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/aluop_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rs_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/rt_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/wsel_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/imm16_out
add wave -noupdate -group idex /system_tb/DUT/CPU/DP/ieif/instr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/ihit
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/dhit
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/memreg_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jmp_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/brn_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/bne_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/halt_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/WEN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/dREN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/dWEN_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jmpaddr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/npc_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jraddr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/brnaddr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/wsel_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/rdat2_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/port_o_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/zero_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/ov_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/neg_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/freeze
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/flush
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/instr_in
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jmp_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/brn_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/bne_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/memreg_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/halt_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/WEN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/dREN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/dWEN_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jmpaddr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/npc_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/jraddr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/brnaddr_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/wsel_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/rdat2_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/port_o_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/zero_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/ov_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/neg_out
add wave -noupdate -group exmem /system_tb/DUT/CPU/DP/emif/instr_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/dmemload_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jraddr_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/brnaddr_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/npc_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/port_o_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/ihit
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/dhit
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/halt_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jmpaddr_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/zero_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/neg_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/ov_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/WEN_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/memreg_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/brn_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/bne_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jmp_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jr_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/wsel_in
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/freeze
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/flush
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/dmemload_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jraddr_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/brnaddr_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/npc_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/port_o_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jmpaddr_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/zero_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/neg_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/ov_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/WEN_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/memreg_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/brn_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/bne_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jmp_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/jr_out
add wave -noupdate -group memwb /system_tb/DUT/CPU/DP/mwif/wsel_out
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exWEN
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/memWEN
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/wbWEN
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exbrn
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exbne
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exzero
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exjmp
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exjr
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exwsel
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/memwsel
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/wbwsel
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/rs
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/rt
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/meminstr
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/stall
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/ifidfreeze
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/idexfreeze
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exmemfreeze
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/memwbfreeze
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/ifidflush
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/idexflush
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/exmemflush
add wave -noupdate -group hazard /system_tb/DUT/CPU/DP/huif/memwbflush
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/rs
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/rt
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/memwsel
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/wbwsel
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/memWEN
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/wbWEN
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/exinstr
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/forwarda
add wave -noupdate -group forward /system_tb/DUT/CPU/DP/fuif/forwardb
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group register /system_tb/DUT/CPU/DP/rfif/rdat2
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group memory /system_tb/DUT/CPU/DP/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {129557663554 ps} 0} {{Cursor 2} {383144 ps} 1} {{Cursor 3} {303598 ps} 0}
quietly wave cursor active 3
configure wave -namecolwidth 188
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2100 ns}
