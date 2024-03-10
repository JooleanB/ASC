bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a - byte, b - word, c - double word, d - qword - Interpretare fara semn
    
    c dd 0FFFFFFh
    a db 5h
    d dq 0FFFFh
    b dw 25h
    

;EXERCITIUL 1  c-(a+d)+(b+d)
segment code use32 class=code
    start:
       
       mov al,[a]
       mov ah,0; ax=0000 0005 
       mov dx,0
       push dx
       push ax
       pop eax ;EAX=a=DD
       mov edx,0 ;EDX:EAX = a=DQ
       add eax, dword [d]
       adc edx, dword [d+4] ; EDX:EAX=(a+d)
       mov ebx, [c]
       mov ecx,0 ; ECX:EBX=c
       sub ebx,eax
       sbb ecx,edx ;ECX:EBX=c-(a+d)
       mov ax,[b]
       mov dx,0
       push dx
       push ax
       pop eax ;b=DD
       mov edx,0 ;b=DQ
       clc
       add eax, dword [d]
       adc edx, dword [d+4] ;EDX:EAX=(b+d)
       clc
       add ebx,eax
       adc ecx,edx ;ECX:EBX=c-(a+d)+(b+d)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
