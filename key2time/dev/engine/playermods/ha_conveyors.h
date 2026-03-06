// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

#ifdef PLAYER_GENITAL

#else
	if (possee) {
		pry = p_y >> 6;
		ATTR (ptx1, pty3, pt1);
		ATTR (ptx2, pty3, pt2);
		if (pt1 & 32) {
			p_gotten = 1; ptgmy = 0;
			ptgmx = (pt1 & 1) ? 64 : -64;
		}
		if (pt2 & 32) {
			p_gotten = 1; ptgmy = 0;
			ptgmx = (pt2 & 1) ? 64 : -64;
		}
	}
#endif
