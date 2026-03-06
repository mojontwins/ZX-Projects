// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Add your code here!

// This function is right called after entering a new room
void on_entering_screen (void) {	
	// Lit?
	if (hotspots [n_pant].act == 1 && hotspots [n_pant].t == 1) {
		lit = 0;
	} else {
		lit = 1;
	}
}

// This function is called each frame right before rendering changes
void my_extra_routines (void) {
	// Lit?
	if (!lit) {
		if ((rand () & 127) < 4 && ray_on == 0) {
			ray_on = 8;
		} 
		
		if (ray_on) {
			-- ray_on;
			if (ray_on == 0) fx_ay (0);
		} 
		
		if (ray_on && (rand () & 3) < 2) {
			lightning ();
			justlit = 1;
		} else {
			if (justlit || prxc != ovl_x || pryc != ovl_y) {
				ovl_x = prxc; ovl_y = pryc;
				#asm
					call _ovl_draw_scr
					call _ovl_draw_buff
					call _ovl_del
				#endasm
				justlit = 0;
			}
		}
	}

	do_attrs = lit;
}

// Return true to win the game!
unsigned char game_win_condition (void) {
	return (p_objs == PLAYER_NUM_OBJETOS);
}

// This function is fired when a collectible is collected
// Return 0 to cancel
#ifdef ENABLE_COLLECTIBLES
	unsigned char on_collected (void) {
		// Show everything
		lit = 1;		
	
		// Invalidate the whole viewport
		invalidate_viewport ();

		if (p_objs & 3 == 0 && p_life < PLAYER_LIFE) {
			fx_beeper (7);
			++ p_life;
		}

		return 1;	// TODO: ALTER!
	}
#endif
