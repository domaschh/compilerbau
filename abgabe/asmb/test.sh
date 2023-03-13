#!/bin/bash

gcc -g -Wall -c -o asmb.o asmb.s -fPIE
gcc -g -Wall asmb.o -o test testsuite.c -no-pie
./test