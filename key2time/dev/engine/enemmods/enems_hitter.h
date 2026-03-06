// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	/*
	if (hitter_on && killable && hitter_hit == 0) {
		if (hitter_frame < 5) {
			if (collide_pixel (hitter_x + (p_facing ? 14 : 1), hitter_y + 3, _en_x, _en_y)) {
				hitter_hit = 1;
				enemy_kill (PLAYER_HITTER_STRENGTH);
				goto continue_enems_loop;
			}
		}
	}
	*/

	#asm

			ld  a, (_hitter_on)
			and a
			jr  z, _enems_hitter_done

			ld  a, (_killable)
			and a
			jr  z, _enems_hitter_done

			ld  a, (_hitter_hit)
			and a
			jr  nz, _enems_hitter_done

			ld  a, (_hitter_frame)
			cp  5
			jr  nc, _enems_hitter_done

			// Inline this:
			// if (collide_pixel (hitter_x + (p_facing ? 14 : 1), hitter_y + 3, _en_x, _en_y))
			// (x >= x1 + 1 && x <= x1 + 14 && y >= y1 + 1 && y <= y1 + 14)

			// rdx = hitter_x + (p_facing ? 14 : 1)

			ld  c, 1
			ld  a, (_p_facing)
			or  a
			jr  z, _enems_hitter_set_rdx_facing_done
			ld  c, 14			
		._enems_hitter_set_rdx_facing_done
			ld  a, (_hitter_x)
			add c
			ld  (_rdx), a

			// rdy = hitter_y + 3
			ld  a, (_hitter_y)
			add 3
			ld  (_rdy), a

			// rdx >= _en_x && rdx <= _en_x + 15 && rdy >= _en_y && rdy <= _en_y + 15

			// rdx >= _en_x
			ld  a, (__en_x)
			ld  c, a
			ld  a, (_rdx)
			cp  c
			jr  c, _enems_hitter_done

			// rdx <= _en_x + 15; _en_x + 15 >= rdx
			ld  a, (_rdx)
			ld  c, a
			ld  a, (__en_x)
			add 15
			cp  c
			jr  c, _enems_hitter_done

			// rdy >= _en_y
			ld  a, (__en_y)
			ld  c, a
			ld  a, (_rdy)
			cp  c
			jr  c, _enems_hitter_done

			// rdy <= _en_y + 15; _en_y + 15 >= rdy

			ld  a, (_rdy)
			ld  c, a
			ld  a, (__en_y)
			add 15
			cp  c
			jr  c, _enems_hitter_done

			// hitter_hit = 1;
			ld  a, 1
			ld  (_hitter_hit), a

			// enemy_kill (PLAYER_HITTER_STRENGTH);
			ld  hl, PLAYER_HITTER_STRENGTH
			push hl

			call _enemy_kill

			pop bc

			// goto continue_enems_loop;
			jp  _continue_enems_loop_a

		._enems_hitter_done
	#endasm
		