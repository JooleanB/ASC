bits 32

global start        

;Se da un numar a reprezentat pe 32 biti fara semn. Se cere sa se afiseze reprezentarea in baza 16 a lui a, precum si rezultatul permutarilor circulare ale cifrelor sale.

extern exit, printf, permutari             
import exit msvcrt.dll    
import printf msvcrt.dll                          

segment data use32 class=data
a dd 123
format db '%x ',0
format2 db ' ',0
segment code use32 class=code
    start:
        ; push dword [a]
        ; push dword format
        ; ;push dword format2
        ; call [printf]
        ; add esp, 8
        push dword [a]
        call permutari
        push    dword 0      
        call    [exit]      

        ;nasm -fobj tema_lab_11.asm
        ;nasm -fobj permutari.asm
        ;alink tema_lab_11.obj permutari.obj -oPE -subsys console -entry start
