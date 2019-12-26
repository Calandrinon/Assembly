%ifndef _LONGEST_COMMON_PREFIX_ASM_
%define _LONGEST_COMMON_PREFIX_ASM_

print_prefix:
    ;; void print_prefix(char *string, int number_of_characters); -> prints the prefix with the length "number_of_characters"
    
    mov EAX, [ESP+8]
    mov EBX, [ESP+4]
    mov [EBX+EAX], byte 0
    
    push dword [ESP+4]
    call [printf]
    add ESP, 4
    
    ret 4*2

min:
    ;; int min(int a, int b);
    mov ECX, [ESP+4]    ;; the first number
    mov EDX, [ESP+8]    ;; the second number
    
    cmp EDX, ECX
    ja .set_result
    ret 4*2
    
    .set_result:
        mov EDX, ECX
        ret 4*2
    

longest_common_prefix:
    ;; int longest_common_prefix(char *str1, char *str2, int l_str1, int l_str2);
    
    mov EAX, [ESP+4]   ;; the offset of the first string
    mov EBX, [ESP+8]   ;; the offset of the second string
    
    
    push dword [ESP+12]   ;; [ESP+12] - the size of the first string
    push dword [ESP+16]   ;; [ESP+16] - the size of the second string
    call min        ;; moves into EDX the minimum between the two numbers
    
    mov ECX, EDX
    push dword 0    ;; [ESP+4] - here, we will store the length of the longest common prefix
    push dword EDX  ;; [ESP] - here we will store EDX, the minimum of the two length of the strings
    
    .repeat:
        mov ESI, [ESP]
        sub ESI, ECX      ;; ESI = [ESP] - ECX
        
        mov DL, [EAX+ESI] ;; [EAX+ESI] - the character from the first string
        cmp DL, [EBX+ESI] ;; [EBX+ESI] - the character from the second string is compared with the character from the first string
        je .increment_length
        jmp .print_longest_common_prefix
        
        .increment_length:
            inc dword [ESP+4]
    loop .repeat
    
    cmp dword [ESP+4], 0
    jmp .no_common_prefix_exception
    
    
    .print_longest_common_prefix:
        push dword [ESP+4]
        push EAX
        call print_prefix'
        add ESP, 4*2
        ret
        
    .no_common_prefix_exception:
        push dword no_prefix_error_message
        call [printf]
        add ESP, 4
        add ESP, 4*2
        ret

%endif