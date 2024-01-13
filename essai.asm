.data
		a: .word 2
		c: .word 2
.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		la  $t0,    a
		lw  $t1,    -4($fp)
		sw  $t1,    0($t0)

		li	$t0,	5
		li	$t1,	3
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		li	$t0,	5
		li	$t1,	2
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall

