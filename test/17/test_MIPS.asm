.data
		a: .word 5
		c: .word 2
		str_const0: .asciiz "ok IF1"
		str_const1: .asciiz "ok ELSE1"
		str_const2: .asciiz "ok IF2"
		str_const3: .asciiz "ok ELSE2"

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
		lw $t3, c
		li $t4, 2
		beq $t3, $t4, if_block2   # Si a == c, aller à if_block
		j else_block2             # Sinon, aller à else_block
		if_block2:
		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const2     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		j end_if2             # end_if
		else_block2:            #aller à else_block
		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const3     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		end_if2:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
