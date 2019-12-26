bits 32
global start


extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    format_hexa db "%x", 0
    
segment code use32 class=code

print_in_base16:
    ;;int print_in_base16(int number);
    
    push dword [ESP+4] 
    push dword format_hexa 
    call [printf]
    add ESP, 4*2
    
    ret 4*1

    
;;print_in_base2:

;;    .repeat:
        
        
;;    loop .repeat

;;    ret
    
    
start:
    
    push dword 38
    call print_in_base16
    
    push dword 0
    call [exit]