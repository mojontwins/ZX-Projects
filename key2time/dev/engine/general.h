// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

unsigned char addons_between (unsigned char x, unsigned char a, unsigned char b, unsigned char h1, unsigned char h2) {
	return ((a < b ? a : b) <= x + h1 && x <= (a < b ? b : a) + h2);
}

void step (void) {
	#asm
		ld a, 16
		out (254), a
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		nop
		xor 16
		out (254), a
	#endasm
}

void cortina (void) {
	#asm
		ld b, 7
	.fade_out_extern
		push bc

		ld   e, 3               ; 3 tercios
		ld   hl, 22528          ; aquí empiezan los atributos
	#endasm
	#asm
		halt                    ; esperamos retrazo.
	#endasm
	#asm
	.fade_out_bucle
		ld   a, (hl )           ; nos traemos el atributo actual

		ld   d, a               ; tomar atributo
		and  7                  ; aislar la tinta
		jr   z, ink_done        ; si vale 0, no se decrementa
		dec  a                  ; decrementamos tinta
	.ink_done
		ld   b, a               ; en b tenemos ahora la tinta ya procesada.

		ld   a, d               ; tomar atributo
		and  56                 ; aislar el papel, sin modificar su posiciÃ³n en el byte
		jr   z, paper_done      ; si vale 0, no se decrementa
		sub  8                  ; decrementamos papel restando 8
	.paper_done
		ld   c, a               ; en c tenemos ahora el papel ya procesado.
		ld   a, d
		and  192                ; nos quedamos con bits 6 y 7 (BRIGHT y FLASH)
		or   c                  ; añadimos paper
		or   b                  ; e ink, con lo que recompuesto el atributo
		ld   (hl),a             ; lo escribimos,
		inc  l                  ; e incrementamos el puntero.
		jr   nz, fade_out_bucle ; continuamos hasta acabar el tercio (cuando L valga 0)
		inc  h                  ; siguiente tercio
		dec  e
		jr   nz, fade_out_bucle ; repetir las 3 veces
		pop bc
		djnz fade_out_extern
	#endasm
}

signed int addsign (signed int n, signed int value) {
	//if (n >= 0) return value; else return -value;
	return n == 0 ? 0 : n > 0 ? value : -value;
}

unsigned int abs (int n) {
	if (n < 0)
		return (unsigned int) (-n);
	else
		return (unsigned int) n;
}

void hide_sprites (unsigned char which_ones) {
	if (which_ones == 0) {
		//sp_MoveSprAbs (sp_player, spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);
		#asm
				ld  ix, (_sp_player)
				ld  iy, vpClipStruct
				ld  bc, 0
				ld  hl, 0xfefe	// -2, -2
				ld  de, 0

				call SPMoveSprAbs

				ld  ix, (_sp_shadow)
				ld  iy, vpClipStruct
				ld  bc, 0
				ld  hl, 0xfefe	// -2, -2
				ld  de, 0

				call SPMoveSprAbs
		#endasm
	}

	/*
	for (gpit = 0; gpit < 3; gpit ++)
		sp_MoveSprAbs (sp_moviles [gpit], spritesClip, 0, VIEWPORT_Y + 30, VIEWPORT_X + 20, 0, 0);
	*/

	#asm
			xor a
		.hide_sprites_enems_loop
			ld  (_gpit), a

			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _sp_moviles
			add hl, bc
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			push de
			pop ix

			ld  iy, vpClipStruct
			ld  bc, 0
			ld  hl, 0xfefe	// -2, -2
			ld  de, 0

			call SPMoveSprAbs

			ld  a, (_gpit)
			inc a
			cp  3
			jr  nz, hide_sprites_enems_loop

	#endasm
	
	//sp_MoveSprAbs (sp_hitter, spritesClip, 0, -2, -2, 0, 0);
}

void active_sleep (int espera) {
	do {
		#asm
			halt
		#endasm
		if (p_killme == 0 && button_pressed ()) break;
	} while (--espera);
	sp_Border (0);
}

void update_hud (void) {
	if (p_life != life_old) {
		_x = LIFE_X; _y = LIFE_Y; _n = p_life; print_number2 ();
		life_old = p_life;
	}
}
