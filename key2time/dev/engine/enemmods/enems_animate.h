// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	/*
	en_an_count [gpit] ++;
	#ifdef ENABLE_FLYING_ENEMIES
		if (gpt != 2) {
	#endif
		if (en_an_count [gpit] == 4) {
			en_an_count [gpit] = 0;
			en_an_frame [gpit] = !en_an_frame [gpit];
			en_an_n_f [gpit] = enem_frames [en_an_base_frame [gpit] + en_an_frame [gpit]];
		}
	#ifdef ENABLE_FLYING_ENEMIES 
		} else {
			en_an_n_f [gpit] = enem_frames [en_an_base_frame [gpit] + (en_an_vx [gpit] > 0)];
		}
	#endif
	*/

#asm
		// Keep gpit on DE so I can easily index all arrays!

		ld  de, (_gpit)
		ld  d, 0

	#ifdef ENABLE_FLYING_ENEMIES
		// if (gpt == 2) {
		//     en_an_n_f [gpit] = enem_frames [en_an_base_frame [gpit] + (en_an_vx [gpit] > 0)];
		// } else

		ld  a, _gpt 
		cp  2
		jr  nz, _enems_animate_flying_done

		ld  hl, _en_an_vx
		add hl, de
		ld  a, (hl)

		// A = en_an_vx [gpit]

		bit 7, a 
		jr  z, _enems_animate_flying_a_set_1
		ld  c, 0
		jr  _enems_animate_flying_a
	._enems_animate_flying_a_set_1
		ld  c, 1
	._enems_animate_flying_a

		// C = (en_an_vx [gpit] > 0)
		
		ld  hl, _en_an_base_frame
		add hl, de
		ld  a, (hl)
		add c

		// A = en_an_base_frame [gpit] + (en_an_vx [gpit] > 0)
		sla a
		ld  c, a
		ld  b, 0
		ld  hl, _enem_frames
		add hl, bc
		ld  a, (hl)
		inc hl
		ld  c, (hl)

		ld  hl, _en_an_n_f
		add hl, de
		add hl, de
		ld  (hl), a
		inc hl
		ld  (hl), c

	._enems_animate_flying_done
	#endif

		// en_an_count [gpit] ++;
		ld  hl, _en_an_count
		add hl, de
		inc (hl)

		// if (en_an_count [gpit] == 4) {
		ld  a, (hl)
		cp  4
		jr  nz, _enems_animate_change_frame_done

		// en_an_count [gpit] = 0;
		xor a
		ld  (hl), a

		// en_an_frame [gpit] = !en_an_frame [gpit];
		ld  hl, _en_an_frame 
		add hl, de
		ld  a, (hl)
		xor 1
		ld  (hl), a
		ld  c, a

		// en_an_n_f [gpit] = enem_frames [en_an_base_frame [gpit] + en_an_frame [gpit]];
		// A = en_an_frame [gpit]
		ld  hl, _en_an_base_frame
		add hl, de
		ld  a, (hl)
		add c

		// enem_frames is 16 bits, so:
		sla a		
		ld  c, a
		ld  b, 0
		ld  hl, _enem_frames
		add hl, bc
		ld  a, (hl)
		inc hl
		ld  c, (hl)

		ld  hl, _en_an_n_f
		add hl, de
		add hl, de
		ld  (hl), a
		inc hl
		ld  (hl), c

	._enems_animate_change_frame_done
#endasm
