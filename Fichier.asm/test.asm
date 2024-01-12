.data
	a: .word	 7
.text
    main:
		li $v0, 10      # syscall pour terminer l'exécution
		syscall
 