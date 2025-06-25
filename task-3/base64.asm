%include "../include/io.mac"

extern printf
global base64

section .data
    alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    fmt db "%d", 10, 0

section .text

base64:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

    ;; DO NOT MODIFY


    ; -- Your code starts here --

    ; Calculam numarul de blocuri de 3 octeti
    ; din sirul sursa

    mov eax, ebx
    xor edx, edx
    mov ecx, 3
    div ecx
    mov ecx, eax

    test ecx, ecx
    jle .encoding_done

.loop_start:
    xor eax, eax

    ; incarca primul octet in al

    mov al, [esi]

    ; deplaseaza eax la stanga cu 8 biti

    shl eax, 8

    ; incarca al doilea octet in al

    mov al, [esi + 1]

    ; deplaseaza eax la stanga cu inca 8 biti

    shl eax, 8

    ; incarca si al treilea octet in al

    mov al, [esi + 2]

    push eax

    ; obtinem caracterele corespunzatoare din
    ; alphabet

    shr eax, 18
    and eax, 0x3F
    mov bl, [alphabet + eax]
    mov [edi], bl

    mov eax, [esp]
    shr eax, 12
    and eax, 0x3F
    mov bl, [alphabet + eax]
    mov [edi + 1], bl

    mov eax, [esp]
    shr eax, 6
    and eax, 0x3F
    mov bl, [alphabet + eax]
    mov [edi + 2], bl

    mov eax, [esp]
    and eax, 0x3F
    mov bl, [alphabet + eax]
    mov [edi + 3], bl

    add esp, 4

    ; actualizeaza pointerii pentru urmatoarea 
    ; iteratie

    add esi, 3
    add edi, 4

    loop .loop_start

.encoding_done:

    ; calculeaza lungimea finala
    ; a sirului destinatie

    mov eax, [ebp + 12]
    xor edx, edx
    mov ecx, 3
    div ecx
    shl eax, 2

    mov edx, [ebp + 20]
    mov [edx], eax

   ; -- Your code ends here --


    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY