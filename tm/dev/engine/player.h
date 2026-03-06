// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Player related functions

void player_init (void) {
	prx = PLAYER_INI_X << 4; p_x = prx << FIXBITS;
	pry = PLAYER_INI_Y << 4; p_y = pry << FIXBITS;

	#asm
			xor a
			ld  (_p_vy), a
			ld  (_p_vx), a
			ld  (_p_saltando), a
			ld  (_p_frame), a
			ld  (_p_subframe), a
			ld  (_p_objs), a
			ld  (_p_state), a
			ld  (_p_ct_state), a
	#endasm
	
	p_jump_ct = 1;
	p_facing = PLAYER_FACING_RIGHT;	
	p_life = PLAYER_LIFE;
}

void player_kill (void) {
	fx_beeper (p_killme);
	p_killme = 0;

	if (p_life) -- p_life; else playing = 0;

	#ifdef PLAYER_FLICKERS
		p_state = PLAYER_STATE_FLICKERING; p_ct_state = 50;
	#endif	
}

#ifdef PLAYER_BOUNCES
	void player_bounce (void) { if (ABS (p_vx) > ABS (p_vy)) p_vx = -p_vx; else p_vy = -p_vy; }
#endif

void player_move (void) {
	// 
	// State
	//
	
	#asm
			ld  a, (_p_state)
			or  a
			jr  z, _player_move_state_done

			ld  a, (_p_ct_state)
			dec a
			or  a
			jr  nz, _player_move_state_set

			xor a
			
		._player_move_state_set
			ld  (_p_state), a

		._player_move_state_done
	#endasm

	// 
	// Vertical
	//

	if (p_vy <= PLAYER_MAX_VY_CAYENDO - PLAYER_G)
		p_vy += PLAYER_G;
	else
		p_vy = PLAYER_MAX_VY_CAYENDO;

	if (p_gotten) p_vy = 0;		

	p_y += p_vy;
	
	// Safe
	if (p_y < 0) p_y = 0;		
	if (p_y > (144 << FIXBITS)) p_y = (144 << FIXBITS);

	pry = p_y >> FIXBITS;

	hit_v = 0;
	
	#asm

	// Collision

			ld  hl, _ptgmy
			ld  a, (_p_vy)
			add a, (hl)
			ld  (_rds), a

			or  a
			jp  z, _player_move_vert_col_done

			ld  a, (_prx)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_cx1), a

			ld  a, (_prx)
			add 11
			srl a
			srl a
			srl a
			srl a
			ld  (_cx2), a

			ld  a, (_rds)
			and 0x80
			jr  z, _player_move_vert_col_down

		._player_move_vert_col_up
			ld  a, (_pry)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_cy1), a
			ld  (_cy2), a

			call _cm_two_points

			ld  a, (_at1)
			and 8
			jr  nz, _player_move_vert_col_up_do

			ld  a, (_at2)
			and 8
			jp  z, _player_move_vert_col_else

		._player_move_vert_col_up_do 
			xor a
			ld  (_p_vy), a
			ld  a, (_cy1)
			inc a
			sla a
			sla a
			sla a
			sla a
			sub 4
			ld  (_pry), a

			; shift left FIXBITS times, 16 bits
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_y), hl
			
			jr _player_move_vert_col_done

		._player_move_vert_col_down			
			ld  a, (_pry)
			add 16
			srl a
			srl a
			srl a
			srl a
			ld  (_cy1), a
			ld  (_cy2), a			

			// Check done!

			call _cm_two_points

			// This check is to prevent "platform hopping", where you pop if start falling mid-platform 
			
			ld  a, (_p_vy)
			srl a
			srl a
			srl a
			srl a // times FIXBIT
			inc a
			ld  b, a

			ld  a, (_pry)
			and 15
			cp  b
			jr  nc, _player_move_vert_col_else

			// Now check tile attributes

			ld  a, (_at1)
			and 12
			jr  nz, _player_move_vert_col_down_do

			ld  a, (_at2)
			and 12
			jr  z, _player_move_vert_col_else

		._player_move_vert_col_down_do 
			xor a
			ld  (_p_vy), a
			ld  a, (_cy1)
			dec a
			sla a
			sla a
			sla a
			sla a			
			ld  (_pry), a

			; shift left FIXBITS times, 16 bits
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_y), hl
			
			jr _player_move_vert_col_done
	
		._player_move_vert_col_else
		#ifndef ENABLE_EVIL_TILES
			ld  a, (_at1)
			and 1
			jr  nz, _player_move_vert_evil_do

			ld  a, (_at2)
			and 1
			jr  z, _player_move_vert_col_done

		._player_move_vert_evil_do
			ld  a, 1
			ld  (_hit_v), a
		#endif
		._player_move_vert_col_done

	// Floor detections
	
			ld  a, (_pry)
			add 16
			srl a
			srl a
			srl a
			srl a
			ld  (_cy1), a
			ld  (_cy2), a
			call _cm_two_points

			// ppossee

			ld  a, (_at1)
			and 12
			ld  c, a
			ld  a, (_at2)
			and 12
			or  c
			ld  (_possee), a
	
	// Jumping
	
		// rda = (((pad & sp_FIRE) == 0) || ((pad & sp_UP) == 0));

			ld  a, (_pad)
			and sp_FIRE
			jr  z, _player_move_rda_set_1

			ld  a, (_pad)
			and sp_UP
			jr  nz, _player_move_rda_set_0

		._player_move_rda_set_1
			ld  a, 1
			jr  _player_move_rda_set

		._player_move_rda_set_0
			xor a 

		._player_move_rda_set
			ld  (_rda), a
	
			or  a
			jr  z, _player_move_jump_reset

			ld  a, (_p_saltando)
			or  a
			jr  nz, _player_move_jump_start_done

			ld  a, (_possee)
			or  a
			jr  nz, _player_move_jump_start

			ld  a, (_p_gotten)
			or  a 
			jr  nz, _player_move_jump_start

			ld  a, (_hit_v)
			or  a
			jr  z, _player_move_jump_start_done

		._player_move_jump_start
			ld  a, 1
			ld  (_p_saltando), a
			xor a
			ld  (_p_jump_ct), a
			ld  hl, 1
			push hl
			call _fx_beeper
			pop  bc

		._player_move_jump_start_done

			ld  a, (_p_saltando)
			and a
			jr  z, _player_move_jump_done

		._player_move_jump_do
			ld  a, (_p_jump_ct)
			srl a
			ld  b, a
			ld  a, PLAYER_VY_INICIAL_SALTO + PLAYER_INCR_SALTO
			sub b
			ld  b, a
			ld  a, (_p_vy)
			sub b
			ld  (_p_vy), a

			// signed comparison
			ld  a, (_p_vy)
			cp  -PLAYER_MAX_VY_SALTANDO
			jp  m, _player_move_jump_do_p_vy_s
			jr  _player_move_jump_do_p_vy_ns
		._player_move_jump_do_p_vy_s
			ld  a, -PLAYER_MAX_VY_SALTANDO
			ld  (_p_vy), a
		._player_move_jump_do_p_vy_ns

			ld  hl, _p_jump_ct
			inc (hl)
			ld  a, (hl)
			cp  8
			jr  nz, _player_move_jump_done
			xor a
			ld  (_p_saltando), a

			jr  _player_move_jump_done

		._player_move_jump_reset
			xor a
			ld  (_p_saltando), a

		._player_move_jump_done
	#endasm

	//
	// Horizontal
	//

	#asm
		// Read pad

		// Set rda if pad left

			ld  a, (_pad)
			and sp_LEFT
			jr  z, _player_move_horz_pad_left_1
			xor a
			jr  _player_move_horz_pad_left_set
		._player_move_horz_pad_left_1
			ld  a, 1
		._player_move_horz_pad_left_set			
			ld  (_rda), a

		// Set rdb if pad right

			ld  a, (_pad)
			and sp_RIGHT
			jr  z, _player_move_horz_pad_right_1
			xor a
			jr  _player_move_horz_pad_right_set
		._player_move_horz_pad_right_1			
			ld  a, 1

		._player_move_horz_pad_right_set					
			ld  (_rdb), a

		// Check if pad left AND right (cancel)

			or  a 	// if (rdb)
			jr  z, _player_move_horz_pad_cancel_no

			ld  a, (_rda)
			or  a
			jr  z, _player_move_horz_pad_cancel_no

		._player_move_horz_pad_cancel
			jp _player_move_horz_pad_done

		._player_move_horz_pad_cancel_no

		// Check if pad left

			ld  a, (_rda)
			or  a
			jr  z, _player_move_horz_pad_left_done

		._player_move_horz_pad_left
			ld  a, PLAYER_FACING_LEFT
			ld  (_p_facing), a

			// if (p_vx < -(PLAYER_MAX_VX-PLAYER_AX)) p_vx = -PLAYER_MAX_VX; else p_vx -= PLAYER_AX; 
			ld  a, (_p_vx)
			cp  -PLAYER_MAX_VX+PLAYER_AX

			jp  m, _player_move_horz_pad_left_A

			ld  a, (_p_vx)
			sub PLAYER_AX
			jr  _player_move_set_pvx

		._player_move_horz_pad_left_A
			ld  a, -PLAYER_MAX_VX
					
		._player_move_horz_pad_left_done

		// Check if pad right

			ld  a, (_rdb)
			or  a
			jr  z, _player_move_horz_pad_right_done
			
		._player_move_horz_pad_right
			ld  a, PLAYER_FACING_RIGHT
			ld  (_p_facing), a

			// if (p_vx < PLAYER_MAX_VX-PLAYER_AX+1) p_vx += PLAYER_AX; else p_vx = PLAYER_MAX_VX;
			ld  a, (_p_vx)
			cp  PLAYER_MAX_VX-PLAYER_AX+1

			jp  m, _player_move_horz_pad_right_A

			ld  a, PLAYER_MAX_VX
			jr  _player_move_set_pvx

		._player_move_horz_pad_right_A
			ld  a, (_p_vx)
			add PLAYER_AX
			jr  _player_move_set_pvx
	
		._player_move_horz_pad_right_done

		// Neither pad left or pad right are pressed, deccelerate!

			ld  a, (_p_vx)
			bit 7, a
			jr  nz, _player_move_horz_pad_no_neg

		._player_move_horz_pad_no_pos
			sub PLAYER_RX
			bit 7, a
			jr z, _player_move_set_pvx
			xor a
			jr _player_move_set_pvx

		._player_move_horz_pad_no_neg
			add PLAYER_RX
			bit 7, a
			jr  nz, _player_move_set_pvx
			xor a

		// All done, modify p_vx

		._player_move_set_pvx
			ld  (_p_vx), a

		._player_move_horz_pad_done

			ld  a, (_rda)
			ld  c, a
			ld  a, (_rdb)
			or  c
			ld  (_p_pad), a

	#endasm

	p_x = p_x + p_vx;
	p_x = p_x + ptgmx;
	
	// Safe	
	if (p_x < 0) p_x = 0;
	if (p_x > (224 << FIXBITS)) p_x = (224 << FIXBITS);

	prx = p_x >> FIXBITS;

	hit_h = 0;

	#asm

	// Collision
	
			ld  hl, _ptgmx
			ld  a, (_p_vx)
			add a, (hl)
			ld  (_rds), a

			or  a
			jp  z, _player_move_horz_col_done

			ld  a, (_pry)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_cy1), a

			ld  a, (_pry)
			add 15
			srl a
			srl a
			srl a
			srl a
			ld  (_cy2), a

			ld  a, (_rds)
			and 0x80
			jr  z, _player_move_horz_col_right

		._player_move_horz_col_left
			ld  a, (_prx)
			add 4
			srl a
			srl a
			srl a
			srl a
			ld  (_cx1), a
			ld  (_cx2), a

			call _cm_two_points

			ld  a, (_at1)
			and 8
			jr  nz, _player_move_horz_col_left_do

			ld  a, (_at2)
			and 8
			jr  z, _player_move_horz_col_else

		._player_move_horz_col_left_do 
			xor a
			ld  (_p_vx), a
			ld  a, (_cx1)
			inc a
			sla a
			sla a
			sla a
			sla a
			sub 4
			ld  (_prx), a

			; shift left FIXBITS times, 16 bits
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_x), hl
			
			jr _player_move_horz_col_done

		._player_move_horz_col_right
			ld  a, (_prx)
			add 12
			srl a
			srl a
			srl a
			srl a
			ld  (_cx1), a
			ld  (_cx2), a

			call _cm_two_points

			ld  a, (_at1)
			and 8
			jr  nz, _player_move_horz_col_right_do

			ld  a, (_at2)
			and 8
			jr  z, _player_move_horz_col_else

		._player_move_horz_col_right_do 
			xor a
			ld  (_p_vx), a
			ld  a, (_cx1)
			dec a
			sla a
			sla a
			sla a
			sla a
			add 4	
			ld  (_prx), a

			; shift left FIXBITS times, 16 bits
			ld  d, 0
			ld  e, a
			ld  l, FIXBITS
			call l_asl
			ld  (_p_x), hl
			
			jr _player_move_horz_col_done
	
		._player_move_horz_col_else
		#ifdef ENABLE_EVIL_TILES
			ld  a, (_at1)
			and 1
			jr  nz, _player_move_horz_evil_do

			ld  a, (_at2)
			and 1
			jr  z, _player_move_horz_col_done

		._player_move_horz_evil_do
			ld  a, 1
			ld  (_hit_h), a
		#endif
		._player_move_horz_col_done
	#endasm	

	// Tiles that kill
	#ifdef ENABLE_EVIL_TILES 
		// hit_v tiene preferencia sobre hit_h

		hit = 0;
		if (hit_v) {
			hit = 1;
			p_vy = addsign (-p_vy, PLAYER_MAX_VX);
		} else if (hit_h) {
			hit = 1;
			p_vx = addsign (-p_vx, PLAYER_MAX_VX);
		}
		
		if (hit && p_state == PLAYER_STATE_NORMAL) p_killme = 3;
	#endif

	// Select animation frame 
	
	#asm
			ld  a, (_p_state)
			and PLAYER_STATE_FLICKERING
			jr  z, _player_move_select_cell

			ld  a, (_half_life)
			or  a
			jr  z, _player_move_select_cell

			ld  hl, _SPR_CELL(CELL_EMPTY)
			jr  _player_move_select_cell_done

		._player_move_select_cell			
			ld  a, (_possee)
			or  a
			jr  nz, _player_move_select_cell_not_air

			ld  a, (_p_gotten)
			or  a
			jr  nz, _player_move_select_cell_not_air

			ld  c, PLAYER_CELL_AIRBORNE
			jr  _player_select_cell_set

		._player_move_select_cell_not_air
			ld  a, (_p_pad)
			or  a
			jr  nz, _player_move_select_cell_walk

			ld  c, PLAYER_CELL_IDLE
			jr  _player_select_cell_set

		._player_move_select_cell_walk 
			ld  a, (_p_subframe)
			or  a
			jr  nz, _player_move_select_cell_A 

	#ifdef PLAYER_STEP_SOUND
			call _step
	#endif

			ld  a, (_p_frame)
			inc a
			and 3
			ld  (_p_frame), a

			ld  a, 4
			jr  _player_move_select_cell_B

		._player_move_select_cell_A 
			dec a

		._player_move_select_cell_B
			ld  (_p_subframe), a
			
			ld  a, (_p_frame)
			add PLAYER_CELL_WALK_BASE
			ld  c, a			

		._player_select_cell_set
			ld  a, (_p_facing)
			add c

			sla a
			ld  b, 0
			ld  c, a
			ld  hl, _player_frames
			add hl, bc
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			ex  de, hl
		
		._player_move_select_cell_done			
			ld  (_p_next_frame), hl		

			// Precalc this, comes handy:
			//prxc = prx >> 3; pryc = pry >> 3;
			ld  a, (_prx)
			srl a
			srl a
			srl a
			ld  (_prxc), a

			ld  a, (_pry)
			srl a
			srl a
			srl a
			ld  (_pryc), a

	#endasm
}
