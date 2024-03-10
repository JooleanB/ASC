bits 32 
segment code use32 public code
global modul
modul:
    mov eax,[esp+4] ;[a]
    mov ebx,[esp+8] ;[max]
    cmp eax,ebx
    jl mai_mic ;daca eax e mai mic decat ebx
    jmp peste
    mai_mic:
    mov eax,ebx
    peste:
    ret 8
    
    
        
