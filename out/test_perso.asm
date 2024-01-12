.data
		a: .word 0

.text
main:
		Opération de type * entre 4 (reg0) et 8 (reg0)
		Stockage de 32.000000 dans 1

		Opération de type + entre 2 (reg0) et 32.000000 (reg1)
		Stockage de 34.000000 dans 2

		Opération de type + entre 34.000000 (reg2) et 9 (reg0)
		Stockage de 43.000000 dans 3

		On mets la valeur contenu dans 3 dans a

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
