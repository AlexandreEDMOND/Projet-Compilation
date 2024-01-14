.data

.text
main:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
