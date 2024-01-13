.data
		a: .word 0

.text
main:
		# On alloue de la memoire pour la pile (longueur = 3)
		addiu	$sp,	$sp,	-20
		sw		$fp,	16($sp)
		move	$fp,	$sp

		li	$t0,	5
		li	$t1,	9
		mul $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		li	$t0,	6
		li	$t1,	8
		mul $t0,	$t0,	$t1
		sw	$t0,	4($fp)

		lw	$t0,	0($fp)
		lw	$t1,	4($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	8($fp)

		la  $t0,    a
		lw  $t1,    8($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
