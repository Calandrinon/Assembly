bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a DB 2
    b DW 15
    c DD 125
    d DQ 80
    
segment code use32 class=code
start:
    ;;;We need to compute (c+c-a)-(d+d)-b
    ;;;First we add c with c
    mov AX, word [c]   ;;; AX = word [c] = 125 = 007Dh
    mov DX, word [c+2] ;;; DX = word [c+2] = 0 = 0000h
                       ;;; DX:AX = 0000:007Dh
    add AX, word [c]   ;;; AX = AX + word [c] = 125 + 125 = 250 = 00FAh
    adc DX, word [c+2] ;;; DX = DX + 0 + CF = 0 + 0 + 0         = 0000h
                       ;;; DX:AX = 0000:00FAh
                       
    ;;;Now we subtract a from (c+c)
    sub AL, [a]        ;;; AL = AL - [a] = 250 - 2 = 248 = F8h
                       ;;; DX:AX = 0000:00F8h
    push DX
    push AX
    pop EAX            ;;; So the result of (c+c-a) is stored in EAX
                       ;;; EAX = 000000F8h
    
    
    ;;;Now we store the quad word [d] into two double words, so in ECX:EBX
    mov EBX, dword [d]
    mov ECX, dword [d+4]
    ;;;ECX:EBX = 00000000:00000050h
    
    ;;;We add [d] with ECX:EBX by adding the low d-word of [d] with EBX
    ;;;and the high d-word of [d], basically [d+4], with ECX
    add EBX, dword [d]
    adc ECX, dword [d+4]
    ;;;The result of (d+d) is stored in ECX:EBX 
    ;;;ECX:EBX = 00000000:000000A0h
    
    
    ;;;Now we need to do the following subtraction (c+c-a)-(d+d)
    ;;;(c+c-a) is stored in EAX, and (d+d) is stored in ECX:EBX
    mov EDX, 0         ;;;Conversion of EAX to EDX:EAX
    sub EAX, EBX       ;;;EAX = EAX - EBX = 248 - 160 = 88 = 00000058h
    sbb EDX, ECX       ;;;EDX = EDX - ECX = 0 - 0          = 00000000h
    ;;;EDX:EAX = 00000000:00000058h    ---> (c+c-a)-(d+d)
    
    ;;;We will subtract the word [b] from the quad word EDX:EAX
    sub AX, [b] ;;;EAX = EAX - [b] = 88 - 15 = 73 = 00000049h 
    ;;; So the result is 73 and stored in EDX:EAX
    push dword 0
    call [exit]