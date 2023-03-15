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
unsigned char* asmb(unsigned char *s, unsigned long n);

unsigned char *asmb_controll(unsigned char *s, unsigned long n)
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
    char testdata[n];
    memcpy(testdata, testinput, n);

    char controlldata[n];
    memcpy(controlldata, testinput, n);

    // Call both implementations
    unsigned char* result = asmb(testdata, n);
    unsigned char* expected = asmb_controll(controlldata, n);

    // Compare the results
    if (memcmp(result, expected, n) == 0)
    {
        printf("========================================\n");
        green();
        printf("Test '%s' passed.\n", testname);
        printf("Called with n(%u): ", n);
        printf("ascii: '%s' \n", testinput);
        printf("Produced: ");
        printf("AMSB ascii: '%s' \n", result);
        printf("AMSB_CONTROL ascii: '%s' \n", expected);
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
    printf("ascii: '%s'\n", testinput);
    printf("Your implementation returned:\n ");
    //printAsHex(result, 64);
    printf("\n\tascii: '%s'", result);
    printf("\n");
    blue();
    printf("But should have returned: ");
    //printAsHex(expected, 64);
    printf("\n\tascii: '%s' \n", expected);
    white();
}

int main()
{
  test("Test0: nothing", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 0);
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
  printf("=======================Multiple of 64 n================");
  test("Test10: One word all lowercase double 64=128", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 128);
  test("Test10: One word all lowercase double 64=128", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 1024);
  test("Test11: One word all lowercase double 64=256", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefgh", 256);
  test("Test12: Mixed characters double 64=128", "ABCDEFGH+-+-+-+-}}}}}}}}abcdefghabcdefghabcdefghabcdefghABCDEFGHABCDEFGH+-+-+-+-}}}}}}}}abcdefghabcdefghabcdefghabcdefghABCDEFGH", 128);
  printf("=======================More than 64 but not multiple================\n");
  test("Test13:More than 64 all lowercase numbers", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghxyz", 67);
  test("Test14:More than 64 all lowercase numbers", "abcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghxyz", 67);
  test("Test15:More than 64 all lowercase 443 length prime number", "abcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefg12", 443);
  test("Test16:More than 64 starts with weird char", "{}cdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghabcdefghxyz", 67);
  test("Test17:More than 64 all lowercase 443 length prime number weird chars", "abcdefgabcdefgabcdefgabc{afgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefgabcdefg12", 443);
}