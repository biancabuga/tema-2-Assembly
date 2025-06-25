%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box

section .text

; initializam cu 0 o zona de memorie
; de 9 octeti
; o folosim sa vedem daca o cifra
; este dublicata

init_presence_map:
    push ecx
    push eax
    mov ecx, 9
    xor eax, eax
.clear_loop:
    mov byte [edi], al
    inc edi
    loop .clear_loop
    pop eax
    pop ecx
    ret

; verificam daca o cifra este valida 
; si nu a mai fost intalnita pana acum

check_and_mark_digit:
    push ebx

    cmp al, 1
    jl .invalid_or_duplicate_cm
    cmp al, 9
    jg .invalid_or_duplicate_cm

    sub al, 1
    movzx ebx, al

    cmp byte [edi + ebx], 1
    je .invalid_or_duplicate_cm

    mov byte [edi + ebx], 1
    clc
    jmp .exit_cm_corrected

.invalid_or_duplicate_cm:
    stc

.exit_cm_corrected:
    pop ebx
    ret

; verificam daca un rand in Sudoku este valid

check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi
    ;; DO NOT MODIFY

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row 

    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

    sub esp, 12
    cmp edx, 0
    jl .invalid_input_row_set_err
    cmp edx, 8
    jg .invalid_input_row_set_err

    cmp esi, 0
    je .invalid_input_row_set_err

    lea edi, [ebp - 32]
    call init_presence_map

    mov eax, edx
    imul eax, eax, 9
    add esi, eax

    mov ecx, 9
.row_loop:
    mov al, [esi]
    inc esi

    lea edi, [ebp - 32]
    call check_and_mark_digit
    jc .error_found_row_set_err

    loop .row_loop

    mov eax, 1
    jmp .cleanup_row

.error_found_row_set_err:
    mov eax, 2
    jmp .cleanup_row

.invalid_input_row_set_err:
    mov eax, 2

.cleanup_row:
    add esp, 12

end_check_row:
    ;; DO NOT MODIFY
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    ;; DO NOT MODIFY

; verificam daca o coloana in Sudoku este valida

check_column:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi
    ;; DO NOT MODIFY

    sub esp, 12

    mov esi, [ebp + 8]
    mov edx, [ebp + 12]

    cmp edx, 0
    jl .invalid_input_col_set_err
    cmp edx, 8
    jg .invalid_input_col_set_err

    cmp esi, 0
    je .invalid_input_col_set_err

    lea edi, [ebp - 32]
    call init_presence_map

    mov ecx, 0
.col_loop:
    mov eax, ecx
    imul eax, eax, 9
    add eax, edx
    mov al, [esi + eax]

    lea edi, [ebp - 32]
    call check_and_mark_digit
    jc .error_found_col_set_err

    inc ecx
    cmp ecx, 9
    jl .col_loop

    mov eax, 1
    jmp .cleanup_col

.error_found_col_set_err:
    mov eax, 2
    jmp .cleanup_col

.invalid_input_col_set_err:
    mov eax, 2

.cleanup_col:
    add esp, 12

end_check_column:
    ;; DO NOT MODIFY
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    ;; DO NOT MODIFY

; verificam daca un cadru 3x3 este valid

check_box:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi
    ;; DO NOT MODIFY

    sub esp, 16

    mov esi, [ebp + 8]
    mov ebx, [ebp + 12]

    cmp ebx, 0
    jl .invalid_input_box_set_err
    cmp ebx, 8
    jg .invalid_input_box_set_err

    cmp esi, 0
    je .invalid_input_box_set_err

    lea edi, [ebp - 36]
    call init_presence_map

    mov eax, ebx
    mov edx, 0
    mov ecx, 3
    div ecx

    imul ebx, eax, 3

    imul eax, edx, 3
    mov [ebp - 24], eax

    mov edx, 0
.box_outer_loop:
    push edx

    mov ecx, 0
.box_inner_loop:
    push ecx

    mov eax, ebx
    add eax, edx

    push edi
    mov edi, [ebp - 24]
    add edi, ecx

    imul eax, eax, 9
    add eax, edi
    pop edi

    mov al, [esi + eax]

    lea edi, [ebp - 36]
    call check_and_mark_digit
    jc .error_found_box_pop_and_set_err

    pop ecx
    inc ecx
    cmp ecx, 3
    jl .box_inner_loop

    pop edx
    inc edx
    cmp edx, 3
    jl .box_outer_loop

    mov eax, 1
    jmp .cleanup_box

.error_found_box_pop_and_set_err:
    pop ecx
    pop edx
    mov eax, 2
    jmp .cleanup_box

.invalid_input_box_set_err:
    mov eax, 2

.cleanup_box:
    add esp, 16

end_check_box:
    ;; DO NOT MODIFY
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    ;; DO NOT MODIFY