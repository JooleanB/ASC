bits 32
extern _printf              
;import printf msvcrt.dll   
segment data use32
format db '%d ',0
format2 db ' ',0
nrcifre db 0
double10 dd 10
word10 dw 10
segment code use32 public code
global _permutari
    _permutari:
        push ebp
        mov ebp,esp
        ;mov ebx,[ebp+8] ;ebx = numarul primit
        mov ecx,[ebp+12] ;ecx = numarul de cifre
        ; calculez 16^ nr de cifre -1
        dec ecx
        mov eax,dword 1
        mov ebx,16
        repeta:
            mul ebx
        loop repeta
        ;eax = 16^ nr de cifre -1
        mov ebx,eax; ebx = 16^ nr de cifre -1
        mov eax,[ebp+8]
        mov edx,0
        mov ecx,16
        div ecx
        mov ecx,eax
        mov eax,edx
        mul ebx
        add eax,ecx; eax = nr permutat
        mov esp,ebp
        pop ebp
        ret 
        
        ;nasm -fobj nume_modul.asm
        ;alink modul_1.obj modul_2.obj ...  modul_n.obj -oPE -subsys console -entry start
        