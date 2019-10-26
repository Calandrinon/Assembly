bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    a DW 5
    b DW 16
    c DW 9
    d DW 27

segment code use32 class=code
start:
    ;;; (b-c)+(d-a) = 7 + 22 = 29 
    mov AX, [b]
    sub AX, [c]
    
    mov BX, [d]
    sub BX, [a]
    
    add AX, BX
    push dword 0
    call [exit]