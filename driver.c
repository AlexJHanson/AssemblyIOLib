/* driver.c
 * test writeStr and readLn functions
*/

#include <libIO.h>
#include <stdio.h>
#define  MAX 17

int main(void) {

    char text[MAX];
    int numChars = 0;

    writeStr("Enter some text: ");
    numChars = readLn(text, MAX);
    writeStr("You entered: ");
    writeStr(text);
    printf("\nNumber of chars read: %i\n", numChars);
    numChars = writeStr("How many chars written out?");
    printf("\nNumber of chars written: %i\n", numChars);

    return 0;
}