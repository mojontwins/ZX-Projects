// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// half-box collision. Check for tile behaviour in two points.
	// Which points? It depends on the type of collision configured:
	
	rdint = p_vx + ptgmx; if (rdint) {

		pty1 = (pry + 14) >> 4;
		pty2 = (pry + 15) >> 4;
		hit_h = 0;
		
		if (rdint < 0) {
			
			ptx1 = (prx + 4) >> 4;
			ATTR (ptx1, pty1, pt1);
			ATTR (ptx1, pty2, pt2);
			
			if ((pt1 & 8) || (pt2 & 8)) {
				p_vx = 0;
				prx = ((ptx1 + 1) << 4) - 4; p_x = prx << FIXBITS;
				wall_h = WLEFT;
			} else if ((pt1 == 1) || (pt2 == 1)) hit_h = TILE_EVIL;

		} else {

			ptx2 = (prx + 12) >> 4;
			ATTR (ptx2, pty1, pt1);
			ATTR (ptx2, pty2, pt2);
			
			if ((pt1 & 8) || (pt2 & 8)) {
				p_vx = 0;
				prx = ((ptx2 - 1) << 4) + 4; p_x = prx << FIXBITS;
				wall_h = WRIGHT;
			} else if ((pt1 == 1) || (pt2 == 1)) hit_h = TILE_EVIL;
		
		}
	}
