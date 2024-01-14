.data
		a: .float -6.500000
		g: .float 1856.759820
		c: .float 0.0
		d: .word -86
		e: .word 69
		f: .word 0
		str_const0: .asciiz "\n"
		str_const1: .asciiz "\n"
		str_const2: .asciiz "\n"
		str_const3: .asciiz "\n"
		str_const4: .asciiz "\n"
		str_const5: .asciiz "\n"

.text
main:
		la  $t0,    c
		lwc1  $f0,    a
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans c

		la  $t0,    a
		lwc1  $f0,    g
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		la  $t0,    f
		lw  $t1,    d
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans f

		la  $t0,    d
		lw  $t1,    e
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans d

		# Afficher d'un float
		lwc1 $f0, a   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un float
		lwc1 $f0, g   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const1     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un float
		lwc1 $f0, c   # Charger la valeur du flottant depuis la mémoire
		mov.s $f12, $f0
		li $v0, 2             # Code de service pour afficher un flottant
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

		# Afficher d'un int
		lw $a0, e   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const4     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, f   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const5     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
