bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf             
import exit msvcrt.dll    
import scanf msvcrt.dll                           
import printf msvcrt.dll
segment data use32 class=data
    a dd 0
    b dd 0
    format_citire db '%d', 0
    format_afisare_cat db 'Catul este: %x, ',0
    format_afisare_rest db 'restul este: %x',0
segment code use32 class=code
    start:
        push dword a ; adresa unde stochez valoare citita
        push dword format_citire
        call [scanf]
        add esp, 4*2
        push dword b ; adresa unde stochez valoare citita
        push dword format_citire
        call [scanf]
        add esp, 4*2  
        mov eax,[a]
        add eax,[b];  eax= [a]+[b]
        mov bx,ax ; bx=partea low din eax
        ror eax,16 ;ax=fosta partea high din eax
        mov dx,ax ;dx= ax adica dx devine partea high din eax
        mov ax,bx; punem inapoi in ax partea low din eax
        mov bx,2 ; mutam 2 in bx pentru a puteam imparti dx:ax la bx
        div bx ;dx:ax=(a+b)/2 , dx=(a+b)%2, ax=(a+b)/2
        cwde ; eax devine catul mediei aritmetice
        push eax
        push dword format_afisare_cat
        call [printf]
        add esp,4*2
        mov ax,dx
        cwde
        push eax
        push dword format_afisare_rest
        call [printf]
        add esp, 4*2
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
