.data
		a: .word 0
		str_const0: .asciiz "\n"

.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		li	$t0,	8
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	9
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 8 (type i) (reg0) et 9 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		la  $t0,    a
		lwc1  $f0,    0($fp)
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		# Afficher d'un float
		lwc1 $f0, a   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
