# writeStr.s
# Writes a C-Style string to standard out 1 character at a time.
# Input:
#   rdi <- (char *) C-Style string
# Returns:
#   number of chars written to output file
        .intel_syntax   noprefix
# Constants
        .equ    STDOUT,        1
        .equ    NULL,          0
# Local vars:
        .equ    charIndex, -8
        .equ    count,     -12
        .equ    localSize, -16
# Code
        .text
        .globl  writeStr
        .type   writeStr, @function
writeStr:
        push    rbp                     # Prologue
        mov     rbp, rsp                # Save caller's frame pointer, establish new frame
        add     rsp, localSize          # Allocate space for local vars

        mov     charIndex[rbp], rdi     # Save starting adress
        mov     DWORD PTR count[rbp], 0 # Initialize count
whileLoop:
        mov     rsi, charIndex[rbp]     # Store address in (2nd arg to write)
        cmp     BYTE PTR [rsi], NULL    # while condition: Not Null
        je      end

        mov     edx, 1                  # Write 1 byte (3rd arg to write)
        mov     edi, STDOUT             # Write to standard out (1st arg to write)
        mov     eax, 0
        call    write@PLT

        inc     DWORD PTR count[rbp]     # count++
        inc     QWORD PTR charIndex[rbp] # (char *)++
        jmp     whileLoop
end:                                     # Epilogue:
        mov     eax, count[rbp]          # Return count
        mov     rsp, rbp                 # Move stack pointer to beginning of frame
        pop     rbp                      # Restore caller's frame pointer
        ret                              # Return to caller

