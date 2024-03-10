bits 32
;1.	Se dă un șir de 10 numere în baza 16 în fișierul input.txt. 
;Să se determine cifra minimă din fiecare număr.
;Să se afișeze acest șir al cifrelor minime, în baza 10, pe ecran.
global start
extern exit,fopen,fclose,printf,fscanf
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
filepath db 'examen1.txt',0
mod_acces db 'r',0
format_afisare db '%d ',0
format_citire db '%x',0
descriptor dd -1
unde_citesc dd 0
cifra_minima db 10
segment code use32 class=code
    start:
          push dword mod_acces
          push dword filepath
          call [fopen]
          add esp,8
          mov [descriptor],eax
          cmp eax,0
          je final
          mov ecx,10
          repeta:
                
                push ecx
                push dword unde_citesc
                push dword format_citire
                push dword [descriptor]
                call [fscanf]
                add esp,12
                pop ecx
                mov eax,[unde_citesc]
                push eax
                pop ax
                pop dx
                repeta2:
                     mov bx,10
                     div bx ; restul este in dx dar impartind la 10 restul poate sa fie maxim 9 care incape in dl
                     cmp dl, byte [cifra_minima]
                     ja mai_mare
                     mov [cifra_minima],dl
                     mai_mare:
                     mov dx,0
                     cmp ax,0
                     je afara
                     jmp repeta2
                afara:
                push ecx
                push dword [cifra_minima]
                push dword format_afisare
                call [printf]
                add esp,8
                pop ecx
                mov bl,10
                mov [cifra_minima],bl
                
         loop repeta
         push dword [descriptor]
         call [fclose]
         add esp,4
         final:
    push dword 0
    call [exit]