all: asma.o

asma.o: asma.s
	as -o $@ $<

test: test.c
	gcc -c -o $@ $<

clean:
	rm -f asma.o test