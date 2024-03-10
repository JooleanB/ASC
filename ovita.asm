bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
     a dd 123456h, 11223344h, 0abcdefh
     len equ ($-a)/4
     b times len dw 0
     numar_de_1 dd 0
     format_afisare db '%x',0
     
     
segment code use32 class=code
    start:
        mov ecx,len
        jecxz final
        mov esi,a
        mov edi,b
        repeta: 
            lodsb
            lodsb
            mov bl,al ; bl = higher byte of lower word
            lodsb
            lodsb
            mov bh,al ; bh = higher byte of higher word
            mov ax,bx
            stosw
        loop repeta
        mov esi,b
        mov ecx,len
        repeta2:
            lodsw
            clc
            push ecx
            mov ecx,16
            repeta3:
                rol ax,1
                adc dword [numar_de_1],0
            loop repeta3
            pop ecx
        loop repeta2
        
        push dword [numar_de_1]
        push dword format_afisare
        call [printf]
        add esp,8
        
                
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
