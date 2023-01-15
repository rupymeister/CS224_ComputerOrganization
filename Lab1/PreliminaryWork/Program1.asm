##
## Program1.asm - prints out "hello world"
##
##	a0 - points to the string
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
	.globl __start 

__start:		# execution starts here
	li $v0,4	# put string address into a0
	la $a0,str	# system call to print
	syscall		#   out a string

	li $v0,10  # system call to exit
	syscall	#    bye bye


#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
str:	.asciiz "0123hello world\n"
n:	.word	10

##
## end of file Program1.asm

