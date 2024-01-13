.data
		a: .word 0
		c: .word 85
		str_const0: .asciiz "\nOk incroyable\n"

.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		li.s    $f0,	1.0
		li.s    $f1,	8.0
		div.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		la  $t0,    a
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		# Afficher d'un float
		lwc1 $f0, a   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Afficher d'un int
		lw $a0, c   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
