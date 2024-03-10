bits 32
;Să se scrie un program în limbaj de asamblare care:

;citește de la tastatură un număr natural N (0 < N < 10) și numele unui fișier text;
;citește toate numerele întregi din fișierul dat;
;afișează pe ecran doar numerele întregi PARE și care au cifra zecilor egală cu N.
;Fișierul text trebuie să existe și va conține doar numere întregi separate prin spații.


; Exemplu:

; Dacă fișierul text conține:

; 1121 -27 150 -1122 26 -121 1123 25 -122 1134 -24 123 -1125 23 124 -1126 32 125

; pentru N = 2, se va afișa pe ecran:

; -1122 26 -122 -24 124 -1126

global start      

extern exit,scanf,fopen,fclose,printf,fscanf                
import exit msvcrt.dll
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import scanf msvcrt.dll 
import printf msvcrt.dll
import fscanf msvcrt.dll   
segment data use32 class=data
filepath times 100 db 0
n dd 0
format_citire_n db '%d',0
format_afisare db '%d ',0
format_citire_nume_fisier db '%s',0
mod_acces db 'r',0
descriptor dd -1
numar_din_fisier dd 0
mesaj_citire_n db 'Introduceti valoarea lui N ',0
mesaj_citire_nume_fisier db 'Introduceti numele fisierului ',0

segment code use32 class=code
    start:
        push dword mesaj_citire_n
        call [printf]
        add esp,4
       
        push dword n
        push dword format_citire_n
        call [scanf]
        add esp,8
        
        push dword mesaj_citire_nume_fisier
        call [printf]
        add esp,4
        
        push dword filepath
        push dword format_citire_nume_fisier
        call [scanf]
        add esp,8
        
        push dword mod_acces
        push dword filepath
        call [fopen]
        add esp,8
        
        cmp eax,0
        je final
        mov [descriptor],eax 
        
        repeta:
            push dword numar_din_fisier
            push dword format_citire_n
            push dword [descriptor]
            call [fscanf]
            add esp,12
            
            cmp eax,1
            jne afara
                
            mov cl,1
            mov eax,[numar_din_fisier]
            cmp eax,0
            jg pozitiv
            not eax
            add eax,1
            mov [numar_din_fisier],eax
            mov cl,0
            pozitiv:
            test eax,01b
            jne impar
            
            ;daca numarul e par
            
            push eax
            pop ax
            pop dx
            mov bx,10
            idiv bx
            mov bl,10
            idiv bl
            cmp ah, [n]
            jne dupa_afisare
            cmp cl,0
            je numar_negativ
            push dword [numar_din_fisier]
            push dword format_afisare
            call [printf]
            add esp,8
            jmp dupa_negativ
            numar_negativ:
            mov eax,[numar_din_fisier]
            sub eax,1
            not eax
            push eax
            push dword format_afisare
            call [printf]
            add esp,8
            dupa_negativ
           dupa_afisare: 
           impar:
           jmp repeta
        afara:
        push dword [descriptor]
        call [fclose]
        add esp,4
        final:
        push    dword 0      
        call    [exit]       
