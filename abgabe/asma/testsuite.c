/**
 * A simple testsuite for the first assignment.
 *
 * If you added additional tests please consider pushing them upstream:
 * https://github.com/flofriday/UEB-Testsuite
 */

#include <stdio.h>
#include <string.h>


void red () {
  printf("\033[1;31m");
}
void green () {
  printf("\033[0;32m");
}
void white () {
  printf("\033[0;37m");
}

void blue () {
  printf("\033[0;34m");
}


void reset () {
  printf("\033[0m");
}

/**
 * This is a forward declaration.
 * The body of this function will be your assembly code.
 * But since this test file calls your code it needs this declaration.
 */
unsigned char* asma(unsigned char *s, unsigned long n);

unsigned char *asma_controll(unsigned char *s, unsigned long n)
{
  unsigned long i;
  for (i=0; i<n; i++) {
    unsigned char c=s[i];
    c += (c>='a' && c<='z') ? 'A'-'a': 0;
    s[i] = c;
  }
  return s;
}

/**
 * A simple helper that will print a chararray as hex values.
 * This is helpful wenn printf fails because the string is null-terminated.
 */
void printAsHex(char text[], int n)
{
    for (int i = 0; i < n; i++)
    {
        if (i != 0)
        {
            printf(" ");
        }

        printf("%02x", text[i]);
    }
}

/**
 * Here is where the magic is happening.
 *
 * @brief This test takes the char array in testdata and passes it to your
 * implementation and the reference implementation and detects if there are
 * any differences. If the the test fails it will print a detailed explaination
 * on why it failed.
 *
 * @details The caller has to make sure testdata is at least 16byte long.
 * Otherwise the functions will access memory outside the buffer.
 *
 * @param testname Every test has a name so that it is easier to figure out
 * exactly which test failed.
 *
 * @param testinput A at least 16byte string with which the implementations will
 * be tested.
 */
void test(char *testname, char *testinput, unsigned long n)
{
    // Create mutable copies of the testinput string
    char testdata[64];
    memcpy(testdata, testinput, 64);

    char controlldata[64];
    memcpy(controlldata, testinput, 64);

    // Call both implementations
    unsigned char* result = asma(testdata, n);
    unsigned char* expected= asma_controll(controlldata, n);

    // Compare the results
    if (memcmp(result, expected, n) == 0)
    {
        printf("========================================\n");
        green();
        printf("Test '%s' passed.\n", testname);
        printf("Called with n(%u): ", n);
        printf("ascii: '%.64s' \n", testinput);
        printf("Produced: ");
        printf("ascii: '%.64s' \n", expected);
        white();
        return;
    }

    // Oh no.
    // The test failed.
    // The best thing we can do now is to tell them what it did and what it
    // should do
    printf("========================================\n");
    red();
    printf("Test '%s' failed!\n", testname);

    printf("Called with n(%u): ", n);
    printf("ascii: '%.64s'\n", testinput);
    printf("Your implementation returned:\n\thex: ");
    //printAsHex(result, 64);
    printf("\n\tascii: '%.64s'", result);
    printf("\n");
    blue();
    printf("But should have returned: ");
    printf("\n\thex: ");
    //printAsHex(expected, 64);
    printf("\n\tascii: '%.64s' \n", expected);
    white();
}

int main()
{
    test("Test1: One word all lowercase 64 long", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 64);
    test("Test2: One word special character 64 long", "{bcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 64);
    test("Test3: One word uppercase 64 long", "Abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 64);
    test("Test3B: One word special and upper and lower mixed 64", "ABCDEFGH+-+-+-+-}}}}}}}}abcdefghabcdefghabcdefghabcdefghABCDEFGH", 64);
    printf("=============Not 64 long tests ==========================");
    test("Test4: One word upper and lower mixed", "HallO", 5);
    test("Test5: One word all lowercase", "hallo", 5);
    test("Test6: One word only special chars", "{}!-=", 5);
    test("Test7: One word all uppercase", "HALLO", 5);
    printf("=======================More lowercase than n================");
    test("Test8: More lowercase than n", "abcdef", 3);
    test("Test9: More lowercase than n ", "aBcdef", 3);
}