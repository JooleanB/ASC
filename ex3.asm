bits 32jecxz final
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s1 dw 1234h, 67abh, 89cdh
    l1 equ $-s1
    s2 dw 2345h, 5678h, 4567h
    l2 equ $-s2
    d times l1 db 0

; Se dau doua siruri de cuvinte s1 si s2.
; Se cere sirul de cuvinte d obtinut in interpretarea cu semn, astfel:
; - d[i] = s1[i], daca s1[i] > s2[i]
; - d[i] = s2[i], altfel.
segment code use32 class=code
    start:
        mov ecx l1
        cld
        mov esi,s1
        mov edi,d
        jecxz final
        rep movsw ;d=s1
        mov esi, s2
        mov edi, d
        mov ecx,l1
        cld
        jecxz final
    repeta:
        cmpsw
        jle mai_mic_sau_egal:
        sub esi,2
        sub edi,2
        movsw
        mai_mic_sau_egal:
    loop repeta
    final:
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program