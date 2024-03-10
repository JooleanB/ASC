bits 32 
global start        

extern exit,printf,fread,fopen,fclose               
import exit msvcrt.dll    
import fread msvcrt.dll 
import printf msvcrt.dll 
import fopen msvcrt.dll
import fclose msvcrt.dll 
segment data use32 class=data
filepath db "text1.txt",0
format db '%d',0
mod_acces db "r",0
cate_caractere equ 100
pointer_fisier dd 0
nr_vocale dd 0
vocale db "aeiouAEIOU",0
len_vocale equ $-vocale
buffer resb cate_caractere
nr_caractere_curent db 0

segment code use32 class=code
    start:
        push dword mod_acces
        push dword filepath
        call [fopen]
        add esp,8
        cmp eax,0
        je final
        mov [pointer_fisier],eax
        repeta:
            push dword [pointer_fisier]
            push dword cate_caractere
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            cmp eax,0
            je inchide_fisier
            mov ecx,eax
            repeta2:
                mov bl,[buffer+ecx-1]
                push ecx
                mov ecx,len_vocale
                repeta3:
                    mov al,[vocale+ecx-1]
                    cmp bl,al
                    jne next
                    inc dword [nr_vocale]
                    next:
                    loop repeta3
                pop ecx
                loop repeta2
            jmp repeta
        inchide_fisier:
            push dword [pointer_fisier]
            call [fclose]
            add esp,4
        final:
        push dword [nr_vocale]
        push dword format
        call [printf]
        add esp,8
                
            
        
        push    dword 0      
        call    [exit]       
