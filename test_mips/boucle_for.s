    .text
main:
    # Initialisation de la variable de compteur
    li $t0, 0        # $t0 est notre compteur (initialisé à 0)

loop:
    # Condition de sortie de la boucle (comparer $t0 à 10)
    bge $t0, 20, end_loop
    nop

    # Afficher la valeur du compteur (dans $t0)
    li $v0, 1         # Code de service pour l'affichage d'un entier
    move $a0, $t0     # Charger la valeur du compteur dans $a0
    syscall

    li $v0,4 # appel système pour afficher un retour à la ligne
    la $a0,str1 # chargement de l’adresse de la chaîne
    syscall # affichage

    # Incrémenter le compteur
    addi $t0, $t0, 1

    # Sauter au début de la boucle
    j loop
    nop

end_loop:
    # Terminer le programme
    li $v0, 10
    syscall

.data
str1: .asciiz "\n"