/*
for (gpit = 0; gpit < 3; ++ gpit) {
	enoffsmasi = enoffs + gpit;
	gpen_x = baddies [enoffsmasi].x;
	gpen_y = baddies [enoffsmasi].y;

	if ((baddies [enoffsmasi].t & 0x78) == 8) gpen_y -= PIXEL_SHIFT;
	
	sp_MoveSprAbs (
		sp_moviles [gpit], 
		spritesClip, 
		en_an_n_f [gpit] - en_an_c_f [gpit], 
		VIEWPORT_Y + (gpen_y >> 3), VIEWPORT_X + (gpen_x >> 3),
		gpen_x & 7, gpen_y & 7
	);
	
	en_an_c_f [gpit] = en_an_n_f [gpit];
}
*/

#asm
		xor a
	.update_sprites_baddies_loop
		ld  (_gpit), a

		ld  c, a
		ld  a, (_enoffs)
		add c
		ld  (_enoffsmasi), a

		// Get a pointer to baddies [enoffsmasi].
		// The struct is 10 bytes long. 
		// We can keep the multiplications 8-bit as long as possible

		sla a 					// Max 94  (x2)
		ld  b, a 				// B = A*2
		sla a 					// Max 188 (x4)
		ld  l, a
		ld  h, 0
		add hl, hl 				// HL = x8
		
		ld  e, b 
		ld  d, 0                // DE = x2
		add hl, de 				// HL = x10

		ld  de, _baddies
		add hl, de

		// HL points to baddies [enoffsmasi]. x and y are the two first bytes
		// x, y, x1, y1, x2, y2, mx, my, t, life

		ld  a, (hl)
		ld  (_gpen_x), a
		inc hl

		ld  a, (hl)
		ld  (_gpen_y), a
		
		// Remove pixel shift for type 8s
		// HL points now to y, add 7 to get t:
		ld  bc, 7
		add hl, bc
		ld  a, (hl) 			// A = baddies [enoffsmasi].t
		and $78
		cp  8
		jr  nz, update_sprites_baddies_pixel_shift

		ld  a, (_gpen_y)
		sub PIXEL_SHIFT
		ld  (_gpen_y), a

	.update_sprites_baddies_pixel_shift

		; enter: IX = sprite structure address 
		;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
		;        BC = animate bitdef displacement (0 for no animation) 
		;         H = new row coord in chars 
		;         L = new col coord in chars 
		;         D = new horizontal rotation (0..7) ie horizontal pixel position 
		;         E = new vertical rotation (0..7) ie vertical pixel position 
		ld  a, (_gpit)
		sla a
		ld  c, a
		ld  b, 0 				// BC = offset to [gpit] in 16bit arrays
		ld  hl, _sp_moviles
		add hl, bc
		ld  e, (hl)
		inc hl 
		ld  d, (hl)
		push de						
		pop ix
		ld  iy, vpClipStruct

		// en_an_n_f [gpit] - en_an_c_f [gpit], 
		ld  hl, _en_an_c_f
		add hl, bc 				// HL -> en_an_c_f [gpit]
		ld  e, (hl)
		inc hl 
		ld  d, (hl) 			// DE = en_an_c_f [gpit]

		ld  hl, _en_an_n_f
		add hl, bc 				// HL -> en_an_n_f [gpit]
		ld  a, (hl)
		inc hl
		ld  h, (hl)
		ld  l, a 				// HL = en_an_n_f [gpit]

		or  a 					// clear carry
		sbc hl, de 				// en_an_n_f [gpit] - en_an_c_f [gpit]

		push bc 				// Save index

		ld  b, h
		ld  c, l 				// ** BC = animate bitdef **

		ld  a, (_gpen_y)					
		srl a
		srl a
		srl a
		add VIEWPORT_Y
		ld h, a

		ld  a, (_gpen_x)
		srl a
		srl a
		srl a
		add VIEWPORT_X
		ld  l, a

		ld  a, (_gpen_x)
		and 7
		ld  d, a

		ld  a, (_gpen_y)
		and 7
		ld  e, a

		call SPMoveSprAbs

		// en_an_c_f [gpit] = en_an_n_f [gpit];

		pop bc 					// Retrieve index

		ld  hl, _en_an_c_f
		add hl, bc
		ex  de, hl 				// DE -> en_an_n_f [gpit]	

		ld  hl, _en_an_n_f
		add hl, bc 				// HL -> en_an_n_f [gpit]
		
		ldi
		ldi

		// Continue

		ld  a, (_gpit)
		inc a
		cp  3
		jp  nz, update_sprites_baddies_loop

	
		/*
		if (0 == p_killme && ( !(p_state & EST_PARP) || half_life == 0) ) {
			rdz = pry - ((-p_z) >> FIXBITS);
		*/
		ld  a, (_p_killme)
		jp  nz, update_sprites_player_else

		ld  a, (_p_state)
		and EST_PARP
		jr  z, update_sprites_player

		ld  a, (_half_life)
		or  a
		jp  nz, update_sprites_player_else

	.update_sprites_player

		ld  a, (_prx)
		ld  (_rdx), a
		ld  a, (_pry)
		ld  (_rdy), a

		ld  de, (_p_z)
		xor a
		sub e 
		ld  e, a
		sbc a, a
		sub d
		ld  d, a 				// DE = -p_z
		ld  l, 4
		call l_asr 				// HL = ((-p_z) >> FIXBITS)
		ld  c, l 				// Will fit
		ld  a, (_rdy)
		sub c
		ld  (_rdz), a

		jp update_sprites_player_do

	.update_sprites_player_else

		ld  a, -16
		ld  (_rdx), a
		ld  (_rdy), a
		ld  (_rdz), a

	.update_sprites_player_do

		/*
		sp_MoveSprAbs (
			sp_shadow, 
			spritesClip, 
			0, 
			VIEWPORT_Y + (pry >> 3) + 1, VIEWPORT_X + (prx >> 3), 
			prx & 7, pry & 7
		);
		*/

		; enter: IX = sprite structure address 
		;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
		;        BC = animate bitdef displacement (0 for no animation) 
		;         H = new row coord in chars 
		;         L = new col coord in chars 
		;         D = new horizontal rotation (0..7) ie horizontal pixel position 
		;         E = new vertical rotation (0..7) ie vertical pixel position 
		
		ld  ix, (_sp_shadow)
		ld  iy, vpClipStruct
		ld  bc, 0

		ld  a, (_rdy)					
		srl a
		srl a
		srl a
		add VIEWPORT_Y
		inc a
		ld h, a

		ld  a, (_rdx)
		srl a
		srl a
		srl a
		add VIEWPORT_X
		ld  l, a

		ld  a, (_rdx)
		and 7
		ld  d, a

		ld  a, (_rdy)
		and 7
		ld  e, a

		call SPMoveSprAbs

		/*
		sp_MoveSprAbs (
			sp_player, 
			spritesClip, 
			p_n_f - p_c_f, 
			VIEWPORT_Y + (rdz >> 3), VIEWPORT_X + (prx >> 3), 
			prx & 7, rdz & 7
		);
		*/

		; enter: IX = sprite structure address 
		;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
		;        BC = animate bitdef displacement (0 for no animation) 
		;         H = new row coord in chars 
		;         L = new col coord in chars 
		;         D = new horizontal rotation (0..7) ie horizontal pixel position 
		;         E = new vertical rotation (0..7) ie vertical pixel position 
		
		ld  ix, (_sp_player)
		ld  iy, vpClipStruct
		
		ld  hl, (_p_n_f)
		ld  de, (_p_c_f)
		or  a
		sbc hl, de
		ld  b, h
		ld  c, l

		ld  a, (_rdz)
		srl a
		srl a
		srl a
		add VIEWPORT_Y
		ld h, a

		ld  a, (_prx)
		srl a
		srl a
		srl a
		add VIEWPORT_X
		ld  l, a

		ld  a, (_prx)
		and 7
		ld  d, a

		ld  a, (_rdz)
		and 7
		ld  e, a

		call SPMoveSprAbs		
	
		// p_c_f = p_n_f;
		ld  hl, (_p_n_f)
		ld  (_p_c_f), hl

#endasm

/*
if (hitter_on) {
	sp_MoveSprAbs (sp_hitter, spritesClip,
		hitter_n_f - hitter_c_f,
		VIEWPORT_Y + (hitter_y >> 3), VIEWPORT_X + (hitter_x >> 3),
		hitter_x & 7, hitter_y & 7);
		hitter_c_f = hitter_n_f;
} else {
	sp_MoveSprAbs (sp_hitter, spritesClip, 0, -2, -2, 0, 0);
}
*/
