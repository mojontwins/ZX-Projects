// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// First, preliminary version. No real collision, just ground level.
	if (p_vz < PLAYER_FALL_VY_MAX) p_vz += PLAYER_G; else p_vz = PLAYER_FALL_VY_MAX;
