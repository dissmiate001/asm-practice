section .data
    b1 db 12 dup(0)
    b2 db 18 dup(0)

section .text
    global _start

pr:
    mov edx,0
a0:
    cmp byte[ecx+edx],0
    je a1
    inc edx
    jmp a0
a1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

c16:
    mov bx,ax
    mov edi,b1+11
a2:
    mov dx,0
    mov ax,bx
    mov si,10
    div si
    add dl,'0'
    mov [edi],dl
    dec edi
    mov bx,ax
    test bx,bx
    jnz a2
    inc edi
    mov eax,edi
    ret

c64:
    mov esi,b2+17
a3:
    mov dx,0
    mov ax,cx
    mov bx,10
    div bx
    add dl,'0'
    mov [esi],dl
    dec esi
    mov cx,ax
    test cx,cx
    jnz a3
    inc esi
    mov eax,esi
    ret

_start:
    mov ax,7
    call c16
    mov ecx,eax
    call pr

    mov ax,7
    mov dx,0
    mov bx,1
l0:
    mul bx
    inc bx
    cmp bx,ax
    jbe l0

    mov cx,ax
    call c64
    mov ecx,eax
    call pr

    mov eax,1
    xor ebx,ebx
    int 0x80
