bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
a db 10
b db 5
c db 3
d db 8
; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov al,[a]
        add al,13 ;a+13
        sub al,[c] ; a+13-c
        add al,[d] ; a+13-c+d
        sub al,7    ; a+13-c+d-7
        add al,[b]  ; a+13-c+d-7+b
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
