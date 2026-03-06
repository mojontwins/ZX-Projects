// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	p_ax = PLAYER_AX;
	p_rx = PLAYER_RX;
	if (pt1 & 64) {
		if (possee) {
			p_ax = PLAYER_AX_ALT;
			p_rx = PLAYER_RX_ALT;
		}
	}
	