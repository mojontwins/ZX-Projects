// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Fixed screens

void lame_beeps (void) {
	gpit = 4; do {
		fx_beeper (7);
		fx_beeper (2);
	} while (-- gpit);
	fx_beeper (9);
}

void game_ending (void) {
	sp_UpdateNow(1);
	
	#asm
			ld  hl, _s_ending;
			ld  de, 16384;
			call depack
	#endasm
	
	lame_beeps ();
	
	busy_wait (500);
}

void game_over (void) {
	_x =10; _y = 11; _t = 79; gp_gen = spacer; print_str ();
	_x =10; _y = 12; _t = 79; gp_gen = " GAME OVER! "; print_str ();
	_x =10; _y = 13; _t = 79; gp_gen = spacer; print_str ();
	sp_UpdateNow (1);
		
	lame_beeps ();
	
	busy_wait (500);
}
