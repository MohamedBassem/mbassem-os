[org 0x7c00]

loop:
	mov ah, 0x0e ; tty mode

	mov al, [the_secret]
	int 0x10

	jmp $ ; Keep printing in an infinite loop

the_secret:
	db 'X'

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
