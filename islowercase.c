#include <stdio.h>

int is_lowercase(char y){
    unsigned char x = y-'a';
    return x <= (unsigned)('z'-'a');
}

int main() {
    printf("%i", is_lowercase('a'));
    printf("%i", is_lowercase('b'));
    printf("%i", is_lowercase('c'));
    printf("%i", is_lowercase('d'));
    printf("%i", is_lowercase('{'));

    //subtract "a" (97)
    return 0;
}