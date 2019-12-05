bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir DB 6, 7, 6, 6
    len_sir equ $-sir
    rez times len_sir DW 0
    verified_num RESB 256
    it DB 0
    old_esi DD 0
    element DB 0
    freq DB 0
    
segment code use32 class=code
start:
    mov ESI, sir
    mov EDI, rez
    mov ECX, len_sir
    cld
    
    re:
        lodsb    
        mov [element], AL 
        mov byte [it], 0
        mov [old_esi], ESI
        mov ESI, sir
        mov byte [freq], 0
        mov EBX, 0
        mov BL, [element]
        
        cmp byte [verified_num+EBX], 0 
        jne already_checked
        
        count:
            lodsb
            
            cmp AL, [element] ;; AL is the current element from the sequence
            je element_found
            
            cont:
            
            inc byte [it]
            mov BL, len_sir
            cmp [it], BL
        jne count
    
        mov ESI, [old_esi]
        mov AH, [freq]
        mov AL, [element]
        mov EBX, 0
        mov BL, [element]
        mov [verified_num+EBX], AL
        stosw
    loop re
    
    
    
    
    push dword 0
    call [exit]
    
    element_found:
        inc byte [freq]
        jmp cont
        
    already_checked:
        mov ESI, [old_esi]
        jmp re