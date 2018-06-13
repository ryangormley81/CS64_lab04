
# Data Area.  Note that while this is typically only
# For global immutable data, for SPIM, this also includes
# mutable data.        
.data
incorrect:
        .asciiz "---TEST FAILED---\n"
before:
        .asciiz "Before:\n"
after:
        .asciiz "After:\n"
comma:
        .asciiz ", "
newline:
        .asciiz "\n"
        
expectedMyArray:
        .word 29 28 27 26 25 24 23 22 21
        
myArray:
        .word 21 22 23 24 25 26 27 28 29

.text

printArray:
        la $t0, myArray

        li $v0, 1
        lw $a0, 0($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall
        
        li $v0, 1
        lw $a0, 4($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 8($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 12($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 16($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 20($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 24($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 28($t0)
        syscall
        li $v0, 4
        la $a0, comma
        syscall

        li $v0, 1
        lw $a0, 32($t0)
        syscall
        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
        
# unsigned int* p1 = expectedMyArray
# unsigned int* p2 = myArray
# unsigned int* limit = expectedMyArray + 9
#
# while (p1 < limit) {
#   if (*p1 != *p2) {
#     return 0                  
#   }
#   p1++                        
#   p2++
# }
# return 1                      
checkArrays:
        # $t0: p1
        # $t1: p2
        # $t2: limit
        
        la $t0, expectedMyArray
        la $t1, myArray
        addiu $t2, $t0, 36

checkArrays_loop:
        slt $t3, $t0, $t2
        beq $t3, $zero, checkArrays_exit

        lw $t4, 0($t0)
        lw $t5, 0($t1)
        bne $t4, $t5, checkArrays_nonequal
        addiu $t0, $t0, 4
        addiu $t1, $t1, 4
        j checkArrays_loop
        
checkArrays_nonequal:
        li $v0, 0
        jr $ra
        
checkArrays_exit:
        li $v0, 1
        jr $ra
        
main:   
        la $a0, before
        li $v0, 4
        syscall

        jal printArray

        jal doSwap

        la $a0, after
        li $v0, 4
        syscall
        
        jal printArray

        jal checkArrays
        beq $v0, $zero, main_failed
        j main_exit
        
main_failed:
        la $a0, incorrect
        li $v0, 4
        syscall
        
main_exit:      
        li $v0, 10
        syscall

        
# COPYFROMHERE - DO NOT REMOVE THIS LINE

doSwap:
        # TODO: translate the following C code into MIPS
        # assembly here.
        # Use only regs $v0-$v1, $t0-$t7, $a0-$a3.
        # You may assume nothing about their starting values.
        #
        #
        # unsigned int x = 0
        # unsigned int y = 8
        #
        # while (x != 4) {
        #   int temp = myArray[x]
        #   myArray[x] = myArray[y]
        #   myArray[y] = temp
        #   x++
        #   y--
        # }	
        # TODO: fill in the code





#set t0 to x and t1 to y and t2 to 4
	li $t0, 0
	li $t1, 8
	li $t2, 4

#loading memory address of myArray to t3
	la $t3, myArray


#creating a loop
loop:
#while statement
	beq $t2, $t0, end
#setting t4=temp=myarray[x]
	sll $t0, $t0, 2
	add $t5, $t3, $t0
	lw $t4, 0($t5)
	sll $t1, $t1, 2
	add $t6, $t1, $t3
	lw $t7, 0($t6)
	sw $t7 0($t5)
	sw $t4 0($t6)

	srl $t1, $t1, 2
	srl $t0, $t0, 2
	addiu $t0, $t0, 1
	addi $t1, $t1, -1
	j loop

end: 
	jr $ra	


#setting $t0=x, $t1=y
   #     addiu, $t0, $zero, 0
  #      addiu, $t1, $zero, 32

 #       li $t2, 16
#	la $t3, myArray
#loop: 
 #       beq $t0, $t2, end

#setting temp($t4)= myArray[x] at $t6
#	addu $t6, $t0, $t3
 #       lw $t4, 0($t6)

#setting myArray[x] to myArray[y] at $t7
#	addu $t7, $t1, $t3
#	lw $t5, 0($t7)
#	sw $t5, 0($t6)

#setting myArray[y] to temp
#	sw $t4, 0($t7)

#x++, y--
#	addiu $t0, $t0, 4
#	addi $t1, $t1, -4

#return to while statement
#	j loop

#end:
        # do not remove this line
#        jr $ra
