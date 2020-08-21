  org   0x0000
MAIN:
// stack pointer init
  ori   $29,$0,0xFFFC

// operands
  ori   $10,$0,2
  ori   $11,$0,3
  ori   $12,$0,4
  ori   $13,$0,5

// end position
  ori   $30,$0,0xFFF8

  push  $10
  push  $11
  push  $12
  push  $13

MULT:
  pop   $14
  pop   $15
  ori   $16,$0,0  // clear result
  LOOP:
    addu  $16,$16,$14
    addiu $15,$15,-1
    bne   $15,$0,LOOP
  push  $16
  bne   $29,$30,MULT
  pop   $16
  halt
