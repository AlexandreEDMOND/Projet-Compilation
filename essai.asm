.data
floatValue: .float 8.596
formatString: .asciiz "%d\n"

.text
.globl main

main:
    # Charger la valeur en virgule flottante dans $f0
    lwc1 $f0, floatValue

    # Convertir le float en int en utilisant la fonction 'cvt.s.w'
    cvt.s.w $f0, $f0

    # Appeler la fonction printf pour afficher le résultat
    la $a0, formatString
    mfc1 $a1, $f0  # Charger la valeur convertie en virgule flottante dans $a1
    li $v0, 1      # Code de l'appel système pour printf
    syscall

    # Terminer le programme
    li $v0, 10
    syscall
