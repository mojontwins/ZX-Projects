// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Printing functions

void draw_coloured_tile (void) {	
	#asm	
			// Calculate address in the display list

			ld  a, (__x)
			ld  c, a
			ld  a, (__y)
			call SPCompDListAddr
			ex de, hl

			// Now write 4 attributes and 4 chars.

			// Make a pointer to the metatile colour array	
			ld  a, (__t)
			sla a
			sla a 				// A = _t * 4
	
			ld  hl, _metatile_attrs
			ld  b, 0
			ld  c, a
			add hl, bc 			// HL = metatile_attrs + _taux

			add 64 				// A = _t * 4 + 64
			ld  c, a 			// C = current pattern #

			// For each char: write colour, inc DE, write tile, inc DE*3
			
			ld  a, (hl) 		// read colour			
			ld  (de), a 		// write colour
			inc de
			inc hl 				// next colour

			ld  a, c  			// read tile
			ld  (de), a			// write tile
			inc de
			inc a 				// next tile
			ld  c, a 

			inc de
			inc de 				// next DisplayList cell

			ld  a, (hl) 		// read colour			
			ld  (de), a 		// write colour
			inc de
			inc hl 				// next colour

			ld  a, c  			// read tile
			ld  (de), a			// write tile
			inc a 				// next tile
			
			ex  de, hl
			ld  bc, 123
			add hl, bc
			ex  de, hl			// next DisplayList cell
			ld  c, a 

			ld  a, (hl) 		// read colour			
			ld  (de), a 		// write colour
			inc de
			inc hl 				// next colour

			ld  a, c  			// read tile
			ld  (de), a			// write tile
			inc de
			inc a 				// next tile
			ld  c, a 

			inc de
			inc de 				// next DisplayList cell

			ld  a, (hl) 		// read colour			
			ld  (de), a 		// write colour
			inc de

			ld  a, c  			// read tile
			ld  (de), a			// write tile
	#endasm
}

void invalidate_tile (void) {
	#asm
			; Invalidate Rectangle
			;
			; enter:  B = row coord top left corner
			;         C = col coord top left corner
			;         D = row coord bottom right corner
			;         E = col coord bottom right corner
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen

			ld  a, (__x)
			inc a
			ld  e, a
			ld  a, (__y)
			inc a
			ld  d, a
			ld  a, (__x)
			ld  c, a
			ld  a, (__y)
			ld  iy, vpClipStruct
			call SPInvalidate
			
	#endasm
}

void invalidate_viewport (void) {
	#asm
			; Invalidate Rectangle
			;
			; enter:  B = row coord top left corner
			;         C = col coord top left corner
			;         D = row coord bottom right corner
			;         E = col coord bottom right corner
			;        IY = clipping rectangle, set it to "ClipStruct" for full screen

			ld  b, VIEWPORT_Y
			ld  c, VIEWPORT_X
			ld  d, VIEWPORT_Y+19
			ld  e, VIEWPORT_X+29
			ld  iy, vpClipStruct
			call SPInvalidate
	#endasm
}

void print_number2 (void) {
	rda = 16 + (_t / 10); rdb = 16 + (_t % 10);
	#asm
			; enter:  A = row position (0..23)
			;         C = col position (0..31/63)
			;         D = pallette #
			;         E = graphic #

			ld  a, (_rda)
			ld  e, a

			ld  d, 7
			
			ld  a, (__x)
			ld  c, a

			ld  a, (__y)

			call SPPrintAtInv

			ld  a, (_rdb)
			ld  e, a

			ld  d, 7
			
			ld  a, (__x)
			inc a
			ld  c, a

			ld  a, (__y)

			call SPPrintAtInv
	#endasm
}

void draw_objs () {
	_x = OBJECTS_X; _y = OBJECTS_Y; _t = p_objs; print_number2 ();
}

void print_str (void) {
	#asm
		.print_str_loop
			ld  hl, (_gp_gen)
			ld  a, (hl)
			or  a

			ret z 

			inc hl
			ld  (_gp_gen), hl

			sub 32
			ld  e, a

			ld  a, (__t)
			ld  d, a

			ld  hl, __x
			ld  c, (hl)
			inc (hl)

			ld  a, (__y)

			call SPPrintAtInv

			jr  print_str_loop
	#endasm
}

void cortina (void) {
	#asm
			;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
			;; para que no queden artefactos feos
			
			ld	de, 22528			; Apuntamos con DE a la zona de atributos
			ld	b,	3				; Procesamos 3 tercios
		.clearb1
			push bc
			
			ld	b, 0				; Procesamos los 256 atributos de cada tercio
		.clearb2
		
			ld	a, (de)				; Nos traemos un atributo
			and	199					; Le hacemos la máscara 11000111 y dejamos PAPER a 0
			ld	(de), a				; Y lo volvemos a poner
			
			inc de					; Siguiente atributo
		
			djnz clearb2
			
			pop bc
			djnz clearb1
			
			;; Y ahora el código original que escribí para UWOL:	
		
			ld	a,	8
		
		.repitatodo
			ld	c,	a			; Salvamos el contador de "repitatodo" en 'c'
		
			ld	hl, 16384
			ld	a,	12
		
		.bucle
			ld	b,	a			; Salvamos el contador de "bucle" en 'b'
			ld	a,	0
		
		.bucle1
			sla (hl)
			inc hl
			dec a
			jr	nz, bucle1
				
			ld	a,	0
		.bucle2
			srl (hl)
			inc hl
			dec a
			jr	nz, bucle2
				
			ld	a,	b			; Restituimos el contador de "bucle" a 'a'
			dec a
			jr	nz, bucle
		
			ld	a,	c			; Restituimos el contador de "repitatodo" a 'a'
			dec a
			jr	nz, repitatodo
	#endasm
}
