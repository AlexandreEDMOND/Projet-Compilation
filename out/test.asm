.data
		a: .word 2
		c: .word 3
		f: .word 0
		g: .word 0

.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		lw $t3, a
		li $t4, 5
		beq $t3, $t4, if_block   # Si a == c, aller à if_block
		j else_block             # Sinon, aller à else_block
		if_block:
		li	$t0,	5
		li	$t1,	3
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		la  $t0,    f
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, f   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		j end_if             # end_if
		else_block:             #aller à else_block
		li	$t0,	5
		li	$t1,	2
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		la  $t0,    g
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, g   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

end_if:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
