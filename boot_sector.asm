[org 0x7c00]

main:
	mov bx, HELLO
	call print
	call print_new_line
	mov bx, BASSEM
	call print
	call print_new_line
	jmp $

%include "boot_sector_print.asm"

HELLO:
	db 'Hello', 0

BASSEM:
	db 'BASSEM', 0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
