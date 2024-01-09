.data
	a: .word	 3
	b: .word	 4
	c: .word	 a
		li	$t1,	4
		li	$t2,	0
		add	$t3,	$t1,	$t2
		li	$v0,	t3
			 syscall
 