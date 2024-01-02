#!/bin/bash

set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <nom_fichier_entrée>"
  exit 1
fi

echo "\033[34m ------------------ Suppression des anciens fichiers ------------------ \033[0m"

make clean

echo "\033[34m ------------------ Compilation ------------------ \033[0m"

make

echo "\033[34m ------------------ Lancement du compilateur ------------------ \033[0m"

bin/cmat.bin -tos < $1