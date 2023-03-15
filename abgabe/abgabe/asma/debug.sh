#!/bin/bash

as -ggdb o asma.o asma.s
gcc -Wall asma.o -o -g3 test testsuite.c
gdb test