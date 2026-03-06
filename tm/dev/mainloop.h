// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

void do_game (void) {

	while (1) {
		// Here the title screen
		sp_UpdateNow (1);	
		#asm
				ld  hl, _s_title;
				ld  de, 16384;
				call depack
		#endasm

		select_joyfunc ();

		// Let's do it.

		#ifndef TITLE_HAS_FRAME
			#asm
					ld  hl, _s_frame;
					ld  de, 16384;
					call depack
			#endasm		
		#endif

		playing = 1;
		player_init ();
		
		gpit = 0; while (gpit < MAP_W * MAP_H) hotspots [gpit ++].act = 1;	

		objs_old = keys_old = life_old = killed_old = 0xff;
		n_pant = SCR_INICIO; on_pant = 0xff;
		maincounter = 0;		
		half_life = 0;
		success = 0;
		ray_on = justlit = 0;
		ovl_x = ovl_y = 0x99;
		do_attrs = 1;

		while (playing) {
			if (n_pant != on_pant) {
				draw_scr ();
				enems_init ();
				on_entering_screen ();

				on_pant = n_pant;
			}

			pad = (joyfunc) (&keys); 
			
			if (p_objs != objs_old) {
				draw_objs ();
				objs_old = p_objs;
			}
			
			if (p_life != life_old) {
				_x = LIFE_X; _y = LIFE_Y; _t = p_life; print_number2 ();
				life_old = p_life;
			}
			
			maincounter ++;
			half_life = !half_life;
			
			// Move enemies
			enems_move ();

			// Move player
			player_move ();
			
			// Render	
			#asm
					xor a
				.update_sprites_baddies_loop
					ld  (_gpit), a

					ld  c, a
					ld  a, (_enoffs)
					add c
					ld  (_enoffsmasi), a

					// Get a pointer to baddies [enoffsmasi].
					// The struct is 10 bytes long. 
					// We can keep the multiplications 8-bit as long as possible

					call _enems_get_pointer

					// HL points to baddies [enoffsmasi]. x and y are the two first bytes
					// x, y, x1, y1, x2, y2, mx, my, t

					ld  a, (hl)
					ld  (_gpx), a
					inc hl

					ld  a, (hl)
					ld  (_gpy), a
					
					; enter: IX = sprite structure address 
					;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
					;        BC = animate bitdef displacement (0 for no animation) 
					;         H = new row coord in chars 
					;         L = new col coord in chars 
					;         D = new horizontal rotation (0..7) ie horizontal pixel position 
					;         E = new vertical rotation (0..7) ie vertical pixel position 
					ld  a, (_gpit)
					sla a
					ld  c, a
					ld  b, 0 				// BC = offset to [gpit] in 16bit arrays
					ld  hl, _sp_moviles
					add hl, bc
					ld  e, (hl)
					inc hl 
					ld  d, (hl)
					push de						
					pop ix
					ld  iy, vpClipStruct

					// en_an_next_frame [gpit] - en_an_current_frame [gpit], 
					ld  hl, _en_an_current_frame
					add hl, bc 				// HL -> en_an_current_frame [gpit]
					ld  e, (hl)
					inc hl 
					ld  d, (hl) 			// DE = en_an_current_frame [gpit]

					ld  hl, _en_an_next_frame
					add hl, bc 				// HL -> en_an_next_frame [gpit]
					ld  a, (hl)
					inc hl
					ld  h, (hl)
					ld  l, a 				// HL = en_an_next_frame [gpit]

					or  a 					// clear carry
					sbc hl, de 				// en_an_next_frame [gpit] - en_an_current_frame [gpit]

					push bc 				// Save index

					ld  b, h
					ld  c, l 				// ** BC = animate bitdef **

					ld  a, (_gpy)					
					srl a
					srl a
					srl a
					add VIEWPORT_Y
					ld h, a

					ld  a, (_gpx)
					srl a
					srl a
					srl a
					add VIEWPORT_X
					ld  l, a

					ld  a, (_gpx)
					and 7
					ld  d, a

					ld  a, (_gpy)
					and 7
					ld  e, a

					call SPMoveSprAbs

					// en_an_current_frame [gpit] = en_an_next_frame [gpit];

					pop bc 					// Retrieve index

					ld  hl, _en_an_current_frame
					add hl, bc
					ex  de, hl 				// DE -> en_an_next_frame [gpit]	

					ld  hl, _en_an_next_frame
					add hl, bc 				// HL -> en_an_next_frame [gpit]
					
					ldi
					ldi

					// Continue

					ld  a, (_gpit)
					inc a
					cp  3
					jp  nz, update_sprites_baddies_loop

				.update_sprites_player

					ld  ix, (_sp_player)
					ld  iy, vpClipStruct
					
					ld  hl, (_p_next_frame)
					ld  de, (_p_current_frame)
					or  a
					sbc hl, de
					ld  b, h
					ld  c, l

					ld  a, (_pryc)
					;srl a
					;srl a
					;srl a
					add VIEWPORT_Y
					ld h, a

					ld  a, (_prxc)
					;srl a
					;srl a
					;srl a
					add VIEWPORT_X
					ld  l, a

					ld  a, (_prx)
					and 7
					ld  d, a

					ld  a, (_pry)
					and 7
					ld  e, a

					call SPMoveSprAbs		
				
					// p_current_frame = p_next_frame;
					ld  hl, (_p_next_frame)
					ld  (_p_current_frame), hl
			#endasm
	
			// Extra routines
			my_extra_routines ();
			
			// Update to screen
			sp_UpdateNow (do_attrs);

			// Kill player / Game over
			if (p_killme) player_kill ();				
			
			// Hotspot interaction.

			#asm
				._hotspots_collision

					// prx >= hotspot_x - 12 -> prx + 12 >= hotspot_x
					ld  a, (_hotspot_x)
					ld  c, a
					ld  a, (_prx)
					add 12
					cp  c
					jp  c, _hotspots_done

					// prx <= hotspot_x + 12 -> hotspot_x + 12 >= prx
					ld  a, (_prx)
					ld  c, a
					ld  a, (_hotspot_x)
					add 12
					cp  c
					jp  c, _hotspots_done

					// pry >= hotspot_y - 12 -> pry + 12 >= hotspot_y
					ld  a, (_hotspot_y)
					ld  c, a
					ld  a, (_pry)
					add 12
					cp  c
					jp  c, _hotspots_done

					// pry <= hotspot_y + 12 -> hotspot_y + 12 >= pry
					ld  a, (_pry)
					ld  c, a
					ld  a, (_hotspot_y)
					add 12
					cp  c
					jp  c, _hotspots_done

				._hotspots_do
					xor a
					ld  (_gpit), a

					// Check hotspot type
					ld  a, (_hotspot_t)

				#ifdef ENABLE_COLLECTIBLES
					cp  1
					jr  nz, _hotspots_type_1_done

				._hotspots_type_1_do
					call _on_collected
					xor a
					or  l
					jp  z, _hotspots_clear_check

					ld  hl, _p_objs
					inc (hl)

					ld  hl, 6
					push hl
					call _fx_beeper
					pop bc
					
					ld  a, 1
					ld  (_gpit), a

					jp  _hotspots_clear_check

				._hotspots_type_1_done
				#endif

				// Delete hotspot?

				._hotspots_clear_check
					ld  a, (_gpit)
					or  a
					jr  z, _hotspots_done

					ld  a, (_hotspot_x)
					srl a
					srl a
					srl a
					add VIEWPORT_X
					ld  (__x), a

					ld  a, (_hotspot_y)
					srl a
					srl a
					srl a
					add VIEWPORT_Y
					ld  (__y), a

					ld  a, (_orig_tile)
					ld  (__t), a

					call _draw_coloured_tile
					call _invalidate_tile
					
					// HOTSPOT struct is 3 bytes per index, so hotspots [n_pant].act is
					// hotspots + (n_pant * 3) + 2
					ld  a, (_n_pant)
					ld  b, a
					sla a
					add b 		
					add 2		; (n_pant * 3) + 2

					ld  d, 0
					ld  e, a
					ld  hl, _hotspots
					add hl, de

					// hotspots [n_pant].act = 0
					xor a
					ld  (hl), a

					ld  a, 240
					ld  (_hotspot_y), a

				._hotspots_done
			#endasm
			
			// Flick screen
			if (prx == 0 && p_vx < 0) {
				-- n_pant;
				prx = 224; p_x = prx << FIXBITS;
			} 
			if (prx == 224 && p_vx > 0) {
				++ n_pant;
				prx = p_x = 0;
			}
			if (pry == 0 && p_vy < 0 && n_pant >= MAP_W) {
				n_pant -= MAP_W;
				pry = 144; p_y = pry << FIXBITS;
			}
			if (pry == 144 && p_vy > 0) {				
				if (n_pant < MAP_W * MAP_H - MAP_W) {
					n_pant += MAP_W;					
					pry = p_y = 0;
					if (p_vy > 127) p_vy = 127;
				}
				#ifdef MAP_BOTTOM_KILLS
					else p_killme = 3;
				#endif
			}			

			// Win game condition
			if (game_win_condition ()) {
				success = 1;
				playing = 0;
			}
		}
		
		sprites_off ();
		sp_UpdateNow (0);
		
		if (success) game_ending (); else game_over ();
		cortina ();
	}
}
