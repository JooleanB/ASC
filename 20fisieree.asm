bits 32
global start
extern exit,fprintf,fopen,fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
;Se dau un nume de fisier si un text (definite in segmentul de date). 
;Textul contine litere mici si spatii. Sa se inlocuiasca toate literele de pe pozitii pare cu numarul pozitiei.
; Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
segment data use32 class=data

filepath db '20fis.txt',0
format_afisare db '%s',0
mod_acces db 'w',0
descriptor dd -1
text db 'muie ana',0
len equ $-text
text_nou times len db 0

segment code use32 class=code

    start:
        cld
        mov ecx,len
        ;dec ecx
        cmp ecx,0
        je final
        mov bl,0
        mov esi,text
        mov edi,text_nou
        repeta:
            lodsb
            cmp al,' '
            jne dupa
            
            ;al = spatiu
            stosb
            inc bl
            dec ecx
            lodsb
            ;al nu e spatiu
            
            dupa:
            MOV DL,BL
            mov dh,al
            mov bh,0
            mov ax,bx
            mov bl,2
            div bl
            cmp ah,0
            je par
            
            
            ;bl impar
            mov al,dh
            mov bl,dl
            stosb
            inc bl
            jmp dupa_par
            
            ;bl par
            par:
            mov bl,dl
            mov al,bl
            add al,48
            stosb
            inc bl
            
            dupa_par:
         loop repeta   
         
    push dword mod_acces
    push dword filepath
    call [fopen]
    add esp,8
    
    cmp eax,0
    je final
    
    mov [descriptor],eax
    push dword text_nou
    push dword format_afisare
    push dword [descriptor]
    
    call [fprintf]
    add esp,12
    
    push dword [descriptor]
    call [fclose]
    add esp,4
        
    final:
    push dword 0
    call [exit]
