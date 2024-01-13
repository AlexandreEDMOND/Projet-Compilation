.data

.text
.globl main

main:

    # On alloue de la memoire pour la pile (longueur = 1)
    addiu	$sp,	$sp,	-12
    sw		$fp,	8($sp)
    move	$fp,	$sp

    li	$t0,	7
    mtc1 $t0, $f0
    cvt.s.w $f0, $f0

    li	$t1,	2
    mtc1 $t1, $f1
    cvt.s.w $f1, $f1
    
    div.s $f0,   $f0,    $f1
    
	s.s	$f0,	0($fp)
	lwc1  $f0,    0($fp)

    mov.s $f12, $f0
    
    li $v0, 2             # Code de service pour afficher un flottant
    syscall

    # Terminer le programme
    li $v0, 10
    syscall
