bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Se da un sir S de dublucuvinte.
    ;Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine crescatoare in interpretarea fara semn.
    s DD 12345607h, 1A2B3C15h
    len esqu $-s
    d times len db 0
segment code use32 class=code
    start:
        mov ecx,len
        mov esi,s
        mov edi,d
        cld
        jecxz final
        repeta:
            mov edx,ecx
            mov edi,d
            cld
            sortare:
                cmpsb
                dec esi
                dec edi
                ja mai_mare
                
        
        
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
