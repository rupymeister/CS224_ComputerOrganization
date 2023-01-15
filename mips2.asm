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
	
	add $t7, $t0,$zero
	
	slt $t6,$t1,$t0
	beq $t6,$zero, Else
	divide:
		divison: #$t4 quotent
			sub $t0,$t0,$t1
			add $t4, $t4, 1
			bge $t0,$t1,divison
	Else:
	mult  $t7, $t2	#$t5 multiplication
	mflo  $t5
	add $t4, $t4, $t5
	sub   $t4, $t4, $t1
	sub $t5, $t5, $t5
	
	slt $t6,$t7,$t4
	beq $t6,$zero, Else2
	mod: 
		sub $t4,$t4,$t7
		bge $t4,$t7,mod
	Else2:
	li $v0, 1
	add $a0, $t4, $zero
	syscall 
	
	
	
	




	.data

	str1: .asciiz "B: "
	str2: .asciiz "C: "
	str3: .asciiz "D: "
