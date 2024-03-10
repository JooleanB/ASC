bits 32 
global start        

extern exit,printf,scanf               
import exit msvcrt.dll 
import scanf msvcrt.dll 
import printf msvcrt.dll    
segment data use32 class=data
a dd 0
format10 db '%d',0
format16 db '%x',0

segment code use32 class=code
    start:
    push dword a
    push dword format16
    call [scanf]
    add esp,8
    push dword [a]
    push dword format10
    call [printf]
    add esp,8
    
        
        push    dword 0      
        call    [exit]       
