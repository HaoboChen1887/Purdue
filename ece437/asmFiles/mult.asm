  org   0x0000
MAIN:
  ori   $29,$0,0xFFFC

  ori   $8,$0,130
  ori   $9,$0,999
  push  $8
  push  $9

MULT:
  pop   $12
  pop   $13
  ori   $11,$0,0 //result
LOOP:
  addu  $11,$11,$12
  addi  $13,$13,-1
  bne   $13,$0,LOOP
  halt
