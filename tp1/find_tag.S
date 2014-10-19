#include <mips/regdef.h>

	.text
	.align 	2
	.globl	find_tag
	.ent	find_tag

find_tag:
	subu $sp, $sp, 32

	sw $t0, 28($sp)
	sw $t1, 24($sp)
	sw $t2, 20($sp)
	sw $t3, 16($sp)
	sw $t4, 12($sp)

	sw $fp, 8($sp)
	sw $gp, 4($sp)

	move $fp, $sp

	lw $t0, 0($a0)	# $t0 = *file
	lw $t1, 0($a2)	# $t1 = *tag
	lw $t2, 0($t0)	# $t2 = **file
	lw $t3, 0($a1)	# $t3 = line
	lw $t4, 0($a3)	# $t4 = length
	
	move $t1, $t0	# *tag = *file

loop1:
	beq $t2, $zero, return_1
	beq $t2, '<', fin_loop1
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	beq $t2, '\n', inc_line
	j loop1

inc_line:
	addi $t3, $t3, 1
	j loop1	

fin_loop1:
	addi $t0, $t0, 1
	addi $t1, $t1, 1

loop2:
	beq $t0, $zero, return_1
	beq $t2, '>', fin_loop2
	addi $t4, $t4, 1
	addi $t0, $t0, 1
	j loop2

fin_loop2:
	addi $t0, $t0, 1
	j return_0

return_0:
	addi $v0, $zero, 0
	j exit

return_1:
	addi $v0, $zero, 1
	j exit

exit:
	move $sp, $fp
	lw $gp, 4($sp)
	lw $fp, 8($sp)
	lw $t4, 12($sp)
	lw $t3, 16($sp)
	lw $t2, 20($sp)
	lw $t1, 24($sp)
	lw $t0, 28($sp)
	addi $sp, $sp, 48
	jr $ra

	.end find_tag

