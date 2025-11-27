section .data
    outbuf db 16 dup(0)      ; буфер под строку (до 10 цифр)

section .text
    global _start

; ----------------------------------------------------------
;  Функция: int_to_str
;  Вход:    ebx — число
;  Выход:   eax — указатель на строку
;  Описание: записывает цифры в буфер справа налево,
;            потом возвращает указатель на первый символ
; ----------------------------------------------------------

int_to_str:
    mov edi, outbuf + 15     ; начинаем с конца буфера
    mov ecx, 0               ; количество символов

.convert:
    mov edx, 0
    mov eax, ebx
    mov esi, 10
    div esi                  ; eax = ebx / 10, edx = ebx % 10

    add dl, '0'              ; цифру в символ
    mov [edi], dl
    dec edi
    inc ecx

    mov ebx, eax
    test ebx, ebx
    jnz .convert

    inc edi                  ; перейти на первый символ строки
    mov eax, edi             ; вернуть указатель
    ret


; ----------------------------------------------------------
;  Основная программа
; ----------------------------------------------------------

_start:
    mov ebx, 9876543         ; число для преобразования
    call int_to_str          ; eax = адрес строки

    ; вывод строки
    mov edx, 16              ; максимальная длина
    mov ecx, eax             ; указатель на строку
    mov ebx, 1               ; stdout
    mov eax, 4               ; sys_write
    int 0x80

    ; выход
    mov eax, 1
    xor ebx, ebx
    int 0x80
