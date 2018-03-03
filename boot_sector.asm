[org 0x7c00]


mov ah, 0x0e ; tty mode


mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10


pop bx
mov al, bl
int 0x10


pop bx
mov al, bl
int 0x10

jmp $ ; Keep printing in an infinite loop


; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
