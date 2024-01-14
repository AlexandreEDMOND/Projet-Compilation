.data
		a: .word 0
		d: .word 56
		c: .word -86
		str_const0: .asciiz "\n"
		str_const1: .asciiz "\n"
		str_const2: .asciiz "\n"

.text
main:
		la  $t0,    a
		la  $t1,    74
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		la  $t0,    d
		la  $t1,    -3
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans d

		la  $t0,    c
		la  $t1,    0
		sw  $t1,    0($t0)

		# On mets la valeur contenu dans (null) dans c

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const0     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, d   # Charger la valeur de l'entier depuis la mémoire
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

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
