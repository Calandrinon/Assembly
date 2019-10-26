bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    a DB 1
    b DB 3
    c DB 9
    d DW 2

segment code use32 class=code
start:
    ;;;[(d/2)*(c+b)-a*a]/b 
    ;first we compute d/2
    mov AX, [d]
    mov BL, 2
    div BL  ;;AX = 0105h
            ;;AH = 01h
            ;;AL = 05h
    
    ;now we compute c+b in BL
    mov BL, [c] ;; BL = 09h
    add BL, [b] ;; BL = 0Ch
    
    ;now we multiply (c+b) from BL with (d/2) from AL
    mul BL ;; the result is in AX = 003Ch
    
    ;we have to move the current result to another register
    mov BX, AX ;; BX = 003Ch 
    
    ;now we compute a*a
    mov AL, [a] ;; AL = 05h
    mul byte [a];; AX = AL * [a] = 0019h
    
    ;now we subtract a*a from the previous result stored in BX
    sub BX, AX  ;; BX = 0023h
    
    ;now we move the result from BX(which is [(d/2)*(c+b)-a*a])to AX
    ;so we can divide it by b
    mov AX, BX  ;; AX = 0023h
    div byte [b] ;;the remainder is stored in AH and the quotient in AL
                 ;;AH = 02h
                 ;;AL = 0Bh
    
    push dword 0
    call [exit]