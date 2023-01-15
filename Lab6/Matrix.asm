#CS224 Lab 6
#Anıl Altuncu (21901880)



.text 
menu:
	jal createMatrix
start:	
	li $v0, 4
	la $a0, msg1
	syscall
	
	addi $t5, $zero, 1
	addi $t6, $zero, 2
	addi $t7, $zero, 3
	
	li $v0, 4
	la $a0, msgSelect
	syscall
	
	li	$v0, 5
	syscall
	
	move $t4, $v0
	beq $t4,$t5, displayDesired
	beq $t4,$t6, sumRow
	beq $t4,$t7, sumColumn
	
	
	j start

createMatrix:
	addi	$sp, $sp, -36 
	sw	$s0, 32($sp)
	sw	$s1, 28($sp)
	sw	$s2, 24($sp)
	sw	$s3, 20($sp)
	sw	$s4, 16($sp)
	sw	$s5, 12($sp)
	sw	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw	$ra, 0($sp)
	
	li $v0, 4
	la $a0, msgDimension
	syscall
	
	li	$v0, 5
	syscall
	
	##### allocate mem
	move $a1, $v0
	
	
	
	mul $s1, $a1, $a1 #s1 is the size
	mul $s2, $s1, 2
	
	move $a0, $s2
	li $v0, 9
	syscall
	#####
	move $s2, $v0 #base
	move $s3, $a1
	
	addi $s1,$s1, 1
	loop: 
	
	sh $s0, 0($s2)
	addi $s2, $s2, 2
	addi $s0, $s0, 1
	bne $s0, $s1, loop
	
	
	move $a2,$v0 # a2 has the base 
		     # a1 has the size n of n x n matrix
	
	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw 	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr $ra
	
displayDesired:
	addi	$sp, $sp, -36 
	sw	$s0, 32($sp)
	sw	$s1, 28($sp)
	sw	$s2, 24($sp)
	sw	$s3, 20($sp)
	sw	$s4, 16($sp)
	sw	$s5, 12($sp)
	sw	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw	$ra, 0($sp)
	li $v0, 4
	la $a0, msgRow
	syscall
	
	li	$v0, 5
	syscall
	move $s0, $v0
	
	li $v0, 4
	la $a0, msgColumn
	syscall
	
	li	$v0, 5
	syscall
	move $s1, $v0
	
	addi $s0, $s0, -1
	mul $s0, $s0, $a1
	add $s0, $s0, $s1
	add $s2, $zero, $zero
	
	move $s1, $a2
	
	loop2:
	addi $s1,$s1, 2
	addi $s2, $s2, 1
	bne $s2,$s0, loop2
	
	lh $s0, 0($s1)
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	li $v0, 4
	la $a0, msgSpace
	syscall
	
	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw 	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr $ra
	
sumRow: 
	addi	$sp, $sp, -36 
	sw	$s0, 32($sp)
	sw	$s1, 28($sp)
	sw	$s2, 24($sp)
	sw	$s3, 20($sp)
	sw	$s4, 16($sp)
	sw	$s5, 12($sp)
	sw	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw	$ra, 0($sp)
	
	move $s4, $zero
	move $s3, $zero
	move $s1, $a2
	move $s2, $a1
	add $s4, $a1, $zero
	add $s5, $s5, 1
	
	loop3:
	addi $s1,$s1, 2
	addi $s2, $s2, -1
	lh $s0, 0($s1)
	add $s3, $s3, $s0
	bne $s2, $zero, loop3
	li $v0, 4
	la $a0, msgR
	syscall
	li $v0, 1
	la $a0, ($s5)
	syscall
	li $v0, 4
	la $a0, msg
	syscall
	li $v0, 1
	la $a0, ($s3)
	syscall
	li $v0, 4
	la $a0, msgSpace
	syscall
	add $s6, $s6, $s3
	move $s3, $zero
	move $s2, $a1
	add $s5, $s5, 1
	addi $s4, $s4, -1
	bne $s4, $zero, loop3
	li $v0, 4
	la $a0, msgSum
	syscall
	li $v0, 1
	la $a0, ($s6)
	syscall
	li $v0, 4
	la $a0, msgSpace
	syscall	
	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw 	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr $ra
sumColumn:
	addi	$sp, $sp, -36 
	sw	$s0, 32($sp)
	sw	$s1, 28($sp)
	sw	$s2, 24($sp)
	sw	$s3, 20($sp)
	sw	$s4, 16($sp)
	sw	$s5, 12($sp)
	sw	$s6, 8($sp)
	sw	$s7, 4($sp)
	sw	$ra, 0($sp) 
	
	move 	$s0, $a2
	move 	$t0, $a2	
	
	addi $s4, $a1, -1
	mul 	$t1, $s4, 2
	move 	$s5, $a1
	
	move 	$s1, $s5

	move 	$s2, $s5	

	
	addi	$s3, $s3, 0	
	addi	$s6, $s6, 0	
	addi	$s7, $s7, 1
	
	loop4:
		addi $s0,$s0, 2
		lh	$s4, 0($s0)
		add	$s3, $s4, $s3
		addi 	$s1, $s1, -1
		
		add 	$s0, $s0, $t1
		
		bne 	$s1, $0, loop4
		la 	$a0, msgC	
		li 	$v0, 4
		syscall
		li $v0, 1
   		move $a0, $s7
		syscall
		la 	$a0, msg	
		li 	$v0, 4
		syscall
		li $v0, 1
   		move $a0, $s3
		syscall
		la 	$a0, msgSpace	
		li 	$v0, 4
		syscall
		
		add 	$s6, $s6, $s3
		li 	$s3, 0
		move 	$s1, $s5
		addi	$s7, $s7, 1
		addi 	$s2, $s2, -1
		
		addi 	$t0, $t0, 2
		move	$s0,$t0
		bne 	$s2, $0, loop4
		la 	$a0, msgSumC	
		li 	$v0, 4
		syscall
		la 	$a0, msgSpace	
		li 	$v0, 4
		syscall
		li $v0, 1
   		move $a0, $s6
		syscall
	
	
	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw 	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr $ra

.data
msgDimension: .asciiz "Enter a number for dim: "
msgRow: .asciiz "Enter a row num: "
msgColumn: .asciiz "Enter a column num: "
msg1: .asciiz "--------\n"
msgSpace: .asciiz "\n"
msgR: .asciiz "Sum of Row "
msg: .asciiz ": "
msgSum: .asciiz "Sum of all rows: "
msgC: .asciiz "Sum of Column "
msgSumC: .asciiz "Sum of all columns: "
msgSelect: .asciiz "1.display element\n2.Row sum\n3.Column sum\nSelect an option:"
