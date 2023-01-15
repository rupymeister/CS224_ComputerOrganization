.text

	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall 
	
	move $t0, $v0
	la	$a0, ($t0) 	
	jal	createLinkedList
	
	move $a1, $v0 #head pointer
	
	move	$a0, $v0	# Pass the linked list address in $a0
	jal 	printLinkedList
	
	
	#a3 is the last node address
	#a2 is the size
	
	
	
	
	li $v0, 4
	la $a0, parantesis1
	syscall
	
	jal	printRecursive
	
	li $v0, 4
	la $a0, parantesis2
	syscall
	
	li	$v0, 10
	syscall
	
	
printRecursive:

	
	addi	$sp, $sp, -28
	sw	$a1, 24($sp)
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp)
	
	
	lw	$s2, 4($a1)	# $s2: Data of current node
	lw 	$s4, 0($a1)	# $s1: Address of  next node
	
	
	
	bne  $s4, $zero, goOn1
	
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall			
	
	li $v0, 4
	la $a0, space
	syscall
	
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	lw	$a1, 24($sp)
	addi	$sp, $sp, 28
	jr	$ra
	
	goOn1:
	
	move 	$a1, $s4
	jal	printRecursive
				# $s0: Address of current node
	
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	
	
	li $v0, 4
	la $a0, space
	syscall
	
	
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	lw	$a1, 24($sp)
	addi	$sp, $sp, 28
	jr	$ra


createLinkedList:
# $a0: No. of nodes to be created ($a0 >= 1)
# $v0: returns list head
# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
# By 4*i inserting a data value like this
# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall 
	move $s4, $v0
	sw	$s4, 4($s2)	# Store the data value.
	beq $s0, $s1, allDone
	
addNode:
# Are we done?
# No. of nodes created compared with the number of nodes to be created.
	beq	$s1, $s0, allDone
	addi	$s1, $s1, 1	# Increment node counter.
	li	$a0, 8 		# Remember: Node size is 8 bytes.
	li	$v0, 9
	syscall
# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s2)
# Now make $s2 pointing to the newly created node.
	move	$s2, $v0	# $s2 now points to the new node.
	
	
	li $v0, 5
	syscall 
	move $s4, $v0	
# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	j	addNode
allDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	move $a2, $s2
	move $a3, $s1
	sw	$zero, 0($s2)
	move	$v0, $s3	# Now $v0 points to the list head ($s3).
	
# Restore the register values
	lw	$ra, 0($sp)
	lw	$s4, 4($sp)
	lw	$s3, 8($sp)
	lw	$s2, 12($sp)
	lw	$s1, 16($sp)
	lw	$s0, 20($sp)
	addi	$sp, $sp, 24
	
	jr	$ra
#=========================================================
printLinkedList:
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp)
	
	
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
	
	li $v0, 4
	la $a0, parantesis1
	syscall
	move $a0, $s0
	
printNextNode:
	beq	$s0, $zero, printedAll
				# $s0: Address of current node
	lw	$s1, 0($s0)	# $s1: Address of  next node
	lw	$s2, 4($s0)	# $s2: Data of current node
	addi	$s3, $s3, 1
	move	$a3, $s0
	move	$a0, $s2	# $s2: Data of current node
	li	$v0, 1		
	syscall	
	li $v0, 4
	la $a0, space
	syscall

# Now consider next node.
	
	move	$s0, $s1	# Consider next node.
	j	printNextNode
printedAll:
# Restore the register values
	
	li $v0, 4
	la $a0, parantesis2
	syscall
	
	move $a2, $s3
	
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra

#=========================================================		
.data
	msg1: .asciiz "enter the size:"
	msg2: .asciiz "enter a number:"
	parantesis1: .asciiz "( "
	parantesis2: .asciiz ")\n"
	space: .asciiz " "
