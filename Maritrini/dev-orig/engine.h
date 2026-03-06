// Some defines.

#define MAX_ENEMIES		128
#define MAX_SHOOTS		3
#define MAX_ATTEMPTS	6

#define DIRECTION_UP 	1
#define DIRECTION_DOWN 	2
#define DIRECTION_LEFT	3
#define DIRECTION_RIGHT	4

#define TILE_SPAWNER	12
#define TILE_KEY		13
#define TILE_GATE		14
#define TILE_EXIT		15
#define TILE_RECHARGE	31

// Controller

struct in_UDK keys;

// Camera

char cam_x;
char cam_y;

// Player

typedef struct {
	char x, y;
	char real_x, real_y;
	unsigned char frame;
	unsigned char step;
	unsigned char facing;
	unsigned char status;
	unsigned char lives;
	unsigned char keys;
	unsigned int energy;
	unsigned char firing;
	unsigned long score;
	unsigned long last_score;
	unsigned long hiscore;
	unsigned char moved;
} PLAYER;

PLAYER player;
unsigned char start_x = 2, start_y = 2;
unsigned char inval;

// Enemy spawners

typedef struct {
	char x, y;
	unsigned char en;
	unsigned char type;
	unsigned char last_spawned;
	unsigned char ct;
} SPAWNER;

SPAWNER spawners [50];
unsigned char max_spawners;

// Enemies

typedef struct {
	char x, y;
	char real_x, real_y;
	char en;
	unsigned char facing;
	unsigned char type;
	unsigned char ns;
	unsigned char frame;
} ENEMY;

ENEMY enemies [MAX_ENEMIES];
unsigned char enemies_bus [MAX_ENEMIES];

// Recharges

unsigned char max_recharges = 5;

// Shoots

typedef struct {
	char x, y;
	char mx, my;
	char trail_dx, trail_dy;
	unsigned char active;
} SHOOT;

SHOOT shoots [MAX_SHOOTS];
unsigned char n_shoots;

// Game stuff

unsigned char halflife;
unsigned char i_shat_brix;

// Functions & Routines

void add_to_score (unsigned int amount) {	
	player.score += amount;
	draw_5_digit (25, 18, player.score);
	if (player.score > player.hiscore) {
		player.hiscore = player.score;
		draw_5_digit (25, 21, player.score);
	}
}

void init_shoots () {
	unsigned char i;
	for (i = 0; i < MAX_SHOOTS; i ++)
		shoots [i].active = 0;	
}

unsigned char is_walkable (unsigned char ntile) {
	// All its 4 chars must be < 64 in attr.
	unsigned char idx = ntile << 2;
	return (dt_charcols [idx] < 64 && dt_charcols [idx + 1] < 64 && dt_charcols [idx + 2] < 64 && dt_charcols [idx + 3] < 64);
}

void init_mapdata () {
	unsigned int i;
	unsigned int xy;
	
	// Examine map to create spawners
	max_spawners = 0;
	for (i = 0; i < 2560; i ++) {
		if (dt_mapdata [i] >= 32) {
			spawners [max_spawners].y = (unsigned char) ((i >> 6) << 1);
			spawners [max_spawners].x = (unsigned char) ((i & 63) << 1);
			spawners [max_spawners].type = 1 + (dt_mapdata [i] - 32) / 8;
			spawners [max_spawners].en = 4 + spawners [max_spawners].type;
			spawners [max_spawners].last_spawned = 0;
			max_spawners ++;
			dt_mapdata [i] = TILE_SPAWNER;
		} else if (dt_mapdata [i] == 16) {
			start_y = (unsigned char) ((i >> 6) << 1);
			start_x = (unsigned char) ((i & 63) << 1);
			dt_mapdata [i] = 0;
		}
	}
	
	// Spread some life recharges here and there.
	for (i = 0; i < max_recharges; i ++) {
		// Look for a walkable tile. (Hopefully accesible).
		do {
			xy = ((rand () % 40) << 6) + (rand () % 64);
		} while (!is_walkable (dt_mapdata [xy]) || dt_mapdata [xy] == TILE_KEY || dt_mapdata [xy] == TILE_EXIT);
		dt_mapdata [xy] = TILE_RECHARGE;
	}
}

void init_enemies () {
	unsigned char i;
	for (i = 0; i < MAX_ENEMIES; i ++)
		enemies [i].type = 0;	
}

unsigned char find_shoot () {
	unsigned char i;
	for (i = 0; i < n_shoots; i ++) 
		if (shoots [i].active == 0)
			return i;
	return 255;
}

unsigned char find_enemy () {
	unsigned char i;
	for (i = 0; i < MAX_ENEMIES; i ++) 
		if (enemies [i].type == 0)
			return i;
	return 255;	
}

void draw_shoot (unsigned char i) {
	dt_putchar (1 + shoots [i].x - cam_x, 1 + shoots [i].y - cam_y, 112 + (rand () & 1), 70 + (rand () & 1));	
	dt_putchar (1 + shoots [i].x - cam_x + shoots [i].trail_dx, 1 + shoots [i].y - cam_y + shoots [i].trail_dy, 112 + (rand () & 1), 70 + (rand () & 1));	
}

void move_shoots () {
	unsigned char i, j;
	unsigned int which_tile;
	
	for (i = 0; i < n_shoots; i ++) {
		if (shoots [i].active) {
			// Collide enemies?
			// MOVED FOR SPEED INTO ENEMIES MANAGEMENT			
			/*
			for (j = 0; j < MAX_ENEMIES; j ++) {
				if (enemies [j].ns) {
					if ((shoots [i].x == enemies [j].x || shoots [i].x == enemies [j].x + 1) &&
						(shoots [i].y == enemies [j].y || shoots [i].y == enemies [j].y + 1)) {
						enemies [j].en --;
						if (enemies [j].en == 0) {
							enemies [j].type = 0;
							enemies [j].ns = 0;
						}
						shoots [i].active = 0;			
					}
				}
			}
			
			*/
			
			// Collide wall?
			if (dt_attr (1 + shoots [i].x - cam_x, 1 + shoots [i].y - cam_y) > 64) {
				shoots [i].active = 0;
				
				// Check if we hit a spawner
				which_tile = (shoots [i].x >> 1) + ((shoots [i].y >> 1) << 6);
				if (dt_mapdata [which_tile] == TILE_SPAWNER) {
					// Find which spawner
					for (j = 0 ; j < max_spawners; j ++) {
						if (((shoots [i].x >> 1) << 1) == spawners [j].x &&
							((shoots [i].y >> 1) << 1) == spawners [j].y &&
							spawners [j].type > 0) {
							add_to_score (spawners [j].type << 4);
							if (spawners [j].en > 0) {
								spawners [j].en --;		
							} else {
								// Kill spawner
								spawners [j].type = 0;
								dt_mapdata [which_tile] = 0;
							}
							draw_shoot (i);
							break;
						}
					}
					wyz_play_sound (1);
				} else {
					wyz_play_sound (2);
				}
			}
			
			shoots [i].x += shoots [i].mx;
			shoots [i].y += shoots [i].my;
			shoots [i].x += shoots [i].mx;
			shoots [i].y += shoots [i].my;
					
			// Exit?
			if (shoots [i].x < cam_x || shoots [i].x > cam_x + 29 ||
				shoots [i].y < cam_y || shoots [i].y > cam_y + 15) 
				shoots [i].active = 0;
					
			//if (shoots [i].active) {
				
			//}
		}
	}
}

void check_shoot () {
	unsigned char i, j;
	
	i = (joyfunc) (&keys);
		
	if ((i & in_FIRE) != 0 && !player.firing) {
		player.firing = 1;
		j = find_shoot ();
		if (j != 255) {
			switch (player.facing) {
				case 0:
					shoots [j].x = player.x + 1;
					shoots [j].y = player.y + 2 - inval;
					shoots [j].mx = 0;
					shoots [j].my = 1;
					shoots [j].trail_dx = 0;
					shoots [j].trail_dy = -1;
					break;
				case 3:
					shoots [j].x = player.x;
					shoots [j].y = player.y - 1 + inval;
					shoots [j].mx = 0;
					shoots [j].my = -1;
					shoots [j].trail_dx = 0;
					shoots [j].trail_dy = 1;
					break;
				case 6:
					shoots [j].x = player.x - 1 + inval;
					shoots [j].y = player.y + 1;
					shoots [j].mx = -1;
					shoots [j].my = 0;
					shoots [j].trail_dx = 1;
					shoots [j].trail_dy = 0;
					break;
				case 9:
					shoots [j].x = player.x + 2 - inval;
					shoots [j].y = player.y;
					shoots [j].mx = 1;
					shoots [j].my = 0;
					shoots [j].trail_dx = -1;
					shoots [j].trail_dy = 0;
					break;
			}	
			shoots [j].active = 1;
			wyz_play_sound (0);
		}
	}
	
	if ((i & in_FIRE) == 0)
		player.firing = 0;
}

void move_enemies () {
	unsigned char i, j, k;
	unsigned char attempts;
	unsigned char x, y, rx, ry, nd;
	unsigned char bus_count;
	unsigned char cao;
	
	// For each enemy, if on screen, paint
	// And put them in the bus to be processed later.
	bus_count = 0;
	inval = 0;
	for (i = 0; i < MAX_ENEMIES; i ++) {
		enemies [i].ns = 0;
		if (enemies [i].type > 0) {
			if (enemies [i].x >= cam_x - 1 && enemies [i].x <= cam_x + 29 &&
				enemies [i].y >= cam_y - 1 && enemies [i].y <= cam_y + 15) {
				enemies [i].real_x = 1 + enemies [i].x - cam_x;
				enemies [i].real_y = 1 + enemies [i].y - cam_y;	
				enemies [i].ns = 1;
				
				if (enemies [i].ns) {
					if (enemies [i].type == 5) {
						draw_sprite (enemies [i].real_x, enemies [i].real_y, 
							29 + enemies [i].frame,
							7);
					} else {
						draw_sprite (enemies [i].real_x, enemies [i].real_y, 
							32 + ((enemies [i].type - 1) << 3) + enemies [i].facing + enemies [i].frame, 
							71 - ((enemies [i].en - 1)>>4));
					}
					enemies_bus [bus_count] = i;
					bus_count ++;
				}
			} 	
		}
	}
	
	// For each enemy, if on screen, attempt to move.
	// for (i = 0; i < MAX_ENEMIES; i ++) {
	// Optimization: precalc which are on screen.
	for (k = 0; k < bus_count; k ++) {
		check_shoot ();
		i = enemies_bus [k];
		//if (enemies [i].ns) {
		nd = 0;
		if (enemies [i].type == 5) {
			// Enemy dying
			enemies [i].frame ++;
			if (enemies [i].frame == 2)  {
				enemies [i].type = 0;
				enemies [i].x = enemies [i].y = 254;
			}
		} else if (enemies [i].type == 4 || halflife) {
			x = enemies [i].x;
			y = enemies [i].y;
			if (enemies [i].x > player.x) {
				enemies [i].facing = 4;
				if (dt_attr (enemies [i].real_x - 1, enemies [i].real_y) < 64 &&
					dt_attr (enemies [i].real_x - 1, enemies [i].real_y + 1) < 64) {
					enemies [i].x --;
					enemies [i].real_x = 1 + enemies [i].x - cam_x;
					nd = 1;
				}
			} else if (enemies [i].x < player.x) {
				enemies [i].facing = 6;
				if (dt_attr (enemies [i].real_x + 2, enemies [i].real_y) < 64 &&
					dt_attr (enemies [i].real_x + 2, enemies [i].real_y + 1) < 64) {
					enemies [i].x ++;
					enemies [i].real_x = 1 + enemies [i].x - cam_x;
					nd = 1;
				}
			}
			
			// Vert
			if (enemies [i].y > player.y) {
				enemies [i].facing = 2;
				if (dt_attr (enemies [i].real_x, enemies [i].real_y - 1) < 64 &&
					dt_attr (enemies [i].real_x + 1, enemies [i].real_y - 1) < 64) {
					enemies [i].y --;
					enemies [i].real_y = 1 + enemies [i].y - cam_y;
					nd = 1;
				}
			} else if (enemies [i].y < player.y) {
				enemies [i].facing = 0;
				if (dt_attr (enemies [i].real_x, enemies [i].real_y + 2) < 64 &&
					dt_attr (enemies [i].real_x + 1, enemies [i].real_y + 2) < 64) {
					enemies [i].y ++;
					enemies [i].real_y = 1 + enemies [i].y - cam_y;
					nd = 1;
				}
			}		
		}
		if (nd) enemies [i].frame = 1 - enemies [i].frame;	
		
		// Moved here: collision with player
		// Collide?
		if (enemies [i].x >= player.x - 1 && enemies [i].x <= player.x + 1 &&
			enemies [i].y >= player.y - 1 && enemies [i].y <= player.y + 1) {
			if (enemies [i].type == 4) {
				enemies [i].en -= 8;
			} else {
				enemies [i].en --;
			}
			if (enemies [i].en <= 0) {
				enemies [i].type = 5;
				enemies [i].frame = 0;
				enemies [i].ns = 0;
			}
			// Don't let the enemy overlap the player
			enemies [i].x = x;
			enemies [i].y = y;
			// Aaaaaaaahhhh!!!
			if (player.energy > 0) player.energy --;
			wyz_play_sound (6);
			draw_5_digit (11, 18, player.energy);
		}
					
		// Moved here: collision with shoots
		if (enemies [i].type != 5 && enemies [i].en > 0) {
			for (j = 0; j < n_shoots; j ++) {
				if (shoots [j].active) {
					cao = 0;
					x = shoots [j].x + shoots [j].trail_dx;
					y = shoots [j].y + shoots [j].trail_dy;
					if ((shoots [j].x == enemies [i].x || shoots [j].x == enemies [i].x + 1) &&
						(shoots [j].y == enemies [i].y || shoots [j].y == enemies [i].y + 1)) 
						cao = 1;
					else if ((x == enemies [i].x || x == enemies [i].x + 1) &&
							 (y == enemies [i].y || y == enemies [i].y + 1))
						cao = 1;
					
					if (cao) {
						//add_to_score (enemies [i].type);
						
						if (enemies [i].en > 16 && enemies [i].type != 5) {
							enemies [i].en -= 16;
						} else {
						//if (enemies [i].en <= 0) {
							enemies [i].type = 5;
							enemies [i].frame = 0;
							enemies [i].ns = 0;
						}
						shoots [j].active = 0;	
						draw_shoot (j);
						wyz_play_sound (1);
					}
				}
			}
		}
		//}
	}
	
	for (j = 0; j < n_shoots; j ++)
		if (shoots [j].active)
			draw_shoot (j);
	
	// If player close to spawner and spawner visible, and player moving!
	// attempt to create enemies.
	for (i = 0; i < max_spawners; i++) {
		/*
		if (spawners [i].x >= cam_x + 2 && spawners [i].x <= cam_x + 26 &&
			spawners [i].y >= cam_y + 2 && spawners [i].y <= cam_y + 12) {
		*/
		if (spawners [i].x >= cam_x - 1 && spawners [i].x <= cam_x + 29 &&
			spawners [i].y >= cam_y - 1 && spawners [i].y <= cam_y + 14) {
			// Can we spawn?
			if (spawners [i].last_spawned == 0) {
				spawners [i].last_spawned = 16 - (spawners [i].type << 1);
				
				// We try to place a new enemy only 4 times
				attempts = 0;
				nd = 0;
				
				do {
					do {
						x = spawners [i].x - 2 + ((rand () % 3) << 1);
						y = spawners [i].y - 2 + ((rand () % 3) << 1);
						rx = 1 + x - cam_x;
						ry = 1 + y - cam_y;	
						attempts ++;
						if (attempts == MAX_ATTEMPTS) nd = 1;
					} while (attempts < MAX_ATTEMPTS && (rx < 2 || rx > 29 || ry < 2 || ry > 14));
				} while (attempts < MAX_ATTEMPTS && 
					(dt_attr (rx, ry) > 64 || dt_attr (rx + 1, ry) > 64  ||
					 dt_attr (rx, ry + 1) > 64 || dt_attr (rx + 1, ry + 1) > 64));
				
				if (!nd) {
					j = find_enemy ();
					if (j != 255) {
						if (spawners [i].ct < 8) {
							enemies [j].type = spawners [i].type;
							enemies [j].x = x;
							enemies [j].y = y;
							enemies [j].en = (spawners [i].type << 4);
							enemies [j].facing = 0;
							enemies [j].frame = 0;
							spawners [i].ct ++;
						}
						if (player.moved) spawners [i].ct = 0;
					}
				}	 		 
			} else {
				spawners [i].last_spawned --;
			}
		}	
	}
}

unsigned char whatInMap (unsigned char x, unsigned char y) {
	return dt_mapdata [x + (y << 6)];	
}

void break_gate (unsigned char x, unsigned char y) {
	// This is a recursive function. Yay.
	// First break current cell:
	dt_mapdata [x + (y << 6)] = 0;
	
	// Now check for neighbors:
	if (x > 0 && whatInMap (x - 1, y) == TILE_GATE)	
		break_gate (x - 1, y);
	if (x < 63 && whatInMap (x + 1, y) == TILE_GATE)
		break_gate (x + 1, y);
	if (y > 0 && whatInMap (x, y - 1) == TILE_GATE)
		break_gate (x, y - 1);
	if (y < 39 && whatInMap (x, y + 1) == TILE_GATE)
		break_gate (x, y + 1);
}

void check_gate (unsigned char direction) {
	unsigned char x, y;
	unsigned char dothis;
	
	dothis = 0;
	
	if (player.keys > 0) {	
		x = player.x >> 1;
		y = player.y >> 1;
		switch (direction) {
			case DIRECTION_UP:
				if (whatInMap (x, y - 1) == TILE_GATE) {
					break_gate (x, y - 1);
					dothis = 1;
				} else if ((player.x & 1) == 1 && whatInMap (x + 1, y - 1) == TILE_GATE) {
					break_gate (x + 1, y - 1);
					dothis = 1;
				}
				break;
			case DIRECTION_DOWN:
				if (whatInMap (x, y + 1) == TILE_GATE) {
					break_gate (x, y + 1);
					dothis = 1;
				} else if ((player.x & 1) == 1 && whatInMap (x + 1, y + 1) == TILE_GATE) {
					break_gate (x + 1, y + 1);
					dothis = 1;
				}
				break;
			case DIRECTION_LEFT:
				if (whatInMap (x - 1, y) == TILE_GATE) {
					break_gate (x - 1, y);
					dothis = 1;
				} else if ((player.y & 1) == 1 && whatInMap (x - 1, y + 1) == TILE_GATE) {
					break_gate (x - 1, y + 1);
					dothis = 1;
				}
				break;
			case DIRECTION_RIGHT:
				if (whatInMap (x + 1, y) == TILE_GATE) {
					break_gate (x + 1, y);
					dothis = 1;
				} else if ((player.y & 1) == 1 && whatInMap (x + 1, y + 1) == TILE_GATE) {
					break_gate (x + 1, y + 1);
					dothis = 1;
				}
		}
		if (dothis) {
			player.keys --;
			wyz_play_sound (3);
			draw_3_digit (20, 21, player.keys);
		}
	}
}

void player_step () {
	player.step = (player.step + 1) & 3;
	if (player.step == 0 || player.step == 2) 
		player.frame = 1;
	else if (player.step == 1)
		player.frame = 0;
	else
		player.frame = 2;
}

void move_player () {
	unsigned char i, nd, j;
	unsigned char xo = player.x, yo = player.y;
	int whichtile;
	
	inval = 2;
	
	player.real_x = 1 + player.x - cam_x;
	player.real_y = 1 + player.y - cam_y;
	
	i = (joyfunc) (&keys);
	nd = 0;
	
	if ((i & in_UP) != 0) {
		player.facing = 3;
		nd = 1;
		if (dt_attr (player.real_x, player.real_y - 1) < 64 && 
			dt_attr (player.real_x + 1, player.real_y - 1) < 64)
			player.y --;
		else
			check_gate (DIRECTION_UP);
	} 
	
	if ((i & in_DOWN) != 0) {
		player.facing = 0;
		nd = 1;
		if (dt_attr (player.real_x, player.real_y + 2) < 64 && 
			dt_attr (player.real_x + 1, player.real_y + 2) < 64)
			player.y ++;
		else
			check_gate (DIRECTION_DOWN);
	}
	
	player.real_y = 1 + player.y - cam_y;
	
	if ((i & in_LEFT) != 0) {
		player.facing = 6;
		nd = 1;
		if (dt_attr (player.real_x - 1, player.real_y) < 64 &&
			dt_attr (player.real_x - 1, player.real_y + 1) < 64)
			player.x --;
		else
			check_gate (DIRECTION_LEFT);
	}
	
	if ((i & in_RIGHT) != 0) {
		player.facing = 9;
		nd = 1;
		if (dt_attr (player.real_x + 2, player.real_y) < 64 &&
			dt_attr (player.real_x + 2, player.real_y + 1) < 64)
			player.x ++;
		else
			check_gate (DIRECTION_RIGHT);
	}

	check_shoot ();
	
	player.real_x = 1 + player.x - cam_x;
	
	if (nd) player_step ();
	
	// ¿Get key? ¿Exit? ¿Recharge?
	
	if ((player.x & 1) == 0 && (player.y & 1) == 0) { 
		whichtile = ((player.y >> 1) << 6) + (player.x >> 1);
		if (dt_mapdata [whichtile] == TILE_KEY) {
			dt_mapdata [whichtile] = 0;
			player.keys ++;
			draw_3_digit (20, 21, player.keys);
			add_to_score (10);
			wyz_play_sound (7);
		} else if (dt_mapdata [whichtile] == TILE_EXIT) {
			i_shat_brix = 1;
			wyz_play_sound (8);
		} else if (dt_mapdata [whichtile] == TILE_RECHARGE) {
			dt_mapdata [whichtile] = 0;
			player.energy += 25;
			draw_5_digit (11, 18, player.energy);
			add_to_score (10);
			wyz_play_sound (5);
		}
	}
	
	player.moved = !(player.x == xo && player.y == yo);
}

unsigned char pass_printer_section [] = {0, 0, 0, 0, 0};

void interim (unsigned char world, unsigned char level) {
	int i;
	
	// Clear screen
	clear_viewport (70);
	
	// Texts
	draw_char_by_char (4, 6, "THIS LEVEL SCORE:");
	draw_5_digit (22, 5, player.score - player.last_score);
	draw_char_by_char (6, 9, "BONUS ENERGY:");
	draw_5_digit (20, 8, player.energy);
	
	// Animation
	i = player.score - player.last_score;
	while (i > 0) {
		player.energy ++;
		i-=25;
		if (!in_Inkey ()) {
			draw_5_digit (22, 5, i);
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
	
	for (i = 0; i < 5; i ++) {
		pass_printer_section [0] = pass_string [i << 2];	
		pass_printer_section [1] = pass_string [1 + (i << 2)];
		pass_printer_section [2] = pass_string [2 + (i << 2)];
		pass_printer_section [3] = pass_string [3 + (i << 2)];
		draw_fast (4 + i * 5, 14, 70, pass_printer_section);
	}
	
	mywaitkey ();
}

unsigned char game (unsigned char world, unsigned char level) {
	unsigned char finished = 0;
	unsigned char do_game, justentered;
	
	n_shoots = 3;
		
	halflife = 0;
	do_game = 1; 
	
	justentered = 1;
	
	while (do_game) {
		
		if (level == 0 || justentered) {
			prepare_world (world, level);
			if (level == 0) level = 1;
			fade_out ();
			get_resource (SCR_MT_MARCO_BIN, 16384, 1);
		} 
		
		justentered = 0;
		
		prepare_stage (world, level);
		draw_1_digit (20, 18, world);
		draw_1_digit (22, 18, level);
		
		// Initialize enemy spawners and other stuff upon mapdata
		init_mapdata ();
		
		// Place player
		player.x = start_x;
		player.y = start_y;
		player.step = 0;
		player.frame = 0;
		player.facing = 0;
		player.keys = 0;
			
		// Initialize enemies
		init_enemies ();
		
		// Initialize shoots
		init_shoots ();
		
		i_shat_brix = 0;
		
		// Marcadores
		
		draw_5_digit (11, 18, player.energy);
		draw_5_digit (25, 18, player.score);
		
		player.last_score = player.score;
		
		// Play music
		
		wyz_play_music (level);
		
		do {
			halflife = 1 - halflife;
			
			// Everything behaves according to the camera position
			// So we move the camera first, then we render the map
			
			// Change this?
			cam_x = player.x - 15;
			cam_y = player.y - 7;
			
			// Camera limits
			if (cam_x < 0) cam_x = 0;
			if (cam_x > 98) cam_x = 98;
			if (cam_y < 0) cam_y = 0;
			if (cam_y > 64) cam_y = 64;
			
			// Now make everything happen
			draw_map (cam_x, cam_y);
			
			// Now everything's on, and we can do stuff
			move_shoots ();
			move_enemies ();
			move_player ();
			
			draw_sprite (player.real_x, player.real_y, 16 + player.facing + player.frame, 68);
			
			// Finally, render
			blit_buffer ();	
			
			// Urm... Change this later
			finished = i_shat_brix || (player.energy == 0);
		} while (!finished);
		
		wyz_stop_sound ();
		
		if (player.energy == 0) {		
			// Game over screen
			get_resource (SCR_GAME_OVER_BIN, 16384, 1);
			wyz_play_music (6);
			draw_5_digit (13, 14, player.score);
			do_game = 0;
			mywaitcycles (300);
		} else {
			if (world > 5) {
				do_game = 0;
			} else {
				if (level != 4 || world != 5) {
					interim (world, level);	
				}
				level ++;
				if (level == 5) {
					level = 0;
					world ++;
					
					if (world == 6) {
						// Game ending
						ending ();

						do_game = 0;
					}
				}
			}
		}
	}
	
	blackout_everything ();
}