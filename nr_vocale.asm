bits 32
global start

extern exit,scanf,printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
;se citeste de la tastatura un cuvant sa se contorizeeze numarul de vocale si sa se afiseze pe ecran
segment data use32 class=data
format_citire db '%s',0
format_afisare db '%d',0
nr_vocale db 0
unde_citesc resd 100
vocale db 'aeiouAEIOU',0
len equ $-vocale
mesaj db 'Numarul de vocale este',0

segment code use32 class=code
    start:
    repeta:
            push dword  unde_citesc
            push dword format_citire
            call [scanf]
            add esp,8
            mov bl,48
            cmp [unde_citesc],bl
            je afara
            mov edx,0
            repeta1:
                mov esi,unde_citesc
                add esi,edx
                lodsb
                inc edx
                mov bl,al
                mov ecx,len
                mov esi,vocale
                repeta2:
                    lodsb
                    cmp al,bl
                    jne consoana
                    inc dword [nr_vocale]
                    consoana:
                    loop repeta2
            jmp repeta1
                
                    
            
            
            jmp repeta
            
    afara       
    push dword 0
    call [exit]