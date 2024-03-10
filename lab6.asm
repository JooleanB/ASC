bits 32 

global start        


extern exit               
import exit msvcrt.dll    

segment data use32 class=data
 a dd 127F5678h, 0ABCDABCDh
 len equ ($-a)/4
 b times len dd 0
segment code use32 class=code
    start:
        mov esi,a
        mov edi,b
        mov ecx,len
        cmp ecx,0
        je final
        
        cld
        repeta:
        mov dx,0
        mov bx,0
        lodsd
        cmp eax,0
        jnge negativ
        sub esi,4
        lodsb
        mov bl,al
        lodsb
        mov dl,al
        lodsb
        mov ah,0
        add bx,ax
        lodsb
        mov ah,0
        add dx,ax
        mov ax,bx
        stosw
        mov ax,dx
        stosw
        jmp dupa
        negativ:
            sub esi,4
            lodsb
            mov bl,al
            lodsb
            mov dl,al
            lodsb
            mov ah,0FFh
            add al,bl
            mov bx,ax
            lodsb
            mov ah,0FFH
            add al,dl
            mov dx,ax
            mov ax,bx
            stosw
            mov ax,dx
            stosw
        dupa:
        loop repeta
        final:
        push    dword 0      
        call    [exit]       
