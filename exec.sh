#!/bin/bash

# set -e

# handle_error() {
#     echo "\033[31mUne erreur est survenue lors de l'exécution de $1\033[0m"
#     exit 1
# }

# trap 'handle_error $BASH_COMMAND' ERR

OUT_DIR="./out"


if [ $# -ge 1 -a $# -lt 3 ]; then
  input=$1

  mkdir -p out
  output="$OUT_DIR/out.txt"

  bin/cmat.bin "-o" $OUT_DIR/temp.s < $input
  spim -f $OUT_DIR/temp.s > $output

else
echo "\033[31mSyntaxe attendue : \033[33msh $0 <input-file>\033[0m"
fi