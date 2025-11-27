section .data
    txtPrime db " prime",10,0
    txtNot  db " not prime",10,0
    buf     db 8 dup(0)

section .text
    global _start

prt:
    mov edx,0
l0:
    cmp byte[ecx+edx],0
    je l1
    inc edx
    jmp l0
l1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

toStr:
    mov bx,ax
    mov edi,buf+7
t0:
    mov dx,0
    mov ax,bx
    mov si,10
    div si
    add dl,'0'
    mov [edi],dl
    dec edi
    mov bx,ax
    test bx,bx
    jnz t0
    inc edi
    mov eax,edi
    ret

isP:
    mov bx,ax
    cmp bx,2
    jl n1
    cmp bx,2
    je p1
    mov cx,2
lp:
    mov ax,bx
    xor dx,dx
    div cx
    cmp dx,0
    je n1
    inc cx
    cmp cx,bx
    jl lp
p1:
    mov eax,1
    ret
n1:
    xor eax,eax
    ret

_start:
    mov ax,41
    call toStr
    mov ecx,eax
    call prt

    mov ax,41
    call isP
    cmp eax,1
    je ok

no:
    mov ecx,txtNot
    call prt
    jmp ex

ok:
    mov ecx,txtPrime
    call prt

ex:
    mov eax,1
    xor ebx,ebx
    int 0x80
