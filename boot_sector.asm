[org 0x7c00]

main:
	mov bx, HELLO
	call print
	call print_new_line

	mov dx, 0x12ef
	call print_hex
	jmp $

%include "boot_sector_print.asm"
%include "boot_sector_print_hex.asm"

HELLO:
	db 'Hello', 0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
