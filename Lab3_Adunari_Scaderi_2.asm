bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    a db 5
    b dw -10
    c dd -25
    d dq 123456789Ah
    x resq 1

;EXERCITIUL 1  (c+b+a)-(d+d)
segment code use32 class=code
    start:
        
        
        mov ax,[b]
        cwd ;b=DD
        add eax, dword [c] ;EAX=c+b
        mov ebx,eax ;EBX=c+b
        mov al,[a]
        cbw ;a=DW
        cwd ;a=DD
        add ebx,eax ;EBX=c+b+a
        mov ecx,0 ;ECX:EBX=c+b+a
        mov eax, dword [d]
        mov edx, dword[d+4]
        clc
        add eax, dword [d]
        adc edx, dword[d+4] ; EDX:EAX=d+d
        clc
        sub ebx,eax
        sbb ecx,edx ; ECX:EBX=(c+b+a)-(d+d)
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
