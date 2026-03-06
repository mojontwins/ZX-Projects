// dostercios zx 
// MARITRINI ENGINE v 1.0

// Buffer de 32x18 del que volcaremos los 30x16 centrales en los dos tercios
// Superiores (centrado)

extern unsigned int asm_int [1];
extern unsigned int seed [1];

unsigned char sx;
unsigned char sy;
unsigned char sn;
unsigned char sc;

// I chose funny numbers instead of just zeros to
// initalize the buffers 'cause I like funny noises
// while loading :-)

unsigned char cx, cy, offx, offy;
	
#asm	
	._asm_int
		defw 0
	._seed
		defw 7
#endasm
unsigned char ttest;
/*
unsigned char dt_attr (unsigned char x, unsigned char y) {
	//return dt_buffer [1 + x + x + (y << 6)];
	return *((unsigned char *) (DT_BUFFER + 1 + (x << 1) + (y << 6)));
}
*/

unsigned char dt_attr (void) {
	//return (*((unsigned char *) (DT_BUFFER + 1 + (_x << 1) + (_y << 6)))) & 64 ? 0 : 1;
	#asm
			ld  a, (__y)
			ld  l, 0
			ld  h, a
			srl h
			rr  l
			srl h
			rr  l

			ld  a, (__x)
			sla a
			ld  d, 0
			ld  e, a

			add hl, de 

			ld  de, DT_BUFFER
			add hl, de 
			inc hl

			ld  a, (hl)
			ld  hl, 0
			and 64
			ret nz

			inc hl
			ret
	#endasm	
}

/*
void dt_putchar (unsigned char x, unsigned char y, unsigned char n, unsigned char c) {
	unsigned int idx = x + x + (y << 6);
	dt_buffer [idx] = n;
	dt_buffer [1 + idx] = c;
}
*/
// Removed parameters
void dt_putchar (void) {
	// idx = (_x << 1) + (_y << 6);
	// dt_buffer [idx] = n;
	// dt_buffer [1 + idx] = c;
	#asm
		ld  a, (__y)
		ld  d, 0
		ld  e, a
		ld  hl, 6
		call	l_asl
		ld  a, (__x)
		sla a
		ld  d, 0
		ld  e, a
		add hl, de
		ld  de, DT_BUFFER
		add hl, de
		ld  a, (__n)
		ld  (hl), a
		ld  a, (__c)
		inc hl
		ld  (hl), a
	#endasm
}

// Undid parameters, now preset sx, sy, sn, sc & call
void draw_sprite (void) {
	#asm
	._mc_draw_sprite
		; 64 * y + x * 2 + dt_buffer
		ld	a, (_sy)

		/*
		ld	h, 0
		ld	l, a
		add	hl, hl	; hl = sy * 2
		add hl, hl	; hl = sy * 4
		add	hl, hl	; hl = sy * 8
		add	hl, hl	; hl = sy * 16
		add	hl, hl	; hl = sy * 32
		add hl, hl	; hl = sy * 64
		*/

		// Fast HL = A << 6
		ld  l, 0
		ld  h, a
		srl h
		rr  l
		srl h
		rr  l

		push hl
		ld	a, (_sx)
		ld	h, 0
		ld	l, a
		add	hl, hl	; hl = sx * 2
		pop	de
		add	hl, de	; hl = sy * 64 + sx * 2
		ld	de, DT_BUFFER
		add	hl, de	; hl = dt_buffer + sy * 64 + sx * 2

		ld  a, (_sc)
		ld  d, a 	; D = sc
		ld	a, (_sn)
		sla a
		sla a 		; A = sn*4
		
		; 4 x (char, attribute)
		
		ld	(hl), a
		inc	hl
		inc a
		ld  (hl), d
		inc	hl
		ld	(hl), a
		inc hl
		inc a
		ld  (hl), d
		
		ld	bc, 61
		add	hl, bc

		ld (hl), a
		inc hl
		inc a
		ld (hl), d
		inc hl
		ld (hl), a
		inc hl
		ld  (hl), d
	#endasm
}

void draw_map (unsigned char cam_x, unsigned char cam_y) {
	
	// Precalc map addresses and blit offset
	
	/*
	cx [0] = cam_x >> 1;
	cy [0] = cam_y >> 1;
	*/

	// If cam_x is EVEN, draws 1 column to the right.
	// If cam_x is ODD,  draws at the leftmost edge.

	// If cam_y is EVEN, draws 1 row down
	// If cam_y is ODD, draws at the topmost edge. <- and this crashes.

	/*
	offx [0] = (cam_x & 1) ? 0 : 2;
	offy [0] = (cam_y & 1) ? 0 : 64;
	*/
	
	// And now, to the action
	
	#asm
		ld  a, (_cam_x)
		ld  b, a
		srl a
		ld  (_cx), a
	
		ld  a, b
		and 1
		jr  z, offx_even
	.offx_odd
		xor a
		jr  offx_set
	.offx_even
		ld  a, 2
	.offx_set
		ld  (_offx), a

		ld  a, (_cam_y)
		ld  b, a
		srl a
		ld  (_cy), a

		ld  a, b
		and 1
		jr  z, offy_even
	.offy_odd
		xor a
		jr  offy_set
	.offy_even
		ld  a, 64
	.offy_set
		ld  (_offy), a

	._mc_draw_map
		; First, calculate where to start drawing
		ld	hl, DT_BUFFER
		
		// New
		ld  bc, (_offx)
		ld  b, 0
		add hl, bc
		ld  bc, (_offy)
		ld  b, 0
		add hl, bc

		// 

		push hl
		
		; Now, calculate where in the map to start
		; DT_MAPDATA + 64*cy + cx
		
		ld	a, (_cy)

		/*
		ld	h, 0
		ld	l, a
		add	hl, hl		; hl <= cy * 2
		add	hl, hl		; hl <= cy * 4
		add	hl, hl		; hl <= cy * 8
		add	hl, hl		; hl <= cy * 16
		add hl, hl		; hl <= cy * 32
		add	hl, hl		; hl <= cy * 64
		*/

		// Fast HL = A << 6
		ld  l, 0
		ld  h, a
		srl h
		rr  l
		srl h
		rr  l
		
		ld	a, (_cx)
		ld	d, 0
		ld	e, a
		add	hl, de		; hl <= cy * 64 + cx
		ld	de, DT_MAPDATA
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
		
		sla	a
		sla a
		
		ld	b, 0
		ld	c, a
		ld	hl, DT_TILESET + 2048
		add	hl, bc
		
		ex de, hl
		; 4x(char,attrs)
		; HL -> BUFFER
		; DE -> ATTRIBUTES
		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a
		inc hl

		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a

		ld  a, c
		ld  bc, 61
		add hl, bc
		ld  c, a

		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a
		inc hl

		ld  (hl), c
		inc hl
		ld  a, (de)
		ld  (hl), a

		;;
		
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
	.flisflolin		
	#endasm
}

void blit_buffer () {
	// Copia todo el buffer a SCREEN$. 

	#asm
	
		// First use vpage to view screen 5/7 and paint on 7/5, then flip.
		// Page register:
		// 76543210
		// 0001sppp

		// s = 0, ppp = 7 (111) 	(view 5, paint 7)  00010111 (23)
		// s = 1, ppp = 5 (101) 	(view 7, paint 5)  00011101 (29)

		di
		ld  a, (_pregister)
		
		ld	BC, $7FFD
		out (C), A
				
		ld  d, a
		and 7
		ld  (_ram_page_act), a
		ld  a, d		
		and 8
		ld  (_video_page), a
		ei

		;;
		ld		hl, DT_BUFFER + 66		; Inicio del buffer, Empezamos en (1, 1)
		
		;; PRIMER TERCIO
		
		;ld 		de, $4021
		ld 		de, $C021

		;call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		
		;; SEGUNDO TERCIO
		
		;ld		de, $4801
		ld		de, $C801

		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres

		;; ATRIBUTOS

		ld		hl, DT_BUFFER + 67		; Inicio del buffer, atributos. Empezamos en (1, 1)
		
		ld 		de, $D800 + 33 			; Skip 1 line, 1 column

		;call	_blit_attrs				; Copiamos 30 caracteres
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		
		ld  a, (_pregister)
		xor 10 							// 00001010, flips bits 3 and 1
		ld  (_pregister), a
		ld  b, a
		
		halt
		di
		and 8
		ld  (_video_page), a
		xor a
		ld  (_ram_page_act), a
		
	.finally_set_ram0
		ld  a, b
		and 0xf8						// 00011xxx -> 00011000
		ld	BC, $7FFD
		out (C), A
		ei

		ret
	
	;; Copia 30 atributos de buffer (HL->BUFFER) a SCREEN$

	._blit_attrs

		ldi 
		inc hl 

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl
	;
		ldi 
		inc hl

		ldi 
		inc hl 

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl
	;
		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl 

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl

		ldi 
		inc hl
	;

	; Siguiente linea

		inc de
		inc de

		ld		bc, 4
		add		hl, bc					
		
		ret		

	;; Copia 30 chars del buffer (HL->BUFFER) a SCREEN$

	._blit_buffer_process_1
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
			
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
	
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl

		inc 	hl
		
		; Siguiente linea
		
		inc 	de
		inc		de
		ld 		bc, 4
		add 	hl, bc

		ret

	._blit_buffer_process_2
		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Char
		ld 		b, DT_TILESET / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl

		; Siguiente linea
		
		inc 	de
		inc		de
		ld 		bc, 4
		add 	hl, bc

		ret
		
	._docopy
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
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
