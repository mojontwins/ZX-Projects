// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Screen renderer

void advance_worm (void) {
	#asm
			/*
			map_attr [gpit] = behs [_rdt];
			map_buff [gpit] = gpd;
			draw_coloured_tile (_x, _y, _t);
			_x += 2; if (_x == VIEWPORT_X + 30) { _x = VIEWPORT_X; _y += 2; }
			*/

			// Fill buffers
			ld  bc, (_gpit)
			ld  b, 0
			
			ld  de, (_rdt)
			ld  d, 0
			ld  hl, _behs
			add hl, de
			ld  a, (hl)

			ld  hl, _map_attr
			add hl, bc
			ld  (hl), a

			ld  a, (_rdt)
			ld  hl, _map_buff
			add hl, bc
			ld  (hl), a

			// Draw a tile
			// _x, _y are set; set _t (which happens to be on A)
			ld  (__t), a
			call _draw_coloured_tile

			// Advance cursor
			ld  a, (__x)
			add a, 2
			cp  VIEWPORT_X + 30
			jr  c, _advance_worm_continue

			ld  a, (__y)
			add a, 2
			ld  (__y), a
			
			ld  a, VIEWPORT_X
					
		._advance_worm_continue
			ld  (__x), a

			ld  hl, _gpit
			inc (hl)
	#endasm
}

void draw_scr (void) {
	seed = n_pant;	
	
	#asm

	#ifdef MAP_FORMAT_RLE
		// Get screen address from index.
		// RLE format

		._draw_scr_get_scr_address
			ld  a, (_n_pant)
			sla a
			ld  d, 0
			ld  e, a
			ld  hl, _mapa
			add hl, de 		; HL = map + (n_pant << 1)
			ld  e, (hl)
			inc hl
			ld  d, (hl) 	; DE = index
			ld  hl, _mapa
			add hl, de      ; HL = map + index
			ld  (_gp_map), hl

		// Now decode & render the current screen 

		._draw_scr_rle
			xor a
			ld  (_gpit), a
			ld  a, VIEWPORT_X
			ld  (__x), a
			ld  a, VIEWPORT_Y
			ld  (__y), a

		._draw_scr_loop
			ld  a, (_gpit)
			cp  150
			jr  z, _draw_scr_loop_done

			ld  hl, (_gp_map)
			ld  a, (hl)
			inc hl
			ld  (_gp_map), hl
			
			ld  c, a
		#if RLE_FORMAT == 44
			and 0x0f
		#elif RLE_FORMAT == 53
			and 0x1f
		#else
			and 0x3f
		#endif			
			ld  (_rdt), a

			ld  a, c
			ld  (_rdct), a

		._draw_scr_advance_loop
			ld  a, (_rdct)
		#if RLE_FORMAT == 44
			cp  0x10
		#elif RLE_FORMAT == 53			
			cp  0x20
		#else
			cp  0x40
		#endif

			jr  c, _draw_scr_advance_loop_done

		#if RLE_FORMAT == 44
			sub 0x10
		#elif RLE_FORMAT == 53
			sub 0x20
		#else
			sub 0x40
		#endif
			ld  (_rdct), a

			call _advance_worm

			// That's it!

			jr _draw_scr_advance_loop

		._draw_scr_advance_loop_done
			call _advance_worm

			jr _draw_scr_loop

		._draw_scr_loop_done			
	#endif

		._hotspots_setup
			// hotspots [n_pant] = hotspots + n_pant * 3
			ld  a, (_n_pant)
			ld  b, a
			sla a
			add b
			ld  d, 0
			ld  e, a
			ld  hl, _hotspots
			add hl, de
			ld  (_gp_gen), hl

			ld  bc, 2
			add hl, bc 		// +2 = .act
			ld  a, (hl)		// A = hotspots [n_pant].act
			or  a 
			jr  z, _hotspots_setup_done

			dec hl 			// +1 = .t
			ld  a, (hl) 	// A = hotspots [n_pant].t
			or  a
			jr  z, _hotspots_setup_done

		._hotspots_setup_do

			ld  (_hotspot_t), a 
			add 16
			ld  (__t), a

			dec hl 			// +0 = .xy
			ld  a, (hl) 	// A = hotspots [n_pant].xy

			ld  c, a
			and 0xf0
			ld  (_hotspot_x), a
			srl a
			srl a
			srl a
			srl a
			ld  (_gpx), a
			sla a
			add VIEWPORT_X
			ld  (__x), a

			ld  a, c
			and 15
			ld  (_gpy), a
			sla a
			ld  c, a
			sla a
			sla a
			sla a
			ld  (_hotspot_y), a
			ld  a, c
			add VIEWPORT_Y
			ld  (__y), a

			ld  a, (_gpx)
			ld  c, a
			ld  a, (_gpy)
			ld  b, a
			sla a
			sla a
			sla a
			sla a
			sub b
			add c
			ld  d, 0
			ld  e, a
			ld  hl, _map_buff
			add hl, de
			ld  a, (hl)
			ld  (_orig_tile), a

			call _draw_coloured_tile

		._hotspots_setup_done

			call _invalidate_viewport
	#endasm	
}
