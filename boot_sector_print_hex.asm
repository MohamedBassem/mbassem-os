; Assuming that we get the data in dx

print_hex:
	pusha
	mov cx, 0

print_hex_loop:
	cmp cx, 4
	je print_hex_done
	
	mov ax, dx
	and ax, 0x000f
	add ax, 0x30
	cmp ax, 0x39
	jle print_hex_step_2 ; Add another 0x11 if it's not a number
	add ax, 7

print_hex_step_2:
	mov bx, HEX_OUT + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4

	add cx, 1
	jmp print_hex_loop

print_hex_done:

	mov bx, HEX_OUT
	call print

	popa
	ret

HEX_OUT:
	db '0x0000', 0
