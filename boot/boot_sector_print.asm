print:
	pusha
	
print_loop_body:
	mov al, [bx]
	cmp al, 0
	je print_done ; If we read a 0, exit loop

	; Print the current char
	mov ah, 0x0e
	int 0x10

	; Increment the counter
	add bx, 1

	; loop
	jmp print_loop_body

print_done:
	popa
	ret


print_new_line:
	pusha

	mov ah, 0x0e ; tty mode
	mov al, 0x0A ; New line
	int 0x10
	mov al, 0x0D ; Carriage return
	int 0x10

	popa
	ret
