.data
		a: .float 0.0
		d: .float 1856.759820
		c: .float -86.340000
		str_const0: .asciiz "\n"
		str_const1: .asciiz "\n"
		str_const2: .asciiz "\n"

.text
main:
		la  $t0,    a
		li.s  $f0,    45.26
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans a

		la  $t0,    d
		li.s  $f0,    -84.7
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans d

		la  $t0,    c
		li.s  $f0,    0.0001
		s.s  $f0,    0($t0)

		# On mets la valeur contenu dans (null) dans c

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
		lwc1 $f0, d   # Charger la valeur du flottant depuis la mémoire
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

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
