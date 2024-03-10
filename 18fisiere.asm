bits 32 
global start
extern exit,fscanf,printf,fopen,fclose
import exit msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

;Se da un fisier text care contine litere, spatii si puncte. Sa se citeasca continutul fisierului, sa se determine numarul de cuvinte si sa se afiseze pe ecran aceasta valoare. (Se considera cuvant orice secventa de litere separate prin spatiu sau punct)

segment data use32 class=data
    a dd 0
    file_path db 'fis.txt',0
    pointer_fisier dd 0
    cate_caractere equ 100
    nr_caractere_curent db 0
    mod_acces db 'r',0
    format_afisare db '%s',0
    format_citire db '%s',0
    buffer resb 100
    format db '%d',0

segment code use32 class=code
    start:
       cld
       push dword mod_acces
       push dword file_path
       call [fopen]
       add esp,8
       cmp eax,0
       je final
       mov [pointer_fisier],eax
       push dword buffer
       push dword format_citire
       push dword [pointer_fisier]
       call [fscanf]
       add esp,12
       push dword buffer
       push dword format_afisare
       call [printf]
       add esp ,8
                
        
    final:
    push dword 0
    call [exit]