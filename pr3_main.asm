bits 32

global start

extern exit, printf, modul
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    sir dd 1234A678h, 12345678h, 1AC3B47Dh, 0FEDC9876h 
    len equ ($ - sir) / 4
    sir_rezultat resb len+1
    mod_afisare_suma db '%d',0
    mod_afisare_sir db '%s',10,13,0
    muie dd 0

segment code use32 class=code
    start:
        ;apelez modulul
        push dword len
        push dword sir
        push dword sir_rezultat
        call modul
        
        ;afisez pe ecran
        push dword sir_rezultat
        push dword mod_afisare_sir
        call [printf]
        add esp, 4 * 2
        
        ;afisez suma pe ecran
        movsx ebx,bl
        push ebx
        push dword mod_afisare_suma
        call [printf]
        add esp, 8
        
        push dword 0
        call [exit]