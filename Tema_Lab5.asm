bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;S: 1, 6, 3, 1
    ;D: 0, 2, 3
    s db 1, 6, 3, 1
    l equ $-s-1
    d times l db 0

; our code starts here
segment code use32 class=code
    start:
        ;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte catul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S.
        mov ecx,l
        mov esi,0 ;cu esi parcurg sirul s si construiesc sirul d
        mov edi,1 ; cu edi parcurg sirul d
        jecxz sfarsit
        Repeta:
              mov al,[s+esi]
              mov ah,0 ;s+esi devine word
              mov bl,[s+edi] ; mutam urmatorul element din s in bl
              div bl  ; impartim la bl => ah=ax%bl si al=ax/bl
              mov [d+esi],al ; mutam catul in d+esi
              inc esi
              inc edi
        loop Repeta
        sfarsit:                
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
