bits 32
global start

extern exit, fopen, fclose, printf, fread
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    max_frequency_digit DB 0
    max_frequency DB 0
    digit_frequency RESB 10
    filename DB "digits.txt", 0
    access_mode DB "r", 0
    file_descriptor DD -1
    digit DD 0
    format DB "Digit: %d;      Frequency: %d", 0
    counter DD 0
   
    
segment code use32 class=code
start:
    
    push dword access_mode
    push dword filename
    call [fopen]
    add ESP, 4*2
    
    mov [file_descriptor], EAX
    cmp EAX, 0
    je end_of_program
    
    get_number_of_numbers:
        push dword [file_descriptor]
        push dword 1
        push dword 1
        push dword digit
        call [fread]
        add ESP, 4*4
        
        mov EDI, [digit]
        cmp EDI, 10
        je set_counter
        sub EDI, 48
        
        mov EAX, [counter]
        mov ECX, 10
        mul ECX
        mov [counter], EAX
        
        add [counter], EDI
        
    jmp get_number_of_numbers
    
    set_counter:
    mov EDI, [counter]
    
    count_frequency:
        push dword [file_descriptor]
        push dword 1
        push dword 1
        push dword digit
        call [fread]
        add ESP, 4*4
        
        mov EAX, [digit]
        cmp EAX, 10
        je count_frequency
        sub EAX, 48
        
        mov EBX, digit_frequency
        inc byte [EBX+EAX*1]
        mov EDX, [EBX+EAX*1]
        
        dec EDI
        cmp EDI, 0
        je out_of_loop
    jmp count_frequency
    out_of_loop:
    
    
    mov ECX, 9
    find_max_frequency:
        mov EBX, digit_frequency
        mov EAX, 0
        mov AL, [max_frequency]
        cmp [EBX+ECX*1], AL
        jg update_max
        continue:
    loop find_max_frequency
    
    push dword [file_descriptor]
    call [fclose]
    add ESP, 4*1
    
    mov EAX, 0
    mov EDX, 0
    mov AL, [max_frequency]
    mov DL, [max_frequency_digit]
    
    push EAX
    push EDX
    push dword format
    call [printf]
    add ESP, 4*3
    
    end_of_program:
    push dword 0
    call [exit]
    
    update_max:
        mov AL, [EBX+ECX*1]
        mov [max_frequency], AL
        mov [max_frequency_digit], CL
    jmp continue