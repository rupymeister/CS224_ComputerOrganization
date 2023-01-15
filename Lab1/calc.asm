	.text

	li $v0, 4
	la $a0, str1
	syscall 
	
	li 	$v0, 5
	syscall
	add $t0, $v0, $zero
	
	li $v0, 4
	la $a0, str2
	syscall 
	
	li 	$v0, 5
	syscall
	add $t1, $v0, $zero
	
	li $v0, 4
	la $a0, str3
	syscall 
	
	li 	$v0, 5
	syscall
	add $t2, $v0, $zero
	
	div $t0, $t1
	mflo $t3
	sub $t3, $t3, $2
	div $t3, $t0
	mfhi $t5
	li 	$v0, 1
	move 	$a0, $t5
	syscall
	
	
	
	




	.data

	str1: .asciiz "B: "
	str2: .asciiz "C: "
	str3: .asciiz "D: "
