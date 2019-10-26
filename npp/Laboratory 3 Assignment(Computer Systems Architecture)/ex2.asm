bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a DB 2
    b DW 15
    c DD 125
    d DQ 80
    
segment code use32 class=code
start:
    ;;;We need to compute (c+d-a)-(d-c)-b
    
    ;;;First we move d into EDX:EAX
    mov EAX, [d]
    mov EDX, [d+4]
    ;;;EDX:EAX = 00000000:00000050h = 80
    
    ;;;Now we add the d-word [c] with the lower d-word of EDX:EAX, which is EAX
    add EAX, [c]                        ;;; EAX = EAX + [c] = 80 + 125 = 205
                                        ;;; EDX:EAX = 00000000:000000CDh = 205
    ;;;Now we subtract the byte [a]
    sub AL, [a]    
                                        ;;;EDX:EAX = 00000000:000000CBh = 203
    
    ;;;We will do the operation (d-c) 
    mov EBX, [d]                        ;;; EBX = [d] = 80
    mov ECX, [d+4]                      ;;; ECX = [d+4] = 0
                                        ;;;ECX:EBX = 00000000:00000050h
    sub EBX, [c]                        ;;; EBX = EBX - [c] = 80 - 125 = -45
    sbb ECX, 0                          ;;;ECX:EBX = FFFFFFFF:FFFFFFD3h = -45
    
    sub EAX, EBX                        ;;; EAX = EAX - EBX = 203 - (-45) = 248
    sbb EDX, ECX                        ;;;EDX:EAX = 00000000:000000F8h
    
    ;;;We will subtract b from the rest of the expression
    sub AX, [b]
    ;;;EDX:EAX = 00000000:000000E9h
    push dword 0
    call [exit]