bits 32
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a DB 2
    b DD 15
    c DB 12
    x DQ -80
segment code use32 class=code
start:
    ;;; Signed representation
    ;;; x-(a*a+b)/(a+c/a); a,c-byte; b-doubleword; x-qword
    ;;;   d-word    byte
    
    ;;; First we compute (a+c/a)
    ;;; We convert c to a word
    mov AL, [c]                     ;;; AL = 0Ch = 12
    cbw                             ;;; AX = 000Ch=12
    idiv byte [a]                   ;;; AL = 06h  = 6
                                    ;;; AH = 00h  = 0
    add AL, [a]                     ;;; AL = 08h  = 8
    ;;; The result of (a+c/a) is in AL
    mov BL, AL                      ;;; BL = AL = 08h = 8
    
    ;;; Now we compute (a*a+b)
    ;;; First, we multiply a with a
    mov AL, [a]                     ;;; AL = 02h = 2
    imul byte [a]                   ;;; AX = AL * [a] = 2 * 2 = 4 = 0004h
    cwd                             ;;; AX = 0004h
                                    ;;; DX = 0000h
    add AX, [b]                     ;;; AX = AX + [b] = 4 + 15 = 19 = 0013h
    add DX, [b+2]                   ;;; DX = DX + [b+2] = 0 + 0 = 0000h
    
    ;;; The result of (a*a+b) is in DX:AX = 0000:0013h
    
    ;;; (a+c/a) is always going to be a byte
    ;;; It is stored in BL
    ;;; We convert the byte BL to a word
    ;;; But for that we need to move BL to AL and we save the result from AX to another register
    mov CX, AX                      ;;; CX = AX = 0013h
    mov AL, BL                      ;;; AL = BL = 08h
    ;;; Now we convert the byte to a word
    cbw
    ;;;We move the result back into BX
    mov BX, AX                      ;;; BX = AX = 0008h
    ;;;And we move CX into AX
    mov AX, CX                      ;;; AX = CX = 0013h
    
    
    ;;; So now we have (a*a+b) in DX:AX and (a+c/a) in BX
    ;;; Now we divide
    idiv BX                         ;;; AX = DX:AX / BX = 0000:0013h / 0008h = 19 / 8
                                    ;;;    = 2 = 0002h
                                    ;;; DX = DX:AX % BX = 0000:0013h % 0008h = 19 % 8
                                    ;;;    = 3 = 0003h
    
    ;;; Now we move the q-word [x] into ECX:EBX
    mov EBX, [x]                    ;;; EBX = FFFFFFB0h
    mov ECX, [x+4]                  ;;; ECX = FFFFFFFFh
    
    ;;; We convert AX to double word extended
    cwde                            ;;; EAX = 00000002h
    
    ;;; Now we sub (a*a+b)/(a+c/a) from x
    sub EBX, EAX                    ;;; EBX = EBX - EAX = -80 - 2 = -82
                                    ;;; EBX = FFFFFFAEh
                                    ;;; ECX = FFFFFFFFh
                                    
    ;;; So the result is -82 and it is stored in ECX:EBX
    ;;; ECX:EBX = FFFFFFFF:FFFFFFAEh
    push dword 0
    call [exit]