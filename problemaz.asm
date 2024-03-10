bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    n dd 0
    text db 'sir',0
    sir times 10 dd 0
    format_citire db '%d',0
    s resb 10
    zece dd 10
    doi db 2
    variabila dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; citim n
        push dword n
        push dword format_citire
        call [scanf]
        add esp,4*2
        
        mov ecx,dword[n]
        mov edi,sir
        ;citim si punem in sir
        repeta:
        push ecx
        
        push dword edi
        push dword format_citire
        call [scanf]
        add esp,4*2
        add ebx,4
        pop ecx
        add edi,4
        
        loop repeta
        
        cld
        mov esi,sir
        mov edi,s
        mov ecx,[n]  ;pentru fiecare cuv
        
        repeta2:
         lodsd  ;luam fiecare double in eax
         
         mov ebx,0
         
         cifre:
         mov edx,0 ;pt a imparti qword
         div dword[zece];in edx avem restul -cifra  in eax ai cat
         test edx,1b
         jnz sari
         add ebx,edx
         
         sari:
         ;comparam daca mai pot imparti eax
         cmp eax,0
         jz afara
         
         jmp cifre
         afara:
         
         mov eax,ebx
         stosd
        
        loop repeta2
        
        ;afisez sirul s
        mov ecx,[n]
        mov esi,s
        
        repeta3:
        push ecx
        mov eax,0
        lodsb
        push  eax
        push dword format_citire
        call [printf]
        add esp,4*2
        add edi,4
        
        pop ecx
        loop repeta3
        
        
       
       
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program