bits 32 
global start        

extern exit,printf,modul               
import exit msvcrt.dll    
import printf msvcrt.dll
segment data use32 class=data
  s dd 1234A678h,12345678h,1AC3B47Dh,0FEDC9876h
  len equ ($-s)/4
  suma dd 0
  text db 'sir_ranguri',0
  sir_ranguri times len+1 db 0
  format_suma db '%d ',0
  format_ranguri db '%s',0
segment code use32 class=code
    start:
        mov eax,s
        mov ebx,len
        mov ecx,sir_ranguri
        
        push dword ebx
        push dword ecx
        push dword eax
        call modul
        
        push eax
        push dword format_suma
        call [printf]
        add esp,8
        
        push dword sir_ranguri
        push dword format_ranguri
        call [printf]
        add esp,8
        push    dword 0      
        call    [exit]   

 ;nasm -fobj examen3_main.asm
        ;nasm -fobj examen3_modul.asm
        ;alink examen3_main.obj examen3_modul.obj -oPE -subsys console -entry start        
