bits 32
extern printf              
import printf msvcrt.dll   
segment data use32
format db '%x ',0
format2 db ' ',0
nrcifre db 0
double10 dd 16
word10 dw 16
segment code use32 public code
global permutari
    permutari:
        mov eax,[esp+4]
        mov ecx,0 ; ecx = contor pentru numarul de cifre al numarului
        mov bx,ax
        ror eax,16
        mov dx,ax
        mov ax,bx ; acum numarul pe care il aveam in eax a fost convertit la dx:ax ca sa 
        ;pot sa impart
        repeta:
            div word [word10]
            inc ecx
            cmp ax,0
            je continua
            mov dx,0
            jmp repeta
        continua:
        ; push ecx
        ; push dword format
        ; call [printf]
        
        mov [esp+12],ecx ;la adresa esp+12 acum se afla numarul de cifre
        dec ecx; scad 1 din ecx pt ca vreau sa calculez 10 la puterea (nr de cifre -1)
        mov eax,1 ; in eax calculez acel numar
        repeta2:
            mul dword [double10]
        loop repeta2
        ; push eax
        ; push dword format
        ; call [printf]
        ; add esp,8
        mov [esp+8], eax; esp+8 = 10^ nr de cifre-1
        mov eax,[esp+4] ; eax e din nou numarul trimis ca parametru
        
        ;pop ecx ; ecx = nr de cifre
        ; push ecx
        ; push dword format
        ; call [printf]
        ; add esp,8
        mov ecx,[esp+12]  ;ecx redevine numarul de cifre
        mov [nrcifre],ecx ; in [nrcifre] se afla numarul de cifre
        repeta3:
            ; push dword 4
            ; push dword format
            ; call [printf]
            ; add esp, 8
            push eax
            pop ax
            pop dx ; eax devine dx:ax
            mov ecx,0
            div word [word10]
            mov ebx,0 
            mov bx,dx ;ebx =restul
            mov cx,ax ;ecx = catul
            mov eax,[esp+8] ;eax = 10^ nr de cifre -1
            mul ebx
            add eax,ecx ;eax = numarul permutat
            mov ecx,eax ;ecx = numarul permutat
            push ecx
            push eax
            push dword format
            ;push dword format2
            call [printf]
            add esp,8
            
            dec dword [nrcifre]
            cmp [nrcifre],dword 0
            je final
            pop eax
            jmp repeta3
        final:
        ret 4
        
        
        
        
        ;nasm -fobj nume_modul.asm
        ;alink modul_1.obj modul_2.obj ...  modul_n.obj -oPE -subsys console -entry start
        
        