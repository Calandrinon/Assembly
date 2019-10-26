bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    a DB 5
    b DB 3
    c DB 9
    d DB 11

segment code use32 class=code
start:
    ;;;we need to compute (a+c-d) +d - (b+b-c)  = (5+9-11) + 11 - (3+3-9) = 
    ;;;=(14-11)+11-(6-9)=3+11-(-3)=14+3=17=11h
    ;first we compute (a+c-d)
    
    mov AL, [a]
    add AL, [c]
    sub AL, [d]
    
    ;now we add d to (a+c-d)(which is stored into AL)
    add AL, [d]
    
    ;now we can compute (b+b-c) into BL
    mov BL, [b]
    add BL, [b]
    sub BL, [c]
    
    ;now we subtract (b+b-c) from the rest of the expression
    ;the rest of the expression is still stored in AL 
    sub AL, BL
    push dword 0
    call [exit]