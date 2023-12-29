	.data
str1:	.asciiz "Entrez un entier :"
str2:	.asciiz "Son factoriel est "

	.text

main:	li $v0, 4        # system call code for print_str
        la $a0, str1     # address of string to print
        syscall          # print the string
	
	li $v0, 5	 # system call code for read_int
	syscall		 # read int, result in $v0

	li  $3, 1	 # initialisation du resultat 
loop:	blt $v0 1 sortie # on utilise $v0 comme variable de boucle, si <=0, on sort
	mul $3 $v0 $3
	sub $v0 $v0 1
	b loop           # sinon, $3=$3*$v0, $v0=$v0-1
	
sortie:	li $v0, 4        # system call code for print_str
        la $a0, str2     # address of string to print
        syscall          # print the string

	li $v0 1         # system call code for print_int
	move $a0 $3      # integer to print
	syscall          # print the integer

	li $v0 10        # on sort proprement du programme
	syscall          #