; The following code will open a file called "ana.txt" from current folder,
; and it will read maximum 100 characters from this file.

; The program will use:
; - the function fopen() to open/create the file
; - the function fread() to read from file
; - the function fclose() to close the created file.

; Because the fopen() call uses the file access mode "r", the file will be open for
; reading. The file must exist, otherwise the fopen() call will fail.
; For details about the file access modes see the section "Theory".

bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nr db 0
    file_name db "file.txt", 0   ; filename to be read
    access_mode db "r", 0       ; file access mode:
                                ; r - opens a file for reading. The file must exist. 
    file_descriptor dd -1       ; variable to hold the file descriptor
    len equ 100                 ; maximum number of characters to read
    text times len db 0         ; string to hold the text which is read from file
    special_characters db "!@#$%^&*()-=_+"
    len_sp_chars equ $-special_characters
    format db "%d", 0
    
; our code starts here
segment code use32 class=code
    start:
        ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        
        
        mov [file_descriptor], eax  ; store the file descriptor returned by fopen

        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        ; read the text from file using fread()
        ; after the fread() call, EAX will contain the number of chars we've read 
        ; eax = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4

        mov ESI, 0
        
        re:
            
            mov ECX, len_sp_chars
            is_special_char:
                mov EAX, [text+ESI]
                cmp EAX, [special_characters+ECX]
                je increment_nr
                continue:
            loop is_special_char
      
            inc ESI
        
        cmp ESI, len
        jne re
        
        
        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4

        
        push dword [nr]
        push dword format
        call [printf]
        add ESP, 4*2
        
    final:

        ; exit(0)
        push dword 0
        call [exit]
        
    increment_nr:
        inc byte [nr]
        jmp continue
            