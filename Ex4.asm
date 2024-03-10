bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s dd 11234456h, 22345567h, 33456678h
    len equ ($-s)/4
    d times len dd 0

; Se da un sir de dublucuvinte s.
; Se cere sirul d ale carui elemente sunt cuvinte obtinute in interpretarea cu semn, astfel:
; - octetul inferior din d[i] este suma octetilor inferiori ai cuvintelor din fiecare dublucuvant al sirului s
; - octetul superior din d[i] este suma octetilor superiori ai cuvintelor din fiecare dublucuvant al sirului s
segment code use32 class=code
    start:
        mov ecx, len
        jecxz final
        mov esi, s
        mov edi, d
        cld
    repeta:
        lodsw
        mov bx, ax ;bx= partea low
        lodsw ; ax= partea high ax:bx
        add al, bl
        add ah, bh
        stosw
    loop repeta 
        
    final:
        ; exit(0)
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
