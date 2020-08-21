  org   0x0000

MAIN:
// stack pointer init
  ori   $29, $0, 0xFFFC
// constant init
  ori   $11,$0,30
  ori   $12,$0,365

// var init
  ori   $13,$0,2018
  ori   $14,$0,8
  ori   $15,$0,20
  ori   $16,$0,0

// current month - 1
  addiu $14,$14,-1

// current year - 2000
  addi  $13,$13,-2000

CALC_Y:
  push  $12
  push  $13

MULT:
  pop   $17
  pop   $18
  ori   $19,$0,0  // clear result
LOOP:
  addu  $19,$19,$17
  addiu $18,$18,-1
  bne   $18,$0,LOOP
  addu  $16,$16,$19
  beq   $12,$0,DONE

CALC_M:
  push  $14
  push  $11
  ori   $12,$0,0
  j     MULT

DONE:
  addu  $16,$16,$15
  halt
