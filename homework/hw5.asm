section .data
    s db "*",0
    sp db " ",0
    nl db 10,0

section .text
    global _start

p:
    mov edx,0
u0:
    cmp byte[ecx+edx],0
    je u1
    inc edx
    jmp u0
u1:
    mov eax,4
    mov ebx,1
    int 0x80
    ret

ps: mov ecx,s  ; print star
    call p
    ret

pp: mov ecx,sp ; print space
    call p
    ret

pn: mov ecx,nl
    call p
    ret

_start:
    mov si,AH
    mov di,AL

    mov dh,0
r0:
    mov dl,0
r1:
    cmp dh,0
    je pr_s
    cmp dh,di
    je pr_s
    cmp dl,0
    je pr_s
    cmp dl,si
    je pr_s

    mov al,dh
    cmp dl,al
    je pr_s

    mov al,si
    sub al,dl
    cmp dh,al
    je pr_s

    jmp pr_sp

pr_s:
    call ps
    jmp nx

pr_sp:
    call pp

nx:
    inc dl
    cmp dl,si
    jle r1

    call pn
    inc dh
    cmp dh,di
    jle r0

    mov eax,1
    xor ebx,ebx
    int 0x80
