bits 32 
global start        
;Se citeste de la tastatura un sir de numere in baza 10, cu semn. Sa se determine valoarea maxima din sir si sa se afiseze in fisierul max.txt (fisierul va fi creat) valoarea maxima, in baza 16.

extern exit,scanf,fprintf,fopen,fclose,printf,modul             
import exit msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data

max dd 0FFFFFFFFh
pointer_fisier dd -1
a dd 0
filepath db 'max.txt',0
mod_acces db 'w',0
format_citire db '%d',0
format_afisare db '%x',0 
segment code use32 class=code
    start:
        repeta:
            push dword a
            push dword format_citire
            call [scanf]
            add esp,8
            mov ebx,[a]
            cmp ebx,0
            je afara
            push dword [a]
            push dword [max]
            call modul
            mov [max],eax
            dupa:
        jmp repeta
        afara:
        
        push dword mod_acces
        push dword filepath
        call [fopen]
        add esp,8
        
        cmp eax,0
        je final
        cld
        
        mov [pointer_fisier],eax
        push dword [max]
        push dword format_afisare
        push dword [pointer_fisier]
        
        call [fprintf]
        add esp,12
        
        push dword [pointer_fisier]
        call [fclose]
        add esp,4
        
        final:
        push    dword 0      
        call    [exit]       
