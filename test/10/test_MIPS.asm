.data
		a: .word 0
		e: .word 0
		c: .word 0
		d: .word 0
		str_const0: .asciiz "\n"
		str_const1: .asciiz "\n"
		str_const2: .asciiz "\n"
		str_const3: .asciiz "\n"

.text
main:
		# On alloue de la memoire pour la pile (longueur = 3)
		addiu	$sp,	$sp,	-20
		sw		$fp,	16($sp)
		move	$fp,	$sp

		li	$t0,	4
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	3
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 4 (type i) (reg0) et 3 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		lwc1	$f0,	0($fp)
		li	$t1,	7
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 7.000000 (type i) (reg1) et 7 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		lwc1	$f0,	4($fp)
		li	$t1,	856
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 14.000000 (type i) (reg2) et 856 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		la  $t0,    a
		lwc1  $f0,  8($fp)
		cvt.w.s $f0, $f0
		mfc1 $t1, $f0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		li	$t0,	3
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	7
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 3 (type i) (reg0) et 7 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		lwc1	$f0,	0($fp)
		li	$t1,	856
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 10.000000 (type i) (reg1) et 856 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		lwc1	$f0,	4($fp)
		li	$t1,	4
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type + entre 866.000000 (type i) (reg2) et 4 (type i) (reg0)
		add.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		la  $t0,    e
		lwc1  $f0,  8($fp)
		cvt.w.s $f0, $f0
		mfc1 $t1, $f0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans e

		li	$t0,	4
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	3
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre 4 (type i) (reg0) et 3 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		lwc1	$f0,	0($fp)
		li	$t1,	7
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre 1.000000 (type i) (reg1) et 7 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		lwc1	$f0,	4($fp)
		li	$t1,	856
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre -6.000000 (type i) (reg2) et 856 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		la  $t0,    c
		lwc1  $f0,  8($fp)
		cvt.w.s $f0, $f0
		mfc1 $t1, $f0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans c

		li	$t0,	3
		mtc1 $t0, $f0
		cvt.s.w $f0, $f0
		li	$t1,	7
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre 3 (type i) (reg0) et 7 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	0($fp)

		lwc1	$f0,	0($fp)
		li	$t1,	856
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre -4.000000 (type i) (reg1) et 856 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	4($fp)

		lwc1	$f0,	4($fp)
		li	$t1,	4
		mtc1 $t1, $f1
		cvt.s.w $f1, $f1
		# Opération de type - entre -860.000000 (type i) (reg2) et 4 (type i) (reg0)
		sub.s $f0,   $f0,    $f1
		s.s	$f0,	8($fp)

		la  $t0,    d
		lwc1  $f0,  8($fp)
		cvt.w.s $f0, $f0
		mfc1 $t1, $f0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans d

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, e   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const1     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, c   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const2     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, d   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const3     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall