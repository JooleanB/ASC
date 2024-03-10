bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dq 1122334455667788h,99AABBCCDDEEFF11h,0FF00000000000055h,0FFFEFFFFFFFFEFFFh,450000AB000000ABh,111137335555577h
    len equ $-s
    n dd 0 ; numarul citit
    ok dd 0 ; pt sortare
    lungime dd 0 ;cati octeti pun in sir_nou si in sir_nr_1
    numar dd 0 ;contor
    format_cit db '%d',0
    format_af db '%x ', 0
    sir_nou times len db 0
    sir_nr_1 times len db 0
segment code use32 class=code
    start:
        push dword n
        push dword format_cit
        call [scanf]
        add esp,8
        
        mov edx,0
        mov eax,len
        mov ebx,[n]
        div ebx
        cmp edx,0
        je adauga
        inc eax
        adauga:
        mov [lungime],eax
        mov ebx,len-1
        mov esi,s
        mov edi,sir_nou
        movsb ; primul octet il pun direct
        repeta:
           mov ecx ,[n]
           repeta2:
                lodsb
                inc dword [numar]
                cmp dword [numar],ebx
                je afara
            loop repeta2
            stosb
        jmp repeta
        afara: ;aici am creeat deja sir_nou
        
        mov dword [numar],-1
        mov edx,[lungime]
        mov esi,sir_nou
        mov edi,sir_nr_1
        nr_de_1:
            lodsb
            inc dword [numar]
            cmp dword [numar],edx
            je afara2
            mov bl,0
            mov ecx,8
            rotire:
                ror al,1
                adc bl,0
            loop rotire
            mov al,bl
            stosb
        jmp nr_de_1
        afara2:
        ; am creeat sir_nr_1
        
        bubble_sort:
            mov ecx, [lungime]
            dec ecx
            jecxz sfarsit
            mov dword [ok], 1
            
            mov esi, sir_nr_1
            mov edi, sir_nou
            
            repeta_bubble_sort:
                lodsb
                mov dl, [edi]
                inc edi
                cmp al, [esi]
                jae next
                
                mov bl, [esi]
                xchg [esi], al
                dec esi
                xchg [esi], bl
                inc esi
                
                mov al, [edi]
                xchg [edi], dl
                dec edi
                xchg [edi], al
                inc edi
                
                mov dword [ok], 0
                
                next:
                    loop repeta_bubble_sort
            cmp dword [ok], 0
            je bubble_sort
            
        sfarsit:
        mov ecx,[lungime]
        mov esi,sir_nou
        loop_afisare:
            push ecx
            lodsb
            movzx eax, al
            push dword eax
            push dword format_af
            call [printf]
            add esp,8
            pop ecx
            ;inc esi
        loop loop_afisare
       
            
            
            
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
