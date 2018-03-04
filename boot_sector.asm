[org 0x7c00]

main:

	mov bp, 0x9000
	mov sp, bp

	mov bx, REAL_MODE_MESSAGE
	call print
	call print_new_line

	call switch_to_pm ; This will never return


%include "boot/boot_sector_print.asm"
%include "boot/boot_sector_print_hex.asm"
%include "boot/32bit-print.asm"
%include "boot/gdt_descriptor.asm"
%include "boot/gdt_switch.asm"


[bits 32]
start_pm:
	mov ebx, PM_MODE_MESSAGE
	call print_string_pm
	jmp $


REAL_MODE_MESSAGE:
	db 'We are now in Real Mode', 0

PM_MODE_MESSAGE
	db 'We are now in Protected Mode', 0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55
