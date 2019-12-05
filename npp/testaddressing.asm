bits 32
global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a DD 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
    format DB "%d", 0
    
segment code use32 class=code
start:
    mov EBX, a
    mov EAX, 5
    mov EDX, dword [EBX+EAX*4+2*4]
    
    push dword EDX
    push dword format
    call [printf]
    add ESP, 4*2
    
    push dword 0
    call [exit]
