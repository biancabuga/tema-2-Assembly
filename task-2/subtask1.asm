%include "../include/io.mac"

%assign EVENT_SIZE 36
%assign NAME_OFFSET 0
%assign VALID_OFFSET 31
%assign DATE_OFFSET 32
%assign DAY_OFFSET 32
%assign MONTH_OFFSET 33
%assign YEAR_OFFSET 34

section .data
    days_in_month db 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8] ; array de evenimente
    mov ecx, [ebp + 12] ; numarul de evenimente
    ;; DO NOT MODIFY

    ;; Your code starts here
    test ecx, ecx
    jz .end_check_loop

    xor esi, esi

.check_loop:
    mov byte [ebx + esi + VALID_OFFSET], 0
    ; initializam cu 0
    ; verificam daca an > 1990 si an < 2030
    mov ax, [ebx + esi + YEAR_OFFSET]
    cmp ax, 1990
    jl .next_event
    cmp ax, 2030
    jg .next_event

    ; verificam daca luna = [1, 12]
    mov dl, [ebx + esi + MONTH_OFFSET]
    cmp dl, 1
    jl .next_event
    cmp dl, 12
    jg .next_event

    ; verificam daca ziua este in intervalul [1, 28/30/31]
    mov dh, [ebx + esi + DAY_OFFSET]
    cmp dh, 1
    jl .next_event

    movzx eax, dl
    mov al, [days_in_month + eax] ;
    cmp dh, al
    jg .next_event

    ; setam variabila de validitate
    mov byte [ebx + esi + VALID_OFFSET], 1

.next_event:
    add esi, EVENT_SIZE
    loop .check_loop

.end_check_loop:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY