bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,fprintf,fread,fopen,fclose,printf              
import exit msvcrt.dll    
import scanf msvcrt.dll
 import printf msvcrt.dll 
  import fprintf msvcrt.dll
   import fclose msvcrt.dll
    import fopen msvcrt.dll
     import fread msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mesaj_citire_fisier db "Numele fisierului citit este: ", 0
    format_citire_fisier db "%s", 0
    fisier times 10 dd 0
    mesaj_citire_caracter db "Caracterul ales este: ", 0
    format_citire_caracter db "%s",0
    caracter dd 0
    mesaj_citire_numar db "Numarul ales este: ",0
    format_citire_numar db "%d", 0
    numar dd 0
    mod_acces db 'r',0
    mod_acces2 db 'w',0
    descriptor dd -1
    descriptor2 dd -1
    unde_citesc dd 0
    numar_aparitii dd 0
    fisier2 db 'output.txt',0
    text1 db 'numarul de aparitii este egal',0
    text2 db 'numarul de aparitii nu este egal',0
; our code starts here
segment code use32 class=code
    start:
        push dword mesaj_citire_fisier
        push dword format_citire_fisier
        call [printf]
        add esp,8
        
        push dword fisier
        push dword format_citire_fisier
        call [scanf]
        add esp,8
        
        push dword mesaj_citire_caracter
        push dword format_citire_fisier
        call [printf]
        add esp,8
        
        push dword caracter
        push dword format_citire_caracter
        call [scanf]
        add esp,8
        
        push dword mesaj_citire_numar
        push dword format_citire_fisier
        call [printf]
        add esp,8
        
        push dword numar
        push dword format_citire_numar
        call [scanf]
        add esp,8
        
        push dword mod_acces
        push dword fisier
        call [fopen]
       add esp,8 
       
        cmp eax,0
        je final
        
         mov [descriptor],eax
        
        repeta: 
            push dword [descriptor]
            push dword 1
            push dword 1
            push dword unde_citesc
            call [fread]
            add esp,16
        
            cmp eax,1
            jne afara
            
            mov ebx,[unde_citesc]
            cmp ebx,dword [caracter]
            jne dupa
            inc dword [numar_aparitii]
            dupa:
            jmp repeta
        afara:
        
        push dword [descriptor]
        call [fclose]
        add esp,4
        
        
        push dword mod_acces2
        push dword fisier2
        call [fopen]
        add esp,8
        
        cmp eax,0
        je final
        
        mov [descriptor2],eax
        
        mov eax,[numar_aparitii]
        cmp eax,[numar]
        je afisare_text1
        
        push dword text2
        push dword format_citire_fisier
        push dword [descriptor2]
        call [fprintf]
        add esp,12
        
        jmp dupa1
        
        afisare_text1:
         push dword text1
        push dword format_citire_fisier
        push dword [descriptor2]
        call [fprintf]
        add esp,12
         
         dupa1:
        
        push dword [descriptor2]
        call [fclose]
        add esp,4
        
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
