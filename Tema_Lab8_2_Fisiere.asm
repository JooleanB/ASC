bits 32

global start        

extern exit, fopen, fclose, fread, printf
import exit   msvcrt.dll 
import fopen  msvcrt.dll 
import fclose msvcrt.dll
import fread  msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    filepath db "text.txt", 0 ; fisierul de unde citesc
    mod_acces db "r", 0 ; ca sa pot sa citesc din fisier
    fisier dd -1 ; aici salvam pointer catre fisier
    
    nr_caract_curent dd 0 ; cate caract am citit pt ca citesc in mai multe etape
    max_caract_pe_etapa equ 100 ; citesc din fisier 100 cate 100 caract 
    buffer resb max_caract_pe_etapa ; bufferul in care salvez caract curente
    
    nr_vocale dd 0
    vocale db "aeiouAEIOU", 0
    len_vocale equ $ - vocale
    format_output db "nr de vocale este: %d", 0
    
segment code use32 class=code
    start:
        push dword mod_acces
        push dword filepath
        call [fopen] 
        add ESP, 4 * 2 ; refac striva
        
        cmp EAX, 0 ; daca fisieru de sus nu s a deschis bine in EAX e 0 
        je final   ; daca nu i bine nu stam la discutii
        
        mov [fisier], EAX ; salvam in var "fisier" adresa la fisieru deschis
        
        repeta:
            push dword [fisier] ; de unde citesc
            push dword max_caract_pe_etapa ;cat as vrea sa citesc 
            push dword 1 ;cati octeti are un caracter
            push dword buffer ; unde imi stochez ce citesc
            call [fread]   ; EAX=CATE CARACTERE AM CITIT
            add ESP, 4 * 4 ; curat stiva
            
            cmp EAX, 0 ; daca n am citit niciun caracter, atunci eax=0 si fisierul trebuie inchis
            je cleanup 
            
            mov  [nr_caract_curent], EAX
            
            mov ECX, [nr_caract_curent] ; pt loop, procesam fiecare caracter, nu mai trb sa verificam daca nu i 0 ca deja am facut o 
            procesare_caracter:
                mov BL, [buffer + ECX - 1] ; iau fiecare caracter unu cate unu in ordine inversa (-1 pentru ca incep de la 0)
                
                push ECX ; salvez pe ECX pe stiva
                mov ECX, len_vocale
                repeta_vocale:
                    cmp BL, [vocale + ECX - 1]
                    jne continua ; daca nu e vocala respectiva sare la urmatoarea vocala                 
                    inc dword[nr_vocale] ; nr_vocale++
                continua:
                    loop repeta_vocale ;decrementeaza ECX
                pop ECX ; refac pe ecx
                loop procesare_caracter
                
        jmp repeta 
        
        
        cleanup:
            push dword [fisier] ;pun pe stiva adresa fisierului aflata in valoarea variabilei "fisier"
            call [fclose] ; inchid fisierul
            add ESP, 4
        
        final: 
            push dword [nr_vocale] ; pun pe stiva numarul de vocale
            push dword format_output ;pun pe stiva formatul 
            call [printf]
       
            push    dword 0
            call    [exit]