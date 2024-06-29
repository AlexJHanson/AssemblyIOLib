# readLn.s
# Reads characters from the keyboard one at a time and stores up to MAX, flushes remaining chars
# Input:
#   rdi <- (char*): starting address to write characters to
#   esi <- MAX:     maximum number of characters that can be read
        .intel_syntax   noprefix
# Constants
        .equ    STDIN,        0
        .equ    NEW_LINE,     10
# Local Vars
        .equ    destIndx,    -8
        .equ    maxChars,    -12
        .equ    storedChars, -16
        .equ    localSize,   -16
# Code
        .text
        .globl  readLn
        .type   readLn, @function
readLn:
        push    rbp                             # Prologue
        mov     rbp, rsp
        add     rsp, localSize

        mov     destIndx[rbp], rdi              # Store starting address to write characters
        mov     maxChars[rbp], esi              # Store MAX number to read
        mov     DWORD PTR storedChars[rbp], 0   # Initialize total stored to 0
doWhileLoop:
        mov     edx, 1                          # Call sequence for system read
        mov     rsi, destIndx[rbp]              # Read to next spot in provided memory
        mov     edi, STDIN
        mov     eax, 0
        call    read@PLT

        mov     rsi, destIndx[rbp]
        cmp     BYTE PTR [rsi], NEW_LINE        # Check to see if character is new line character ASCII 10 or X0A
        je      end                             # If so, end read loop and NULL terminate input

        mov     eax, storedChars[rbp]           # Is the character the MAX - 1 character to be read?
        add     eax, 1                          # If so, flush the remaining chars in the keyboard buffer
        cmp     eax, maxChars[rbp]                        
        je      doWhileLoop

        inc     DWORD PTR storedChars[rbp]      # If the newline character hasn't been read, and space 
        inc     QWORD PTR destIndx[rbp]         # remains, increment the storedChars value- logically 
        jmp     doWhileLoop                     # saving the read- and move pointer to next position
end:
        mov    rsi, destIndx[rbp]
        mov    BYTE PTR [rsi], 0                # Null terminate string

        mov    eax, storedChars[rbp]            # Return num characters read
        mov    rsp, rbp
        pop    rbp
        ret






