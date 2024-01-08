.data
message: .asciiz "Hello, World!\n"  # Texte à afficher

.text
.globl main

main:
    # Afficher le texte
    li $v0, 4           # Code de service pour l'affichage de chaîne
    la $a0, message     # Charger l'adresse de la chaîne à afficher dans $a0
    syscall

    # Terminer le programme
    li $v0, 10          # Code de service pour la sortie de programme
    syscall
