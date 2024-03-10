bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format db '%x ',0
    k equ 77h
    a dd 11223344h, 0abcdef12h
    len equ ($-a)/4
    b dd 0
    
; our code starts here
segment code use32 class=code
    start:
    mov esi,a
    mov edi,b
    mov ecx,len
        repeta:
        movsb
        lodsb
        mov al,k
        stosb
        movsb
        movsb
        loop repeta
        mov ecx,len
        mov ebx,0
        repeta2:
        push ecx
        push dword [b+ebx]
        push dword format
        call [printf]
        add esp,8
        add ebx,4
        pop ecx
        loop repeta2
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
