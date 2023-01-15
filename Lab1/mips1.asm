	.text
	#Swap elements of an array
	li 	$v0, 5
	syscall
	sw 	$v0, arraySize
	beq	$v0, $zero, quit
	la 	$t1, array
	lw 	$t2, arraySize
	
	
next:	li 	$v0, 5
	syscall
	
	sw 	$v0, 0($t1)
	
	addi 	$t1, $t1, 4
	addi 	$t2, $t2, -1
	bne 	$t2, $zero, next
	
	la	$t5, -4($t1) 
	la 	$t1, array
	lw 	$t2, arraySize
	
loop:	lw	$t3, 0($t1)
	li 	$v0, 1
	move 	$a0, $t3
	syscall
	li      $v0,4       
	la      $a0, space 
	syscall              
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	bne $t2, $zero, loop
	
	la 	$t1, array
	lw 	$t2, arraySize
	li      $v0,4       
	la      $a0, newLine
	syscall
	
	
	
loop2:	
	lw $t4, ($t1)
	lw $t6, ($t5)
	sw $t6, 0($t1)
	sw $t4, 0($t5)
	
	addi $t5, $t5, -4
	addi $t1, $t1, 4
	addi $t2,$t2, -1
	ble $t1, $t5, loop2
	
	
	la 	$t1, array
	lw 	$t2, arraySize

	

loop3:	lw	$t3, 0($t1)
	li 	$v0, 1
	move 	$a0, $t3
	syscall
	li      $v0,4       
	la      $a0, space 
	syscall              
	addi $t1, $t1, 4
	addi $t2, $t2, -1
	bne $t2, $zero, loop3
	
	la 	$t1, array
	lw 	$t2, arraySize
	li      $v0,4       
	la      $a0, newLine
	syscall
	
	j exit
	
quit:
	li $v0, 4
	la $a0, msg1
	syscall
exit:		
	li $v0, 10
	syscall

	.data
	array: .space 80
	arraySize: .space 4 
	space: .asciiz      " "
	newLine: .asciiz "\n"
	msg1: .asciiz "there are 0 elements!"
