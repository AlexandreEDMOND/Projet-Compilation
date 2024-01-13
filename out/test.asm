.data
		a: .word 2
		c: .word 2

.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		lw $t3, a
		lw $t4, c
		beq $t3, $t4, if_block   # Si a == c, aller à if_block
		j else_block             # Sinon, aller à else_block
		if_block:
		li	$t0,	5
		li	$t1,	3
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		j end_if             # end_if
		else_block:             #aller à else_block
		li	$t0,	5
		li	$t1,	2
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		# Afficher d'un int
		lw $a0, c   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		end_if:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
