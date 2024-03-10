bits 32

global modul

segment data use32 class=data
    maxim db 0

segment code use32 public class=code
    modul:
        ;esp -> adresa de revenire
        mov ecx, [esp + 12] ;pun in ecx lungimea sirului
        mov esi, [esp + 8] ;pun in esi sirul din care iau dd
        mov edi, [esp + 4] ;pun in edi sirul in care incarc bytes maxim
        mov edx, 0 ;in dl voi calcula suma
        
        ;parcurg sirul
        repeta:
            lodsd ;pun in eax dublucuvantul din sir
            push ecx ;salvez ecx-ul pe stiva
            mov ecx,4 ;parcurg toti bytes ai dublucuvantului
            mov byte[maxim], 0;pun in maxim 0
            mov ebx, 1;aici voi retine rankul byte-ului maxim
            
            cauta_maxim:
                cmp byte[maxim], al ;verific daca al este byte-ul maxim
                JAE next
                mov byte[maxim],al ;actualizez maximul
                mov ebx,ecx ;actualizez rankul
                next:
                    shr eax,8 ;verific urmatorul byte
            loop cauta_maxim
            
            pop ecx ;scot ecx-ul de pe stiva
            add dl,[maxim]
            mov al,bl
            add al,'0'
            
            stosb ;pun in sir maximul
             ;fac suma byte-ului
        
        loop repeta
        mov ebx,edx
        
        ret 4 * 3