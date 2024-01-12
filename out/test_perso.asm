.data
		a: .word 0

.text
main:
		Opération de type * entre 4 et 8
		Stockage dans 1

		Opération de type + entre 2 et 32.000000
		Stockage dans 2

		Opération de type + entre 34.000000 et 9
		Stockage dans 3

		On mets la valeur contenu dans 3 dans a

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
