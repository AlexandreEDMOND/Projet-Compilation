.data
		a: .word 0

.text
main:
		# On alloue de la memoire pour la pile (longueur = 3)
		addiu	$sp,	$sp,	-20
		sw		$fp,	16($sp)
		move	$fp,	$sp

		li	$t0,	4
		li	$t1,	8
		mul $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		li	$t0,	2
		lw	$t1,	0($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	4($fp)

		lw	$t0,	4($fp)
		li	$t1,	9
		add $t0,	$t0,	$t1
		sw	$t0,	8($fp)

		On mets la valeur contenu dans 3 dans a

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
