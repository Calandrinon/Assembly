bits 32
global sum

section .text
sum:
	push ebp
	mov ebp, esp
		
	mov eax, [ebp+4*2]
	mov ebx, [ebp+4*3]
	add eax, ebx
	
	mov esp, ebp
	pop ebp

	ret



	
