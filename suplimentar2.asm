bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
 
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll                         


segment data use32 class=data
    
    nr1 dd 0
    nr2 dd 0
    input_text db "%d", 0
    format db "%d", 0
    rezultat dd 0
segment code use32 class=code
    start:
      push dword nr1
      push dword format
      call [scanf]
      add esp, 4*2
      
      push dword nr2
      push dword format
      call [scanf]
      add esp, 4*2
      
      mov eax, dword [nr1]
      cdq
      idiv dword [nr2]
      
      mov [rezultat],eax
      push eax
      push dword format
      call [printf]
      add esp, 4*2
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
