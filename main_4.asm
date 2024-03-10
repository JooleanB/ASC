bits 32 
global start        

extern exit,printf               
import exit msvcrt.dll   
import printf msvcrt.dll 


segment data use32 class=data
    format_afisare db '%c',0
    format_spatiu db '%c',0
    text1 db 's este',0
    s dq 1110111b,100000000h,0ABCD0002E7FCh,5
    len equ ($-s)/4
    text2 db 'rez este',0
    rez times len dd 0
    numar db 0
    sir_binar times 8*len db 0
segment code use32 class=code
    start:
        mov esi,s
        mov edi,rez
        mov ecx,len
        repeta:
            mov byte [numar],0
            lodsd
            mov edx,eax
            push ecx
            mov ecx,32
            mov bl,0
            repeta2:
                ror eax,1
                jc este1
                mov bl,0
                jmp dupa_1
                este1:
                    adc bl,0
                    cmp bl,3
                    jne inca_nu_e_3
                    add byte [numar],1
                    inca_nu_e_3:
                dupa_1:
                loop repeta2
            mov bl,2
            cmp byte [numar],bl
            jb dupa
            mov eax,edx
            stosd
            dupa:
            pop ecx
            loop repeta
            
        mov esi,rez
        mov edi,sir_binar
        mov ecx,len
        repeta_sir:
            lodsd
            push ecx
            mov ecx,32
            mov ebx,0
            repeta_octet:
                mov bl,0
                ror eax,1
                adc bl,0
                push ebx
            loop repeta_octet
            mov ecx,32
            repeta_stocare:
                pop eax
                add al,'0'
                stosb
            loop repeta_stocare
            pop ecx
        loop repeta_sir
        
        mov ecx,len
        mov esi,sir_binar
        repeta_afisare:
            push ecx
            mov ecx,32
            repeta_3:
                push ecx
                mov eax,0
                lodsb
                push eax
                push dword format_afisare
                call [printf]
                add esp,8
                pop ecx
            loop repeta_3
            push dword ' '
            push dword format_spatiu
            call [printf]
            add esp,8
            pop ecx 
            loop repeta_afisare
            
        
        
        
                
                
            
            
        push    dword 0      
        call    [exit]       
