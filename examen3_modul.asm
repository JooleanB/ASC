bits 32 
        
global modul
extern exit               
import exit msvcrt.dll    
segment code use32 public code
    modul:
       mov esi,[esp+4] ; adresa lui s
       mov edi,[esp+8] ; adresa sirului de ranguri
       mov ecx,[esp+12]; valoare lui len
       mov dl,0
       repeta:
            mov ebx,4
            lodsb
            mov ah,al
            lodsb
            cmp ah,al
            ja dupa
            dec ebx
            xchg al,ah
            dupa:
            lodsb
            cmp ah,al
            ja dupa1
            dec ebx
            xchg al,ah
            dupa1:
            lodsb
            cmp ah,al
            ja dupa2
            dec ebx
            xchg al,ah
            dupa2:
            xchg al,ah
            add dl,al
            mov al,'0'
            add al,bl
            stosb
        loop repeta
        movsx edx,dl
        mov eax,edx
        ret 8
            
       
