.data
my_stack: .space 1024  # Réservez de l'espace pour la pile

.text
main:
    # Initialisation de la pile
    la $sp, my_stack  # Charge l'adresse de début de la pile dans $sp

    # Empilez 1 et 2
    li $t0, 657
    sw $t0, 0($sp)
    addi $sp, $sp, -4

    li $t1, 343
    sw $t1, 0($sp)
    addi $sp, $sp, -4

    # Dépilez les valeurs de la pile
    lw $t0, 4($sp)
    lw $t1, 8($sp)

    # Effectuez l'opération arithmétique
    sub $t2, $t0, $t1  # Addition : $t2 = 343 + 657

    # Affichez le résultat
    move $a0, $t2
    li $v0, 1
    syscall

    # Fin du programme
    li $v0, 10
    syscall
