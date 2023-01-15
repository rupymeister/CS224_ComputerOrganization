.text

menu:
	
	jal monitor
	
	j menu
monitor:
	jal init
	
	jal display
	
	
	jal minMax

	jal bubbleSort
	
	jal display
	

init:
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall 
	
	move $a3, $v0 # s0 = size of the array

	blt $a3, $zero, error
	
	sll $s1, $a3, 2
	
	li $v0, 9
	move $a0, $s1
	syscall 
	
	move $a1, $v0 # s1 = base
	move $a2, $a1 # s2 = copy of the base
	li $s3, 0
	
	
	move $s0, $a3
	move $s1, $a1
	move $s2, $a2
	
	loop1: bge $s3, $s0, out
	
		li $v0, 4
		la $a0, msg2
		syscall 
		
		li $v0, 5
		syscall 
	
		add $s4, $v0, $zero  	
		
		sw $s4, 0($s2) 		
		addi $s2, $s2, 4 	
		
		addi $s3, $s3, 1 
		j loop1	
		 
	out:
		
		
		move $v1, $s1	# base
		move $v0, $s0	# size
		
		lw $s5, 20($sp)
		lw $s4, 16($sp)
		lw $s3, 12($sp)
		lw $s2, 8($sp)
		lw $s1, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 24
		jr $ra
	
	
display:
	
	addi $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $ra, 20($sp)
	
	move $s0, $a3 # s0 = size
	move $s1, $a1
	move $s2, $a2 # s2 = copy of the base
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	 
	
	
	
	li $s3, 0
	j check2
	
	loop2: 
		li $v0, 4
		la $a0, space
		syscall 
		
		lw $s4, 0($s2)
		li $v0, 1
		move $a0, $s4
		syscall 
		
		addi $s2, $s2, 4 
		addi $s3, $s3, 1 
		
	check2:
		blt  $s3, $s0, loop2	
		
	
		
		
	
	lw $ra, 20($sp)
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 24
	
	
	
	jr $ra


bubbleSort:
	#alloc
	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)

	
	loop3: 
		move $s2, $a2 # s2 = copy of the base
		move $s0, $a3 # s0 = size
		move $s1, $a1 # s1 = base
		move $s2, $a2 # s2 = copy of the base
		addi $s3, $zero, 1 
		add $s7, $zero, $zero # pass count
		loop4: 	
			
			lw $s4, 0($s2) # i
			lw $s5, 4($s2) # i+1
			bge $s4, $s5, out1 # if i > i+1 exit
			add $s6, $s4, $zero # else swap
			sw $s5, 0($s2)	    #
			sw $s6, 4($s2)	    #
			addi $s7, $s7, 1    # pass++
			out1: addi $s2, $s2, 4 	
			addi $s3, $s3, 1 
			blt $s3, $s0, loop4
			
			bne $s7, $zero, loop3
		
	
	
	
	#alloc
	sw $ra, 32($sp)
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 36
	
	jr $ra
minMax:
	#alloc
	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	
	move $s0, $a3 # s0 = size
	move $s1, $a1
	move $s2, $a2 # s2 = copy of the base
	li $s3, 0
	lw $s5, 0($s2) #max val
	lw $s6, 0($s2) #min val
	loopMin: bge $s3, $s0, exit1
		lw $s4, 0($s2) 	
		bgt $s4, $s6, doNotUpdateMin
		add $s6, $s4, $zero		
		doNotUpdateMin:		
		addi $s2, $s2, 4 	
		addi $s3, $s3, 1 
		j loopMin
	exit1:	
	li $s3, 0
	move $s2, $a2
	loopMax: bge $s3, $s0, exit2
		lw $s4, 0($s2) 
		blt $s4, $s5, doNotUpdateMax
		add $s5, $s4, $zero
		doNotUpdateMax:		
		addi $s2, $s2, 4 	
		addi $s3, $s3, 1 
		j loopMax
	exit2:
	
	li 	$v0, 4
	la 	$a0, msgMin
	syscall
	
	li 	$v0, 1
	la 	$a0, ($s6)
	syscall
	
	li 	$v0, 4
	la 	$a0, msgMax
	syscall
	
	li 	$v0, 1
	la 	$a0, ($s5)
	syscall

	#alloc
	sw $ra, 32($sp)
	sw $s7, 28($sp)
	sw $s6, 24($sp)
	sw $s5, 20($sp)
	lw $s4, 16($sp)
	lw $s3, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 36
	
	jr $ra

error:
	li 	$v0, 4
	la 	$a0, msgError
	syscall 	
	
	j menu






.data

	msg1: .asciiz "\nEnter the size of the array: "
	msg2: .asciiz "\nEnter an element: "
	msg3: .asciiz "\nArray is:"
	msgMin: .asciiz "\nMin value is: "
	msgMax: .asciiz "\nMax value is: " 
	space: .asciiz " "
	msgError: .asciiz "\nThe value is invalid"
	



