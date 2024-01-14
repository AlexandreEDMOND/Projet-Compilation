.data
		a: .float 0.0
		d: .float 0.0
		c: .float 0.0

.text
main:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
