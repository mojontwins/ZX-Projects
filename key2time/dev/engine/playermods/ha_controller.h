// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	if ( ! ((pad & sp_LEFT) == 0 || (pad & sp_RIGHT) == 0) && p_z == 0) 
	{
		p_facing_h = 0xff;
		if (p_vx > 0) {
			p_vx -= RXVAL; if (p_vx < 0) p_vx = 0;
		} else if (p_vx < 0) {
			p_vx += RXVAL; if (p_vx > 0) p_vx = 0;
		}
	}

	if ((pad & sp_LEFT) == 0) {
		p_thrust = 1;
		p_facing_h = FACING_LEFT;
		if (p_vx > -PLAYER_VX_MAX) {
			p_vx -= AXVAL;
		}
	}

	if ((pad & sp_RIGHT) == 0) {
		p_thrust = 1;
		p_facing_h = FACING_RIGHT;
		if (p_vx < PLAYER_VX_MAX) {
			p_vx += AXVAL;
		}
	}
