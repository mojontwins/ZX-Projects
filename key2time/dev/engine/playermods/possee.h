// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// Very perliminar 2.5D
	pry = p_y >> FIXBITS;
	pty1 = (pry + 15) >> 4;
	ptx1 = (prx + 8) >> 4;
	ATTR (ptx1, pty1, pt1);
	possee = (p_z == 0) && (pt1 != 3);
