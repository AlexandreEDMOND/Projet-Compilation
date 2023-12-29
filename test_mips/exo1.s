  .text
main:
  li $v0,1 # appel système pour afficher un entier
  li $a0,5 # chargement de l’entier à afficher
  syscall # affichage

  li $v0,4 # appel système pour afficher un retour à la ligne
  la $a0,str1 # chargement de l’adresse de la chaîne
  syscall # affichage

  li $v0,2 # appel système pour afficher un réel
  l.s $f12,temp0 # chargement du réel à afficher
  syscall # affichage
  
  li $v0,4 # appel système pour afficher un retour à la ligne
  la $a0,str1 # chargement de l’adresse de la chaîne
  syscall # affichage

  li $v0,10 # on sort du programme proprement
  syscall
  .data
temp0: .float 4.560000
temp1: .float 8.600000
temp2: .float 0.250000
str1: .asciiz "\n"
str2: .asciiz " "
