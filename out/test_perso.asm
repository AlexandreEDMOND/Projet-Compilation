.data
		a: .word 26
3.000000 / + / 7.000000 /5.000000 / * / 10.000000 /		tempo_var0: .word 50
		str_const1: .asciiz "Hello World\n"
		tempo_var2: .word 5
		str_const3: .asciiz "\n"
		str_const4: .asciiz "\n"
26.000000 / + / 5.000000 /		tempo_var5: .word 31
		str_const6: .asciiz "\n"

.text
main:
		# Afficher d'un int
		lw $a0, tempo_var0   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const1     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, tempo_var2   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const3     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, a   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const4     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Afficher d'un int
		lw $a0, tempo_var5   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		# Afficher le texte
		li $v0, 4           # Code de service pour l'affichage de chaîne
		la $a0, str_const6     # Charger l'adresse de la chaîne à afficher dans $a0
		syscall

		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
