// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Baddies related functions

void enems_get_pointer (void) {
	#asm
			// Those values are stores in this order:
			// x, y, x1, y1, x2, y2, mx, my, t
			// Point HL to baddies [enoffsmasi]. The struct is 9 bytes long
			// so this is baddies + enoffsmasi*9, or...
			// enoffsmasi is, at maximum, ((MAP_W*MAP_H)-1)*3+2, or 71.
			// We can keep the multiplications 8-bit as long as possible

			// In A = enoffsmasi,      Max 71

			ld  e, a
			sla a 					// Max 142  (x2)
			ld  l, a
			ld  h, 0
			add hl, hl 				// HL = x4
			add hl, hl 				// HL = x8
						
			ld  d, 0                // DE = x1
			add hl, de 				// HL = x9

			ld  de, _baddies
			add hl, de

			// Out HL = baddies [enoffsmasi]
	#endasm
}

void enems_init (void) {
	#asm
			ld  a, (_n_pant)
			ld  b, a
			sla a
			add b 					// A = n_pant * 3
			ld  (_enoffs), a

			ld  bc, 3
		._enems_init_loop
			dec c
		
			// Calculate enoffsmasi

			ld  a, (_enoffs)
			add c
			ld  (_enoffsmasi), a

			// Reset _en_an_frame

			xor a
			ld  hl, _en_an_frame
			add hl, bc			
			ld  (hl), a 			// en_an_frame [gpit] = 0;			

			// Reset _en_an_count

			ld  a, 3
			ld  hl, _en_an_count
			add hl, bc			
			ld  (hl), a 			// en_an_count [gpit] = 3;

	#ifdef ENEMS_MAY_DIE
		#if ENEMS_LIFE_GAUGE > 1
			// Set life gauge
			ld  a, ENEMS_LIFE_GAUGE
			ld  hl, _en_an_life
			add hl, bc
			ld  (hl), a
		#endif
	#endif

			// Get enemy type

			ld  a, (_enoffsmasi)
			
			call _enems_get_pointer

			ld  de, 8
			add hl, de 				// HL -> baddies [enoffsmasi].t
			ld  a, (hl)
			ld  (__en_t), a

	#ifdef ENEMS_NEED_STATES
			// Set _en_an_state

		#ifdef ENEMS_MAY_DIE
			#ifdef ENEMS_RESPAWN_ON_ENTER
				and 127 				// Remove mark if exists
				ld  (hl), a
				ld  a, ENEMS_STATE_NORMAL
				#else
				bit 7, a
				jr  z, _enems_init_not_dead

				ld  a, ENEMS_STATE_DEAD
				jr  ._enems_init_state_set
			._enems_init_not_dead
			#endif
		#else
			ld  a, ENEMS_STATE_NORMAL
		#endif	

		._enems_init_state_set
			ld  hl, _en_an_state
			add hl, bc			
			ld  (hl), a 			// en_an_state [gpit] = 0;
	#endif			

			// Initialize enemy depending on enemy type

			// Enemy type linear
			// -----------------

			ld  a, (__en_t)
			cp  1
			jr  z, _enems_init_linear
			cp  2
			jr  z, _enems_init_linear
			cp  3
			jr  z, _enems_init_linear
			cp  4
			jr  nz, _enems_init_linear_done

		._enems_init_linear
			dec a 					// A = _en_t - 1
			sla a 					// A = (_en_t - 1) << 1

			ld  hl, _en_an_base_frame
			add hl, bc
			ld  (hl), a

			jr  _enems_init_type_done

		._enems_init_linear_done

	#ifdef ENABLE_CUSTOM_TYPE_6

			// Enemy type custom type 6
			// ------------------------

			cp  6
			jr  nz, _enems_init_custom_done

		._enems_init_custom
			jr  _enems_init_type_done

		._enems_init_custom_done
	#endif

		._enems_init_type_done

			xor  a 
			or   c
			jr   nz, _enems_init_loop
	#endasm
}

#ifdef ENEMS_MAY_DIE
	void enems_hit (void) {	
		#asm
		#if ENEMS_LIFE_GAUGE > 1
				ld  bc, (_gpit)
				ld  b, 0
				ld  hl, _en_an_life
				add hl, bc
				ld  a, (hl)
				or  a
				jr  z, _enems_kill

			._enems_deplete
				dec a
				ld  (hl), a

				ld  hl, _en_an_state
				add hl, bc
				ld  a, ENEMS_STATE_HIT
				ld  (hl), a

				ld  hl, _en_an_ct_state
				add hl, bc
				ld  a, ENEMS_HIT_FRAMES
				ld  (hl), a
				ret
		#endif
			// Killing an enemy is about raising bit 7 of .t 
			// and setting the ENEMS_STATE_DYING state

			._enems_kill
				// _en_t will be updated at the end of the enems_move loop, so
				ld  a, (__en_t)
				or  128
				ld  (__en_t), a

				ld  hl, _en_an_state
				add hl, bc
				ld  a, ENEMS_STATE_DYING
				ld  (hl), a

				ld  hl, _en_an_ct_state
				add hl, bc
				ld  a, ENEMS_DYING_FRAMES
				ld  (hl), a
				ret	
		#endasm
	}
#endif

void enems_move (void) {
	tocado = p_gotten = ptgmx = ptgmy = 0;

	for (gpit = 0; gpit < 3; gpit ++) {
		active = animate = 0;
		enoffsmasi = enoffs + gpit;

		// Copy array values to temporary variables as fast as possible
		
		#asm
				ld  a, (_gpit)
				ld  c, a
				ld  a, (_enoffs)
				add c
				ld  (_enoffsmasi), a

				call _enems_get_pointer // A = enoffsmasi -> HL = baddies [enoffsmasi]

				ld  (_gp_gen), hl 		// Save address for later

				ld  a, (hl)
				ld  (__en_x), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y), a
				inc hl 

				ld  a, (hl)
				ld  (__en_x1), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y1), a
				inc hl 

				ld  a, (hl)
				ld  (__en_x2), a
				inc hl 

				ld  a, (hl)
				ld  (__en_y2), a
				inc hl 

				ld  a, (hl)
				ld  (__en_mx), a
				inc hl 

				ld  a, (hl)
				ld  (__en_my), a
				inc hl 

				ld  a, (hl)
				ld  (__en_t), a

		#ifdef ENEMS_NEED_STATES
				// Check state
				// - Dead enemies are automaticly deactivated (_en_t = 0)
				// - Hit, dying, paused enemies won't execute the 'update' routine
				// - Paused enemies still have to animate

				ld  bc, (_gpit)
				ld  b, 0
				ld  hl, _en_an_state
				add hl, bc
				ld  a, (hl)

				cp  ENEMS_STATE_NORMAL
				jr  nz, _enems_move_state_normal_done

			._enems_move_state_normal
				ld  a, 1
				ld  (_update), a
				ld  (_animate), a

				jr  _enems_move_state_done
			._enems_move_state_normal_done

			#ifdef ENEMS_MAY_DIE
				cp  ENEMS_STATE_DYING
				jr  nz, _enems_move_state_dying_done
			._enems_move_state_dying

				jr  _enems_move_state_done
			._enems_move_state_dying_done

				cp  ENEMS_STATE_DEAD
				jr  nz, _enems_move_state_dead_done
			._enems_move_state_dead

				jr  _enems_move_state_done
			._enems_move_state_dead_done

				cp  ENEMS_STATE_HIT
				jr  nz, _enems_move_state_hit_done
			._enems_move_state_hit

				jr  _enems_move_hit_done
			._enems_move_state_hit_done
			#endif

			#ifdef ENEMS_MAY_PAUSE
				cp  ENEMS_STATE_PAUSED
				jr  nz, _enems_move_state_paused_done
			._enems_move_state_paused

				jr  _enems_move_state_done
			._enems_move_state_paused_done
			#endif

			._enems_move_state_done
		#else
				ld  a, 1
				ld  (_update), a
				ld  (_animate), a
		#endif

				// Calculate pregotten
				// pregotten = (prx + 12 >= _en_x && prx <= _en_x + 12);

				// prx + 12 >= _en_x
				ld  a, (__en_x)
				ld  c, a
				ld  a, (_prx)
				add 12
				cp  c
				jp  c, _enems_move_pregotten_not 	// branch if <

				// prx <= _en_x + 12; _en_x + 12 >= prx
				ld  a, (_prx)
				ld  c, a
				ld  a, (__en_x)
				add 12
				cp  c 
				jp  c, _enems_move_pregotten_not 	// branch if <

				ld  a, 1
				jr  _enems_move_pregotten_set

			._enems_move_pregotten_not
				xor a

			._enems_move_pregotten_set
				ld  (_pregotten), a			
		#endasm

		// Update routine

		if (update) switch (_en_t) {
			case 1:
			case 2:
			case 3:
			case 4:
				#include "engine/enem_types/enem_linear.h"
				break;
			#ifdef ENABLE_CUSTOM_TYPE_6
				case 6:
					#include "engine/enem_types/enem_custom.h"
					break;
			#endif
			default:
				animate = 0;
				en_an_next_frame [gpit] = SPR_CELL(CELL_EMPTY);
		}

		if (animate) {
			// Animate
			/*
			en_an_count [gpit] ++; 
			if (en_an_count [gpit] == 4) {
				en_an_count [gpit] = 0;
				en_an_frame [gpit] = !en_an_frame [gpit];
				en_an_next_frame [gpit] = enem_frames [en_an_base_frame [gpit] + en_an_frame [gpit]];
			}
			*/

			#asm
					ld  bc, (_gpit)
					ld  b, 0

					ld  hl, _en_an_count
					add hl, bc
					ld  a, (hl)
					inc a

					cp  4
					jr  nz, _enems_move_animate_count_set

				._enems_move_animate_frame_flip

					ld  hl, _en_an_frame
					add hl, bc
					ld  d, (hl)
					ld  a, 1
					sub d
					ld  (hl), a
					ld  d, a

					ld  hl, _en_an_base_frame
					add hl, bc
					ld  a, (hl)
					add d
					sla a

					ld  e, a
					ld  d, 0

					ld  hl, _enem_frames
					add hl, de

					ld  e, (hl)
					inc hl
					ld  d, (hl)

					ld  hl, _en_an_next_frame
					add hl, bc
					add hl, bc
					ld  (hl), e
					inc hl
					ld  (hl), d
					
					ld  hl, _en_an_count
					add hl, bc
					xor a

				._enems_move_animate_count_set
					ld  (hl), a
			#endasm
		}
		
		if (active) {			
			
			// Collide with player
			
			// Platforms
			if (_en_t == 4) {
				#include "engine/enem_types/enem_platform.h"
			} else {				
				#asm
					._enems_collision 
						// tocado == 0
						ld  a, (_tocado)
						or  a
						jr  nz, _enems_collision_done

						// p_state == 0
						ld  a, (_p_state)
						or  a
						jr  nz, _enems_collision_done

						// (prx + 8 >= _en_x && prx <= _en_x + 8 && pry + 8 >= _en_y && pry <= _en_y + 8)

						// prx + 8 >= _en_x
						ld  a, (__en_x)
						ld  c, a
						ld  a, (_prx)
						add 8
						cp  c
						jr  c, _enems_collision_done

						// prx <= _en_x + 8; _en_x + 8 >= prx
						ld  a, (_prx)
						ld  c, a
						ld  a, (__en_x)
						add 8
						cp  c
						jr  c, _enems_collision_done

						// pry + 8 >= _en_y
						ld  a, (__en_y)
						ld  c, a
						ld  a, (_pry)
						add 8
						cp  c
						jr  c, _enems_collision_done

						// pry <= _en_y + 8; _en_y + 8 >= pry
						ld  a, (_pry)
						ld  c, a
						ld  a, (__en_y)
						add 8
						cp  c
						jr  c, _enems_collision_done

					._enems_collision_do
						ld  a, 1
						ld  (_tocado), a
						ld  a, 2
						ld  (_p_killme), a

				#ifdef PLAYER_BOUNCES
						call _player_bounce	
				#endif
										
					._enems_collision_done
				#endasm
			}
		} 
		continue_enems_loop:
		#asm
			._continue_enems_loop_a
				// Those values are stores in this order:
				// x, y, x1, y1, x2, y2, mx, my, t, life

				ld  hl, (_gp_gen) 		// Restore pointer

				ld  a, (__en_x)
				ld  (hl), a
				inc hl

				ld  a, (__en_y)
				ld  (hl), a
				inc hl

				ld  a, (__en_x1)
				ld  (hl), a
				inc hl

				ld  a, (__en_y1)
				ld  (hl), a
				inc hl

				ld  a, (__en_x2)
				ld  (hl), a
				inc hl

				ld  a, (__en_y2)
				ld  (hl), a
				inc hl

				ld  a, (__en_mx)
				ld  (hl), a
				inc hl

				ld  a, (__en_my)
				ld  (hl), a
				inc hl

				ld  a, (__en_t)
				ld  (hl), a
		#endasm
	}
}
