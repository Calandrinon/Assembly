bits 32
global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

extern longest_common_prefix

segment data use32 class=data
    a db "abcdefbbbbbbbbbbbbbbbbbbbbb", 0
    len_a equ $-a-1
    b db "abcdefff", 0
    len_b equ $-b-1
    d db "abcd", 0
    len_d equ $-d-1
    space db " ", 0
;;; TASK 7:
;;; Three strings (of characters) are given. Show the longest prefix for each of the three pairs of two strings that can be formed. 
    
segment code use32 class=code
print_space:
    push dword space
    call [printf]
    add ESP, 4*1
    ret
    
    
start:
    push dword len_b
    push dword len_a
    push dword b
    push dword a
    call longest_common_prefix
    call print_space
    
    push dword len_d
    push dword len_b
    push dword d
    push dword b
    call longest_common_prefix
    call print_space
    
    push dword len_d
    push dword len_a
    push dword d
    push dword a
    call longest_common_prefix
    call print_space
    
    push dword 0
    call [exit]
    
    
    