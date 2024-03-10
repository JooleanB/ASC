bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a-byte; b-doubleword; c-qword
    a db 5h
    b dd 100h
    c dq 0FFFFFFFFh

; EXERCITIUL 1  c+(a*a-b+7)/(2+a)
segment code use32 class=code
    start:
        
        mov al,[a]
        imul byte [a] ; AX=A*A
        cwd ; DX:AX=A*A
        clc
        sub ax,word [b] 
        sbb dx, word [b+2] ;DX:AX=A*A-B
        clc
        add ax,7 
        adc dx,0 ;DX:AX=A*A-B+7
        mov bl,[a]
        add bl,2 ;BL=A+2
        cbw ;BX=A+2
        idiv bx ; AX=(a*a-b+7)/(2+a) si DX=(a*a-b+7)%(2+a)
        cwde ; EAX=(a*a-b+7)/(2+a)
        cdq ;EDX:EAX=(a*a-b+7)/(2+a)
        add eax,dword [c]
        adc edx,dword [c+4] ; EDX:EAX=c+(a*a-b+7)/(2+a)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
