bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a DD 0
    b DD 0
    rez DD 0
    f DB "%d/%d=%d", 0
    a_equals DB "a=", 0
    b_equals DB "b=", 0
    format_scanf DB "%d", 0 
    
segment code use32 class=code
start:
    
    push dword a_equals
    call [printf]
    add ESP, 4*1
    
    push dword a
    push dword format_scanf
    call [scanf]
    add ESP, 4*2
    
    push dword b_equals
    call [printf]
    add ESP, 4*1
    
    push dword b
    push dword format_scanf
    call [scanf]
    add ESP, 4*2
    ;---------------------
    mov EDX, 0
    mov EAX, [a]
    
    div dword [b]
    mov [rez], EAX
    
    
    
    push dword [rez]
    push dword [b]
    push dword [a]
    push dword f
    call [printf]
    add ESP, 4*4
    
    push dword 0
    call [exit]