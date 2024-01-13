.data
a: .word 2       # Déclaration de la variable a avec la valeur initiale 2
c: .word 3       # Déclaration de la variable c avec la valeur initiale 3

.text
.globl main

main:
    # Charger les valeurs de a et c
    lw $t0, a     # Charger la valeur de a dans le registre $t0
    lw $t1, c     # Charger la valeur de c dans le registre $t1

    # Comparer a et c
    beq $t0, $t1, if_block   # Si a == c, aller à if_block
    j else_block             # Sinon, aller à else_block

if_block:
    li $t2, 8                # d = 5 + 3
    li $v0, 1                # Code d'appel système pour afficher un entier
    move $a0, $t2            # Déplacer la valeur de d dans $a0
    syscall                  # Effectuer l'appel système pour afficher
    j end_if                 # Aller à la fin du bloc if

else_block:
    li $t2, 7                # d = 5 + 2
    li $v0, 1                # Code d'appel système pour afficher un entier
    move $a0, $t2            # Déplacer la valeur de d dans $a0
    syscall                  # Effectuer l'appel système pour afficher

end_if:
    # Fin du programme
    li $v0, 10               # Mettre 10 dans $v0 pour terminer l'exécution
    syscall                  # Appel système pour terminer l'exécution
