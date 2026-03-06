// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// Very preliminary version!

	if (BUTTON_JUMP && p_jmp_on == 0 && (possee || p_gotten)) {
		p_jmp_on = 1;
		p_jmp_ct = 0;
		p_jmp_facing = p_facing;
		p_vz = -PLAYER_JMP_VY_INITIAL;

		// Affected by intertia
		p_vx += ptgmx;
		p_vy += ptgmy;

		_AY_PL_SND (2);
		
		// Safe
		if (!p_gotten) {
			p_safe_pant = n_pant;
			p_safe_x = prx;
			p_safe_y = pry;
		}
	}

	if (BUTTON_JUMP && p_jmp_on) {
		p_vz -= (PLAYER_JMP_VY_INCR - (p_jmp_ct>>1));
		if (p_vz < -PLAYER_JMP_VY_MAX) p_vz = -PLAYER_JMP_VY_MAX;
		++ p_jmp_ct;
		if (p_jmp_ct == 4)
			p_jmp_on = 0;
	}

	if (!BUTTON_JUMP) p_jmp_on = 0;
