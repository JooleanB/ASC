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
    a db 10h
    e dw 188h
    f dw 3A3h
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov al,[a]
        mov bl,[a]
        mul bl   ;a*a in bl
        mov bx,0
        mov cx,0
        mov bx,[e] 
        mov cx,[f]
        add bx,cx ; e+f in bx
        sub ax,bx   ;a*a-(e+f) in ax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
