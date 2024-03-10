bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 255
    b db 2h
    c db 3h
    d db 125
    e dw 5h
    f dw 6h
    g dw 7h
    h dw 8h
    
; our code starts here
segment code use32 class=code
    start:
        mov eax,0
        mov al,[a]
        mov bl,[d]
        mul bl     ;ax=a*d
        add ax,[e] ; ax=a*d+e
        mov bx,ax
        mov eax,0
        mov ax,[h]
        mov ecx,0
        mov cl,[c]
        sub cl,[b] ; cl= c-b
        div cx   ; ax= h/(c-b
        mov al,ah
        mov ah,0
        mov cx,ax 
        add cx,[c]   ; cx= c+h/(c-b)     
        mov ax,bx    
        div cx       ; ax=a*d+e/[c+h/(c-b)]
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
