# CS224 Lab 3
# Anýl Altuncu

.text
menu:
	li $v0, 4
	la $a0, msgGetNumber
	syscall
	
	li	$v0, 5
	syscall
	
	move $a1, $v0
	
	beq $a1, $zero, error
	
	li $v0, 4
	la $a0, msgGetDivider
	syscall
	
	li	$v0, 5
	syscall
	
	move $a2, $v0
	
	beq $a2, $zero, error
	
	jal	start
# Print result.	
	li $v0, 4
	la $a0, msgResult
	syscall
	
	
	move $t2, $a3
	
	li	$v0, 1
	move	$a0, $t2
	syscall
	
	
	j menu
# Stop	
error:	

	li $v0, 4
	la $a0, msgError
	syscall
	
	li	$v0, 10
	syscall
#==========================================
start:
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp)
	
	move $s1, $a1 #divident
	move $s2, $a2 #divider
		      #s3 is quotent
divide:
	bge	$s1, $zero, else
	move $a3, $s3
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra
	
add1: 	addi	$s3, $s3, 1
	j done1
else:
	sub 	$s1, $s1, $s2
	bge	$s1, $zero, add1
	done1:
	jal	divide
	
	
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra


.data
	msgGetNumber: .asciiz "\nEnter a number:"
	msgGetDivider: .asciiz "Enter a divider:"
	msgError: .asciiz "Entered 0"
	msgResult: .asciiz "The result is: "
