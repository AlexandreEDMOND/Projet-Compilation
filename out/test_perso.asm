.data
		a: .word 0
		c: .word 0
		d: .word 0

.text
main:
		# On alloue de la memoire pour la pile (longueur = 4)
		addiu	$sp,	$sp,	-24
		sw		$fp,	20($sp)
		move	$fp,	$sp

		li	$t0,	6
		li	$t1,	8
		mul $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		lw	$t0,	0($fp)
		li	$t1,	6
		sub $t0,	$t0,	$t1
		sw	$t0,	4($fp)

		li	$t0,	8
		li	$t1,	9
		div $t0,	$t0,	$t1
		sw	$t0,	8($fp)

		lw	$t0,	4($fp)
		lw	$t1,	8($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	12($fp)

		la  $t0,    a
		lw  $t1,    12($fp)
		sw  $t1,    0($t0)

		li	$t0,	7.0
		li	$t1,	2
		div $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		la  $t0,    c
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		lw	$t0,	c
		li	$t1,	9
		mul $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		lw	$t0,	a
		lw	$t1,	0($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	4($fp)

		lw	$t0,	4($fp)
		li	$t1,	6
		add $t0,	$t0,	$t1
		sw	$t0,	8($fp)

		la  $t0,    d
		lw  $t1,    8($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher d'un int
		lw $a0, c   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher d'un int
		lw $a0, d   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
