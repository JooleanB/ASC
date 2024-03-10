bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 127F5678h, 0ABCDABCDh 
    len equ ($-s)/4
    d times len dd 0

; our code starts here
segment code use32 class=code

;Se da un sir de dublucuvinte continand date impachetate (4 octeti scrisi ca un singur dublucuvant). Sa se obtina un nou sir de dublucuvinte, in care fiecare dublucuvant se va obtine dupa regula: suma octetilor de ordin impar va forma cuvantul de ordin impar, iar suma octetilor de ordin par va forma cuvantul de ordin par. Octetii se considera numere cu semn, astfel ca extensiile pe cuvant se vor realiza corespunzator aritmeticii cu semn.
    start:
        mov ecx,len ; ecx= lungimea lui s in dd
        jecxz final
        mov esi,s
        mov edi,d
        cld
    repeta:
        lodsd    ;eax primeste valoare dublucuvintelor din s unul cate unul
        cmp eax,0 ; COMPARA EAX CU 0
        jg pozitiv ; DACA EAX ESTE MAI MARE DECAT 0 ATUNCI SE FACE SALT LA ETICHETA pozitiv
        sub esi,4  ; Scadem din esi 4 pentru a reveni la inceputul dublucuvantului verificat
        lodsb       ; al=octetul low din cuvantul low din dublucuvant din s
        mov bl,al
        lodsb       ;al=octetul high din cuvantul low din dublucuvant din s
        mov dl,al   
        lodsb       ;al=octetul low din cuvantul high din dublucuvantul din s
        add al,bl
        mov ah,0FFh ; ax=suma octetilor de indice par, extins la cuvant cu semnul dublucuvantului din s
        mov bx,ax
        lodsb
        add al,dl
        mov ah,0FFh ;ax=suma octetilor de indice impar, extins la cuvant cu semnul dublucuvantului din s
        mov dx,ax   
        mov ax,bx
        stosw       ;mutam in d suma octetilor de indice par, extins la cuvant cu semnul dublucuvantului din s
        mov ax,dx
        stosw       ;mutam in d suma octetilor de indice impar, extins la cuvant cu semnul dublucuvantului din s
        jmp peste   ;salt pentru a nu se efectua si codul pentru numere pozitive
    pozitiv:
        sub esi,4
        lodsb
        mov bl,al
        lodsb
        mov dl,al
        lodsb
        add al,bl
        mov ah,0
        mov bx,ax
        lodsb
        add al,dl
        mov ah,0
        mov dx,ax
        mov ax,bx
        stosw
        mov ax,dx
        stosw
    peste:
    loop repeta
    final:   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
