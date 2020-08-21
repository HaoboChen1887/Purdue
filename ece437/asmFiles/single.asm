org 0x0000
ori $11, $zero, 3
LOOP:
addi $11, $11, -1
bne $11, $zero, LOOP
DONE:
addi $11, $11, -1
sw $11, 0xFFFC($zero)
halt
