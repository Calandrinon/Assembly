bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a DB 2
    b DD 15
    c DB 125
    x DQ 80
segment code use32 class=code
start:
    ;;; Unsigned representation
    ;;; x-(a*a+b)/(a+c/a); a,c-byte; b-doubleword; x-qword
    ;;;   d-word    word
    
    ;;;First we compute (a*a+b)
    mov AL, [a]                     ;;;AL = 2 = 02h 
    mul byte [a]                    ;;;AX = AL * [a] = 2 * 2 = 4 = 0004h
    
    ;;;Now we add b to a*a
    mov EBX, [b]                    ;;;EBX = 0000000Fh = 15
    add BX, AX                      ;;;EBX = 00000013h = 19
    ;;;The result of (a*a+b) is in EBX
   
    
    
    ;;; Now we compute (a+c/a)
    mov AL, [c]                     ;;;AL = 7Dh = 125
    div byte [a]                    ;;;AL = AX / [a] = 125 / 2 = 62 = 3Eh
                                    ;;;AH = AX % [a] = 125 % 2 = 1 =  01h
                                    ;;;AX = 013Eh
    mov AH, 0;;;We don't need the remainder -> AX = 003Eh
    ;;; We add a to (c/a)
    add AL, [a]                     ;;;AX = 0040h = 64
    ;;;The result of (a+c/a) is in AX
    
    ;;;We move AX into CX and EBX into EAX
    mov CX, AX                      ;;;CX =     0040h = 64
    mov EAX, EBX                    ;;;EAX= 00000013h = 19
    
    ;;;Now we do the operation (a*a+b)/(a+c/a)
    mov DX, 0
    div CX                          ;;;AX = EAX / CX = 19 / 64 = 0  = 0000h
                                    ;;;DX = EAX % CX = 19 % 64 = 19 = 0013h
    
    ;;;Now we need to subtract AX (which is (a*a+b)/(a+c/a)) from x 
    ;;;But firstly, we move x into two 4-byte registers
    ;;;We will chose ECX:EBX
    
    mov EBX, dword [x]              ;;;EBX= 00000050h = 80
    mov ECX, dword [x+4]            ;;;ECX= 00000000h
                                    ;;;ECX:EBX = 00000000:00000050h = 80
    
    sub BX, AX                      ;;;BX = BX - AX = 80 - 0 = 80 = 50h
                                    ;;;ECX:EBX = 00000000:00000050h = 80
    
    push dword 0
    call [exit]