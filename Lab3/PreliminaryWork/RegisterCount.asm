#Anýl Altuncu
#lab03 preliminary work 2

.text
start:
	li $v0, 4
	la $a0, msg1
	syscall
	
	
	li $v0, 5
	syscall
	
	move $a2, $v0
	
	ble $a2, 0, error
	bge $a2, 32, error
	
	la	$a0, check1
	la	$a1, end1
	
	jal counter
	move $t1, $v0
	
	move	$a0, $t1
	li	$v0, 1
	syscall
	
	li	$v0, 10
	syscall
	
error:
	li $v0, 4
	la $a0, msgError
	syscall
	
	li	$v0, 10
	syscall
	
counter:


	addi, $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	move $s0,$a0 
	
	
	move $s1,$a1 
	
	move $s2,$a2
	
	li $s7, 0  
	
count:
	beq $s0, $s1, done
	lw $s6, 0($s0)
	
	#Opcode (31-26)
	srl $s3, $s6, 26
	
	#RegisterS (25-21)

	sll $s4, $s6, 6
	check1:
	srl $s4, $s4, 27
	end1:
	bne $s4, $s2, skip
	addi $s7, $s7, 1

	
skip:
	#RegisterT (20-16)
	sll $s4, $s6, 11
	srl $s4, $s4, 27
	
	
	bne $s4, $s2, RD
	
	addi $s7, $s7, 1
	
	beqz $s3, RD
	
	j next
RD:
	#RegisterD (15-11)
	sll $s4, $s6, 16
	srl $s4, $s4, 27
	bne $s4, $s3, next
	addi $s7, $s7, 1
next:			

	addi	$s0, $s0, 4
	j	count
	
done:

	move $v0, $s7
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$s4, 16($sp)
	lw	$s5, 20($sp)
	lw	$s6, 24($sp)
	lw	$s7, 28($sp)
	lw	$ra, 32($sp)
	addi	$sp, $sp, 36
	jr	$ra
	
.data
	msg1: .asciiz "Enter the register number (1-31): "
	msgError: .asciiz "Invalid value"
