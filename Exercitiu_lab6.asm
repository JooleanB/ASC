bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s db 'abcdef'
    d db '0'
    
; Se da un sir de caractere s.
; Se cere sirul de caractere d obtinut prin copierea sirului s.
segment code use32 class=code
    start:
        mov esi,[s]
        mov [d],esi
        
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program