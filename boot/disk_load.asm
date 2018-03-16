disk_load:
	push dx
	
	mov ah, 0x02
	mov al, dh   ; Read DH sectors
	mov ch, 0x00 ; cylinder 0
	mov dh, 0x00 ; head 0
	mov cl, 0x02 ; Starting from sector 2. We already have the first sector in memory (the boot sector).


	int 0x13

	jc disk_error

	pop dx
	cmp dh, al
	jne sector_read_error
	ret

disk_error:
	mov bx, DISK_ERROR_MESSAGE
	call print
	call print_new_line
	jmp $

sector_read_error:
	mov bx, SECTOR_ERROR_MESSAGE
	call print
	call print_new_line
	jmp $

DISK_ERROR_MESSAGE db "Disk read error", 0
SECTOR_ERROR_MESSAGE db "Sector read error", 0
