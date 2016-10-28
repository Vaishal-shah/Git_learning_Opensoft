#####################################################################
#   MIPS Program for finding the nth fibonacci word				    #
#   Group Number : 13                                               #
#   Name: Pranay Dhote (14CS10036), Satyesh Mundra (14CS10058)      #
#                                                                   #
#####################################################################


.data									#data for printing
	
prompt :  .asciiz	"Enter an integer m (no less than 2): "	 

blankspace: .asciiz  " "
new_line: .asciiz "\n"
saty: .asciiz "saty\n"
S: .asciiz "S["
close: .asciiz "] : "
basecase0: .asciiz "S[0] : 0"
basecase1: .asciiz "S[1] : 01"
one: .byte '1'
zero: .byte '0'

.text
.globl main

main:

	move $fp, $sp							# sets frame_pointer to stack_pointer
	move $gp, $0

	la $a0, prompt							# | 
	li $v0, 4								# | => for printing the string "Enter an integer m (no less than 2):"
	syscall									# |

	li $v0, 5								# | => for taking the input as an integer
	syscall									# |

	move $s0, $v0							# s0 contains the value of m

	la $a0, basecase0							# | 
	li $v0, 4								# | => for printing the string basecase0
	syscall
		la $a0, new_line							# | 
	li $v0, 4								# | => for printing the new line
	syscall
	la $a0, basecase1							# | 
	li $v0, 4								# | => for printing the string basecase1
	syscall
	la $a0, new_line							# | 
	li $v0, 4								# | => for printing the new line
	syscall
	subu $sp, $sp, 4						#space for return address

	subu $sp, $sp, 4
	sw $s0, 0($sp)
	subu $sp, $sp, 4	
	li $t1, 1								#value of f(0) = 1
	move $s2, $sp
	sw $t1, 0($s2) 							#s2 = f(m-2)

	subu $sp, $sp, 4
	move $s1, $sp 						#value of f(1) = 2
	li $t1, 2							#s1 = f(m-1)
	sw $t1, 0($s1) 


	subu $sp, $sp, 1
	move $a3, $sp
	lb $t0, zero
	sb $t0, 0($sp)					#first element of the stack = 0

	subu $sp, $sp, 1
	lb $t0, one						#second element of the stack = 1
	sb $t0, 0($sp)

	move $a0, $s0					#parameters
	move $a1, $s1					#parameters
	move $a2, $s2					#parameters
	

	jal fibWord						#function call

	li $v0, 10
	syscall									#exit


fibWord:
	
	bne $gp, $0, savereturn
	sw $ra, -4($fp)							#saving previous return value
savereturn:
	addu $gp, $gp, 1	
	li $t0, 2

	ble $a0, $t0, compute					#continue calling the lower functions till m = 2
	subu $a0, $a0, 1						#m--

	jal fibWord								#calling fib(m-1)

compute:

	subu $t2, $sp, 1						#pointer to start writing
	lw $t6, 0($a2)							#number of new elements to be written
	sub $sp, $sp, $t6						#creating space for new elements

	move $t3, $a3
	move $t4, $t6

	subu $gp, $gp, 1

loop:

	beq  $t4, $0, exitloop 					#continue writing the new value till iterator becomes zero
	lb $t5, 0($t3)							#|
	sb $t5, 0($t2)							#| copying data
	subu $t3, $t3, 1
	subu $t2, $t2, 1
	subu $t4, $t4, 1						#decreasing iterator
	j loop

exitloop:

	lw $t7, 0($a1)
	add $t1, $t7, $t6						#f(m) = f(m-1) + f(m-2)
	sw $t7, 0($a2)
	sw $t1, 0($a1)

	

	la $a0, S							# | 
	li $v0, 4								# | => for printing the new line
	syscall
	
	lw $t8, -8($fp)
	subu $a0, $t8, $gp
	li $v0, 1
	syscall

	la $a0, close							# | 
	li $v0, 4								# | => for printing the new line
	syscall


	lw $t8, 0($a1)					#iterator
	move $t9, $a3
printloop:
	
	beq $0, $t8, exitprintloop		#continue till iterator becomes zero

	li $v0, 11
	lb $a0, 0($t9)
	syscall							#printing each byte

	subu $t9, $t9, 1
	subu $t8, $t8, 1				#decreasing iterator
	j printloop

exitprintloop:

	la $a0, new_line							# | 
	li $v0, 4								# | => for printing the new line
	syscall

	beq $gp, $0, finalreturn
	jr $ra									#return to the recursive call

finalreturn:
	lw $ra, -4($fp)							#return to the original call
	jr $ra
