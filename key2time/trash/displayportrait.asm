org 32768

		ld hl, portraits
		ld de, 18465
		
		ld b, 8
ptpl1:	ld c, b
	
		push de

		ld b, 6
ptpl2:
		push bc

		; Inner loop.
		; Copy 4 bytes
		ldi
		ldi
		ldi
		ldi
		
		; Next char line
		ex de, hl		
		ld bc, 28
		add hl, bc
		ex de, hl

		pop bc

		djnz ptpl2

		; Next pixel line
		pop de
		inc d

		ld b, c
		djnz ptpl1

		; Paint white
		ld 		a, 71
		ld 		b, 6
		ld 		hl, 22817

	ptpl3:
		ld 		(hl), a
		inc 	l
		ld 		(hl), a
		inc 	l
		ld 		(hl), a
		inc 	l
		ld 		(hl), a
		ld 		d, b
		ld 		bc, 29
		add 	hl, bc
		ld 		b, d
		djnz ptpl3

		ret
		
portraits:
		incbin "output.bin" 
		

