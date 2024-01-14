.data
		a: .word 5
		str_const0: .asciiz "ok IF"
		str_const1: .asciiz "ok ELSE"
		v: .word 1

.text
main:
		lw $t3, a
		li $t4, 6
		beq $t3, $t4, if_block1   # Si a == c, aller à if_block
		j else_block1             # Sinon, aller à else_block
		if_block1:
		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		j end_if1             # end_if
		else_block1:            #aller à else_block
		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const1     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		end_if1:
		# Afficher d'un int
		lw $a0, v   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
