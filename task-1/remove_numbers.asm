%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY

	;; Your code starts here
	
	xor ecx, ecx
	xor eax, eax

.loop_start:
	cmp ecx, ebx ;conditia pentru for
	jge .loop_end

	mov edx, [esi + ecx * 4]
	; parcurgerea vectorului

	test dl, 1; verificare paritate
	jnz .next_iteration

	cmp edx, 0 ; verificare semn
	jle .copy_element

	push ecx
	mov ecx, edx
	dec ecx
	test edx, ecx
	; verificare putere a lui 2

	pop ecx
	jz .next_iteration

.copy_element:
	mov [edi + eax * 4], edx
	; copiere in vectorul destinatie
	inc eax

.next_iteration:
	inc ecx
	jmp .loop_start

.loop_end:
	mov edx, [ebp + 20]
	mov [edx], eax

	;; Your code ends here
	
	;; DO NOT MODIFY

	popa
	leave
	ret
	
	;; DO NOT MODIFY