// Functions & Routines

void add_to_score (unsigned int amount) {	
	player.score += amount;
	draw_5_digit (25, 18, player.score);
	if (player.score > player.hiscore) {
		player.hiscore = player.score;
		draw_5_digit (25, 21, player.score);
	}
}

void destructors_init (void) {
	/*
	dei = MAX_DESTRUCTORS; while (dei --) {
		destructors_slots [dei] = dei;
		destructors_ct [dei] = 0;
	}
	destructors_slots_i = MAX_DESTRUCTORS;
	*/
	#asm
			ld  bc, MAX_DESTRUCTORS

		.destructors_init_loop
			dec c

			ld  hl, _destructors_slots
			add hl, bc
			ld  (hl), c

			ld  hl, _destructors_ct
			add hl, bc
			xor a
			ld  (hl), a

			or  c
			jr  nz, destructors_init_loop

			ld  a, MAX_DESTRUCTORS
			ld  (_destructors_slots_i), a
	#endasm
}

void focos_init (void) {
	#asm
			ld  bc, MAX_FOCOS

		.focos_init_loop
			dec c

			ld  hl, _focos_slots
			add hl, bc
			ld  (hl), c

			ld  hl, _focos_ct
			add hl, bc
			xor a
			ld  (hl), a

			or  c
			jr  nz, focos_init_loop

			ld  a, MAX_FOCOS
			ld  (_focos_slots_i), a
	#endasm
}

void shoots_init (void) {
	/*
	for (gpit = 0; gpit < MAX_SHOOTS; gpit ++)
		shoots_active [gpit] = 0;	
	*/
	#asm
			ld  hl, _shoots_active
			ld  de, _shoots_active + 1
			ld  bc, MAX_SHOOTS - 1
			xor a
			ld  (hl), a
			ldir
	#endasm
}

void mapdata_init (void) {
	// Examine map to create spawners
	/*
	max_spawners = 0;
	for (gpint = 0; gpint < 2560; ++ gpint) {
		rdx = (unsigned char) ((gpint & 63) << 1);
		rdy = (unsigned char) ((gpint >> 6) << 1);
		gp_gen = ((unsigned char *) (DT_MAPDATA + gpint));
		if (*gp_gen >= 32 && ((*gp_gen) & 7) == 0) {
			spawners_y [max_spawners] = rdy;
			spawners_x [max_spawners] = rdx;
			spawners_type [max_spawners] = 1 + ((*gp_gen - 32) >> 3);
			spawners_en [max_spawners] = 4 + spawners_type [max_spawners];
			spawners_last_spawned [max_spawners] = 0;
			spawners_ptr [max_spawners] = gp_gen;
			max_spawners ++;
			*gp_gen = TILE_SPAWNER;
		} else if (*gp_gen == 16) {
			start_y = rdy;
			start_x = rdx;
			*gp_gen = 0;
		}
	}
	*/

	#asm
		.spawners_create
			xor a
			ld  (_max_spawners), a

			// Iterate whole map
			ld  bc, 2560
		.spawners_create_loop
			ld  a, b
			or  c
			jp  z, spawners_create_done
			dec bc

			// rdx = (unsigned char) ((gpint & 63) << 1);
			// use LSB
			ld  a, c
			and 63
			sla a
			ld  (_rdx), a

			// rdy = (unsigned char) ((gpint >> 6) << 1);
			ld  h, b
			ld  l, c
			call HLshr6_A
			sla a
			ld  (_rdy), a

			ld  hl, DT_MAPDATA
			add hl, bc

			// if (*gp_gen >= 32 && ((*gp_gen) & 7) == 0) {
			ld  a, (hl)
			cp  32
			jr  c, check_place_player

			and 7
			jr  nz, check_place_player

			ld  de, (_max_spawners)
			ld  d, 0

			// spawners_y [max_spawners] = rdy;
			ld  hl, _spawners_y
			add hl, de
			ld  a, (_rdy)
			ld  (hl), a

			// spawners_x [max_spawners] = rdx;
			ld  hl, _spawners_x
			add hl, de
			ld  a, (_rdx)
			ld  (hl), a

			// spawners_type [max_spawners] = 1 + ((*gp_gen - 32) >> 3);
			ld  hl, DT_MAPDATA
			add hl, bc
			ld  a, (hl)
			sub 32
			srl a
			srl a
			srl a
			inc a
			ld  hl, _spawners_type
			add hl, de
			ld  (hl), a

			// spawners_en [max_spawners] = 4 + spawners_type [max_spawners];
			add 4
			ld  hl, _spawners_en
			add hl, de
			ld  (hl), a

			// spawners_last_spawned [max_spawners] = 0;
			xor a
			ld  hl, _spawners_last_spawned
			add hl, de
			ld  (hl), a

			// spawners_ptr [max_spawners] = gp_gen;
			ld  hl, DT_MAPDATA
			add hl, bc
			push hl

			ld  hl, _spawners_ptr
			add hl, de
			add hl, de

			pop de
			ld  (hl), e
			inc hl
			ld  (hl), d

			ld  hl, _max_spawners
			inc (hl)

			ld  a, TILE_SPAWNER
			ld  hl, DT_MAPDATA
			add hl, bc
			ld  (hl), a
			jp  spawners_create_loop

		.check_place_player
			ld  a, (hl)
			cp  16
			jp  nz, spawners_create_loop

			ld  a, (_rdx)
			ld  (_start_x), a
			ld  a, (_rdy)
			ld  (_start_y), a

			xor a
			ld  (hl), a

			jp  spawners_create_loop

		.spawners_create_done
	#endasm
	
	// Spread some life recharges here and there.
	for (gpit = 0; gpit < max_recharges; ++ gpit) {
		// Look for a walkable tile. (Hopefully accesible).
		/*
		do {
			gpint = ((rand () % 40) << 6) + (rand () % 64);
			gp_gen = ((unsigned char *) (DT_MAPDATA + gpint));
			// All its 4 chars must be < 64 in attr.
			idx = *gp_gen << 2;
			rda = ((DT_TILESET + 2048 + idx) < 64 && (DT_TILESET + 2048 + idx + 1) < 64 && (DT_TILESET + 2048 + idx + 2) < 64 && (DT_TILESET + 2048 + idx + 3) < 64);
		} while (!rda || *gp_gen == TILE_KEY || *gp_gen == TILE_EXIT);
		*/

		// Better
		do {
			//gpint = ((rand () % 40) << 6) + (rand () % 64);
			rdy = rand () % 40;
			gpint = (rand () & 63) + (rdy << 6);

			gp_gen = ((unsigned char *) (DT_MAPDATA + gpint));
			rda = *gp_gen;
		} while (behs [rda] != 0 || rda == TILE_KEY || rda == TILE_EXIT );

		*gp_gen = TILE_RECHARGE;
	}
}

void char_mapdata_attribute (void) {
	/*
	return behs [
		*((unsigned char *) (DT_MAPDATA + (_x >> 1) + ((_y & 0xfe) << 5)))
	];
	*/
	#asm
			ld  a, (__y)
			and 0xfe
			ld  h, 0
			ld  l, a

			add hl, hl
			add hl, hl
			add hl, hl
			add hl, hl
			add hl, hl

			ld  de, (__x)
			ld  d, 0
			srl e
			add hl, de

			ld  de, DT_MAPDATA
			add hl, de

			ld  l, (hl)
			ld  h, 0
			ld  de, _behs
			add hl, de

			ld  l, (hl)
			ld  h, 0
	#endasm
}

void enemies_init (void) {
	/*
	for (gpit = 0; gpit < MAX_ENEMIES; ++ gpit)
		enemies_type [gpit] = 0;	
	*/
	#asm
			ld  hl, _enemies_type
			ld  de, _enemies_type + 1
			ld  bc, MAX_ENEMIES - 1
			xor a
			ld  (hl), a
			ldir
	#endasm
}

void destructors_create (void) {
	if (_x > 127 || _y > 79) return;
	if (destructors_slots_i) {
		// Make sure we don't create a new explosion on a existing one
		dei = MAX_DESTRUCTORS; while (dei) {
			-- dei; if (destructors_ct [dei] && destructors_address [dei] == gp_gen) return;
		}

		-- destructors_slots_i; dei = destructors_slots [destructors_slots_i];
		destructors_x [dei] = _x;
		destructors_y [dei] = _y;
		destructors_ct [dei] = 8;
		destructors_address [dei] = gp_gen;
		
		// Destroy tile if tile is destructible
		if (behs [*gp_gen] & (16+32)) *gp_gen = 0;

		wyz_play_sound (1);
	}
}

void destructors_update (void) {
	dei = MAX_DESTRUCTORS; while (dei) {
		-- dei;
		if (destructors_ct [dei]) {
			-- destructors_ct [dei];
			
			sx = 1 + destructors_x [dei] - cam_x;
			sy = 1 + destructors_y [dei] - cam_y;
			if (sx <= 30 && sy <= 15) {
				sn = 30 - (destructors_ct [dei] >> 2);
				sc = 71;
				draw_sprite ();
			}

			if (destructors_ct [dei] == 0) {
				destructors_slots [destructors_slots_i] = dei; ++ destructors_slots_i;
			}
		}
	}
}

void focos_create (void) {
	if (_x > 127 || _y > 79) return;
	if (focos_slots_i) {
		-- focos_slots_i; foic = focos_slots [focos_slots_i];
		focos_x [foic] = _x;
		focos_y [foic] = _y;
		focos_ct [foic] = 2;
		focos_propagador [foic] = _n;
		
		// Kill player
		if ((player.x >= _x - 1 && player.x <= _x + 1) &&
			(player.y >= _y - 1 && player.y <= _y + 1)
		) {
			if (player.energy > 25) player.energy -= 25; else player.energy = 1;
		}

		whichtile = (_x >> 1) + ((_y >> 1) << 6);
		gp_gen = ((unsigned char *) (DT_MAPDATA + whichtile));
		
		// Destroy map
		if (behs [*gp_gen] & 32) *gp_gen = 0;

		// Destroy spawners
		if (*gp_gen == TILE_SPAWNER) {
			// Find which
			for (si = 0 ; si < max_spawners; si ++) 
				if (spawners_type [si] > 0 && spawners_ptr [si] == gp_gen) {
					add_to_score (spawners_type [si] << 4);
					spawners_type [si] = 0;
					*gp_gen = 0;
				}
		}

		// Spawn a destructor
		destructors_create ();
 	}
}

void focos_update (void) {
	foi = MAX_FOCOS; while (foi) {
		-- foi;
		if (focos_ct [foi]) {
			-- focos_ct [foi];
			if (0 == focos_ct [foi]) {
				// Destroy foco
				focos_slots [focos_slots_i] = foi; ++ focos_slots_i;
				
				// Spawn new focos?
				if (focos_propagador [foi]) {
					_n = focos_propagador [foi] - 1;
					rdx = focos_x [foi]; rdy = focos_y [foi];
					_x = rdx - 2; _y = rdy; focos_create ();
					_x = rdx + 2;           focos_create ();
					_x = rdx; _y = rdy - 2; focos_create ();
					        ; _y = rdy + 2; focos_create ();
				}
			}
		}
	}
}

unsigned char shoots_find (void) {
	/*
	for (idx = 0; idx < n_shoots; ++ idx) 
		if (shoots_active [idx] == 0)
			return idx;
	return 255;
	*/
	#asm
			ld  a, (_n_shoots)
			ld  b, a
			ld  c, 0
			ld  hl, _shoots_active
		.shoots_find_loop
			ld  a, (hl)
			or  a
			jr  z, shoots_find_loop_done
			inc hl
			inc c
			djnz shoots_find_loop
			ld  c, 0xff

		.shoots_find_loop_done
			ld  l, c 				// Return index c
			ld  h, 0
	#endasm
}

unsigned char enemies_find (void) {
	/*
	for (idx = 0; idx < MAX_ENEMIES; ++ idx) 
		if (enemies_type [idx] == 0)
			return idx;
	return 255;
	*/	
	#asm
			ld  b, MAX_ENEMIES
			ld  c, 0
			ld  hl, _enemies_type
		.enemies_find_loop
			ld  a, (hl)
			or  a
			jr  z, enemies_find_loop_done
			inc hl
			inc c
			djnz enemies_find_loop
			ld  c, 0xff

		.enemies_find_loop_done
			ld  l, c 				// Return index c
			ld  h, 0
	#endasm
}

// Implied parameter: it is *always* bi
/*
void draw_shoot (unsigned char i) {
	dt_putchar (1 + shoots_x [i] - cam_x, 1 + shoots_y [i] - cam_y, º2 + (rand () & 1), 70 + (rand () & 1));	
	dt_putchar (1 + shoots_x [i] - cam_x + shoots_trail_dx [i], 1 + shoots_y [i] - cam_y + shoots_trail_dy [i], 112 + (rand () & 1), 70 + (rand () & 1));	
}
*/
void draw_shoot (void) {
	// Draw shoot #bi
	/*
	_x = 1 + shoots_x [bi] - cam_x;
	_y = 1 + shoots_y [bi] - cam_y;
	_n = 112 + (rand () & 1);
	_c = 70 + (rand () & 1);
	dt_putchar ();
	*/

	#asm
			ld  bc, (_bi)
			ld  b, 0

			ld  de, (_cam_x)
			ld  hl, _shoots_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub e
			ld  (__x), a

			ld  de, (_cam_y)
			ld  hl, _shoots_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub e 
			ld  (__y), a

			/*
			call _rand
			ld  a, l
			and 1
			add 112
			*/
			ld  a, 112
			ld  (__n), a

			/*
			call _rand
			ld  a, l
			and 1
			add 70
			*/
			ld  a, 70
			ld  (__c), a

			call _dt_putchar
	#endasm

	/*
	_x = 1 + shoots_x [bi] - cam_x + shoots_trail_dx [bi];
	_y = 1 + shoots_y [bi] - cam_y + shoots_trail_dy [bi];
	_n = 112 + (rand () & 1);
	_c = 70 + (rand () & 1);
	dt_putchar ();
	*/

	#asm
			ld  bc, (_bi)
			ld  b, 0

			ld  de, (_cam_x)
			ld  hl, _shoots_trail_dx
			add hl, bc
			ld  d, (hl)
			ld  hl, _shoots_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub e
			add d
			ld  (__x), a

			ld  de, (_cam_y)
			ld  hl, _shoots_trail_dy
			add hl, bc
			ld  d, (hl)
			ld  hl, _shoots_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub e 
			add d
			ld  (__y), a

			/*
			call _rand
			ld  a, l
			and 1
			add 112
			*/
			ld  a, 113
			ld  (__n), a

			/*
			call _rand
			ld  a, l
			and 1
			add 70
			*/
			ld  a, 66
			ld  (__c), a

			call _dt_putchar
	#endasm
}

void shoot_detect (void) {
	// Collide wall?
	/*
	_x = 1 + _sh_x - cam_x; _y = 1 + _sh_y - cam_y;
	if (0 == dt_attr ()) {
		shoots_active [bi] = 0;
		
		// Check if we hit a spawner
		whichtile = (_sh_x >> 1) + ((_sh_y >> 1) << 6);
		gp_gen = ((unsigned char *) (DT_MAPDATA + whichtile));
		if (*gp_gen == TILE_SPAWNER) {
			// Find which spawner
			for (si = 0 ; si < max_spawners; si ++) {
				if (((_sh_x >> 1) << 1) == spawners_x [si] &&
					((_sh_y >> 1) << 1) == spawners_y [si] &&
					spawners_type [si] > 0) {
					add_to_score (spawners_type [si] << 4);
					if (spawners_en [si] > 0) {
						spawners_en [si] --;		
					} else {
						// Kill spawner
						spawners_type [si] = 0;
						*gp_gen = 0;
					}
					draw_shoot ();
					break;
				}
			}
			wyz_play_sound (1);
		} else if (behs [*gp_gen] & 16) {
			// Breakable!
			_x = _sh_x & 0xfe;
			_y = _sh_y & 0xfe;
			destructors_create ();
			add_to_score (5);
		} else {
			wyz_play_sound (2);
		}
	}
	*/

	#asm
		.check_head

			// _x = 1 + _sh_x - cam_x; 
		
			ld  a, (_cam_x)
			ld  c, a
			ld  a, (__sh_x)
			inc a
			sub c
			ld  (__x), a

			// _y = 1 + _sh_y - cam_y;

			ld  a, (_cam_y)
			ld  c, a
			ld  a, (__sh_y)
			inc a
			sub c
			ld  (__y), a

			call _dt_attr
			xor a
			or  l
			jp  nz, check_trail

		.check_head_do
			// shoots_active [bi] = 0;
			ld  bc, (_bi)
			ld  b, 0
			ld  hl, _shoots_active
			add hl, bc
			ld  (hl), a 	// A = 0

			// whichtile = (_sh_x >> 1) + ((_sh_y >> 1) << 6);
			
			ld  a, (__sh_x)
			srl a
			ld  b, 0
			ld  c, a 		// BC = SH_X >> 1
			
			ld  a, (__sh_y)
			srl a 			// A = SH_Y >> 1

			// fast X << 6

			call Ashl6_HL 	// HL = (SH_Y >> 1) << 6

			add hl, bc 		// HL = ((SH_Y >> 1) << 6) + (SH_X >> 1)

			ld  (_whichtile), hl
			// gp_gen = ((unsigned char *) (DT_MAPDATA + whichtile));
			
			ld  bc, DT_MAPDATA
			add hl, bc
			ld  (_gp_gen), hl

		.check_spawner
			// if (*gp_gen == TILE_SPAWNER) {
			ld  a, (hl)
			cp  TILE_SPAWNER
			jr  nz, check_breakable

		.check_spawner_do
			// find which spawner
			ld  bc, (_max_spawners)
			ld  b, 0

		.check_spawner_loop
			xor a
			or  c
			jr  z, check_spawner_done

			dec c

			// if (((_sh_x >> 1) << 1) == spawners_x [si] &&
			// ((_sh_y >> 1) << 1) == spawners_y [si] &&
			//  spawners_type [si] > 0) {

			ld  a, (__sh_x)
			and 0xfe
			ld  d, a
			ld  hl, _spawners_x
			add hl, bc
			ld  a, (hl)
			cp  d
			jr  nz, check_spawner_loop

			ld  a, (__sh_y)
			and 0xfe
			ld  d, a
			ld  hl, _spawners_y
			add hl, bc
			ld  a, (hl)
			cp  d
			jr  nz, check_spawner_loop

			ld  hl, _spawners_type
			add hl, bc
			ld  a, (hl)
			or  a
			jr  z, check_spawner_loop

			ld  l, a
			ld  h, 0
			add hl, hl
			add hl, hl
			add hl, hl
			add hl, hl
			push bc
			push hl
			call _add_to_score
			pop hl
			pop bc

			ld  hl, _spawners_en
			add hl, bc
			ld  a, (hl)

			or  a
			jr  z, check_spawner_kill

			dec (hl)
			jr  check_spawner_kill_done

		.check_spawner_kill
			ld  hl, _spawners_type
			add hl, bc
			xor a
			ld  (hl), a

			ld  hl, (_gp_gen)
			ld  (hl), a

			ld  a, (__sh_x)	
			and 0xfe
			ld  (__x), a

			ld  a, (__sh_y)
			and 0xfe
			ld  (__y), a

			push bc
			call _destructors_create
			pop  bc

		.check_spawner_kill_done
			push bc
			call _draw_shoot
			pop bc
			jr  check_spawner_done

		.check_spawner_continue
			jr  check_spawner_loop 

		.check_spawner_done

			ld  hl, 1
			push hl
			call _wyz_play_sound
			pop bc

			jr  check_trail

		.check_breakable
			// Breakable?
			ld  hl, (_gp_gen)
			ld  a, (hl)
			ld  b, 0
			ld  c, a
			ld  hl, _behs
			add hl, bc
			ld  a, (hl)
			and 16
			jr  z, check_breakable_done

		.check_breakable_do
			ld  a, (__sh_x)
			and 0xfe
			ld  (__x), a

			ld  a, (__sh_y)
			and 0xfe
			ld  (__y), a

			call _destructors_create
			ld  hl, 5
			push hl
			call _add_to_score
			pop bc
			jr  check_trail

		.check_breakable_done

			ld  hl, 2
			push hl
			call _wyz_play_sound
			pop bc
		.check_trail
	#endasm

	// trail collision
}

void bomb_explode (void) {
	// EXPLOSION
	_x = bomb.x;
	_y = bomb.y;
	_n = 2;
	focos_create ();
	// Restore map
	*(bomb.map_idx) = tile_bomb;
}

void shoots_move (void) {
	for (bi = 0; bi < n_shoots; bi ++) {
		// Collide enemies?
		// MOVED FOR SPEED INTO ENEMIES MANAGEMENT			
		
		if (shoots_active [bi]) {
			_sh_x = shoots_x [bi]; 
			_sh_y = shoots_y [bi];
			shoot_detect ();
			_sh_x = shoots_x [bi] + shoots_trail_dx [bi]; 
			_sh_y = shoots_y [bi] + shoots_trail_dy [bi];
			shoot_detect ();
		}

		if (shoots_active [bi]) {
			/*
			_sh_x = shoots_x [bi] += shoots_mx [bi];
			_sh_y = shoots_y [bi] += shoots_my [bi];
			*/
			#asm
					ld  bc, (_bi)
					ld  b, 0

					ld  hl, _shoots_mx
					add hl, bc
					ld  d, (hl)
					ld  hl, _shoots_x
					add hl, bc
					ld  a, (hl)
					add d
					add d
					ld  (hl), a
					ld  (__sh_x), a

					ld  hl, _shoots_my
					add hl, bc
					ld  d, (hl)
					ld  hl, _shoots_y
					add hl, bc
					ld  a, (hl)
					add d
					add d
					ld  (hl), a
					ld  (__sh_y), a
			#endasm

			// Exit?
			if (_sh_x < cam_x - 1 || _sh_x > cam_x + 29 ||
				_sh_y < cam_y - 1 || _sh_y > cam_y + 15) 
				shoots_active [bi] = 0;
					
			if (shoots_active [bi]) {
				draw_shoot ();	
			}

			// Collide set bomb -> make explode
			if (bomb.timer) {
				if (_sh_x >= bomb.x &&
					_sh_x <= bomb.x + 1 &&
					_sh_y >= bomb.y &&
					_sh_y <= bomb.y + 1
				) {
					// Explode bomb
					bomb.timer = bomb.ct = 0;
					bomb_explode ();
					shoots_active [bi] = 0;
				}
			}
		}
	}
}

void check_shoot (void) {
	pad0 = (joyfunc) (&keys);
		
	if ((pad0 & in_FIRE) != 0) {
		if (0 == player.firing) {
			player.firing = 1;

			// Bomb?
			if (player.with_bomb) {
				player.with_bomb = 0;
				bomb.x = player.x & 0xfe;
				bomb.y = player.y & 0xfe; if (player.y & 1) bomb.y += 2;
				bomb.timer = 5;
				bomb.ct = BOMB_TICK;
				return;
			}

			bi = shoots_find ();
			if (bi != 255) {
				switch (player.facing) {
					case 0:
						/*
						shoots_x [bi] = player.x + 1;
						shoots_y [bi] = player.y + 2 - inval;
						shoots_mx [bi] = 0;
						shoots_my [bi] = 1;
						shoots_trail_dx [bi] = 0;
						shoots_trail_dy [bi] = -1;
						*/
						#asm
								ld  bc, (_bi)
								ld  b, 0

								ld  a, (_player)
								inc a
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a

								ld  a, (_inval)
								ld  d, a
								ld  a, (_player + 1)
								add 2
								sub d
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a

								xor a
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a

								inc a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a

								xor a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a

								dec a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
						#endasm
						break;
					case 3:
						/*
						shoots_x [bi] = player.x;
						shoots_y [bi] = player.y - 1 + inval;
						shoots_mx [bi] = 0;
						shoots_my [bi] = -1;
						shoots_trail_dx [bi] = 0;
						shoots_trail_dy [bi] = 1;
						*/
						#asm
								ld  bc, (_bi)
								ld  b, 0

								ld  a, (_player)
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a

								ld  a, (_inval)
								ld  d, a
								ld  a, (_player + 1)
								dec a
								add d
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a

								xor a
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a

								dec a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a

								xor a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a

								inc a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
						#endasm
						break;
					case 6:
						/*
						shoots_x [bi] = player.x - 1 + inval;
						shoots_y [bi] = player.y + 1;
						shoots_mx [bi] = -1;
						shoots_my [bi] = 0;
						shoots_trail_dx [bi] = 1;
						shoots_trail_dy [bi] = 0;
						*/
						#asm
								ld  bc, (_bi)
								ld  b, 0

								ld  a, (_inval)
								ld  d, a
								ld  a, (_player)
								dec a
								add d
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a

								ld  a, (_player + 1)
								inc a
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a

								ld  a, 0xff
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a

								inc a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a

								inc a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a

								dec a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
						#endasm
						break;
					case 9:
						/*
						shoots_x [bi] = player.x + 2 - inval;
						shoots_y [bi] = player.y + 1;
						shoots_mx [bi] = 1;
						shoots_my [bi] = 0;
						shoots_trail_dx [bi] = -1;
						shoots_trail_dy [bi] = 0;
						*/
						#asm
								ld  bc, (_bi)
								ld  b, 0

								ld  a, (_inval)
								ld  d, a
								ld  a, (_player)
								add 2
								dec d
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a

								ld  a, (_player + 1)
								inc a
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a

								ld  a, 1
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a

								dec a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a

								dec a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a

								inc a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
						#endasm
						break;
				}	
				shoots_active [bi] = 1;
				wyz_play_sound (0);
			}
		}
	} else player.firing = 0;
}

void enemies_select (void) {
	// For each enemy, if on screen, paint
	// And put them in the bus to be processed later.

	/*
	bus_count = 0;
	inval = 0;
	
	for (ei = 0; ei < MAX_ENEMIES; ++ ei) {
		enemies_ns [ei] = 0;
		if (enemies_type [ei] > 0) {
			if (enemies_x [ei] >= cam_x - 1 && enemies_x [ei] <= cam_x + 29 &&
				enemies_y [ei] >= cam_y - 1 && enemies_y [ei] <= cam_y + 15) {
				enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
				enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;	
				enemies_ns [ei] = 1;
				
				if (enemies_type [ei] == 5) {
					sx = enemies_real_x [ei];
					sy = enemies_real_y [ei]; 
					sn = 29 + enemies_frame [ei];
					sc = 7;
					draw_sprite ();
				} else {
					sx = enemies_real_x [ei];
					sy = enemies_real_y [ei];
					sn = 32 + ((enemies_type [ei] - 1) << 3) + enemies_facing [ei] + enemies_frame [ei];
					sc = 71 - ((enemies_en [ei] - 1) >> 4);
					draw_sprite ();
				}
				enemies_bus [bus_count] = ei;
				++ bus_count;

			} 	
		}
	}
	*/

	#asm
			xor a
			ld  (_bus_count), a
			ld  (_inval), a 		// ??? may be used later. Can't remember

			ld  (_ei), a

		._enemies_move_selector
			ld  bc, (_ei)
			ld  b, 0

			ld  hl, _enemies_ns
			add hl, bc
			ld  (hl), b 			// B = 0

			// if (enemies_type [ei] > 0) {
			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			or  a
			jp  z, _enemies_move_selector_continue

			// if (enemies_x [ei] >= cam_x - 1 -> jump if "<"
			// But beware of negatives. Transform to the safer
			// if (enemies_x [ei] + 1 >= cam_x)
			ld  a, (_cam_x)
			ld  d, a
			ld  hl, _enemies_x
			add hl, bc
			ld  a, (hl)
			inc a
			cp  d
			jp  c, _enemies_move_selector_continue

			// && enemies_x [ei] <= cam_x + 29 
			// A = enemies_x [ei] already
			ld  d, a 				// Save it

			// cam_x + 29 >= enemies_x [ei] -> jump if "<"
			ld  a, (_cam_x)
			add 29
			cp  d
			jp  c, _enemies_move_selector_continue

			// && enemies_y [ei] >= cam_y - 1 -> jump if "<"
			// But beware of negatives. Transform to the safer
			// && enemies_y [ei] + 1 >= cam_y)
			ld  a, (_cam_y)
			ld  d, a
			ld  hl, _enemies_y
			add hl, bc
			ld  a, (hl)
			inc a
			cp  d
			jp  c, _enemies_move_selector_continue

			// && enemies_y [ei] <= cam_y + 15) {
			// A = enemies_y [ei] aready
			ld  d, a 				// Save it

			// cam_y + 15 >= enemies_y [ei] -> jump if "<"
			ld  a, (_cam_y)
			add 15
			cp  d
			jp  c, _enemies_move_selector_continue

			// Here, paint & add to bus

			// enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
			ld  a, (_cam_x)
			ld  d, a
			ld  hl, _enemies_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub d
			ld  hl, _enemies_real_x
			add hl, bc
			ld  (hl), a
			
			// enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;	
			ld  a, (_cam_y)
			ld  d, a
			ld  hl, _enemies_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub d
			ld  hl, _enemies_real_y
			add hl, bc
			ld  (hl), a
			
			// enemies_ns [ei] = 1;
			ld  a, 1
			ld  hl, _enemies_ns
			add hl, bc
			ld  (hl), a

			//sx = enemies_real_x [ei];
			ld  hl, _enemies_real_x
			add hl, bc
			ld  a, (hl)
			ld  (_sx), a
			
			//sy = enemies_real_y [ei]; 
			ld  hl, _enemies_real_y
			add hl, bc
			ld  a, (hl)
			ld  (_sy), a

			// if (enemies_type [ei] == 5) {
			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			cp  5
			jr  nz, _enemies_move_selector_not5
			
			//sn = 29 + enemies_frame [ei];
			ld  hl, _enemies_frame
			add hl, bc
			ld  a, (hl)
			add 29
			ld  (_sn), a
			
			//sc = 7;
			ld  a, 7
			ld  (_sc), a

			jr  _enemies_move_selector_add_bus

		._enemies_move_selector_not5
			// sn = 32 + ((enemies_type [ei] - 1) << 3) + enemies_facing [ei] + enemies_frame [ei];

			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			dec a
			sla a
			sla a
			sla a

			// Patch here to render type 4 as type 3s.
			// Values are 0, 8, 16 and 24. 
			// 24 becomes 16
			cp  24
			jr  nz, emsnchg000
			ld  a, 16
		.emsnchg000
			// And done.

			add 32

			ld  hl, _enemies_facing
			add hl, bc
			add a, (hl)

			ld  hl, _enemies_frame
			add hl, bc
			add a, (hl)

			ld  (_sn), a

			// sc = 71 - ((enemies_en [ei] - 1) >> 4);
			ld  hl, _enemies_en 
			add hl, bc
			ld  a, (hl)
			dec a
			srl a
			srl a
			srl a
			srl a
			neg a
			add 71
			ld  (_sc), a

		._enemies_move_selector_add_bus		
			call _draw_sprite

			// enemies_bus [bus_count] = ei;
			ld  de, (_bus_count)
			ld  d, 0
			ld  hl, _enemies_bus
			add hl, de
			ld  a, (_ei)
			ld  (hl), a
			
			// ++ bus_count;
			inc de
			ld  a, e
			ld  (_bus_count), a

		._enemies_move_selector_continue
			ld  a, (_ei)
			inc a
			ld  (_ei), a
			cp  MAX_ENEMIES
			jp  nz, _enemies_move_selector
	#endasm
}

void collide (void) {

	// Moved here: collision with player
	// Collide?

	// Opt / easier: only collide ONCE per frame
	// 2026 version: enemies NEVER overlap the player 
	// so check is different. Register collision if:

	// * if (ex == px - 2 || ex == px + 2)
	//   * if (ey >= py - 1 && ey <= py + 1) -> COLLIDE
	// * elseif (ey == py - 2 || py == py + 2)
	//   * if (ex >= ex - 1 && ex <= px + 1) -> COLLIDE
	// RET

	// COLLIDE:

	/*
	{
		if (enemies_type [ei] == 4) {
			enemies_en [ei] -= 8;
		} else {
			-- enemies_en [ei];
		}
		if (enemies_en [ei] <= 0) {
			enemies_type [ei] = 5;
			enemies_frame [ei] = 0;
			enemies_ns [ei] = 0;
		}
		
		// Aaaaaaaahhhh!!!
		if (player.energy > 0) -- player.energy;
		wyz_play_sound (6);
		draw_5_digit (11, 18, player.energy);
	}
	*/

	#asm

		._en_bus_collision_check
			
			// if (ex == px - 2 || ex == px + 2)

			ld  hl, _enemies_x
			add hl, bc
			ld  e, (hl) 			// E = enemies_x [ei]
			
			ld  a, (_player) 		// A = player.x
			sub 2 
			cp  e 					// player.x - 2 == enemies_x [ei] ?
			jr  z, _en_bus_collision_check_h

			add 4 					// A = player.x - 2 + 4 
			cp  e 					// player.x + 2 == enemies_x [ei] ?
			jr  z, _en_bus_collision_check_h 

			// elseif (ey == py - 2 || py == py + 2)

			ld  hl, _enemies_y
			add hl, bc
			ld  e, (hl) 			// E = enemies_y [ei]
			
			ld  a, (_player + 1) 	// A = player.y
			sub 2 
			cp  e 					// player.y - 2 == enemies_y [ei] ?
			jr  z, _en_bus_collision_check_v

			add 4 					// A = player.y - 2 + 4 
			cp  e 					// player.y + 2 == enemies_y [ei] ?
			jr  z, _en_bus_collision_check_v

			ret

		._en_bus_collision_check_h
			// if (ey >= py - 1 && ey <= py + 1) -> COLLIDE
			// ey >= py - 1
			ld  hl, _enemies_y
			add hl, bc
			ld  e, (hl) 			// E = enemies_y [ei]

			ld  a, (_player + 1) 	// A = player.y  
			dec a 					// A = player.y - 1
			ld  d, a  				// D = player.y - 1
			ld  a, e 				// A = enemies_y [ei]
			cp  d  					// A >= D ?
			ret c  					// NOPE

			// py + 1 >= ey 
			ld  a, d 				// A = player.y - 1
			add 2 					// A = player.y + 1
			cp  e 					// A >= E ?
			ret c 					// NOPE

			// Got to this point -> do collision
			jr  _en_bus_collision_do

		._en_bus_collision_check_v
			// if (ex >= px - 1 && ex <= px + 1) -> COLLIDE
			// ex >= px - 1
			ld  hl, _enemies_x
			add hl, bc
			ld  e, (hl) 			// E = enemies_x [ei]

			ld  a, (_player) 		// A = player.x
			dec a 					// A = player.x - 1
			ld  d, a  				// D = player.x - 1
			ld  a, e 				// A = enemies_x [ei]
			cp  d  					// A >= D ?
			ret c  					// NOPE

			// py + 1 >= ex 
			ld  a, d 				// A = player.x - 1
			add 2 					// A = player.x + 1
			cp  e 					// A >= E ?
			ret c 					// NOPE

			// Got to this point -> do collision

		._en_bus_collision_do
			
			/*
			if (enemies_type [ei] == 4) {
				enemies_en [ei] -= 8;
			} else {
				-- enemies_en [ei];
			}
			*/
			ld  hl, _enemies_type 
			add hl, bc 
			ld  a, (hl)

			ld  hl, _enemies_en 
			add hl, bc

			cp  4 
			jr  nz, _en_bus_collision_sap_normal

		._en_bus_collision_sap_type4
			ld  a, (hl)
			sub 8 
			ld  (hl), a
			jr  _en_bus_collision_sap_done

		._en_bus_collision_sap_normal
			dec (hl)

		._en_bus_collision_sap_done

			/*
			if (enemies_en [ei] <= 0) {
				enemies_type [ei] = 5;
				enemies_frame [ei] = 0;
				enemies_ns [ei] = 0;
			}
			*/
			ld  a, (hl)
			
			// enems_en [ei] == 0 -> kill
			or  a 
			jr  z, _en_bus_collision_kill

			// enems_en [ei] < 0 -> kill
			and 128
			jr  z, _en_bus_collision_kill_done
		._en_bus_collision_kill
			ld  a, 5
			ld  hl, _enemies_type
			add hl, bc
			ld  (hl), a 

			xor a 
			ld  hl, _enemies_frame
			add hl, bc 
			ld  (hl), a 

			ld  hl, _enemies_ns
			add hl, bc 
			ld  (hl), a 
		._en_bus_collision_kill_done

			ld  a, (_player + 27) 	// player.collided
			or  a 
			jp  nz, _en_bus_collision_done
			inc a
			ld  (_player + 27), a

			// Aaaaaaaahhhh!!!
	#endasm	
			if (player.energy > 0) player.energy --;
			wyz_play_sound (6);
			draw_5_digit (11, 18, player.energy);
	#asm

		._en_bus_collision_done
	#endasm
}

void enemies_move (void) {	
	// For each enemy, if on screen, attempt to move.
	// Optimization: precalc which are on screen.
	#asm
		// Reset player.collided

			xor a 
			ld  (_player + 27), a
	#endasm 

	for (busi = 0; busi < bus_count; ++ busi) {
		check_shoot ();
		ei = enemies_bus [busi];
		
		/*
		nd = 0;
		if (enemies_type [ei] == 5) {
			// Enemy dying
			enemies_frame [ei] ++;
			if (enemies_frame [ei] == 2)  {
				enemies_type [ei] = 0;
				enemies_x [ei] = enemies_y [ei] = 254;
			}
		} else if (enemies_type [ei] == 4 || halflife) {
			rdx = enemies_x [ei];
			rdy = enemies_y [ei];
			if (rdx > player.x) {
				enemies_facing [ei] = 4;
				_x = enemies_real_x [ei] - 1; _y = enemies_real_y [ei]; at1 = dt_attr ();
				++_y; at2 = dt_attr ();
				if (at1 && at2) {
					enemies_x [ei] --;
					enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
					nd = 1;
				}
			} else if (rdx < player.x) {
				enemies_facing [ei] = 6;
				_x = enemies_real_x [ei] + 2; _y = enemies_real_y [ei]; at1 = dt_attr ();
				++ _y; at2 = dt_attr ();
				if (at1 && at2) {
					enemies_x [ei] ++;
					enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
					nd = 1;
				}
			}
			
			// Vert
			if (rdy > player.y) {
				enemies_facing [ei] = 2;
				_x = enemies_real_x [ei]; _y = enemies_real_y [ei] - 1; at1 = dt_attr ();
				++ _x; at2 = dt_attr ();
				if (at1 && at2) {
					enemies_y [ei] --;
					enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;
					nd = 1;
				}
			} else if (rdy) {
				enemies_facing [ei] = 0;
				_x = enemies_real_x [ei]; _y = enemies_real_y [ei] + 2; at1 = dt_attr ();
				++_x; at2 = dt_attr ();
				if (at1 && at2) {
					enemies_y [ei] ++;
					enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;
					nd = 1;
				}
			}		
		}
		*/

		#asm
			._en_bus_upd
				xor a

				ld  (_nd), a
				ld  bc, (_ei) 		// Just writes C, B is trash
				ld  b, a 			// B = 0 to fix ptr

				// if (enemies_type [ei] == 5) {
				ld  hl, _enemies_type
				add hl, bc
				ld  a, (hl)
				cp  5
				jr  nz, _en_bus_upd_not_dying

			._en_bus_upd_dying
				// Enemy dying
				ld  hl, _enemies_frame 
				add hl, bc
				inc (hl)
				ld  a, (hl)
				cp  2
				ret  nz

				ld  hl, _enemies_type
				add hl, bc
				xor a
				ld  (hl), a

				ld  a, 0xfe 

				ld  hl, _enemies_x
				add hl, bc
				ld  (hl), a 

				ld  hl, _enemies_y
				add hl, bc
				ld  (hl), a 

				//jp  _en_bus_upd_done
				ret

			._en_bus_upd_not_dying
				// else if (enemies_type [ei] == 4 || halflife) {
				// Means "run each odd frame or every frame if enemy type is 4"

				ld  a, (_halflife)
				or  a
				jr  nz, _en_bus_upd_do 

				ld  hl, _enemies_type
				add hl, bc 
				ld  a, (hl)
				cp  4
				jp  nz, _en_bus_upd_done

			._en_bus_upd_do

				// Here we basicly move the enemy towards the player
				// Enemy can't walk over the player so we can take a couple of shortcuts

			._en_bus_move_horizontal
				ld  hl, _enemies_x
				add hl, bc
				ld  a, (hl) 				// A = enemies_x [ei]
				//ld  (_rdx), a 				// rdx = enemies_x [ei]
				ld  d, a 					// D = enemies_x [ei]

				ld  hl, _enemies_y
				add hl, bc
				ld  a, (hl)
				//ld  (_rdy), a 				// rdy = enemies_y [ei]

				ld  a, (_player) 			// player.x
				cp  d 
				jp  z, _en_bus_move_vertical

				jr  c, _en_bus_upd_move_left

			._en_bus_upd_move_right
				// enemies_facing [ei] = 6;
				ld  a, 6
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 

				// _x = enemies_real_x [ei] + 2; _y = enemies_real_y [ei]; at1 = dt_attr ();
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				add 2 
				ld  (__x), a 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				ld  (__y), a 

				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 

				// ++ _y; at2 = dt_attr ();
				ld  hl, __y
				inc (hl)

				call _dt_attr
				ld  d, l 					; D = at2
				
				// if (at1 && at2) {
				ld  a, (_at1)
				and d
				jr  z, _en_bus_move_vertical

				// enemies_x [ei] ++;
				ld  hl, _enemies_x
				add hl, bc
				inc (hl)
				
				// enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
				ld  a, (_cam_x)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 

				ld  hl, _enemies_real_x
				add hl, bc 
				ld  (hl), a 

				// nd = 1;
				ld  a, 1
				ld  (_nd), a
				jr  _en_bus_move_vertical

			._en_bus_upd_move_left
				// enemies_facing [ei] = 4;
				ld  a, 4
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 

				// _x = enemies_real_x [ei] - 1; _y = enemies_real_y [ei]; at1 = dt_attr ();
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				dec a
				ld  (__x), a 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				ld  (__y), a 

				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 

				// ++ _y; at2 = dt_attr ();
				ld  hl, __y
				inc (hl)

				call _dt_attr
				ld  d, l 					; D = at2

				// if (at1 && at2) {
				ld  a, (_at1)
				and  d
				jr  z, _en_bus_move_vertical

				// enemies_x [ei] --;
				ld  hl, _enemies_x
				add hl, bc
				dec (hl)
				
				// enemies_real_x [ei] = 1 + enemies_x [ei] - cam_x;
				ld  a, (_cam_x)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 

				ld  hl, _enemies_real_x
				add hl, bc 
				ld  (hl), a 

				// nd = 1;
				ld  a, 1
				ld  (_nd), a

			._en_bus_move_vertical

				ld  hl, _enemies_y
				add hl, bc
				ld  a, (hl)
				//ld  (_rdy), a 
				ld  d, a

				ld  hl, _enemies_x
				add hl, bc
				ld  a, (hl)
				//ld  (_rdx), a 

				ld  a, (_player+1) 			// player.y
				cp  d 
				jp  z, _en_bus_upd_done

				jr  c, _en_bus_upd_move_up

			._en_bus_upd_move_down
				// enemies_facing [ei] = 0;
				ld  a, 0
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 

				// _x = enemies_real_x [ei]; _y = enemies_real_y [ei] + 2; at1 = dt_attr ();
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				ld  (__x), a 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				add 2 
				ld  (__y), a 

				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 

				// ++ _x; at2 = dt_attr ();
				ld  hl, __x
				inc (hl)

				call _dt_attr
				ld  d, l 					; D = at2
				
				// if (at1 && at2) {
				ld  a, (_at1)
				and d
				jr  z, _en_bus_upd_done

				// enemies_y [ei] ++;
				ld  hl, _enemies_y
				add hl, bc
				inc (hl)
				
				// enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;
				ld  a, (_cam_y)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  (hl), a 

				// nd = 1;
				ld  a, 1
				ld  (_nd), a
				jr  _en_bus_upd_done

			._en_bus_upd_move_up
				// enemies_facing [ei] = 2;
				ld  a, 2
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 

				//_x = enemies_real_x [ei]; _y = enemies_real_y [ei] - 1; at1 = dt_attr ();
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				ld  (__x), a 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				dec a
				ld  (__y), a 

				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 

				// ++ _x; at2 = dt_attr ();
				ld  hl, __x
				inc (hl)

				call _dt_attr
				ld  d, l 					; D = at2

				// if (at1 && at2) {
				ld  a, (_at1)
				and d
				jr  z, _en_bus_upd_done

				// enemies_y [ei] --;
				ld  hl, _enemies_y
				add hl, bc
				dec (hl)
				
				// enemies_real_y [ei] = 1 + enemies_y [ei] - cam_y;
				ld  a, (_cam_y)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 

				ld  hl, _enemies_real_y
				add hl, bc 
				ld  (hl), a 

				// nd = 1;
				ld  a, 1
				ld  (_nd), a

			._en_bus_upd_done

				// Check collision, new method (2026)
				// Collide with player?
				call _en_bus_collision_check
			._en_bus_collision_check_done

				// if (nd) enemies_frame [ei] = 1 - enemies_frame [ei];	
				ld  a, (_nd)
				or  a
				jr  z, _en_bus_step_done

			._en_bus_step
				ld  hl, _enemies_frame 
				add hl, bc 
				ld  a, 1
				sub (hl)
				ld  (hl), a
			._en_bus_step_done
		#endasm

				
		// Moved here: collision with shoots
		if (enemies_type [ei] != 5 && enemies_en [ei] > 0) {
			for (bi = 0; bi < n_shoots; ++ bi) {
				if (shoots_active [bi]) {
					cao = 0;
					rdx = shoots_x [bi] + shoots_trail_dx [bi];
					rdy = shoots_y [bi] + shoots_trail_dy [bi];
					if ((shoots_x [bi] == enemies_x [ei] || shoots_x [bi] == enemies_x [ei] + 1) &&
						(shoots_y [bi] == enemies_y [ei] || shoots_y [bi] == enemies_y [ei] + 1)) 
						cao = 1;
					else if ((rdx == enemies_x [ei] || rdx == enemies_x [ei] + 1) &&
							 (rdy == enemies_y [ei] || rdy == enemies_y [ei] + 1))
						cao = 1;
					
					if (cao) {
						//add_to_score (enemies_type [ei]);
						
						if (enemies_en [ei] > 16 && enemies_type [ei] != 5) {
							enemies_en [ei] -= 16;
						} else {
						//if (enemies_en [ei] <= 0) {
							enemies_type [ei] = 5;
							enemies_frame [ei] = 0;
							enemies_ns [ei] = 0;
						}
						shoots_active [bi] = 0;	
						draw_shoot ();
						wyz_play_sound (1);
					}
				}
			}
		}

		// Collision with focos
		for (foi = 0; foi < MAX_FOCOS; ++ foi) {
			if (focos_ct [foi]) {
				if ((focos_x [foi] >= enemies_x [ei] - 1 && focos_x [foi] <= enemies_x [ei] + 1) &&
					(focos_y [foi] >= enemies_y [ei] - 1 && focos_y [foi] <= enemies_y [ei] + 1)
				) {
					enemies_type [ei] = 5;
					enemies_frame [ei] = 0;
					enemies_ns [ei] = 0;
				}
			}
		}
	}
	
	/*
	for (bi = 0; bi < n_shoots; ++ bi)
		if (shoots_active [bi])
			draw_shoot ();
	*/
	
	// If player close to spawner and spawner visible,
	// attempt to create enemies.
	for (si = 0; si < max_spawners; si++) {
		/*
		if (spawners_x [si] >= cam_x + 2 && spawners_x [si] <= cam_x + 26 &&
			spawners_y [si] >= cam_y + 2 && spawners_y [si] <= cam_y + 12) {
		*/
		if (spawners_x [si] >= cam_x - 1 && spawners_x [si] <= cam_x + 29 &&
			spawners_y [si] >= cam_y - 1 && spawners_y [si] <= cam_y + 14) {
			// Can we spawn?
			if (spawners_last_spawned [si] == 0) {
				spawners_last_spawned [si] = 16 - (spawners_type [si] << 1);
				
				// We try to place a new enemy only 4 times
				rda = 0;
				nd = 0;
				
				do {
					do {
						rdx = spawners_x [si] - 2 + ((rand () % 3) << 1);
						rdy = spawners_y [si] - 2 + ((rand () % 3) << 1);
						rrdx = 1 + rdx - cam_x;
						rrdy = 1 + rdy - cam_y;	
						++ rda;
						if (rda == MAX_ATTEMPTS) nd = 1;
					} while (rda < MAX_ATTEMPTS && (rrdx < 2 || rrdx > 29 || rrdy < 2 || rrdy > 14));
					
					// This checks the tile is walkable. As we are map-aligned and all non-
					// walkable tiles have both top-row chars with bit 6 raised, there's no
					// need to check all 4 attributes.
					_x = rrdx; _y = rrdy; 	ca1 = dt_attr ();
					++ _x; 					ca2 = dt_attr ();
					/*
					_x = rrdx; ++ _y; 		ca3 = dt_attr ();
					++ _x; 					ca4 = dt_attr ();
					*/
				} while (rda < MAX_ATTEMPTS && 
					(ca1 == 0 || ca2 == 0 /*|| ca3 == 0 || ca4 == 0*/));
				
				if (!nd) {
					ei = enemies_find ();
					if (ei != 255) {
						if (spawners_ct [si] < 8) {
							enemies_type [ei] = spawners_type [si];
							enemies_x [ei] = rdx;
							enemies_y [ei] = rdy;
							enemies_en [ei] = (spawners_type [si] << 4);
							enemies_facing [ei] = 0;
							enemies_frame [ei] = 0;
							++ spawners_ct [si];
						}
						if (player.moved) spawners_ct [si] = 0;
					}
				}	 		 
			} else {
				spawners_last_spawned [si] --;
			}
		}	
	}
}

unsigned char whatInMap (void) { return *((unsigned char *) (DT_MAPDATA + _x + (_y << 6))); }

void gates_break (unsigned char x, unsigned char y) {
	// This is a recursive function. Yay.
	// First break current cell:
	*((unsigned char *) (DT_MAPDATA + x + (y << 6))) = 0;
	
	// Now check for neighbors:
	/*
	if (x > 0 && whatInMap (x - 1, y) == TILE_GATE)	
		gates_break (x - 1, y);
	if (x < 63 && whatInMap (x + 1, y) == TILE_GATE)
		gates_break (x + 1, y);
	if (y > 0 && whatInMap (x, y - 1) == TILE_GATE)
		gates_break (x, y - 1);
	if (y < 39 && whatInMap (x, y + 1) == TILE_GATE)
		gates_break (x, y + 1);
	*/
	
	_x = x - 1; _y = y; if (whatInMap () == TILE_GATE) gates_break (_x, _y);
	_x = x + 1; _y = y; if (whatInMap () == TILE_GATE) gates_break (_x, _y);
	_x = x; _y = y - 1; if (whatInMap () == TILE_GATE) gates_break (_x, _y);
	_x = x; _y = y + 1; if (whatInMap () == TILE_GATE) gates_break (_x, _y);
}

void gates_check (unsigned char direction) {
	dothis = 0;
	
	if (player.keys > 0) {	
		rdx = player.x >> 1;
		rdy = player.y >> 1;
		switch (direction) {
			case DIRECTION_UP:
				_x = rdx; _y = rdy - 1; 
				break;
			case DIRECTION_DOWN:
				_x = rdx; _y = rdy + 1;
				break;
			case DIRECTION_LEFT:
				_x = rdx - 1; _y = rdy;
				break;
			case DIRECTION_RIGHT:
				_x = rdx + 1; _y = rdy;
				break;
		}

		if (whatInMap () == TILE_GATE) {
			gates_break (_x, _y);
			player.keys --;
			wyz_play_sound (3);
			draw_3_digit (20, 21, player.keys);
		}
	}
}

void update_cam (void) {

	if (cam_x < player.x - 16) cam_x = player.x - 16;
	if (cam_x > player.x - 14) cam_x = player.x - 14;
	if (cam_y < player.y - 8) cam_y = player.y - 8;
	if (cam_y > player.y - 6) cam_y = player.y - 6;
	
	// Camera limits
	if (cam_x < 0) cam_x = 0;
	if (cam_x > 98) cam_x = 98;
	if (cam_y < 0) cam_y = 0;
	if (cam_y > 64) cam_y = 64;

	player.real_x = 1 + player.x - cam_x;
	player.real_y = 1 + player.y - cam_y;

}

void draw_arbitrary_cam (void) {	
	draw_map (cam_x, cam_y);
	enemies_select ();
	if (player.x > cam_x && player.x < cam_x + 30 &&
		player.y > cam_y && player.y < cam_y + 14) {
		sx = 1 + player.x - cam_x;
		sy = 1 + player.y - cam_y;
		sn = 16 + player.facing + player.frame;
		sc = 4;
		draw_sprite ();
	}
	blit_buffer ();
}

void move_cam (void) {
	// Camera limits
	if (cam_x_dest < 0)  cam_x_dest = 0;
	if (cam_x_dest > 98) cam_x_dest = 98;
	if (cam_y_dest < 0)  cam_y_dest = 0;
	if (cam_y_dest > 64) cam_y_dest = 64;

	while (cam_x != cam_x_dest || cam_y != cam_y_dest) {
		draw_arbitrary_cam ();
		if (cam_x < cam_x_dest) cam_x ++;
		if (cam_x > cam_x_dest) cam_x --;
		if (cam_y < cam_y_dest) cam_y ++;
		if (cam_y > cam_y_dest) cam_y --;
	}
	draw_arbitrary_cam ();
}

void check_step_on_tile (void) {
	gp_gen = ((unsigned char *) (DT_MAPDATA + whichtile));
	rda = *gp_gen;
	if (rda == TILE_KEY) {
		*gp_gen = 0;
		player.keys ++;
		draw_3_digit (20, 21, player.keys);
		add_to_score (10);
		wyz_play_sound (7);
	} else if (rda == TILE_EXIT) {
		i_shat_brix = 1;
		wyz_play_sound (8);
	} else if (rda == TILE_RECHARGE) {
		*gp_gen = 0;
		player.energy += 100;
		draw_5_digit (11, 18, player.energy);
		add_to_score (10);
		wyz_play_sound (5);
	} else if (rda == tile_bomb && player.with_bomb == 0 && bomb.timer == 0) {
		*gp_gen = 0;
		player.with_bomb = 1;
		bomb.map_idx = gp_gen;
		wyz_play_sound (7);
	} else if (rda == tile_switch) {
		*gp_gen = tile_switch + 1;
		wyz_play_sound (0);
		update_cam ();
		draw_arbitrary_cam ();

		#asm
				ld  ix, (_level_switches)

			.switches_do
				ld  l, (ix + 0)
				xor a
				or  l
				jp  z, switches_done

				ld  h, (ix + 1)

				ld  de, (_whichtile)
				sbc hl, de
				jp  nz, switches_continue

				// This is the switch, IX->switch

				ld  (_current_switch), ix

				// whichtile x1, y1, x2, y2
				// 0,1        2   3   4   5

				// We'll attempt to center the screen
				// in the area where the wall is.

				// X = (X1 + (X2-X1) / 2) - 7
				ld  a, (ix + 4)
				sub (ix + 2)
				srl a 
				add (ix + 2) 
				//cp  7
				//jr  c, switches_do_cam_x_0

				sub 7
				sla a

				//jr  switches_do_cam_x_set
			//.switches_do_cam_x_0
				//xor a

			.switches_do_cam_x_set
				ld  (_cam_x_dest), a

				// Y = (Y1 + (Y2-Y1) / 2) - 3
				ld  a, (ix + 5)
				sub (ix + 3)
				srl a 
				add (ix + 3) 
				//cp  3
				//jr  c, switches_do_cam_y_0

				sub 3
				sla a
				//jr  switches_do_cam_y_set
			//.switches_do_cam_y_0
				//xor a

			.switches_do_cam_y_set
				ld  (_cam_y_dest), a

				ld  a, (_cam_x)
				ld  (_cam_x_store), a
				ld  a, (_cam_y)
				ld  (_cam_y_store), a		
				call _move_cam

				ld  b, 20
			.poopoo1
				halt
				djnz poopoo1

				ld  ix, (_current_switch)

				// Now clear map
				// Iterate from y1 to y2
				ld  a, (ix + 5) 	// y2
				inc a
				sub (ix + 3) 		// y1
				ld  b, a
			.switches_erase_lines
				push bc

				// Address of this line
				ld  a, (ix + 3) 	// y1
				add b
				dec a 				// Y = Y1 + B - 1

				ld  h, a
				ld  l, 0
				srl h 
				rr  l
				srl h
				rr  l 				// HL = Y * 64

				ld  e, (ix + 2) 	// x1
				ld  d, 0
				add hl, de 			// HL = Y * 64 + X1
				ld  de, DT_MAPDATA
				add hl, de 			// HL set!

				ld  a, (ix  + 4) 	// x2
				inc a
				sub (ix + 2) 		// x1
				ld  b, a
			.switches_erase_columns
				xor a
				ld  (hl), a
				inc hl
				djnz switches_erase_columns

				pop  bc
				djnz switches_erase_lines


			.switches_continue
				ld  bc, 6
				add ix, bc
				jp  switches_do
			.switches_done

		#endasm

		wyz_play_sound (2);

		#asm

		// Show for a bit

				call _draw_arbitrary_cam

				ld  b, 20
			.poopoo2
				halt
				djnz poopoo2	

				ld  a, (_cam_x_store)
				ld  (_cam_x_dest), a		
				ld  a, (_cam_y_store)
				ld  (_cam_y_dest), a
				call _move_cam
		#endasm
	}
}

void player_move (void) {
	xo = player.x; yo = player.y;
	
	inval = 2;
	
	pad0 = (joyfunc) (&keys);
	nd = 0;

	dx = dy = 0;

	if (conveyors_on) {
		// Detect conveyors
		// 128 left, 129 right, 130, up, 131 down

		/*
		_x = player.x; _y = player.y; 	ca1 = char_mapdata_attribute ();
		++ _x; 							ca2 = char_mapdata_attribute ();
		_x = player.x; ++ _y; 			ca3 = char_mapdata_attribute ();
		++ _x; 							ca4 = char_mapdata_attribute ();
		*/
		#asm
				ld  a, (_player)			// player.x
				ld  (__x), a
				ld  a, (_player + 1) 		// player.y
				ld  (__y), a
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca1), a

				ld  hl, __x
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca2), a

				ld  a, (_player)			// player.x
				ld  (__x), a
				ld  hl, __y
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca3), a

				ld  hl, __x
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca4), a				
		#endasm
		
		/*
		if (ca1 == 128 || ca2 == 128 || ca3 == 128 || ca4 == 128) -- dx;
		if (ca1 == 129 || ca2 == 129 || ca3 == 129 || ca4 == 129) ++ dx;
		if (ca1 == 130 || ca2 == 130 || ca3 == 130 || ca4 == 130) -- dy;
		if (ca1 == 131 || ca2 == 131 || ca3 == 131 || ca4 == 131) ++ dy;
		*/

		#asm
				ld  hl, _dx 

				ld  a, (_ca1)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca2)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca3)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca4)
				cp  128
				jr  nz, _pmcdecdx_done

			._pmc_decdx
				dec (hl)

			._pmcdecdx_done

				ld  a, (_ca1)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca2)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca3)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca4)
				cp  129
				jr  nz, _pmcincdx_done

			._pmc_incdx
				inc (hl)

			._pmcincdx_done

				ld  hl, _dy 

				ld  a, (_ca1)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca2)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca3)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca4)
				cp  130
				jr  nz, _pmcdecdy_done

			._pmc_decdy
				dec (hl)

			._pmcdecdy_done

				ld  a, (_ca1)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca2)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca3)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca4)
				cp  131
				jr  nz, _pmcincdy_done

			._pmc_incdy
				inc (hl)

			._pmcincdy_done
		#endasm
	}
	

	if ((pad0 & in_DOWN) != 0) player.facing = 0;
	if ((pad0 & in_UP) != 0) player.facing = 3;
	if ((pad0 & in_LEFT) != 0) player.facing = 6;
	if ((pad0 & in_RIGHT) != 0) player.facing = 9;

	if (((pad0 & in_UP) != 0 && dy == 0) || dy == -1) {
		nd = 1;
		_x = player.real_x; _y = player.real_y - 1; at1 = dt_attr ();
		++_x; 										at2 = dt_attr ();
		if (at1 && at2) {
			-- player.y;
			-- player.real_y;
		} else
			gates_check (DIRECTION_UP);
	} 
	
	if (((pad0 & in_DOWN) != 0 && dy == 0) || dy == 1) {
		nd = 1;
		_x = player.real_x; _y = player.real_y + 2; at1 = dt_attr ();
		++_x; 										at2 = dt_attr ();
		if (at1 && at2) {
			++ player.y;
			++ player.real_y;
		} else
			gates_check (DIRECTION_DOWN);
	}

	if (((pad0 & in_LEFT) != 0 && dx == 0) || dx == -1) {
		nd = 1;
		_x = player.real_x - 1; _y = player.real_y; at1 = dt_attr ();
		++_y; 										at2 = dt_attr ();
		if (at1 && at2)		
			-- player.x;
		else
			gates_check (DIRECTION_LEFT);
	}
	
	if (((pad0 & in_RIGHT) != 0 && dx == 0) || dx == 1) {
		nd = 1;
		_x = player.real_x + 2; _y = player.real_y; at1 = dt_attr ();
		++_y; 										at2 = dt_attr ();
		if (at1 && at2)
			++ player.x;
		else
			gates_check (DIRECTION_RIGHT);
	}

	check_shoot ();	
	
	if (dx || dy) nd = 0;
	if (nd) {
		#asm
				ld  a, (_player + 5)		// player.step
				inc a
				and 3
				ld  (_player + 5), a 		// player.step

				or  a
				jr  z, _player_step_frame_1
				cp  2
				jr  nz, _player_step_frame_not1

			._player_step_frame_1
				ld  a, 1			
				jr  _player_step_done

			._player_step_frame_not1
				cp  1
				jr  nz, _player_step_frame_2
				xor a
				jr  _player_step_done

			._player_step_frame_2
				ld  a, 2

			._player_step_done
				ld  (_player + 4), a 		// player.frame
		#endasm
	}
	
	// ¿Get key? ¿Exit? ¿Recharge?
	
	//if ((player.x & 1) == 0 && (player.y & 1) == 0) { 
	whichtile = ((player.y >> 1) << 6) + (player.x >> 1);
	check_step_on_tile ();
	++ whichtile;
	if (player.x & 1) {
		//whichtile = ((player.y >> 1) << 6) + ((player.x + 1) >> 1);
		check_step_on_tile ();
	}
	whichtile += 63;
	if (player.y & 1) {
		//whichtile = (((player.y + 1) >> 1) << 6) + (player.x >> 1);
		check_step_on_tile ();
	}
	++ whichtile;
	if ((player.x & 1) && (player.y & 1)) {
		//whichtile = (((player.y + 1) >> 1) << 6) + ((player.x + 1) >> 1);
		check_step_on_tile ();
	}
	//}
	
	player.moved = !(player.x == xo && player.y == yo);
}

unsigned char pass_printer_section [] = {0, 0, 0, 0, 0};

void interim (unsigned char world, unsigned char level) {
	// Clear screen
	clear_viewport (70);
	
	// Texts
	draw_char_by_char (4, 6, "THIS LEVEL SCORE:");
	draw_5_digit (22, 5, player.score - player.last_score);
	draw_char_by_char (6, 9, "BONUS ENERGY:");
	draw_5_digit (20, 8, player.energy);
	
	// Animation
	gpint = player.score - player.last_score;
	while (gpint > 25) {
		player.energy ++;
		gpint -= 25;
		if (!in_Inkey ()) {
			draw_5_digit (22, 5, gpint);
			draw_5_digit (20, 8, player.energy);
		}
	}
	draw_5_digit (22, 5, 0);
	draw_5_digit (20, 8, player.energy);
	
	if (level == 4) {
		draw_char_by_char (4, 12, "EXTRA END OF STAGE BONUS");
		player.energy += (40 + world * 10);
	}
	
	draw_5_digit (20, 8, player.energy);
	
	// Draw password
	
	build_password (player.score, player.energy, level == 4 ? world + 1 : world, level == 4 ? 1 : level + 1);
	
	for (gpit = 0; gpit < 5; ++ gpit) {
		pass_printer_section [0] = pass_string [gpit << 2];	
		pass_printer_section [1] = pass_string [1 + (gpit << 2)];
		pass_printer_section [2] = pass_string [2 + (gpit << 2)];
		pass_printer_section [3] = pass_string [3 + (gpit << 2)];
		draw_fast (4 + gpit * 5, 14, 70, pass_printer_section);
	}
	
	mywaitkey ();
}

void game (unsigned char world, unsigned char level) {
	unsigned char finished = 0;
	unsigned char do_game, justentered;
	
	n_shoots = 3;
		
	halflife = 0;
	do_game = 1; 
	
	justentered = 1;
	
	while (do_game) {

		video_page = 0;
		ram_page_act = 0;
		pregister = 0x17;
				
		if (level == 0 || justentered) {
			prepare_world (world, level);
			if (level == 0) level = 1;
			fade_out ();
			get_resource (SCR_MT_MARCO_BIN, 16384, 1);
			
			// Now the game frame is in RAM5, we have to copy
			// it to RAM7

			#asm
				call copy_screen0_to_screen1
			#endasm
		} 
		
		justentered = 0;
		
		prepare_stage (world, level);
		draw_1_digit (20, 18, world);
		draw_1_digit (22, 18, level);
		
		// Initialize enemy spawners and other stuff upon mapdata
		mapdata_init ();
		
		// Place player
		player.x = start_x;
		player.y = start_y;
		player.step = 0;
		player.frame = 0;
		player.facing = 0;
		player.keys = 0;
		player.with_bomb = 0;

		// Initialize bomb
		bomb.timer = 0;
		tile_bomb = 99;
		if (world == 4 || world == 11) tile_bomb = 2;
		tile_switch = (world <= 5) ? 57 : 99;
		conveyors_on = (world == 5);

		#asm
			.level_switches_assignment
		#endasm

		level_switches = switches_data [((world - 1) << 2) + (level - 1)];

		// Initialize enemies
		enemies_init ();
		
		// Initialize shoots
		shoots_init ();
		
		// Initialize destructors
		destructors_init ();

		// Initialize focos
		focos_init ();

		i_shat_brix = 0;
		
		// Marcadores
		
		draw_5_digit (11, 18, player.energy);
		draw_5_digit (25, 18, player.score);
		
		player.last_score = player.score;
		
		// Play music
		
		wyz_play_music (1 + (world & 3));
		cam_x = player.x - 15;
		cam_y = player.y - 7;
		update_cam ();
					
		do {
			halflife = 1 - halflife;
			
			// Everything behaves according to the camera position
			// So we move the camera first, then we render the map
			draw_map (cam_x, cam_y);

			// Now everything's on, and we can do stuff
			shoots_move ();
			destructors_update ();
			focos_update ();
			enemies_select ();
			player_move ();

			// Draw player
			sx = player.real_x;
			sy = player.real_y;
			sn = 16 + player.facing + player.frame;
			sc = 4+64;
			draw_sprite ();
			
			enemies_move ();

			// Now make everything happen

			// Update bomb
			if (bomb.timer) {
				sx = 1 + bomb.x - cam_x; sy = 1 + bomb.y - cam_y;
				if (sx <= 30 && sy <= 15) {
					sn = 2; sc = 65 + bomb.timer;
					draw_sprite ();
				}

				-- bomb.ct; if (bomb.ct == 0)  {
					bomb.ct = BOMB_TICK;
					-- bomb.timer; 
					if (bomb.timer == 0) {
						bomb_explode ();						
					}
				}
			}

			// Draw bomb
			if (player.with_bomb) {
				if (player.facing == 0 || player.facing == 6) 
					sx = player.real_x + 1;
				else
					sx = player.real_x - 1;
				sy = player.real_y - 1;
				sn = 2; sc = 6;
				draw_sprite ();
			}		

			update_cam ();

			// Finally, render
			blit_buffer ();

			// Cheat: press M + T
			if (in_KeyPressed (0x047f) &&
				in_KeyPressed (0x10fb)) i_shat_brix = 1;
						
			// Urm... Change this later
			finished = i_shat_brix || (player.energy == 0);
		} while (!finished);
		
		wyz_stop_sound ();
		reset_double_buffer ();
		
		if (player.energy == 0) {		
			// Game over screen			
			get_resource (SCR_GAME_OVER_BIN, 16384, 1);
			wyz_play_music (6);
			draw_5_digit (13, 14, player.score);
			do_game = 0;
			mywaitcycles (300);
		} else {
			// Demo: Advance world up to 6, then show ending.
			// Level should always be 0.
			if (world != 5) interim (world, level);	
			level = 0;
			world ++; 
			if (world == 6) { ending (); do_game = 0; }

		}
	}

	blackout_everything ();
}
