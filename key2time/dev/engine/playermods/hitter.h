// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// Hitter.h

	if (BUTTON_FIRE && !p_disparando
		&& items [flags [FLAG_SLOT_SELECTED]] == PLAYER_HITTER_INV
		&& invalidate_fire == 0
	) {
		p_disparando = 1;
		if (0 == hitter_on) {
			hitter_hit = 0;
			hitter_on = 1;
			hitter_frame = 0;
			p_hitting = 1;
			_AY_PL_SND (7);
		}
	}
