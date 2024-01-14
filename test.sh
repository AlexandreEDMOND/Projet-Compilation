#!/bin/bash

TEST_FOLDER="test"

PROGRAM="bin/cmat.bin"

title() {
  echo "\033[34m------------------ $1 ------------------\033[0m"
}

run_test() {
  test_folder=$1
  test_number=$2
  input_file="$test_folder/test.in"
  intermediar_file="$test_folder/test_MIPS.asm"
  output_file="$test_folder/test.out"
  expected_output_file="$test_folder/ref.out"

  title "Test $test_number"
  echo "\033[33mDescription: $(cat $test_folder/description.txt) \033[0m"
  # On lance le programme
  $PROGRAM "-o" $intermediar_file < $input_file

  # Le output_file est un fichier test.out où est redirigée la sortie des affichage
  # Pour la génération d'un code MIPS, il faut ensuite le compiler et rediriger sa sortie vers un autre fichier
  # On poura ensuite le comparer  au fichier expected_output_file
  "spim" "-file" $intermediar_file | grep -v "SPIM Version 8.0 of January 8, 2010" | grep -v "Copyright 1990-2010, James R. Larus." | grep -v "All Rights Reserved." | grep -v "See the file README for a full copyright notice." | grep -v "Loaded: /usr/lib/spim/exceptions.s" > $output_file



  if diff -q $output_file $expected_output_file; then
    echo "\033[32mVALIDE\033[0m"
  else
    echo "\033[31mERREUR\033[0m"
    diff $output_file $expected_output_file
  fi
}

compil() {
  title "Suppression des anciens fichiers"
  make clean

  title "Compilation"
  make
}

compil

# Si un numéro de test est fourni en paramètre
if [ $# -eq 1 ]; then
  # Vérifier que le numéro de test est valide
  test_number=$1
  test_folder="$TEST_FOLDER/$test_number"
  if [ -d $test_folder ]; then
    run_test $test_folder $test_number
  else
    echo "Numéro de test invalide. Utilisation : $0 [numéro de test]"
    exit 1
  fi

else
  # Exécuter tous les tests
  for test_folder in $TEST_FOLDER/*; do
    test_number=$(basename $test_folder)
    if [ -d "$test_folder" ]; then
      run_test $test_folder $test_number
    fi
  done
fi