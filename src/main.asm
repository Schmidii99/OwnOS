org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A




start:
	jmp main


;
;	Prints string to the screen:
;	Params:
;	- 	ds:si points to string
;
puts:
	; save register
	push si
	push ax

.loop:
	lodsb			; loads next character in al
	or al, al 		; very if next character is null?
	jz .done

	mov ah, 0x0e	; call bios interrupt
	mov bh, 0 		; set page number to 0
	int 0x10
	
	jmp .loop

.done:
	pop ax
	pop si
	ret



main:

	; setup data segments
	mov ax, 0     			; can not write to ds/es directly
	mov ds, ax
	mov es, ax

	; setup the stack
	mov ss, ax
	mov sp, 0x7C00

	mov si, msg_hello
	call puts
	
		
	hlt

.halt:
	jmp .halt


msg_hello: db 'Hello World!', ENDL,  0



times 510-($-$$) db 0
dw 0AA55h
