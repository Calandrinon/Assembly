bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    special_characters DB '!', '@', '#', '$', '%', '^', '&', '*'

segment code use32 class=code
start:
    mov EAX, 0
    mov EBX, 1
    mov ECX, [special_characters+EBX]
    
    cmp [special_characters+EAX], ECX
    jb exit_label 
    
    
    exit_label:
        push dword 0
        call [exit]