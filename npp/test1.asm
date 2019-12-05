bits 32
global start

extern exit
import exit msvcrt.dll
    
segment data use32 class=data
    
segment code use32 class=code
start: 
    mov ax, 10h
    add ah, 16
    div al
    ;;integer division by zero
    push dword 0
    call [exit]