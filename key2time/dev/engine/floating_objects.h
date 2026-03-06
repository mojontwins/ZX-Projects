// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// Floating objects
// Common functions (included from fo_genital and fo_sideview)

void FO_clear (void) {
	fo_it = 0;
	while (fo_it < MAX_FLOATING_OBJECTS) f_o_t [fo_it ++] = 0;
	fo_idx = 0;
#ifdef ENABLE_FO_CARRIABLE_BOXES
	p_hasbox = 99;
#ifdef CARRIABLE_BOXES_ALTER_JUMP
	PLAYER_JMP_VY_MAX = PLAYER_JMP_VY_MAX;
#endif
#ifdef CARRIABLE_BOXES_THROWABLE
	fo_fly = 0;
#endif
#endif
#ifdef CARRIABLE_BOXES_THROWABLE
	delete_box_sprite ();
#endif
#ifdef ENABLE_FO_SCRIPTING
	flags [FO_T_FLAG] = 0;
#endif
}

unsigned char FO_add (unsigned char x, unsigned char y, unsigned char t) {
	f_o_t [fo_idx] = t;
	f_o_x [fo_idx] = x;
	f_o_y [fo_idx] = y;
	f_o_s [fo_idx] = 0;
	fo_idx ++;
	return fo_idx - 1;
}

void FO_paint (unsigned char idx) {
	fo_au = f_o_t [idx];
	if (fo_au & 128) fo_au = flags [fo_au & 127];
	if (fo_au == 0) return;
	
#if FT_FIREZONES == 48
	if (fo_au == FT_FIREZONES) return;
#endif

	_x = f_o_x [idx]; _y = f_o_y [idx]; _t = fo_au;
	draw_coloured_tile_gamearea ();
	
	// Bit 7 marks this block as "floating". That way the player movement routine can identify it
	// and will never store this location as a "safe" one.
	map_attr [BUFFER_IDX (f_o_x [idx], f_o_y [idx])] = behs [fo_au] | 128;
}

void FO_unpaint (unsigned char idx) {
	fo_au = BUFFER_IDX (f_o_x [idx], f_o_y [idx]);
	_x = f_o_x [idx]; _y = f_o_y [idx]; _t = map_buff [fo_au];
	draw_coloured_tile_gamearea ();	
	map_attr [fo_au] = behs [map_buff [fo_au]];
}

void FO_paint_all (void) {
	fo_it = 0;
	while (fo_it < MAX_FLOATING_OBJECTS) {
#ifdef ENABLE_FO_CARRIABLE_BOXES
		if (f_o_t [fo_it] && fo_it != p_hasbox) FO_paint (fo_it);
#else
		if (f_o_t [fo_it]) FO_paint (fo_it);
#endif
		fo_it ++;
	}
}

void FO_do (void) {
	if ((pad & sp_FIRE) == 0) {
		if (0 == d_prs) {
			fo_it = 0;
			while (fo_it < MAX_FLOATING_OBJECTS) {
				// Collision / interaction (is the player touching the f.o.?)
				// tile->pixel
				fo_x = f_o_x [fo_it] << 4;
				fo_y = f_o_y [fo_it] << 4;

				// Bounding box to check if player is around.
				// (adapted for NEW_GENITAL-style collision)
				if (prx + 15 >= fo_x && prx <= fo_x + 15 && pry + 16 >= fo_y && pry <= fo_y + 8) {

					// Containers...
					if (f_o_t [fo_it] & 128) {
						// Tengo que cambiar lo que haya en items [flags [FLAG_ITEM_SELECTED]]
						// por lo que haya en flags [f_o_t [fo_it] & 127]
						fo_st = f_o_t [fo_it] & 127;
						fo_au = flags [fo_st];
						flags [fo_st] = items [flags [FLAG_SLOT_SELECTED]];
						items [flags [FLAG_SLOT_SELECTED]] = fo_au;
						display_items ();
						
						if (flags [fo_st]) FO_paint (fo_it); else FO_unpaint (fo_it);
						_AY_PL_SND (11);
						invalidate_fire = 1;
					}					

				}

				fo_it ++;
			}
			d_prs = 1;
		}
	} else d_prs = 0;
}
