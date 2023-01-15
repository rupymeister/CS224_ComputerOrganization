.text

	li $v0, 4
	la $a0, msg1
	syscall 
	
	li 	$v0, 5
	syscall
	
	sw 	$v0, arraySize
	
	la 	$t1, array
	lw 	$t2, arraySize
	
	li $v0, 4
	la $a0, msg2
	syscall 
	next:	li 	$v0, 5
		syscall
		sw 	$v0, 0($t1)
		addi 	$t1, $t1, 4
		addi 	$t2, $t2, -1
		bne 	$t2, $zero, next
menu:
		la	$t5, -4($t1) 
		la 	$t1, array
		lw 	$t2, arraySize
		sub $t0, $t0,$t0
	li $v0, 4
	la $a0, msg8
	syscall 
	li 	$v0, 5
	syscall
	add $t0,$t0,$v0
	
	addi $t3, $zero, 1
	beq $t3,$t0, partA
	addi $t3, $t3, 1
	beq $t3,$t0, partB 
	addi $t3, $t3, 1
	beq $t3,$t0, partC 
	addi $t3, $t3, 1
	beq $t3,$t0, quit 
	j menu
partA:
	
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
	
	
		li $v0, 4
		la $a0, newLine
		syscall 
		add $t0, $t0, $zero
		li $v0, 4
		la $a0, msg9
		syscall
		li 	$v0, 5
		syscall
		add $t0, $v0, $zero #$t0 is the input number
		sub $t3, $t3, $t3

	sum1:	
		lw $t4, 0($t1)
		ble $t4,  $t0, skip
		add $t3, $t3, $t4 #$t3 summation
		sub $t4, $t4, $t4

		skip:            
			addi $t1, $t1, 4
			addi $t2, $t2, -1
			bne $t2, $zero, sum1
	
		li 	$v0, 1
		move 	$a0, $t3
		syscall

		li      $v0,4       
		la      $a0, newLine
		syscall
		la 	$t1, array
		lw 	$t2, arraySize
		li      $v0,4       
		syscall
		sub $t3, $t3, $t3
		sub $t7,$t7,$t7
		addi	$t7, $t7, 2
		lw $t6, arraySize
	
		
		j menu
		
partB:
		
		add $t0,$zero, $zero
		add $t3, $zero, $zero
		addi $t7, $zero, 2  
		la 	$t1, array
		lw 	$t2, arraySize
		li      $v0,4       
		la      $a0, msg4
		syscall
	sum2:
		lw $t4, 0($t1)
	
		div $t4, $t7
		mfhi $t0
		beqz $t0, even  
		odd:
			addi $t3, $t3, 1 #$t3 summation
			li 	$v0, 1
			move 	$a0, $t4
			syscall
			li      $v0,4       
			la      $a0, space 
			syscall   
        	even:
        	
			addi $t1, $t1, 4
			addi $t2, $t2, -1
			bne $t2, $zero, sum2
	
	
		li      $v0,4       
		la      $a0, msg5
		syscall
		li 	$v0, 1
		move 	$a0, $t3
		syscall
		la 	$t1, array
		lw 	$t2, arraySize
		sub $t6, $t2, $t3
		lw $t4, 0($t1)
	
		sub $t5, $t5, $t5
		addi $t5, $t5, 1
		li      $v0,4       
		la      $a0, msg3
		syscall
	sum3:	
		lw $t4, 0($t1)
	
		div $t4, $t7
		mfhi $t0
		beq $t0, $t5, odd1  
		li 	$v0, 1
		move 	$a0, $t4
		syscall
		li      $v0,4       
		la      $a0, space 
		syscall     
        odd1:
        	
		addi $t1, $t1, 4
		addi $t2, $t2, -1
		bne $t2, $zero, sum3
	
	
		li      $v0,4       
		la      $a0, msg5
		syscall
		li 	$v0, 1
		move 	$a0, $t6
		syscall
		
		j menu
partC:
	la 	$t1, array
	lw 	$t2, arraySize
	
	li $v0, 4
	la $a0, msg9
	syscall 
	li 	$v0, 5
	syscall
	add $t7, $zero, $v0
	sub $t5, $t5, $t5
	loop3:	lw $t3, 0($t1)
		div $t3, $t7
		mfhi  $t4
		
		bnez  $t4, skip3
		addi $t5, $t5, 1
		
		skip3:             
			addi $t1, $t1, 4
			addi $t2, $t2, -1
			bne $t2, $zero, loop3

	la 	$t1, array
	lw 	$t2, arraySize
	li      $v0,4       
	la      $a0, newLine
	syscall
	li 	$v0, 1
	move 	$a0, $t5
	syscall

	j menu
	
quit:
	li $v0, 10
	syscall

.data 
	array: .space 100
	arraySize: .space 4 
	space: .asciiz      " "
	newLine: .asciiz "\n"

	msg1: .asciiz "\nEnter the number of elements: "
	msg2: .asciiz "\nEnter the elements one by one: "
	msg3: .asciiz "\nEven Numbers: "
	msg4: .asciiz "\nOdd Numbers: "
	msg5: .asciiz "\ncount: "
	msg6: .asciiz "\nNumber of occurences: "
	msg7: .asciiz "\nDivisible numbers: "
	msg8: .asciiz "\n1. Find summation of numbers stored in the array which is greater than an input number.\n2. Find summation of even and odd numbers and display them.\n3. Display the number of occurrences of the array elements divisible by a certain input number.\n4. Quit."
	msg9: .asciiz "Enter a number: "
	
