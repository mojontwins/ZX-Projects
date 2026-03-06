// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

void enemy_kill (unsigned char amount) {
	
	#if PLAYER_BULLETS_STRENGTH > 0 || PLAYER_HITTER_STRENGTH > 0 || PLAYER_BOMBS_STRENGTH > 0)
		en_an_n_f [gpit] = sprite_17_a;

		// Trajectory modification?
		#ifdef ENABLE_FLYING_ENEMIES
			if (gpt == 2) {
				en_an_vx [gpit] += -en_an_vx [gpit];
				en_an_x [gpit] += en_an_vx [gpit];
			}
		#endif

		#if ENEMIES_LIFE_GAUGE > 1 || FANTIES_LIFE_GAUGE > 1
		// Lose life
			if (killable) _en_life -= amount;

		// No life left?
			if (_en_life == 0) {
		#endif								

		// Play sound								
		en_an_state [gpit] = GENERAL_DYING;
		en_an_count [gpit] = 8;
		_AY_PL_SND (14);
			
		// Mark as enemy dead																
		#ifdef ENABLE_PURSUERS
			if (gpt != 7) _en_t |= 128;
		#else
			_en_t |= 128;
		#endif

		// Count kills								
		++ flags [BODY_COUNT_ON];

		// Special for pursuers...	
		#ifdef ENABLE_PURSUERS
			en_an_alive [gpit] = 0;
			en_an_dead_row [gpit] = DEATH_COUNT_EXPRESSION;
		#endif

		// Run script on kill
		run_script (2 * MAP_W * MAP_H + 5);

		#if ENEMIES_LIFE_GAUGE > 1 || FANTIES_LIFE_GAUGE > 1
			} else {
				_en_mx = -_en_mx;
				_en_my = -_en_my;
			}
		#endif

	#else

		// Trajectory modification?
		#ifdef ENABLE_FLYING_ENEMIES
			if (gpt == 2) {
				en_an_vx [gpit] =- en_an_vx [gpit];
			}
		#endif

		_en_mx = -_en_mx;
		_en_my = -_en_my;

		// Play sound
		_AY_PL_SND (14);
		
	#endif		

}
