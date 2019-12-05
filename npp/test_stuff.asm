bits 32
global start 

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dd 1a2b3ch, 4d9fh, 6e5d27h
    format db "%d", 0
    
segment code use32 class=code
start:
    mov ebx, 0
    mov bx, [a+5]
    push dword 0
    call [exit]