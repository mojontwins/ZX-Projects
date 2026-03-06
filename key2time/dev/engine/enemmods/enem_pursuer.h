// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// Move pursuers

	switch (en_an_alive [gpit]) {
		case 0:
			if (en_an_dead_row [gpit] == 0) {
				_en_x = _en_x1;
				_en_y = _en_y1;
				en_an_alive [gpit] = 1;
				en_an_rawv [gpit] = 1 << (rand () % 5);
				if (en_an_rawv [gpit] > 4) en_an_rawv [gpit] = 2;
				en_an_dead_row [gpit] = 11 + (rand () & 7);
				#if defined (PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
					_en_life = ENEMIES_LIFE_GAUGE;
				#endif
			} else {
				en_an_dead_row [gpit] --;
			}
			break;
		case 1:
			if (en_an_dead_row [gpit] == 0) {
				en_an_base_frame [gpit] = (rand () & 3) << 1;
				en_an_alive [gpit] = 2;
			} else {
				en_an_dead_row [gpit] --;
				en_an_n_f [gpit] = sprite_17_a;
			}
			break;
		case 2:
			active = killable = animate = 1;
			if (p_state == EST_NORMAL) {
				_en_mx = (signed char) (addsign (((prx >> 2) << 2) - _en_x, en_an_rawv [gpit]));
				_en_x += _en_mx;
				
				_en_my = (signed char) (addsign (((pry >> 2) << 2) - _en_y, en_an_rawv [gpit]));
				_en_y += _en_my;
				
			}			
	}
