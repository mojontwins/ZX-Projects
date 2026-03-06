// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Enemy type : platform

/*
if (pregotten && (p_gotten == 0)) {

	// Horizontal moving platforms
	if (_en_mx) {
		if (pry + 17 >= _en_y && pry + 10 <= _en_y) {
			p_gotten = 1;
			ptgmx = _en_mx << FIXBITS;
			pry = (_en_y - 16); p_y = pry << FIXBITS;
		}
	}

	// Vertical moving platforms
	if (
		(_en_my < 0 && pry + 18 >= _en_y && pry + 10 <= _en_y) ||
		(_en_my > 0 && pry + 17 + _en_my >= _en_y && pry + 10 <= _en_y)
	) {
		p_gotten = 1;
		ptgmy = _en_my << FIXBITS;
		pry = (_en_y - 16); p_y = pry << FIXBITS;						
	}

}
*/

#asm
		ld  a, (_pregotten)
		or  a
		jp  z, _enems_collision_done

		ld  a, (_p_gotten)
		or  a
		jp  nz, _enems_collision_done

		// Horizontal

		ld  a, (__en_mx)
		or  a
		jr  z, _enems_plats_horz_done

		// pry + 17 >= _en_y
		ld  a, (__en_y)
		ld  c, a
		ld  a, (_pry)
		add 17
		cp  c
		jr  c, _enems_plats_horz_done

		// pry + 10 <= _en_y -> _en_y >= _pry + 10
		ld  a, (_pry)
		add 10
		ld  c, a
		ld  a, (__en_y)
		cp  c
		jr  c, _enems_plats_horz_done

	._enems_plats_horz_do
		ld  a, 1
		ld  (_p_gotten), a
		ld  a, (__en_mx)
		sla a
		sla a
		sla a
		sla a 	; times FIXBITS
		ld  (_ptgmx), a

		jr _enems_plats_pry_set

	._enems_plats_horz_done

		// Vertical

		//(_en_my < 0 && pry + 18 >= _en_y && pry + 10 <= _en_y) ||
		//(_en_my > 0 && pry + 17 + _en_my >= _en_y && pry + 10 <= _en_y)

		// Has been rehashed to:

		//	if (_en_y >= pry + 10) {
		//		if (_en_my < 0) {
		//			if (pry + 18 >= _en_y) goto DO
		//		} else {
		//			if (pry + 17 + _en_my >= _en_y) goto DO
		//		}
		//	}

	._enems_plats_vert_check_1

		// _en_y >= pry + 10
		ld  a, (_pry)
		add 10
		ld  c, a
		ld  a, (__en_y)
		cp  c
		jr  c, _enems_plats_vert_done

		// _en_my < 0
		ld  a, (__en_my)
		bit 7, a
		jr  z, _enems_plats_vert_check_2 	; _en_my is positive 

		// pry + 18 >= _en_y
		ld  a, (__en_y)
		ld  c, a
		ld  a, (_pry)
		add 18
		cp  c
		jr  nc, _enems_plats_vert_do

	._enems_plats_vert_check_2
		// _en_my > 0
		// (implied)

		// pry + 17 + _en_my >= _en_y
		ld  a, (__en_y)
		ld  c, a
		ld  a, (__en_my)
		ld  b, a
		ld  a, (_pry)
		add 17
		add b
		cp  c
		jr  c, _enems_plats_vert_done		

	._enems_plats_vert_do

		ld  a, 1
		ld  (_p_gotten), a
		ld  a, (__en_my)
		sla a
		sla a
		sla a
		sla a 	; times FIXBITS
		ld  (_ptgmy), a

		xor a
		ld  (_p_vy), a

	._enems_plats_pry_set

		ld  a, (__en_y)
		sub 16
		ld  (_pry), a

		// p_y = pry << FIXBITS; 16 bits shift
		ld  d, 0
		ld  e, a
		ld  l, FIXBITS
		call l_asl
		ld  (_p_y), hl

	._enems_plats_vert_done
		jp  _enems_collision_done
#endasm
