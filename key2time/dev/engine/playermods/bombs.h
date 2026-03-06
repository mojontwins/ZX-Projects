// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// Bombs.h

#ifdef PLAYER_SIMPLE_BOMBS
	if (BUTTON_FIRE && !p_disparando
#ifdef PLAYER_BOMBS_INV
		&& items [flags [FLAG_SLOT_SELECTED]] == PLAYER_BOMBS_INV
#endif
		&& invalidate_fire == 0
	) {
		p_disparando = 1;
		if (0 == bomb_state && possee) {
			bomb_set ();
			_AY_PL_SND (9);
#ifdef PLAYER_BOMBS_INV
			items [flags [FLAG_SLOT_SELECTED]] = 0;
			display_items ();
#endif		
		}
	}
#endif
