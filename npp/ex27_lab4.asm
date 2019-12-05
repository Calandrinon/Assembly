bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    A dq 0000000000000001111110100100111101011101101011010010100001010010b
    N db 0
    B dd 0
    C db 0
    bitmask1 dd 111100000000b
    bitmask2 dd 11110000000000000000b
    
;;; 27. Given the quadword A, obtain the integer number N represented on 
;;; the bits 35-37 of A. Then obtain the the doubleword B by rotating 
;;; the low doubleword of A N positions to the right. Obtain the byte C as follows: 
;;; 1. the bits 0-3 of C are the same as the bits 8-11 of B
;;; 2. the bits 4-7 of C are the same as the bits 16-19 of B
   
segment code use32 class=code
start:;;; 001
    ;;; First we obtain the bitmask that is needed in ECX:EBX.
    mov EBX, 0
    mov ECX, 111b
    ;;; We move the 3 bits 3 positions to the left.
    ;;; So the bits 32-34 will be shifted 3 positions to the left 
    ;;; on positions 35-37 in the bitmask.
    shl ECX, 3
    
    ;;; We move [A] into EDX:EAX so that we can apply the "and" 
    ;;; bitwise operation with the bitmask.
    mov EAX, dword [A]
    mov EDX, dword [A+4]
    
    ;;; Now we apply the "and" operation, first on the low dword of 
    ;;; A, which in this case is EAX, and then on the high dword of A
    ;;; which is stored in EDX.
    and EAX, EBX
    and EDX, ECX
    ;;; We shift the bits 35-37 3 positions to the right (the bits will be shifted)
    ;;; on the positions 32-34) and we obtain the number in the first byte
    ;;; of EDX which is DL.
    shr EDX, 3
    
    ;;; The result is moved into [N].
    mov byte [N], DL
    
    
    
    ;;; Now we want to obtain the number B that is required in the 
    ;;; problem statement.
    ;;; First, we copy the low d-word of A into EAX.
    mov EAX, dword [A]
    mov CL, [N]     ;;; Now we move into the default operand of the ror instruction
                    ;;; the number [N].
    ror EAX, CL     ;;; CL = 1, EAX = 2ED69429h
    mov [B], EAX    ;;; The number B is stored in EAX.
    
    
    
    ;;; Now we need to obtain the number C.
    ;;; First, we need to obtain the bits 8-11 of B.
    ;;; To do that, we will use the "and" instruction and the
    ;;; first bitmask "bitmask1" on the number [B].
    mov EAX, [B]
    and EAX, [bitmask1]   
    ;;; Now we shift the bits that we obtained with 8 positions to the right.
    ;;; In this way, we will obtain the bits 8-11 of B(EAX) on the positions 
    ;;; 0-3 of B(EAX).
    shr EAX, 8 ;;; EAX = 4h
    ;;; Now we move the 4 bits into the number [C]
    mov [C], AL
    
    
    ;;; The next step is to get the bits 16-19 of [B]
    ;;; For that, we will apply the "and" operation on [B] with the 
    ;;; second bitmask
    mov EAX, [B]
    and EAX, [bitmask2]
    shr EAX, 12
    or [C], EAX
    
    
    push dword 0
    call [exit]
    