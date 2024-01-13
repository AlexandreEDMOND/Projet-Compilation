.data
		a: .word 0

.text
main:
		# On alloue de la memoire pour la pile (longueur = 14)
		addiu	$sp,	$sp,	-64
		sw		$fp,	60($sp)
		move	$fp,	$sp

		li	$t0,	17
		li	$t1,	3
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		li	$t0,	29
		li	$t1,	42
		sub $t0,	$t0,	$t1
		sw	$t0,	4($fp)

		lw	$t0,	0($fp)
		lw	$t1,	4($fp)
		mul $t0,	$t0,	$t1
		sw	$t0,	8($fp)

		lw	$t0,	8($fp)
		li	$t1,	8
		add $t0,	$t0,	$t1
		sw	$t0,	12($fp)

		lw	$t0,	12($fp)
		li	$t1,	14
		sub $t0,	$t0,	$t1
		sw	$t0,	16($fp)

		li	$t0,	36
		li	$t1,	5
		mul $t0,	$t0,	$t1
		sw	$t0,	20($fp)

		lw	$t0,	16($fp)
		lw	$t1,	20($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	24($fp)

		li	$t0,	19
		li	$t1,	11
		add $t0,	$t0,	$t1
		sw	$t0,	28($fp)

		lw	$t0,	24($fp)
		lw	$t1,	28($fp)
		sub $t0,	$t0,	$t1
		sw	$t0,	32($fp)

		lw	$t0,	32($fp)
		li	$t1,	25
		add $t0,	$t0,	$t1
		sw	$t0,	36($fp)

		lw	$t0,	36($fp)
		li	$t1,	7
		sub $t0,	$t0,	$t1
		sw	$t0,	40($fp)

		li	$t0,	33
		li	$t1,	2
		mul $t0,	$t0,	$t1
		sw	$t0,	44($fp)

		lw	$t0,	40($fp)
		lw	$t1,	44($fp)
		add $t0,	$t0,	$t1
		sw	$t0,	48($fp)

		lw	$t0,	48($fp)
		li	$t1,	47
		sub $t0,	$t0,	$t1
		sw	$t0,	52($fp)

		la  $t0,    a
		lw  $t1,    52($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
