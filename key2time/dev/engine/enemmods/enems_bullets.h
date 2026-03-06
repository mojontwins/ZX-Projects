// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// Collide with bullets
		for (gpjt = 0; gpjt < MAX_BULLETS; ++ gpjt) {
			if (bullets_estado [gpjt] == 1) {
				if (collide_pixel (bullets_x [gpjt] + 3, bullets_y [gpjt] + 3, _en_x, _en_y)) {
					bullets_estado [gpjt] = 0;						
					enemy_kill (PLAYER_BULLETS_STRENGTH);
					goto continue_enems_loop;;
				}
			}
		}
