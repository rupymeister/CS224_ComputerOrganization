.text
	
	
menu:
	li 	$v0, 4
	la 	$a0, msg1
	syscall 
	

	
         li $v0,8 #take in input
         la $a0, input 
         li $a1, 20 
         move $a3,$a0 
         syscall
         add $s0,$zero,$zero
         add $s1,$zero,$zero
	add $s2, $zero, $zero
         add $s3,$zero,$zero
        add $s4,$zero,$zero
        add $s5,$zero,$zero
        add $s6,$zero,$zero
        add $s7, $zero, $zero
        la $a2,($a3)
        # a3 has the address of the input string
        # s7 is the length of the string
        jal strLength
        add $s0, $zero, $s7
        la $a3, ($a2)
        
        add $s1, $zero, $zero
        loop:
        jal checkNumbers
        
        jal power
 	mul $s2, $s5, $s2
        add $s4, $s2, $s4
        bgt  $s0,$zero, loop
        
	li 	$v0,1 # print 
        move 	$a0, $s4
        syscall
        
        
        j menu
        
        
strLength:
	

        #
	lbu $s2, 0($a3)
	addi $a3, $a3, 1
	addi $s7, $s7, 1
	bne $s2, $zero, strLength
	addi $s7, $s7, -2
	jr  $ra
	
checkNumbers:	
	

	#
	

	lbu $s2, 0($a3)
	addi $a3, $a3, 1
	addi $s3, $zero, 48 #ascii 0
	blt $s2, $s3, error 
	addi $s3, $s3, 9 #ascii 9
	ble $s2, $s3, safe 
checkLetters:
	addi $s3, $s3, 8 #ascii A
	blt $s2, $s3, error
	addi $s3, $s3, 5 #ascii F
	bgt $s2, $s3, error

	addi $s2,$s2, -7
safe:
	addi $s2,$s2, -48
	jr $ra  
	
power:
        addi $s0, $s0, -1
        #
	add $s5,$zero, 1
	add $s6,$zero, 16
	add $s1,$zero,$s0
	beq $s1,$zero,goto
	loop1:
	mul  $s5, $s6, $s5
        addi $s1, $s1, -1
        bgt  $s1,$zero, loop1
        goto:
        jr $ra
        
	
error:
	li 	$v0, 4
	la 	$a0, msgError
	syscall 	
	
	li $v0, 10
	syscall
	

	
	
.data
	
	msg1: 	.asciiz "\nEnter the value: "
	msg2: 	.asciiz "\nBye bye "
	msgError: 	.asciiz "\nThe value is invalid"
	newLine: .asciiz "\n"
	input:	.space 20

	
	
