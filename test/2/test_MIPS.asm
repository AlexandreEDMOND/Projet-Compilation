.data
		a: .word 0
		d: .word 0
		c: .word 0

.text
main:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
