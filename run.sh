#!/bin/bash

set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <nom_fichier_entrée> <nom_fichier_sortie>"
  exit 1
fi

echo "\033[34m ------------------ Suppression des anciens fichiers ------------------ \033[0m"

make clean

echo "\033[34m ------------------ Compilation ------------------ \033[0m"

make

echo "\033[34m ------------------ Lancement du compilateur ------------------ \033[0m"

mkdir -p out

bin/cmat.bin "-o" out/$2 < $1