// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

void init_player (void) {
	p_z = p_vz = 0;
	p_jmp_facing = 0;
	p_vy = 0;
	p_vx = 0;
	p_jmp_ct = 1;
	p_jmp_on = 0;
	p_frame = 0;
	p_subframe = 0;
	p_facing = FACING_DOWN;
	p_facing_v = p_facing_h = 0xff;
	p_state = EST_NORMAL;
	p_state_ct = 0;
	p_objs = 0;
	p_keys = 0;
	flags [BODY_COUNT_ON] = 0;
	p_disparando = 0;
	ctimer.count = 0;
	ctimer.zero = 0;
	ctimer.frames = TIMER_LAPSE;
	ctimer.t = TIMER_INITIAL;
	ctimer.on = 0;
	p_killme = 0;
	p_safe_pant = n_pant;
	p_safe_x = p_x >> (4+FIXBITS);
	p_safe_y = p_y >> (4+FIXBITS);
}

void player_kill (void) {
	-- p_life;
	
	_AY_ST_ALL ();
	_AY_PL_SND (8);
	p_killme = 0;
	
	p_state = EST_PARP;
	p_state_ct = 50;

	active_sleep (50);

	if (n_pant != p_safe_pant) {
		o_pant = n_pant = p_safe_pant;
		draw_scr ();
	}

	p_x = p_safe_x << FIXBITS;
	p_y = p_safe_y << FIXBITS;
	p_vx = 0;
	p_vy = 0;
	p_jmp_on = 0;

	_AY_PL_SND (18);
}

unsigned char player_move (void) {
	#asm
			xor a
			ld  (_wall_v), a
			ld  (_wall_h), a
			ld  (_p_thrust), a
	#endasm	

	/*
	if (p_state) {
		-- p_state_ct; 
		if (p_state_ct == 0) {
			if (p_state & EST_HOLED) p_killme = 1;
			else p_state = EST_NORMAL;
		}
		if (p_state & EST_HOLED) pad = 0xff;
	}
	*/
	#asm
			ld  a, (_p_state)
			ld  c, a
			or  a
			jr  z, player_move_p_state_done

			ld  a, (_p_state_ct)
			dec a
			ld  (_p_state_ct), a

			jr  nz, player_move_p_state_zero_done

			ld  a, c
			and EST_HOLED
			jr  z, player_move_p_state_set_normal

			ld  a, 1
			ld  (_p_killme), a
			jr  player_move_p_state_zero_done

		.player_move_p_state_set_normal
			xor a
			ld  (_p_state), a

		.player_move_p_state_zero_done
			ld  a, c
			and EST_HOLED
			jr  z, player_move_p_state_done

			ld  a, 255
			ld  (_pad), a

		.player_move_p_state_done
	#endasm
	
	// Get bottom-center pixel tile behaviour for several NEW_GENITAL stuff		
	// prxx = (prx + 8) >> 4; pryy = (pry + 15) >> 4;
	#asm
			ld  a, (_prx)
			add 8
			srl a
			srl a
			srl a
			srl a
			ld  (_prxx), a

			ld  a, (_pry)
			add 15
			srl a
			srl a
			srl a
			srl a
			ld  (_pryy), a
	#endasm
	// pt1 = attr (prxx, pryy);
	ATTR (prxx, pryy, pt1);

	// Pre-detect conveyors. Needs attr @ bottom-center pixel in pt1!
	#include "engine/playermods/ng_conveyors.h"

	// Pre-detect behaviour 64. Needs attr @ bottom-center pixel in pt1!
	#include "engine/playermods/ng_beh64.h"

	// ***************************************************************************
	//  MOVEMENT IN THE VERTICAL AXIS
	// ***************************************************************************

	
	// Top-down
	#include "engine/playermods/va_genital.h"

	// Gravity
	#include "engine/playermods/va_gravity.h"

	// Move
	p_y += p_vy;
	if (p_gotten) p_y += ptgmy;

	p_z += p_vz;
	if (p_z > 0) p_z = p_vz = 0;
	
	// Safe
	if (p_y < 0) p_y = 0;
	if (p_y > (144 << FIXBITS)) p_y = (144 << FIXBITS);

	pry = p_y >> FIXBITS;

	// Handle collision
	// "New genital" top-down games need slightly different vertical collision
	#include "engine/playermods/va_collision_25d.h"
	
	// Possee - player is on solid floor.
	#include "engine/playermods/possee.h"

	// Jumping Jack!
	#include "engine/playermods/jump_genital.h"


	// ***************************************************************************
	//  MOVEMENT IN THE HORIZONTAL AXIS
	// ***************************************************************************

	
	// Conveyors
	#include "engine/playermods/ha_conveyors.h"
	
	// Controller
	#include "engine/playermods/ha_controller.h"

	// Move
	p_x = p_x + p_vx;
	if (p_gotten) p_x += ptgmx;

	// Safe
	if (p_x < 0) p_x = 0;
	if (p_x > (224 << FIXBITS)) p_x = (224 << FIXBITS);

	prx = p_x >> FIXBITS;

	// Handle collision
	// "New genital" top-down games need slightly different vertical collision
	#include "engine/playermods/ha_collision_25d.h"


	// **********
	// MORE STUFF
	// **********

	// Priority to decide facing
	
	#asm
			ld  a, (_p_facing_h)
			cp  255
			jr  nz, player_moving_facing_set 
		
		.player_moving_facing_sel_not_h
			ld  a, (_p_facing_v)
			cp  255
			jr  z, player_moving_facing_done		

		.player_moving_facing_set
			ld  (_p_facing), a

		.player_moving_facing_done

	#endasm

	// *******
	// Hitters
	// *******
	
	#include "engine/playermods/hitter.h"

	// *****
	// Bombs
	// *****
	
	#include "engine/playermods/bombs.h"

	// Done with the fire button...

	if (0 == BUTTON_FIRE) p_disparando = invalidate_fire = 0;

	// **********
	// Evil tiles
	// **********

	// hit_v tiene preferencia sobre hit_h
	hit = 0;
	if (hit_v == TILE_EVIL) {
		hit = 1;
		p_vy = addsign (-p_vy, PLAYER_VX_MAX);
	} else if (hit_h == TILE_EVIL) {
		hit = 1;
		p_vx = addsign (-p_vx, PLAYER_VX_MAX);
	}
	if (hit) {
		if (p_life > 0 && p_state == EST_NORMAL) {
			p_killme = 1;
		}
	}

	// **********
	// Hole tiles
	// **********

	prx = p_x >> FIXBITS;
	pty1 = (pry + 15) >> 4;
	ptx1 = (prx + 4) >> 4;
	ptx2 = (prx + 12) >> 4;
	ATTR (ptx1, pty1, pt1);
	ATTR (ptx2, pty1, pt2);
	if (p_z == 0 && p_gotten == 0 && pt1 == 3 && pt2 == 3 && p_state != EST_HOLED) {
		if (p_ct_hole < 2) {
			++ p_ct_hole;
		} else {
			if (p_vy > 0) { pry += 8; p_y = pry << FIXBITS; }
			p_state = EST_HOLED; p_state_ct = 50;
		}
	} else p_ct_hole = 0;

	// ********
	// Tile get 
	// ********
	

	// **********************
	// Select animation frame
	// **********************

	#asm
		// if (p_state == EST_HOLED) { p_n_f = FALLING_FRAME; if (p_state_ct < 25) p_n_f += 144; } else

			ld  a, (_p_state)
			and EST_HOLED
			jr  z, _player_move_af_not_holed

			ld  a, (_p_state_ct)
			cp  1
			jr  nc, _playe_move_af_holed_falling

			ld hl, _sprite_18_a
			jr _player_move_af_holed_set

		._playe_move_af_holed_falling
			ld  hl, _sprite_e;
			
			cp  25
			jr  nc, _player_move_af_holed_set

			ld  bc, 144
			add hl, bc 

		._player_move_af_holed_set
			ld  (_p_n_f), hl

			jr  _player_move_af_done

		._player_move_af_not_holed

		// if (p_z != 0) { p_n_f = player_frames [1 + p_jmp_facing]; } else

			ld  a, (_p_z)
			ld  c, a
			ld  a, (_p_z+1)
			or  c
			jr  z, _player_move_af_floor

			ld  de, (_p_jmp_facing)
			ld  d, 0
			inc de
			ld  hl, _player_frames
			add hl, de
			add hl, de
			jr  _player_move_af_set

		._player_move_af_floor

		// if (p_vx == 0 && p_vy == 0) { p_n_f = player_frames [p_facing]; } else

			ld  a, (_p_vx)
			and a
			jr  nz, _player_move_af_floor_moving

			ld  a, (_p_vy)
			and a
			jr  nz, _player_move_af_floor_moving

			ld  de, (_p_facing)
			ld  d, 0
			ld  hl, _player_frames
			add hl, de
			add hl, de
			jr  _player_move_af_set

		._player_move_af_floor_moving

			ld  a, (_p_subframe)
			inc a
			ld  (_p_subframe), a
			cp  4
			jr  nz, _player_move_af_incframe_done

			ld  a, (_p_frame)
			xor 1
			ld  (_p_frame), a

			call _step

			xor a			
		._player_move_af_incframe_done
			ld  (_p_subframe), a

			ld  a, (_p_facing)
			ld  c, a
			ld  a, (_p_frame)
			add c
			sla a
			ld  b, 0
			ld  c, a
			ld  hl, _player_frames
			add hl, bc
			jr  _player_move_af_set

		._player_move_af_set
			ld  de, _p_n_f
			ldi
			ldi

		._player_move_af_done
			
	#endasm
}
