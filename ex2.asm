bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen,fscanf,fclose,scanf,printf        ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import fscanf msvcrt.dll    
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
;problema: se da un nr si un nume de fisier text de la taastatura
;sa se citeasca din fisierul cu numele citit de la tastatura numere si sa se afiseze doar cele ce au cifra zecilor egala cu cifra citita de la tastatura
    ; ...

    c db 0,0,0,0 
    format db '%d',0
    nume_fisier times 30 db 0
    format_s db '%s',0
    descriptor dd -1
    mesaj db 'Eroare',0
    numar dd 0
    mod_acces db 'r',0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword c
        push dword format
        call [scanf]
        add esp,8
        
        push dword nume_fisier
        push dword format_s
        call [scanf]
        add esp,8
        
       
        
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp,8
        
        
        cmp eax,0
        je final
        
        mov [descriptor],eax
        
        citeste:
        push dword numar
        push dword format
        push dword [descriptor]
        call [fscanf]
        add esp,4*3
  
        cmp eax,1
        jne ies
        
        push dword [numar]
        push dword format
        call [printf]
        add esp,8
        
        ;verif penultima cifra
        
        mov ax,word[numar]
        mov dx,word[numar+2]  ;dx:ax e [numar]
        mov bx,10
        div bx
        ;nr dx:ax /10 avem in ax catul
        mov bx,0
        mov bl,10
        div bl ;in ah e restul
        
        cmp ah ,byte [c]
        jne nu_afis
        
        ;afisare numar
        push dword [numar]
        push dword format
        call [printf]
        add esp, 4*2
        
        nu_afis:
        
        jmp citeste
        ies:
        ;inchid fisier
        push dword [descriptor]
        call [fclose]
        add esp,4
        
        jmp gata
        
        final:
        push dword mesaj
        push dword format_s
        call [printf]
        add esp,8
        
        gata:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
