bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    
    
; Se da un sir de caractere s.
; Se cere sirul de caractere d obtinut prin copierea sirului s, folosind instructiuni pe siruri.
segment code use32 class=code
start:
    push dword 0
    push dword 12345678h
    mov eax,[esp+4]
    mov ebx, [esp+8]
    mov ecx,[esp]
    mov [esp],dword 0

        
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
