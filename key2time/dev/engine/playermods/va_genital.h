// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	if ( ! ((pad & sp_UP) == 0 || (pad & sp_DOWN) == 0) && p_z == 0) 
	{
		p_facing_v = 0xff;
		if (p_vy > 0) {
			p_vy -= RXVAL; if (p_vy < 0) p_vy = 0;
		} else if (p_vy < 0) {
			p_vy += RXVAL; if (p_vy > 0) p_vy = 0;
		}
	}

	if ((pad & sp_UP) == 0) {
		p_facing_v = FACING_UP;
		p_thrust = 1;
		if (p_vy > -PLAYER_VX_MAX) p_vy -= AXVAL;
	}

	if ((pad & sp_DOWN) == 0) {
		p_facing_v = FACING_DOWN;
		p_thrust = 1;
		if (p_vy < PLAYER_VX_MAX) p_vy += AXVAL;
	}
	