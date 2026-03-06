// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// Fire.h
#ifdef PLAYER_CAN_FIRE
	if (BUTTON_FIRE && !p_disparando
#ifdef PLAYER_CAN_FIRE_INV
		&& items [flags [FLAG_SLOT_SELECTED]] == PLAYER_CAN_FIRE_INV
#endif
		&& invalidate_fire == 0

	) {

		p_disparando = 1;
		fire_bullet ();
	}
#endif	
