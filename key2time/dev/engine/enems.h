// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// enems.h

// Enemies' "t" is now slightly more complex:
// XTTTTDNN where
// X = dead
// TTTT = type       1000 = platform
//                   0001 = linear
//                   0010 = flying
//                   0011 = pursuing

// Reserved (addons)
//                   1001 = drops
//                   1010 = arrows
//                   1011 = Hanna Type 11
//                   1100 = Hanna Punchos

#include "engine/enemmods/helper_funcs.h"
#include "engine/enemmods/enems_kill.h"

void enems_init (void) {

	for (gpit = 0; gpit < 3; ++ gpit) {
		en_an_frame [gpit] = 0;
		en_an_count [gpit] = 3;
		en_an_state [gpit] = 0;
		enoffsmasi = enoffs + gpit;

		// Back to life!
		if (do_respawn) {
			baddies [enoffsmasi].t &= 0x7f;
			en_an_state [gpit] = 0;
			#if defined (PLAYER_CAN_FIRE) || defined (PLAYER_CAN_PUNCH) || defined (PLAYER_HAZ_SWORD)
				baddies [enoffsmasi].life = level_data.enems_life;
			#endif
		}

		// Init enems:
		// - Asign "base frame"
		// - Init coordinates for flying people
		// Remember XTTTTDNN, TTTT = type, D = fires balls, NN = sprite number

		gpt = baddies [enoffsmasi].t >> 3;
		if (gpt && gpt < 16) {
			en_an_base_frame [gpit] = (baddies [enoffsmasi].t & 3) << 1;

			switch (gpt) {
				#ifdef ENABLE_FLYING_ENEMIES
					case 2:
						// Flying
						#ifdef TYPE_6_FIXED_SPRITE
							en_an_base_frame [gpit] = TYPE_6_FIXED_SPRITE << 1;
						#endif
						en_an_x [gpit] = baddies [enoffsmasi].x << FIXBITS;
						en_an_y [gpit] = baddies [enoffsmasi].y << FIXBITS;
						en_an_vx [gpit] = en_an_vy [gpit] = 0;
						en_an_state [gpit] = TYPE_6_IDLE;
						break;
				#endif
				#ifdef ENABLE_HANNA_MONSTERS_11
					case 11:
						en_an_state [gpit] = 0;
						break;
				#endif
				default:
					break;
			}

		} else {
			en_an_n_f [gpit] = sprite_18_a;
		}
	}

}

void enems_move (void) {

	p_gotten = 0;
	ptgmx = ptgmy = 0;
	tocado = 0;

	for (gpit = 0; gpit < 3; ++ gpit) {
		active = killable = animate = 0;
		enoffsmasi = enoffs + gpit;

		// Copy array values to temporary variables as fast as possible
		
		#asm
				// Those values are stores in this order:
				// x, y, x1, y1, x2, y2, mx, my, t, life
				// Point HL to baddies [enoffsmasi]. The struct is 10 bytes long
				// so this is baddies + enoffsmasi*9, or...
				// enoffsmasi is, at maximum, ((MAP_W*MAP_H)-1)*3+2, or 47.
				// We can keep the multiplications 8-bit as long as possible
				ld 	a, (_enoffsmasi) 	// Max 47
				sla a 					// Max 94  (x2)
				ld  b, a 				// B = A*2
				sla a 					// Max 188 (x4)
				ld  l, a
				ld  h, 0
				add hl, hl 				// HL = x8
				
				ld  e, b 
				ld  d, 0                // DE = x2
				add hl, de 				// HL = x10

				ld  de, _baddies
				add hl, de

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
				inc hl 

				ld  a, (hl)
				ld  (__en_life), a
		#endasm
	
		/*
		if (en_an_state [gpit] == GENERAL_DYING) {
			-- en_an_count [gpit];
			if (0 == en_an_count [gpit]) {
				en_an_state [gpit] = 0;
				en_an_n_f [gpit] = sprite_18_a;
				goto continue_enems_loop;
			}
		}
		*/
		#asm
				// Keep gpit on BC
				ld  bc, (_gpit)
				ld  b, 0

				ld  hl, _en_an_state
				add hl, bc
				ld  a, (hl)
				cp  GENERAL_DYING
				jr  nz, _enems_general_dying_done

				ld  hl, _en_an_count;
				add hl, bc
				dec (hl)

				jr nz, _enems_general_dying_done

				ld  hl, _en_an_state
				add hl, bc
				xor a
				ld  (hl), a

				ld  hl, _en_an_n_f
				add hl, bc
				add hl, bc
				ld  (hl), _sprite_18_a

				jp _continue_enems_loop_a

			._enems_general_dying_done
		#endasm

		// Gotten preliminary:	
		/*
		pregotten =	(prx + 12 >= _en_x && prx <= _en_x + 12) &&
					(pry + 15 >= _en_y && pry <= _en_y);
		*/
		
		#asm
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

				// pry + 15 >= _en_y
				ld  a, (__en_y)
				ld  c, a
				ld  a, (_pry)
				add 15
				cp  c
				jp  c, _enems_move_pregotten_not	// branch if <

				// pry <= _en_y; _en_y >= pry
				ld  a, (_pry)
				ld  c, a
				ld  a, (__en_y)
				cp  c
				jp  c, _enems_move_pregotten_not	// branch if <

				ld  a, 1
				jr  _enems_move_pregotten_set

			._enems_move_pregotten_not
				xor a

			._enems_move_pregotten_set
				ld  (_pregotten), a
		
			// enemy_shoots = (_en_t & 4);
			// gpt = _en_t >> 3;

				ld  a, (__en_t)
				ld  c, a
				and 4
				ld  (_enemy_shoots), a
				ld  a, c
				srl a
				srl a
				srl a
				ld  (_gpt), a
		#endasm
		
		switch (gpt) {
			case 1:			// linear
				killable = 1;
			case 8:			// moving platforms
				#include "engine/enemmods/enem_linear.h"
				break;
			#ifdef ENABLE_FLYING_ENEMIES
				case 2:		// flying
					#include "engine/enemmods/enem_fanty.h"
					break;
			#endif
			#ifdef ENABLE_PURSUERS
				case 3:		// pursuers
					#include "engine/enemmods/enem_pursuers.h"
					break;
			#endif
			case 10:		// arrows
				#include "engine/enemmods/enem_arrows.h"
				break;
			#ifdef ENABLE_HANNA_MONSTERS_11
				case 11:	// Hanna monsters type 11
					#include "engine/enemmods/enem_hanna_11.h"
					break;
			#endif
			default:
				if (gpt > 15 && en_an_state [gpit] != GENERAL_DYING) en_an_n_f [gpit] = sprite_18_a;
		}

		if (active) {
			if (animate) {
				#include "engine/enemmods/enems_animate.h"
			}

			#ifdef ENABLE_HITTER
				#include "engine/enemmods/enems_hitter.h"
			#endif

			#if defined (PLAYER_SIMPLE_BOMBS)
				#include "engine/enemmods/enems_bombs.h"
			#endif

			// Collide with player
			#include "engine/enemmods/enem_platforms_25d.h"
			// If there was a collision with a 25d platform, this block is skipped
			// (there's a jp _enems_collision_skip)...

			/*
			if ((tocado == 0) && collide (prx, pry, _en_x, _en_y) && p_state == EST_NORMAL) {
				if (p_life > 0) {
					tocado = 1;
					p_killme = 1;
				}
			}
			*/

			#asm
				._enems_collision 
					ld  a, (__en_t)
					and 8
					ld  a, (__en_y)
					jr  z, _enems_collision_no_pixel_shift
					sub PIXEL_SHIFT
				._enems_collision_no_pixel_shift
					ld  (_gpen_y), a


					ld  a, (_tocado)
					or  a
					jr  nz, _enems_collision_skip

					ld  a, (_p_state)
					or  a
					jr  nz, _enems_collision_skip

					// (prx + 8 >= _en_x && prx <= _en_x + 8 && pry + 8 >= _en_y && pry <= _en_y + 8)

					// prx + 8 >= _en_x
					ld  a, (__en_x)
					ld  c, a
					ld  a, (_prx)
					add 8
					cp  c
					jr  c, _enems_collision_skip

					// prx <= _en_x + 8; _en_x + 8 >= prx
					ld  a, (_prx)
					ld  c, a
					ld  a, (__en_x)
					add 8
					cp  c
					jr  c, _enems_collision_skip

					// pry + 8 >= _en_y
					ld  a, (_gpen_y)
					ld  c, a
					ld  a, (_pry)
					add 8
					cp  c
					jr  c, _enems_collision_skip

					// pry <= _en_y + 8; _en_y + 8 >= pry
					ld  a, (_pry)
					ld  c, a
					ld  a, (_gpen_y)
					add 8
					cp  c
					jr  c, _enems_collision_skip

					ld  a, 1
					ld  (_tocado), a
					ld  (_p_killme), a
					
				._enems_collision_skip
			#endasm

			#ifdef PLAYER_CAN_FIRE
				#include "engine\enemmods\enems_bullets.h"
			#endif
		}

		// Restore temporary values to arrays as fast as possible
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
			inc hl

			ld  a, (__en_life)
			ld  (hl), a
		#endasm

	}
}
