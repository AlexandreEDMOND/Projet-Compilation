	#
	# Test suite to show some peculiarities of the SPIM assembler
	#
	.text
main:
	li $v0 0
	li $v1 1
loop:
	add $v0 $v0 $v1
	add $v1 $v1 1
	blt $v1 1000 loop
exit:
	move $a0 $v0
	li $v0 1
	syscall
	j $ra # return to main
