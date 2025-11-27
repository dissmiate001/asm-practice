section .text
global sort

sort:
    mov bp,cx
    mov ax,bx

c0:
    cmp bp,0
    je c1
    mov dl,[si]
    mov [di],dl
    inc si
    inc di
    dec bp
    jmp c0
c1:

    mov dx,cx

o1:
    cmp dx,1
    jbe end
    mov si,di
    mov bx,dx
    sub bx,1

i1:
    cmp bx,0
    je n1
    mov al,[si]
    mov ah,[si+1]
    cmp al,ah
    jbe s1

    mov [si],ah
    mov [si+1],al

s1:
    inc si
    dec bx
    jmp i1

n1:
    dec dx
    jmp o1

end:
    ret
