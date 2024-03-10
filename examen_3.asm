bits 32
global start

extern exit,gets,printf
import exit msvcrt.dll
import gets msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
nr_litere dd -1
format db "%s",0
cuvant_invers times 10 dd 0
unde_citesc dd 0
segment code use32 class=code
    start:
        push dword unde_citesc
        call [gets]
        add esp,4
        mov esi,unde_citesc
        mov edi,cuvant_invers
        mov eax,0
        cld
        lacai:
        repeta:
            lodsb
            inc dword [nr_litere]
            cmp al,' '
            je afara
            cmp al,0
            je final
            jmp repeta
        afara:
        afara3:
        push esi
        sub esi,2
        
        repeta2:
            std
            lodsb
            cld
            stosb
            dec dword [nr_litere]
            mov ebx,0
            cmp ebx,[nr_litere]
            je afara2
            jmp repeta2
        afara2:
        ; cmp ecx,0
        ; je final
        pop esi
        sub esi,dword 1
        lodsb
        stosb
        jmp lacai
     final:
     sub esi,1
     repeta3:
            std
            lodsb
            cld
            stosb
            dec dword [nr_litere]
            mov ebx,0
            cmp ebx,[nr_litere]
            je sfarsit
            jmp repeta3
    sfarsit
    push dword cuvant_invers
    ;push dword format
    call [printf]
    add esp,4
    push dword 0
    call [exit]