.text
    main:
		li	$t0,	3
		li	$t1,	4
		add	$t2,	$t0,	$t1
		li	$t0,	10
		move $a0, $t0       # Mettre la valeur de c dans $a0
		li $v0, 1  
		syscall
 		li $v0, 10      # syscall pour terminer l'exécution
		syscall
 