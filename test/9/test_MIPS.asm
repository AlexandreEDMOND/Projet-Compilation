.data
		a: .float -6.500000
		e: .float 1856.759820
		c: .word -86
		d: .word 69

.text
main:
		l.s   $f0,    a
		li.s  $f1,	  1.0
add.s   $f0,   $f0,    $f1
		s.s    $f0,    a

		l.s   $f0,    e
		li.s  $f1,	  1.0
sub.s   $f0,   $f0,    $f1
		s.s    $f0,    e

		lw    $t0,    c
		li    $t1,	  1
		sub   $t0,   $t0,    $t1
		sw $t0, c

		lw    $t0,    d
		li    $t1,	  1
		add   $t0,   $t0,    $t1
		sw $t0, d

		# Afficher d'un float
		lwc1 $f0, a   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Afficher d'un float
		lwc1 $f0, e   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
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
