.data
		a: .word 0
		c: .word 0
		str_const0: .asciiz "\n"

.text
main:
		# On alloue de la memoire pour la pile (longueur = 4)
		addiu	$sp,	$sp,	-24
		sw		$fp,	20($sp)
		move	$fp,	$sp

		li.s    $f0,	1.0
		li.s    $f1,	8.0
		# Opération de type / entre 1.0 (type f) (reg0) et 8.0 (type f) (reg0)
		div.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		li	$t0,	3
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		lwc1	$f1,	0($fp)
		# Opération de type + entre 3 (type i) (reg0) et 0.125000 (type f) (reg1)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		li	$t0,	8
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	9
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type * entre 8 (type i) (reg0) et 9 (type i) (reg0)
		mul.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		lwc1	$f0,	4($fp)
		lwc1	$f1,	8($fp)
		# Opération de type - entre 3.125000 (type f) (reg2) et 72.000000 (type i) (reg3)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	12($fp)

		la  $t0,    a
		lwc1  $f0,  12($fp)
		cvt.w.s $f0, $f0
		mfc1 $t1, $f0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		li.s    $f0,	1.0
		li.s    $f1,	8.0
		# Opération de type / entre 1.0 (type f) (reg0) et 8.0 (type f) (reg0)
		div.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		li	$t0,	3
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		lwc1	$f1,	0($fp)
		# Opération de type + entre 3 (type i) (reg0) et 0.125000 (type f) (reg1)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		li	$t0,	8
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	9
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type * entre 8 (type i) (reg0) et 9 (type i) (reg0)
		mul.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		lwc1	$f0,	4($fp)
		lwc1	$f1,	8($fp)
		# Opération de type - entre 3.125000 (type f) (reg2) et 72.000000 (type i) (reg3)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	12($fp)

		la  $t0,    c
		lwc1  $f0,    12($fp)
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans c

		la  $t0,    a
		la  $t1,    8.0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		la  $t0,    c
		lwc1  $f0,    -4($fp)
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans c

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un float
		lwc1 $f0, c   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
