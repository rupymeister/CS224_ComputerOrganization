.text
	li $v0, 5
	syscall 
	move $a0, $v0
	
	li $v0, 34
	syscall
	
	jal invertBytes
	
	li $v0,34
	add $a0, $v1, $zero
	syscall
	
	li $v0,10
	syscall
	
invertBytes:
	#alloc
	addi $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	add $s0, $a0, $zero #Saving the number
	add $s1, $zero, $zero
	add $s2, $zero, $zero #INVERTED SUM

	andi $s1, $s0, 0xFF000000
	srl $s1, $s1,24
	
	add $s2, $s1, $zero
	
	andi $s1, $s0, 0x00FF0000
	srl $s1, $s1,8
	
	add $s2, $s1, $s2
	
	andi $s1, $s0, 0x0000FF00
	sll $s1, $s1,8
	
	add $s2, $s1, $s2
	
	andi $s1, $s0, 0x000000FF
	sll $s1, $s1,24
	
	add $s2, $s1, $s2
	move $v1, $s2
	
	#alloc
	sw $ra, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 16
	
	jr $ra
.data

	msg1: .asciiz "\nEnter a number: "
	msg2: .asciiz "\nHexadecimal version: "
	msg3: .asciiz "\nReversed version: "
	newLine: .asciiz "\n"
