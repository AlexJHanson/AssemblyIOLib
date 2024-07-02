# getInt.s
# Reads a signed int from the keyboard and stores in int*
# Input:
#       rdi <- (int *) location to store signed int
# Returns 0
        .intel_syntax   noprefix
# Constants
        .equ    MAX,        12      # 10 digits, potential sign, NULL terminator
# Local variables
        .equ    inputArr,  -12
        .equ    intAdr,    -20
        .equ    localSize, -32
# Code
        .text
        .globl  getInt
        .type   getInt, @function
getInt:
        push    rbp                 # Prologue
        mov     rbp, rsp
        add     rsp, localSize

        mov     intAdr[rbp], rdi    # Store (int*)

        mov     esi, MAX            # readLn call sequence
        lea     rdi, inputArr[rbp]  
        mov     eax, 0
        call    readLn 

        mov     rsi, intAdr[rbp]    # Load int address
        lea     rdi, inputArr[rbp] 
        mov     eax, 0
        call    decToSInt 

        mov     eax, 0
        mov     rsp, rbp
        pop     rbp
        ret

        
