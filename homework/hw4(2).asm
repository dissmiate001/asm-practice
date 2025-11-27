section .data
    t1 db 10 dup(0)
    t2 db 16 dup(0)

section .text
    global _start

p:
    mov edx,0
r0:
    cmp byte[ecx+edx],0
    je r1
    inc edx
    jmp r0
r1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

s1:
    mov bx,ax
    mov edi,t1+9
r2:
    mov dx,0
    mov ax,bx
    mov si,10
    div si
    add dl,'0'
    mov [edi],dl
    dec edi
    mov bx,ax
    test bx,bx
    jnz r2
    inc edi
    mov eax,edi
    ret

s2:
    mov esi,t2+15
r3:
    mov dx,0
    mov ax,cx
    mov bx,10
    div bx
    add dl,'0'
    mov [esi],dl
    dec esi
    mov cx,ax
    test cx,cx
    jnz r3
    inc esi
    mov eax,esi
    ret

fn:
    cmp ax,1
    jbe r4
    push ax
    dec ax
    call fn
    pop bx
    mul bx
    ret
r4:
    mov ax,1
    mov dx,0
    ret

_start:
    mov ax,4
    call s1
    mov ecx,eax
    call p

    mov ax,4
    call fn
    mov cx,ax
    call s2
    mov ecx,eax
    call p

    mov eax,1
    xor ebx,ebx
    int 0x80
