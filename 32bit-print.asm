[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Accepts the address of the string to be printed in ebx
print_string_pm:
	pusha

	mov edx, VIDEO_MEMORY ; Points to where we should write next


print_string_pm_loop:
	mov al, [ebx] ; The char to be printed
	mov ah, [WHITE_ON_BLACK]
	cmp eax, 0
	je print_string_pm_end

	mov [edx], ax

	add edx, 2 ; Move the new write place two bytes
	add ebx, 1 ; Move to the next char in the string
	jmp print_string_pm_loop

print_string_pm_end:
	popa
	ret
