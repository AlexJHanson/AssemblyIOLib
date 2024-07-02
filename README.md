# I/O Library written in assembly language 
<span style="font-size:20px; font-weight: bold;">x86_64 &nbsp;&nbsp; Architecture &nbsp;&nbsp;Linux Ubuntu </span>

## Interface &nbsp;&nbsp;<libIO.h>

__int readLn(char* str, int max)__

Reads chars from STDIN one at a time up to the MAX - 1 and stores them starting at the memory address passed. NULL terminates the string. Creates C-Style string.

Returns the number of char code-points read not including the final NULL terminator.

*__NOTE:__* *Caller is responsible for allocating enough memory for storage!*

__int writeStr(char* str)__

Writes chars to STDOUT one at a time. Assumes a NULL terminated C-Style input string.

Returns the number of chars written out.

*__NOTE:__* *Caller is responsible for passing NULL terminated string!*

## Using the library

provided as libIOLibrary.so

gcc link command *__-lIOLibrary__* 

## DEPENDENCIES
dependends on libNumUtils.so | @ https://github.com/AlexJHanson/NumUtils