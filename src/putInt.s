# putInt.s
# Displays a 32-bit signed integer to the screen
# Input
#       edi <- int to display
# Returns 0
        .intel_syntax   noprefix
# Constants
        .section    .rodata
        .align 8
test:
        .string "Testing one two three!"
# Local Variables 
        .equ    intStr,    -12
        .equ    localSize, -16
# Code
        .text
        .globl  putInt
        .type   putInt, @function
putInt:
        push    rbp                 # Prologue
        mov     rbp, rsp
        add     rsp, localSize

        mov     esi, edi            # Move int to second arg register for intToSDec call
        lea     rdi, intStr[rbp]    # Load address of local array for str representation of int

        call    intToSDec           # Convert int to str

        lea     rdi, intStr[rbp]

        call    writeStr            # Write int str to STDOUT. First arg is correct reg

        mov     eax, 0              # Epilogue 
        mov     rsp, rbp
        pop     rbp 
        ret 
