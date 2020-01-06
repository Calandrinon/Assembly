bits 32
global maxnum

segment .data
    result DD 0

segment .text
maxnum:
    push ebp
    mov ebp, esp
    pushad

    mov EDX, [EBP+8] ;; the offset of the array
    mov ECX, [EBP+12] ;; the number of elements of the array
    mov EAX, -999999999 ;; the variable which contains the current maximum number in the array

    .find_max_num:
        cmp EAX, [EDX]
        jl .update_max
        .continue:
        add EDX, 4
    loop .find_max_num

    mov [result], EAX

    popad
    mov EAX, [result]
    mov esp, ebp
    pop ebp
    ret

    .update_max:
        mov EAX, [EDX]
    jmp .continue
