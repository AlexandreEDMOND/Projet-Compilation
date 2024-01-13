.data
float1: .float 3.14
float2: .float 2.71
result: .float 0.0  # Espace pour stocker le résultat

.text
.globl main

main:
    # Charger les valeurs en virgule flottante dans les registres FPU
    lwc1 $f0, float1   # Charger float1 dans $f0
    lwc1 $f2, float2   # Charger float2 dans $f2

    # Effectuer l'addition
    add.s $f4, $f0, $f2  # Additionner $f0 et $f2, stocker le résultat dans $f4

    # Stocker le résultat dans la mémoire (facultatif)
    swc1 $f4, result   # Stocker le résultat dans la mémoire à l'adresse result

    mov.s $f12, $f4
    li $v0, 2  # Code de l'appel système pour printf
    syscall


    # Terminer le programme
    li $v0, 10
    syscall
