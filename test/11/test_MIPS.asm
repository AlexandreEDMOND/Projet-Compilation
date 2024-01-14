.data
		a: .word 0
		str_const0: .asciiz "Affichage\n"

.text
main:
		condition1:
		lw $t3, a
		li $t4, 10
		blt $t3, $t4, while_block1   # Si a > 5, aller à while_block
		j end_while1             # Sinon, aller à else_block
		while_block1:
		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		lw    $t0,    a
		li    $t1,	  1
		add   $t0,   $t0,    $t1
		sw $t0, a

		j condition1             # Sinon, aller à else_block
		end_while1:
		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
