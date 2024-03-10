bits 32

global start        


extern exit, scanf, printf             
import exit msvcrt.dll    
import scanf msvcrt.dll 
import printf msvcrt.dll                         

segment data use32 class=data
a dd 123
b dd 2
format db '%d + %d = %d  ',0
rezultat dd 0
segment code use32 class=code
    start:
        mov eax,[a]
        add eax,dword [b]
        push eax
        push dword [b]
        push dword [a]
        push dword format
        call [printf]
        add esp,16

        push    dword 0      
        call    [exit] 