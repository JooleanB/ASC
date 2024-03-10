bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
a dw 16h
b dw 23h
c dw 121h
d dw 82h
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov ax,[a]
        add ax,[b] ;a+b
        add ax,[b] ;a+b+b in ax
        mov ebx,0
        mov bx,[c] 
        sub bx,[d] ;c-d in bx
        add ax,bx ; (a+b+b)+(c-d) in ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
