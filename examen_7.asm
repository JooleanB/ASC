bits 32
global start
;2.	Se citește de la tastatură un număr N și apoi N numere.
;Să se calculeze suma numerelor pare introduse, să se calculeze suma numerelor impare introduse,
; apoi diferența dintre cele două sume.
;Să se afișeze în fișierul output.txt cele 3 rezultate, în baza 16, pe linii separate.

extern exit,fopen,fclose,fprintf,scanf,printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
filepath db 'examen_profir.txt', 0
mod_acces db 'w',0 ;programul 
descriptor dd -1
format_citire db '%d',0
format_afisare db '%x ',0
unde_citesc dd 0
suma_pare dd 0
suma_impare dd 0
segment code use32 class=code
    start:
    push dword unde_citesc
    push dword format_citire
    call [scanf]
    add esp,8
    mov ecx,[unde_citesc]
    repeta:
        push ecx
        push dword unde_citesc
        push dword format_citire
        call [scanf]
        add esp,8
        mov eax,[unde_citesc]
        push eax
        pop ax
        pop dx
        mov bx,2
        div bx
        cmp dx,0
        je par
        mov eax,[unde_citesc]
        add [suma_impare],eax
        jmp peste
        par:
        mov eax,[unde_citesc]
        add [suma_pare],eax
        peste:
        pop ecx
    loop repeta
    
    push dword mod_acces
    push dword filepath
    call [fopen]
    add esp,8
    
    cmp eax,0
    je final
    mov [descriptor],eax
    
    mov ebx,[suma_pare]
    sub ebx,[suma_impare]
    
    push dword [suma_pare]
    push dword format_afisare
    push dword [descriptor]
    call [fprintf]
    add esp,12
    
    push dword [suma_impare]
    push dword format_afisare
    push dword [descriptor]
    call [fprintf]
    add esp,12
    
    push ebx
    push dword format_afisare
    push dword [descriptor]
    call [fprintf]
    add esp,12
    
    push dword [descriptor]
    call [fclose]
    add esp,4
    
    final:
    push dword 0
    call [exit]