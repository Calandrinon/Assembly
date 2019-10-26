bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
    a DB 2
    b DB 5
    c DB 4
    d DB 12
    e DW 7
    f DW 13
    g DW 9
    h DW 8

segment code use32 class=code
start:
    ;;;Exercise 11: (e+f)*(2*a+3*b)
    ;first we compute (e+f)
    mov AX, [e];;; AX=0007h
    add AX, [f];;; AX=0014h
    
    ;we move the current result into BX
    mov BX, AX ;;; BX=0014h
    
    ;we compute 2*a
    mov AL, 2  ;;; AL=0002h
    mul byte [a];; AX=0000 0004h
    
    ;we move the result of 2*a from AX to CX
    mov CX, AX;;;; ECX=00000004h
    
    ;now we compute 3*b
    mov AX, 3;;;;; EAX=00000003h
    mul byte [b];; EAX=0000000Fh
    
    add AX, CX
    mul BX;;;;;;;; EAX=0000017Ch
    
    push dword 0
    call [exit]