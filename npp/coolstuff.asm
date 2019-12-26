bits 32
global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    format db "abcdefghijklmnopqrstuvwxyz", 0

segment code use32 class=code

print_prefix:
    ;;void print_prefix(char *string, int number_of_characters); -> prints the prefix with the length "number_of_characters"
    
    mov EAX, [ESP+8]
    mov EBX, [ESP+4]
    mov [EBX+EAX], byte 0
    
    push dword [ESP+4]
    call [printf]
    add ESP, 4
    
    ret 4*2
    
start:
    
    push dword 6
    push dword format
    call print_prefix
    
    push dword 0
    call [exit]
    
    