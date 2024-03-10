bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fread, fopen, fclose              
import exit msvcrt.dll 
import printf msvcrt.dll 
import fread msvcrt.dll    
import fopen msvcrt.dll    
import fclose msvcrt.dll    
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    format_citire db '%c',0
    filepath db 'numere.txt',0
    mod_acces db 'r',0
    fisier dd -1

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword filepath
        call [fopen] 
        add ESP, 4 * 2 ; refac striva
        
        cmp eax,0
        je final
        
        mov [fisier],eax
        repeta:
            push dword fisier ; de unde citesc
            push dword 4 ;cat as vrea sa citesc 
            push dword 1 ;cati octeti are un caracter
            push dword a ; unde imi stochez ce citesc
            call [fread]   ; EAX=CATE CARACTERE AM CITIT
            add esp,16
            ; push eax
            ; push dword format_citire
            ; call [printf]
            ; add esp,8
            ; add ESP, 4 * 4 ; curat stiva
            cmp eax,0
            je inchide_fisier
            push dword [a]
            push dword format_citire
            call [printf]
            add esp,8
            jmp repeta
        inchide_fisier:
            push dword [fisier] ;pun pe stiva adresa fisierului aflata in valoarea variabilei "fisier"
            call [fclose] ; inchid fisierul
            add ESP, 4
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
