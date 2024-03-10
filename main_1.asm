bits 32
global start        

extern exit,printf,suma_hex               
import exit msvcrt.dll   
import printf msvcrt.dll                       
segment data use32 class=data
    ; ...
    format db '%d ',0
    endl db "" ,13,10,0
    sir dd -1,123456,0xabcdeff,0xabcdeff,0xcbcdeff,0xdbcdeff,0111010101b
    len equ ($-sir)/4
    sir0 dd 0
    suma_sir times len dd 0
    suma_sir_cresc times len dd 0
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi,sir
        mov edi,suma_sir
        
        again:
        lodsd ;eax=esi[0]
        cmp eax,0
        je prelucrare
        push esi
        push eax
        call suma_hex
        stosb ;
        pop esi
        
        jmp again
        prelucrare:
        mov esi,suma_sir
        
        foru:
        lodsb
        cmp eax,0
        je final
        
        
        
        
        push dword eax
        push dword format
        
        
        call [printf]
        add esp,4*2
        
        jmp foru
        
        
        
        final:
        push dword endl
        call [printf]
        add esp,4
        
        mov esi,suma_sir
        mov ebx,0
        mov al,[esi+ebx]
        cmp al,[esi+ebx+1]
        inc ebx
        
        ja sarl
        dec ebx
        again1:
            mov al,byte[esi+ebx]
            cmp ebx,len-1
            je finalus
            
            cmp al,byte[esi+ebx+1]
            jae top
            
            mov ah,0
            cwde
            
            
            push dword eax
            push dword format
            call [printf]
            add esp,4*2
            
            
            inc ebx
        jmp again1
        top:
            mov ah,0
            cwde
            
            
            push dword eax
            push dword format
            call [printf]
            add esp,4*2
            
            push dword endl
            call [printf]
            add esp,4
        
        sare:
            inc ebx
            
            push dword endl
            call [printf]
            add esp,4
        
        sarl:
        
        jmp again1
        
        
        
        
        finalus:
        push    dword 0      
        call    [exit]   

;nasm -fobj main.asm
        ;nasm -fobj test1.asm
        ;alink main.obj test1.obj -oPE -subsys console -entry start        