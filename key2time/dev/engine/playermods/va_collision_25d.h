// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// half-box collision. Check for tile behaviour in two points.
	// Which points? It depends on the type of collision configured:

	rdint = p_vy + ptgmy; if (rdint) {

		ptx1 = (prx + 4) >> 4;
		ptx2 = (prx + 11) >> 4;
		hit_v = 0;

		if (rdint < 0) {

			pty1 = (pry + 14) >> 4;
			ATTR (ptx1, pty1, pt1);
			ATTR (ptx2, pty1, pt2);

			if ((pt1 & 8) || (pt2 & 8)) {
				p_vy = 0;
				pry = ((pty1 + 1) << 4)  - 14; p_y = pry << FIXBITS;
				wall_v = WTOP;
			}  else if ((pt1 == 1) || (pt2 == 1)) hit_v = TILE_EVIL;

		} else {

			pty2 = (pry + 16) >> 4;
			ATTR (ptx1, pty2, pt1);
			ATTR (ptx2, pty2, pt2);

			if ((pt1 & 8) || (pt2 & 8))	{
				p_vy = 0;
				pry = ((pty2 - 1) << 4); p_y = pry << FIXBITS;
				wall_v = WBOTTOM;
			} else if ((pt1 == 1) || (pt2 == 1)) hit_v = TILE_EVIL;
		}
	}
