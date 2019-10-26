bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
segment code use32 class=code
start:
    ;;; We compute 128 * 2
    mov AL, 128
    mov BL, 2
    mul BL
    push dword 0
    call [exit]