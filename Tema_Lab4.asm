bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;Se dau cuvantul A si octetul B. Sa se obtina dublucuvatul C
    A dw 8A9Fh;1010101010101010b ;8A9F
    B db 9Ah;10001111b ;9A
    C dd 0 ;E62A40FF

; our code starts here
segment code use32 class=code
    start:
        ;Se dau cuvantul A si octetul B. Sa se obtina dublucuvatul C:
        ;bitii 0-3 ai lui C au valoarea 1
        ;bitii 4-7 ai lui C coincid cu bitii 0-3 ai lui A
        ;bitii 8-13 ai lui C au valoarea 0
        ;bitii 14-23 ai lui C coincid cu bitii 4-13 ai lui A
        ;bitii 24-29 ai lui C coincid cu bitii 2-7 ai lui B
        ;bitii 30-31 au valoarea 1
        
        mov eax,0  ;  eax => REZULTATUL
        or  eax, 000000000000000000000000000001111b ;bitii 0-3 ai lui C au valoarea 1 ax=0000 0000 0000 1111b
        mov bx,[A]
        mov cx,0
        push cx
        push bx
        pop ebx ; EBX=A DOUBLE WORD
        and ebx, 00000000000000000000000000001111b ;izolam bitii 0-3 ai lui A  bx=0000 0000 0000 1010b
        mov cl,4
        rol bx,cl ; rotim bitii la stanga cu 4 pozitii bx=0000 0000 1010 0000b
        or eax,ebx ;  ax=0000 0000 1010 1111b bitii 4-7 ai lui C coincid cu bitii 0-3 ai lui A
        and eax, 11111111111111111100000011111111b ; ax=0000 0000 1010 1111b bitii 8-13 ai lui C au valoarea 0
        mov bx,[A]
        mov cx,0
        push cx
        push bx
        pop ebx ; EBX=A DOUBLE WORD
        and ebx, 00000000000000000011111111110000b ;izolam bitii 4-13 ai lui A
        mov cl,10
        rol ebx,cl ;rotim bitii la stanga cu 10 pozitii 
        or eax,ebx ; eax=0000 0000 1010 1010 1000 0000 1010 1111b  bitii 14-23 ai lui C coincid cu bitii 4-13 ai lui A
        mov bl,[B]
        mov bh,0 ;bx=B word
        mov cx,0
        push cx
        push bx
        pop ebx ;ebx=B doubleword
        and ebx,00000000000000000000000011111100b ;izolam bitii 2-7 ai lui B
        mov cl,22
        rol ebx,cl ; rotim bitii la stanga cu 22 de pozitii
        or eax,ebx; eax=0010 0011 1010 1010 1000 0000 1010 1111b
        or eax,11000000000000000000000000000000b ; eax=1110 0011 1010 1010 1000 0000 1010 1111b
        mov [C],eax ; C=1110 0011 1010 1010 1000 0000 1010 1111b = 3819602095(10)-unsigned
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
