bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    n dd 0
    message db "n=", 0
    format db "%d", 0
    
segment code use32 class=code
start:
    push dword message
    call [printf]
    add esp, 4*1

    push dword n
    push dword format
    call [scanf]
    add esp, 4*2

    push dword 0
    call [exit]