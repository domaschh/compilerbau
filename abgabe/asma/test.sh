#!/bin/bash

gcc -g -Wall -c -o asma.o asma.s
gcc -g -Wall asma.o -o test testsuite.c
./test