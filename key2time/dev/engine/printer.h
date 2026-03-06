// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// printer.h
// Printing functions

#define MESSAGE_COLOUR 79
unsigned char *spacer = "            ";

void print_number2 (void) {
	sp_PrintAtInv (_y, _x, 7, 16 + (_n / 10));
	sp_PrintAtInv (_y, _x + 1, 7, 16 + (_n % 10));
}

void draw_coloured_tile (void) {	
	_n = 64 + (_t << 2);
	gen_pt = tileset + 2048 + _n;
	sp_PrintAtInv (_y    , _x    , *gen_pt, _n); ++ gen_pt; ++ _n;
	sp_PrintAtInv (_y    , _x + 1, *gen_pt, _n); ++ gen_pt; ++ _n;
	sp_PrintAtInv (_y + 1, _x    , *gen_pt, _n); ++ gen_pt; ++ _n;
	sp_PrintAtInv (_y + 1, _x + 1, *gen_pt, _n);
}

void draw_coloured_tile_gamearea (void) {
	_x = VIEWPORT_X + (_x << 1); _y = VIEWPORT_Y + (_y << 1);
	draw_coloured_tile ();
}

void print_str (unsigned char *s) {
	while (*s) sp_PrintAtInv (_y, _x ++, _t, (*s ++) - 32);
}

void blackout_area (void) {
	// blackens gameplay area for LEVEL XX display
	asm_int [0] = 22528 + 32 * VIEWPORT_Y + VIEWPORT_X;
	#asm
		ld	hl, _asm_int
		ld	a, (hl)
		ld	e, a
		inc	hl
		ld	a, (hl)
		ld	d, a

		ld b, 20
	.bal1
		push bc
		push de
		pop hl
		ld	(hl), 0
		inc de
		ld bc, 29
		ldir
		inc de
		inc de
		pop bc
		djnz bal1
	#endasm
}

unsigned char utaux = 0;
void update_tile (void) {
	//utaux = (_y << 4) - _y + _x;
	utaux = (_y << 4) | _x;
	map_attr [utaux] = _n;
	map_buff [utaux] = _t;
	draw_coloured_tile_gamearea ();
}

void print_message (unsigned char *s) {
	_t = MESSAGE_COLOUR; 
	_x = 10; _y = 11; print_str (spacer);
	_x = 10; _y = 12; print_str (s);
	_x = 10; _y = 13; print_str (spacer);
	sp_UpdateNow ();
	sp_WaitForNoKey ();
}

unsigned char button_pressed (void) {
	return (sp_GetKey () || ((((joyfunc) (&keys)) & sp_FIRE) == 0));
}

// Subtileset loader
unsigned char load_subtileset (void) {
	// Get offsets
	offs_attr = read_offset (_t, 0);
	offs_behs = read_offset (_t, 2);

	// Unpack patterns
	unpack_RAMn (resources [_t].ramPage, resources [_t].ramOffset + 4, (unsigned int) (tileset + (_n << 9) + 512));
	// Unpack attributes
	unpack_RAMn (resources [_t].ramPage, resources [_t].ramOffset + offs_attr, (unsigned int) (tileset + (_n << 6) + 2112));
	// Unpack behs
	unpack_RAMn (resources [_t].ramPage, resources [_t].ramOffset + offs_behs, (unsigned int) (behs + (_n << 4)));
}

void print_digitH (unsigned char x, unsigned char y, unsigned char d) {
	if (d < 10) sp_PrintAtInv (y, x, 7, d+16);
	else        sp_PrintAtInv (y, x, 7, d+23);
}

void print_numberH (unsigned char x, unsigned char y, unsigned char n) {
	print_digitH (x, y, n >> 4);
	print_digitH (x + 1, y, n & 15);
}

void draw_scr_background (void) {
	#asm
		ld	hl, (_n_pant)
		ld  h, 0
		ld	(rnd + 1),hl
		ld	hl, (_level)
		ld  h, 0
		ld	(rnd + 4),hl
	#endasm
	
	map_pointer = map + (n_pant << 6) + (n_pant << 3) + (n_pant << 1) + (n_pant);
	gpit = rdx = rdy = 0;

	// Draw 150 tiles
	/*
	do {
		gpjt = rand () & 15;

		if (gpit & 1) {
			_t = rdc & 15;
		} else {
			rdc = *map_pointer ++;
			_t = rdc >> 4;
		}

		map_attr [gpit] = behs [_t];
		map_buff [gpit] = _t;
		_x = rdx; _y = rdy;
		draw_coloured_tile_gamearea ();

		++ rdx; if (rdx == 15) { rdx = 0; ++ rdy; }
	} while (++ gpit < 150);
	*/
	
	#asm
			xor a
			ld  (_rdx), a
			ld  (_rdy), a
			ld  (_gpjt), a
			
		.draw_scr_background_loop
			ld  (_gpit), a

			ld  c, a

			ld  a, (_gpjt)
			and 1
			jr  z, draw_scr_background_new_byte

			ld  a, (_rdc)
			and 15
			jr  draw_scr_background_set_t

		.draw_scr_background_new_byte
			ld  hl, (_map_pointer)
			ld  a, (hl)
			inc hl
			ld  (_map_pointer), hl
			ld  (_rdc), a
			srl a
			srl a
			srl a
			srl a

		.draw_scr_background_set_t
			ld (__t), a

			ld  b, 0 			; BC = gpit

			ld  hl, _map_buff
			add hl, bc
			ld  (hl), a

			ld  hl, _map_attr
			add hl, bc
			ex  de, hl			; DE = map_attr [gpit]

			ld  c, a 			; BC = _t
			ld  hl, _behs
			add hl, bc 			; HL = behs [_t]

			ldi 				; Corrupts BC!

			ld  a, (_rdx)
			ld  (__x), a
			ld  a, (_rdy)
			ld  (__y), a

			call _draw_coloured_tile_gamearea

			ld  a, (_rdx)
			inc a
			cp  15
			jr nz, draw_scr_background_continue

			ld  hl, _gpit		; Skip one as buffers are 16 tiles wide
			inc (hl)

			ld  hl, _rdy
			inc (hl)

			xor a

		.draw_scr_background_continue
			ld (_rdx), a
			
			ld  a, (_gpjt)
			inc a
			ld  (_gpjt), a

			ld  a, (_gpit)
			inc a
			cp  160
			jr  nz, draw_scr_background_loop
	#endasm
}

void draw_scr (void) {
	if (cur_map_attr != map_attrs [n_pant]) {
		cur_map_attr = map_attrs [n_pant];
		if (cur_map_attr) {
			_t = levels [level].resource + cur_map_attr; _n = 1; load_subtileset ();
		}
	}
	
	if (no_draw) no_draw = 0; else draw_scr_background ();
	
	f_zone_ac = 0;
	
	enoffs = (n_pant << 1) + n_pant;

	do_respawn = 1;
	
	x_pant = n_pant % level_data->map_w;
	y_pant = n_pant / level_data->map_w;

	p_safe_pant = n_pant;
	p_safe_x = (p_x >> FIXBITS);
	p_safe_y = (p_y >> FIXBITS);
}
