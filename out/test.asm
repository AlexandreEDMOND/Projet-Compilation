.data
		a: .word 2
		c: .word 3
		f: .word 0
		g: .word 0

──────────────── Liste des quadruplets ────────────────
Nombre d'éléments : 11
Taille de la table : 100

Case n°0:
| OPERATEUR
@
| OPERANDE 1
a
-1
| OPERANDE 2
5
0
| RESULT
prout
0

Case n°1:
| OPERATEUR
g
| OPERANDE 1
lol
0
| OPERANDE 2
lol
0
| RESULT
prout
0

Case n°2:
| OPERATEUR
+
| OPERANDE 1
5
0
| OPERANDE 2
3
0
| RESULT
8.000000
1

Case n°3:
| OPERATEUR
=
| OPERANDE 1
f
0
| OPERANDE 2
8.000000
0
| RESULT
1
0

Case n°4:
| OPERATEUR
p
| OPERANDE 1
f
0
| OPERANDE 2
id
0
| RESULT

0

Case n°5:
| OPERATEUR
$
| OPERANDE 1
lol
0
| OPERANDE 2
lol
0
| RESULT
lol
0

Case n°6:
| OPERATEUR
+
| OPERANDE 1
5
0
| OPERANDE 2
2
0
| RESULT
7.000000
1

Case n°7:
| OPERATEUR
=
| OPERANDE 1
g
0
| OPERANDE 2
7.000000
0
| RESULT
1
0

Case n°8:
| OPERATEUR
p
| OPERANDE 1
g
0
| OPERANDE 2
id
0
| RESULT

0

Case n°9:
| OPERATEUR
T
| OPERANDE 1

0
| OPERANDE 2

0
| RESULT

0

Case n°10:
| OPERATEUR
e
| OPERANDE 1

0
| OPERANDE 2

0
| RESULT

0


.text
main:
		# On alloue de la memoire pour la pile (longueur = 1)
		addiu	$sp,	$sp,	-12
		sw		$fp,	8($sp)
		move	$fp,	$sp

		lw $t3, a
		li $t4, 5
		beq $t3, $t4, if_block   # Si a == c, aller à if_block
		j else_block             # Sinon, aller à else_block
		if_block:
		li	$t0,	5
		li	$t1,	3
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		la  $t0,    f
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, f   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

		j end_if             # end_if
		else_block:             #aller à else_block
		li	$t0,	5
		li	$t1,	2
		add $t0,	$t0,	$t1
		sw	$t0,	0($fp)

		la  $t0,    g
		lw  $t1,    0($fp)
		sw  $t1,    0($t0)

		# Afficher d'un int
		lw $a0, g   # Charger la valeur de l'entier depuis la mémoire
		li $v0, 1             # Code de service pour afficher un entier
		syscall

end_if:
		# Terminer le programme
		li $v0, 10          # Code de service pour la sortie de programme
		syscall
