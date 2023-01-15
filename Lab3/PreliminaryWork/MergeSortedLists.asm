#Anýl Altuncu
#lab03 preliminary work 1

.text
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall 
	
	
	
	move $t0, $v0
	
	beq $t0, $zero, printZero1
	
	
	la	$a0, ($t0) 	
	jal	createLinkedList
	
	move $a1, $v0 #head pointer
	
	move	$a0, $a1	# Pass the linked list address in $a0
	jal 	printLinkedList

con1:
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall 
	
	move $t1, $v0
	
	beq $t1, $zero, printZero2
	la	$a0, ($t1) 	
	jal	createLinkedList
	
	move $a2, $v0 #head pointer
	
	move	$a0, $a2	# Pass the linked list address in $a0
	jal 	printLinkedList
con2:
	beq $t0, $zero, printS
	beq $t1, $zero, printF
	add $t2, $t0, $t1
	beq $t2, $zero, printZero3
	
	
	move $a0, $t0
	move $a3, $t1
	
	
	jal merge
	
	move	$a0, $v0
	
	jal printLinkedList
	
	#stop
	li	$v0, 10
	syscall
printZero1:
	li $v0, 4
	la $a0, parantesis1
	syscall
	
	li $v0, 4
	la $a0, parantesis2
	syscall
	j con1
	
printZero2:
	li $v0, 4
	la $a0, parantesis1
	syscall
	
	li $v0, 4
	la $a0, parantesis2
	syscall
	j con2
	
printZero3:
	li $v0, 4
	la $a0, parantesis1
	syscall
	
	li $v0, 4
	la $a0, parantesis2
	syscall
	li	$v0, 10
	syscall
printF:
	move	$a0, $a1	# Pass the linked list address in $a0
	jal 	printLinkedList
	li	$v0, 10
	syscall
printS:
	move	$a0, $a2	# Pass the linked list address in $a0
	jal 	printLinkedList
	li	$v0, 10
	syscall
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
	
	lw	$ra, 0($sp)
	lw	$s3, 4($sp)
	lw	$s2, 8($sp)
	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	addi	$sp, $sp, 20
	jr	$ra

	
merge:
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
	
	move $s0, $a0 #size of first
	move $s1, $a1 # head of first list
	move $s2, $a2 # head of second list
	move $s3, $a3 # size of second
	
	add $s4, $s0, $s3 # size in total 
	beq $s4, $zero, printNone
	beq $s1, $zero, printSecond
	beq $s2, $zero, printFirst
	
	
compare:
	beq	$s3, $zero, continueFirst
	beq	$s0, $zero, continueSecond

	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	move	$s5, $v0	# $s2 points to the first and last node of the linked list.
	move	$s6, $v0	# $s3 now points to the list head.
	
	
	lw $s4, 4($s1)
	lw $s7, 4($s2)
	bgt	$s4, $s7, addsecond
	bgt	$s7, $s4, addfirst
	beq	$s4, $s7, addone
	addfirst:
	sw	$s4, 4($s5)	# Store the data value.
	lw      $s1, 0($s1)
	addi $s0,$s0, -1
	j addDone
	addsecond:
	sw	$s7, 4($s5)	# Store the data value.
	lw      $s2, 0($s2)
	addi $s3,$s3, -1
	j addDone
	addone:
	sw	$s4, 4($s5)	# Store the data value.
	lw      $s1, 0($s1)
	lw      $s2, 0($s2)
	addi $s0,$s0, -1
	addi $s3,$s3, -1
	j addDone
	addDone:
	
	
compare2:
	beq	$s3, $zero, continueFirst
	beq	$s0, $zero, continueSecond

# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
# OK now we have the list head. Save list head pointer 
	# Connect the this node to the lst node pointed by $s2.
	sw	$v0, 0($s5)
# Now make $s2 pointing to the newly created node.
	move	$s5, $v0	# $s2 now points to the new node.
	 
	lw $s4, 4($s1)
	lw $s7, 4($s2)
	bgt	$s4, $s7, addsecond1
	bgt	$s7, $s4, addfirst1
	beq	$s4, $s7, addone1
	addfirst1:
	sw	$s4, 4($s5)	# Store the data value.
	lw      $s1, 0($s1)
	addi $s0,$s0, -1
	j addDone1
	addsecond1:
	sw	$s7, 4($s5)	# Store the data value.
	lw      $s2, 0($s2)
	addi $s3,$s3, -1
	j addDone1
	addone1:
	sw	$s4, 4($s5)	# Store the data value.
	lw      $s1, 0($s1)
	lw      $s2, 0($s2)
	addi $s0,$s0, -1
	addi $s3,$s3, -1
	j addDone1
	addDone1:
	j compare2
	
continueFirst:
	beq	$s0, $zero, mergeDone
	# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
	sw	$v0, 0($s5)
	move $s5,$v0
	lw $s7, 4($s1)
	sw	$s7, 4($s5)	# Store the data value.
	lw      $s1, 0($s1)
	addi $s0,$s0, -1
	j continueFirst

continueSecond:
	beq	$s3, $zero, mergeDone
	# Create the first node: header.
# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall

	sw	$v0, 0($s5)
	move $s5,$v0
	lw $s7, 4($s2)
	sw	$s7, 4($s5)	# Store the data value.
	lw      $s2, 0($s2)
	addi $s3,$s3, -1
	j continueSecond
	
mergeDone:
# Make sure that the link field of the last node cotains 0.
# The last node is pointed by $s2.
	sw	$zero, 0($s5)
	move	$v0, $s6	# Now $v0 points to the list head ($s6).

	lw	$ra, 0($sp)
	lw	$s7, 4($sp)
	lw	$s6, 8($sp)
	lw	$s5, 12($sp)
	lw	$s4, 16($sp)
	lw	$s3, 20($sp)
	lw	$s2, 24($sp)
	lw	$s1, 28($sp)
	lw	$s0, 32($sp)
	addi	$sp, $sp, 36
	jr	$ra
	
printSecond:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	move $a0,$a2
	jal printLinkedList
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	j mergeDone
	
printFirst:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	move $a0,$a1
	jal printLinkedList
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	j mergeDone


printNone:
	li $v0, 4
	la $a0, msg1
	syscall
	li $v0, 4
	la $a0, msg2
	syscall
	j mergeDone
	

#=========================================================		
.data
	msg1: .asciiz "enter the size:"
	msg2: .asciiz "enter a number:"
	parantesis1: .asciiz "( "
	parantesis2: .asciiz ")\n"
	space: .asciiz " "
