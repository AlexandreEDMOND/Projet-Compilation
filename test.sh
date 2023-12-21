#!/bin/bash

TEST_FOLDER="test"


input_file=echo "test$1/in.txt"

echo "Test $1"
echo input_file

make clean
make

bin/cmat.bin -o echo "test$1/out.txt" << echo "test$1/in.txt"
