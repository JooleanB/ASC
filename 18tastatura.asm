bits 32 
global start        
; Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
; a = 32 = 0010 0000b
; b = 1Ah = 0001 1010b
; 32 + 1Ah = 0011 1010b
; Se va afisa pe ecran valoarea 4.
extern exit,scanf,printf               
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll    
segment data use32 class=data
    a dd 0
    b dd 0
    format10 db '%d',0
    format16 db '%x',0
segment code use32 class=code
    start:
        push dword a
        push dword format10
        call [scanf]
        add esp,8
        push dword b
        push dword format16
        call [scanf]
        add esp,8
        mov eax,dword [a]
       
        add eax,dword [b]
        mov ebx,0
        mov ecx,32
        repeta:
            ror eax,1       
            inc ebx
        dupa:
        loop repeta
        push ebx
        push dword format10
        call [printf]
        add esp,8
        push    dword 0      
        call    [exit]       
