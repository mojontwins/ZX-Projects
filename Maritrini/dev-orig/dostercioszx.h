// dostercios zx 
// MARITRINI ENGINE v 1.0

// Buffer de 32x18 del que volcaremos los 30x16 centrales en los dos tercios
// Superiores (centrado)

extern unsigned char dt_buffer [];
extern unsigned char dt_tileset [];
extern unsigned char dt_charcols [];
extern unsigned char dt_mapdata [];

extern unsigned int asm_int [1];
extern unsigned int seed [1];

extern unsigned char cx [];
extern unsigned char cy [];
extern unsigned char offx [];
extern unsigned char offy [];

extern unsigned char sx [];
extern unsigned char sy [];
extern unsigned char sn [];
extern unsigned char sc [];

// I chose funny numbers instead of just zeros to
// initalize the buffers 'cause I like funny noises
// while loading :-)
	
#asm	
	._dt_buffer
		defs 1216, 85				; 32*19*2
	
		defb 0	;; ESTO ALINEA A DIRECCION MULTIPLO DE 8
	._dt_tileset
		defs 2048, 170
	._dt_charcols
		defs 64, 85
		; extended fix
		defs 60, 7
		defb 5, 7, 5, 7
	._dt_mapdata
		defs 2560,1
	._asm_int
		defw 0
	._seed
		defw 7
	._cx
		defb 0
	._cy	
		defb 0		
	._offx
		defb 0
	._offy
		defb 0
		
	._sx
		defb 0
	._sy
		defb 0
	._sn
		defb 0
	._sc
		defb 0
#endasm

unsigned char dt_attr (unsigned char x, unsigned char y) {
	return dt_buffer [1 + x + x + (y << 6)];
}

void dt_putchar (unsigned char x, unsigned char y, unsigned char n, unsigned char c) {
	unsigned int idx = x + x + (y << 6);
	dt_buffer [idx] = n;
	dt_buffer [1 + idx] = c;
}

void draw_sprite (unsigned char x, unsigned char y, unsigned char n, unsigned char c) {
	sx [0] = x;
	sy [0] = y;
	sn [0] = n;
	sc [0] = c;
	#asm
	._mc_draw_sprite
		; 64 * y + x * 2 + dt_buffer
		ld	a, (_sy)
		ld	h, 0
		ld	l, a
		add	hl, hl	; hl = sy * 2
		add hl, hl	; hl = sy * 4
		add	hl, hl	; hl = sy * 8
		add	hl, hl	; hl = sy * 16
		add	hl, hl	; hl = sy * 32
		add hl, hl	; hl = sy * 64
		push hl
		ld	a, (_sx)
		ld	h, 0
		ld	l, a
		add	hl, hl	; hl = sx * 2
		pop	de
		add	hl, de	; hl = sy * 64 + sx * 2
		ld	de, _dt_buffer
		add	hl, de	; hl = dt_buffer + sy * 64 + sx * 2
		ex	de, hl
		ld	a, (_sn)
		add	a, a
		add	a, a
		
		; 4 chars
		
		push de
		ld	(de), a
		inc	de
		inc	de
		inc a
		ld	(de), a
		ex	de, hl
		ld	bc, 62
		add	hl, bc
		ex	de, hl
		inc a
		ld (de), a
		inc de
		inc de
		inc a
		ld (de), a
		pop	de
		
		; 4 attributes
		
		ld	a, (_sc)
		inc	de
		ld (de), a
		inc de
		inc de
		ld (de), a
		ex	de, hl
		ld	bc, 62
		add	hl, bc
		ex	de, hl
		ld (de), a
		inc de
		inc de
		ld (de), a
		
	#endasm
}

void draw_map (unsigned char cam_x, unsigned char cam_y) {
	
	// Precalc map addresses and blit offset
	
	cx [0] = cam_x >> 1;
	cy [0] = cam_y >> 1;
	offx [0] = cam_x & 1;
	offy [0] = cam_y & 1;
	
	// And now, to the action
	
	#asm
	._mc_draw_map
		; First, calculate where to start drawing
		ld	hl, _dt_buffer
		ld	a, (_offx)
		or	a
		jr 	nz, _dm001
		inc	hl
		inc	hl
		
	._dm001
		ld	a, (_offy)
		or	a
		jr	nz, _dm002
		ld	bc, 64
		add	hl, bc
		
	._dm002
		push hl
		
		; Now, calculate where in the map to start
		; _dt_mapdata + 64*cy + cx
		
		ld	a, (_cy)
		ld	h, 0
		ld	l, a
		add	hl, hl		; hl <= cy * 2
		add	hl, hl		; hl <= cy * 4
		add	hl, hl		; hl <= cy * 8
		add	hl, hl		; hl <= cy * 16
		add hl, hl		; hl <= cy * 32
		add	hl, hl		; hl <= cy * 64
		
		ld	a, (_cx)
		ld	d, 0
		ld	e, a
		add	hl, de		; hl <= cy * 64 + cx
		ld	de, _dt_mapdata
		add hl, de
		
		pop	de
		
		; de <- where to draw tiles
		; hl <- tiles to draw
		
		ld	b, 8		; 9 rows of tiles
	._dm_l1
		push bc
		
		ld	b, 16		; 16 cols of tiles
	._dm_l2
		push bc
		
		ld	a, (hl)
		inc	hl
		
		push hl
		push de
		
		add	a, a
		add	a, a
		
		ld	b, 0
		ld	c, a
		ld	hl, _dt_charcols
		add	hl, bc
		
		; First 4 chars:
		ld	(de), a
		inc	de
		inc de
		inc	a
		ld	(de), a
		ex	de, hl
		ld	bc, 62
		add	hl, bc
		ex	de, hl
		inc a
		ld	(de), a
		inc	de
		inc de
		inc	a
		ld	(de), a
		
		; Now 4 attrs:
		pop de
		push de
		
		inc de
		ldi
		inc de
		ldi
		ex	de, hl
		ld	bc, 61
		add	hl, bc
		ex	de, hl
		ldi
		inc de
		ldi 
		
		;
		
		pop de
		pop hl
		
		inc de
		inc	de
		inc	de
		inc	de
		
		pop bc
		djnz _dm_l2
		
		ld	bc, 48
		add	hl, bc
		ld	bc, 64
		ex	de, hl
		add	hl, bc
		ex	de, hl
		
		pop	bc
		djnz _dm_l1	
	#endasm
}

void blit_buffer () {
	// Copia todo el buffer a SCREEN$. 
	
	#asm
		;;
		ld		hl, _dt_buffer + 66		; Inicio del buffer, Empezamos en (1, 1)
		
		;; PRIMER TERCIO
		
		ld 		de, $4021
		;call	_blit_buffer_process_1	; Copiamos 30 caracteres
		;ld		bc, 4
		;add	hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		
		;; SEGUNDO TERCIO
		
		ld		de, $4801
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		ld		bc, 4
		add		hl, bc					; Siguiente linea
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		
		ret
		
	;; Copia 32 chars del buffer (HL->BUFFER) a SCREEN$

	._blit_buffer_process_1
		ld		b, 30		; 30 carácteres	
	._blit_buffer_l1
		ld		a, (hl)
		push 	bc
		push	hl
		
		;; Calcular HL apuntando al carácter actual
		;; DE apuntando al carácter actual en pantalla
		
		ld		h, 0
		ld		l, a					; HL <- n
		add		hl, hl					; HL = n * 2
		add		hl, hl					; HL = n * 4
		add		hl, hl					; HL = n * 8
		ld		bc, _dt_tileset			
		add		hl, bc					; HL = _dt_tileset + n * 8
		
		call	_docopy
		
		pop		hl
		pop		bc
		inc 	hl
		
		ld		a, (hl)					; atributo!
		push	de
		dec		e						;
		ld		d, $58					; Este "truco" es la hostia para pasar de bitmap a atributos
		ld		(de), a
		pop		de
		
		inc		hl
		djnz	_blit_buffer_l1			
		inc 	de
		inc		de
		ret
		
	._blit_buffer_process_2
		ld		b, 30		; 32 carácteres	
	._blit_buffer_l2
		ld		a, (hl)
		push 	bc
		push	hl
		
		;; Calcular HL apuntando al carácter actual
		;; DE apuntando al carácter actual en pantalla
		
		ld		h, 0
		ld		l, a					; HL <- n
		add		hl, hl					; HL = n * 2
		add		hl, hl					; HL = n * 4
		add		hl, hl					; HL = n * 8
		ld		bc, _dt_tileset			
		add		hl, bc					; HL = _dt_tileset + n * 8
		
		call	_docopy
		
		pop		hl
		pop		bc
		inc 	hl
		
		ld		a, (hl)					; atributo!
		push	de
		dec		e
		ld		d, $59
		ld		(de), a
		pop		de
		
		inc		hl
		djnz	_blit_buffer_l2
		inc 	de
		inc		de	
		ret
		
	._docopy
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		inc		d
		ld		a, (hl)
		ld		(de), a
		inc 	l
		ld		a, d
		sub 	7
		ld		d, a
		inc		e
		
		ret
#endasm
}

void srand (unsigned int new_seed) {
	seed [0] = new_seed;	
}

unsigned char rand () {
	unsigned char res;
	
	#asm
		.rand16
			ld	hl, _seed
			ld	a, (hl)
			ld	e, a
			inc	hl
			ld	a, (hl)
			ld	d, a
			
			;; Ahora DE = [SEED]
						
			ld	a,	d
			ld	h,	e
			ld	l,	253
			or	a
			sbc	hl,	de
			sbc	a, 	0
			sbc	hl,	de
			ld	d, 	0
			sbc	a, 	d
			ld	e,	a
			sbc	hl,	de
			jr	nc,	nextrand
			inc	hl
		.nextrand
			ld	d,	h
			ld	e,	l
			ld	hl, _seed
			ld	a,	e
			ld	(hl), a
			inc	hl
			ld	a,	d
			ld	(hl), a
			
			;; Ahora [SEED] = HL
		
			ld 	hl, _asm_int
			ld	a,	e	
			ld	(hl), a
			inc	hl
			ld	a,	d
			ld	(hl), a
			
			;; Ahora [ASM_INT] = HL
	#endasm
	
	res = asm_int [0];

	return res;
}
