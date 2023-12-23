#!/bin/bash

set -e

handle_error() {
    echo "\033[31mUne erreur est survenue lors de l'exécution de $1\033[0m"
    exit 1
}

trap 'handle_error $BASH_COMMAND' ERR

echo "\033[34m ------------------ Suppression des anciens fichiers ------------------ \033[0m"

make clean

echo "\033[34m ------------------ Compilation ------------------ \033[0m"

make

echo "\033[34m ------------------ Lancement du compilateur ------------------ \033[0m"

bin/cmat.bin