
bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    format_citire db '%d',0
    n dd 0
    sir_numere times 10 dd 0
    text2 db 'sir octeti',0
    sir_octeti_suma times 10 db 0
    text db 'suma',0
    suma_numar db 0

; our code starts here
segment code use32 class=code
    start:
        push dword n
        push dword format_citire
        call [scanf]
        add esp,8
        mov ebx,sir_numere
        mov ecx,[n]
        repeta:
            push ecx
            
            push dword ebx
            push dword format_citire
            call [scanf]
            add esp,8
            pop ecx
            add ebx,4
        loop repeta
        
        mov ecx,[n]
        mov esi,sir_numere
        mov edi,sir_octeti_suma
        repeta2:
            lodsd
            push eax
            pop ax
            pop dx
            repeta3:
                mov bx,10
                div bX ; dx = restul ax = catul
                cmp ax,0
                je afara
                xchg dx,ax ; dx = catul ax= restul
                mov bl,2
                div bl ; ah = restul restului/2
                cmp ah,0
                jne impar
                mov bl,2
                mul bl
                add [suma_numar],al
                impar:
                xchg dx,ax
                mov dx,0
            jmp repeta3
            afara:
            mov al,[suma_numar]
            stosb
        loop repeta2
        push dword 0      
        call [exit]