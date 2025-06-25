%include "../include/io.mac"

%assign EVENT_SIZE 36
%assign NAME_OFFSET 0
%assign VALID_OFFSET 31
%assign DATE_OFFSET 32
%assign DAY_OFFSET 32
%assign MONTH_OFFSET 33
%assign YEAR_OFFSET 34

section .bss
    tmp_event resb EVENT_SIZE

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov esi, [ebp + 8] ; array de evenimente
    mov ecx, [ebp + 12] ; nr evenimente
    ;; DO NOT MODIFY

    ;; Your code starts here

    cmp ecx, 1
    jle .done_sorting

    xor edx, edx

.outer_loop:
    mov eax, ecx
    dec eax
    cmp edx, eax
    jge .done_sorting

    mov edi, edx
    inc edi

.inner_loop:
    cmp edi, ecx
    jge .next_iteration_i

    mov eax, edx
    imul eax, EVENT_SIZE
    lea ebp, [esi + eax]

    ; criteriile de sortare
    ; intai verificam daca evenimentul este valid 
    ; apoi implementam criteriile pentru
    ; sortarea in functie de data

    mov eax, edi
    imul eax, EVENT_SIZE
    lea ebx, [esi + eax]

    mov al, [ebp + VALID_OFFSET]
    mov ah, [ebx + VALID_OFFSET]

    cmp al, ah
    jne .handle_different_validity

    mov ax, [ebp + YEAR_OFFSET]
    cmp ax, [ebx + YEAR_OFFSET]
    jl .next_iteration_j
    jg .swap_elements
    mov al, [ebp + MONTH_OFFSET]
    cmp al, [ebx + MONTH_OFFSET]
    jl .next_iteration_j
    jg .swap_elements
    mov al, [ebp + DAY_OFFSET]
    cmp al, [ebx + DAY_OFFSET]
    jl .next_iteration_j
    jg .swap_elements

    push esi
    push edi
    push edx
    push ecx

    mov esi, ebp
    mov edi, ebx
    mov ecx, 31
    repe cmpsb 

    ja .trigger_swap_after_name_cmp

    pop ecx
    pop edx
    pop edi
    pop esi
    jmp .next_iteration_j

.trigger_swap_after_name_cmp:
    pop ecx
    pop edx
    pop edi
    pop esi
    jmp .swap_elements

.handle_different_validity:
    cmp al, ah
    jl .swap_elements
    jmp .next_iteration_j

; daca 2 evenimente au aceeasi date, 
; le sortam in ordine lexicografica
; interschimbandu-le

.swap_elements:
    push ecx
    push esi
    push edi

    mov ecx, EVENT_SIZE
    mov esi, ebp
    lea edi, [tmp_event]
    cld
    rep movsb

    mov ecx, EVENT_SIZE
    mov esi, ebx
    mov edi, ebp
    cld
    rep movsb

    mov ecx, EVENT_SIZE
    lea esi, [tmp_event]
    mov edi, ebx
    cld
    rep movsb

    pop edi
    pop esi
    pop ecx

    jmp .next_iteration_j

.next_iteration_j:
    inc edi
    jmp .inner_loop

.next_iteration_i:
    inc edx
    jmp .outer_loop

.done_sorting:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY