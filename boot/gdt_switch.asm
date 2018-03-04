[bits 16]

switch_to_pm:
	cli
	lgdt [gdt_descriptor]

	; Now that everything is in place, do the switch!
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	; We are in protected mode!
	jmp CODE_SEG:init_pm

[bits 32]

init_pm:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; Set the stack pointer
	mov ebp, 0x90000
	mov esp, ebp

	jmp start_pm
