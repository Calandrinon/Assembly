bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    special_characters DB '!', '@', '#', '$', '%', '^', '&', '*'
    len_special_char_arr equ $-special_characters
    s DB '+', '4', '2', 'a', '@', '3', '$', '*'
    len_s equ $-s
    d times len_s DB 0

segment code use32 class=code
start:;;; 40, 24, 2A
    mov ESI, 0
    mov EDI, 0
    mov ECX, len_s
    cld
    cmp ECX, 0
    je end_of_program
    
    get_special_chars:
        mov EBX, 0
        check_if_character_is_special:
            mov AL, byte [special_characters+EBX]
            cmp byte [s+ESI], AL
            je add_special_char_to_d
            inc EBX
            cmp EBX, len_special_char_arr
            jb check_if_character_is_special
        
        update_iterators_and_exit_if_needed:
            inc ESI
            dec ECX
            cmp ECX, 0
            je end_of_program
            jmp get_special_chars
    
    add_special_char_to_d:
        mov AL, byte [s+ESI]
        mov byte [d+EDI], AL
        inc EDI
        jmp update_iterators_and_exit_if_needed
    
    end_of_program:
        push dword 0
        call [exit]