bits 32
global start
extern exit,fopen,fclose,fscanf,printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
filepath db 'examen_6.txt',0
mod_acces db 'r',0
unde_citesc dd 0
nr_impare dd 0
nr_pare dd 0
format db '%d',0
format_afisare db '%d ',0
descriptor dd -1
N times 10 dd 0
P times 10 dd 0


segment code use32 class=code
    start:
         push dword mod_acces
         push dword filepath
         call [fopen]
         add esp,8
         cmp eax,0
         je final
         mov [descriptor],eax
         repeta:
               push dword unde_citesc
               push dword format
               push dword [descriptor]
               call [fscanf]
               add esp,12
               mov eax,[unde_citesc]
               cmp eax,dword 0
               je afara

               test eax,01b
               je par

               mov edi,N
               add edi,dword [nr_impare]
               stosd
               add [nr_impare],dword 4
               jmp dupa_par
               par:

               mov edi,P
               add edi,dword [nr_pare]
               add [nr_pare],dword 4
               stosd
               dupa_par:
            jmp repeta
            afara:
            push dword [P]
            push dword format_afisare
            call [printf]
            add esp,8
            push dword [N]
            push dword format_afisare
            call [printf]
            add esp,8

            push dword [descriptor]
            call [fclose]
            add esp,4
   final:
   push dword 0
   call [exit]
