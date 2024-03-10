bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    nr dd 0
    input_text db "%d", 0
    format db "cel mai mic numar: %d", 0
    
segment code use32 class=code
    ;Se citesc de la tastatura numere (in baza 10) pana cand se introduce cifra 0. Determinaţi şi afişaţi cel mai mic număr dintre cele citite.
    start:
        mov EBX, 01111111111111111111111111111111b ; pun cel mai mare numar posibil in interpretarea cu semn in EBX
        repeta:
            push DWORD nr
            push DWORD input_text
            call [scanf]
            add ESP, 4 * 2 ; citesc pe nr
            
            mov EAX, [nr]
            cmp EAX, 0
            jz final ; daca EAX e 0
            
            cmp [nr], EBX ; compar EBX cu nr
            jng mai_mic ; daca nr e mai mic ca maximu
            jg continua ; daca e mai mare n are rost sa l bag in seama
            mai_mic:
                mov EBX, [nr] ; il salvez pe al mai mare in EBX
            
            continua:
                jmp repeta ; daca nr nu i 0 da i mai departe
    
        final:
            push EBX
            push dword format
            call [printf]
    
        push DWORD [0]
        call [exit]