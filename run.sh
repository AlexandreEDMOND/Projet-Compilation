#!/bin/bash

set -e


echo "\033[34m ------------------ Suppression des anciens fichiers ------------------ \033[0m"

make clean

echo "\033[34m ------------------ Compilation ------------------ \033[0m"

make

echo "\033[34m ------------------ Lancement du compilateur ------------------ \033[0m"

bin/cmat.bin