#!/bin/bash

as -ggdb o asmb.o asmb.s
gcc -Wall asmb.o -o -g3 test testsuite.c
gdb test