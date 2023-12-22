#!/bin/bash

TEST_FOLDER="test"

title() {
  echo -e "\033[34m ------------------ $1 ------------------ \033[0m"
}

run_test() {
  test_folder=$1
  test_number=$2
  input_file="$test_folder/test.in"
  output_file="$test_folder/test.out"
  expected_output_file="$test_folder/ref.out"

  title "Test $test_number"
  ./bin/cmat.bin < $input_file > $test_folder/out.txt

  if diff -q $output_file $expected_output_file; then
    echo "Le test a réussi"
  else
    echo "Le test a échoué. Différences détéctées :"
    diff $output_file $expected_output_file
  fi
  

}

compil() {
  title "Suppression des anciens fichiers"
  make clean

  title "Compilation"
  make
}

# Si un numéro de test est fourni en paramètre
if [ $# -eq 1 ]; then
  # Vérifier que le numéro de test est valide
  test_number=$1
  test_folder="$TEST_FOLDER/$test_number"
  if [ -d $test_folder ]; then
    compil
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
      compil
      run_test $test_folder $test_number
    fi
  done
fi