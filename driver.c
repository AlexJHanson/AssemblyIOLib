/* driver.c
 * test writeStr and readLn functions
*/

#include <libIO.h>
#include <stdio.h>
#define  MAX 17

int main(void) {

    int num;

    writeStr("\nEnter an integer: ");
    getInt(&num);
    writeStr("\nYou entered: ");
    putInt(num);
    writeStr("\n");

    return 0;
}