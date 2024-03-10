bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10h
    b db 8h
    c db 10h
    d dw 32h
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,0
        mov al,[a] ;a
        add al,[b] ;a+b
        mov bl,2
        div bl   ;(a+b)/2 in ch
        mov ch,al
        mov eax,0
        mov bl, 10 
        mov al,[a]
        mov edx,0
        mov dl,[c]
        div dl ;a/c
        sub bl,al   ;10-a/c in bh
        mov bh,bl
        mov eax,0
        mov al,[b]
        mov cl,4
        div cl ;b/4 in al
        add ch,bl ;(a+b)/2+(10-a/c)
        add ch,al ;(a+b)/2+(10-a/c)+b/4
        mov al,ch
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
