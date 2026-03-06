// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

void game_loop (void) {

	prepare_level ();

	// Level screen

	if (!silent_level) screen_level ();
	silent_level = 0;

	// Level initialization

	init_player ();
	
	maincounter = script_result = success = no_draw = 0;
	playing = do_respawn = 1;
	objs_old = keys_old = life_old = killed_old = o_pant = 0xff;

	// Entering game script
	
	run_script (MAP_W * MAP_H * 2);

	_AY_PL_MUS (levels [level].music_id);	
	display_items ();

	while (playing) {
		// Read player input
		pad = (joyfunc) (&keys);

		// Timer stuff
		#include "mainloop/timer.h"

		// New screen?
		if (n_pant != o_pant) {
			o_pant = n_pant;
			draw_scr ();
			enems_init ();
			FO_clear ();
			run_entering_script ();
		}

		// Update HUD
		update_hud ();

		// Main counter and main flip-flop
		++ maincounter;
		half_life ^= 1;

		// Move player
		player_move ();
		
		// Move hitter
		if (hitter_on) hitter_do ();

		// Move enemies
		sp_Border(4);
		enems_move ();
		sp_Border(0);

		// Update sprites
		#include "mainloop/update_sprites.h"
		
		// Update to screen
		#asm
			ld c, 254
			ld a, 2
			out (c), a
		#endasm
		while (isr_c < 2) {
			#asm
				halt
			#endasm
		} isr_c = 0;
		#asm
			ld c, 254
			xor a
			out (c), a
		#endasm

		sp_UpdateNow();

		// Die & Respawn
		if (p_killme) player_kill ();
		
		// Select object
		do_inventory_fiddling ();

		// Scripting related stuff
		#include "mainloop/scripting.h"

		// Interact w/floating objects
		FO_do ();

		// Pause/Abort handling

		// Win game condition
		#include "mainloop/win_game.h"

		// Game over condition
		#include "mainloop/game_over.h"

		// Warp to level condition (3)
		// Game ending (4)
		if (script_result > 2) {
			success = script_result;	// Warp_to (3), Game ending (4)
			playing = 0;
		}
		
		// Flick screen
		flick_screen ();

		// Main loop is done!
	}

	_AY_ST_ALL ();

	hide_sprites (0);
	sp_UpdateNow ();
}

void game_do (void) {
	while (1) {

		// Title screen		
		
		sp_UpdateNow();
		get_resource (0, 16384);
		
		_AY_PL_MUS (0);
		select_joyfunc ();
		_AY_ST_ALL ();
		cortina ();

		// Game initialization
		
		mlplaying = 1;
		silent_level = 0;
		level = 9;
		p_life = PLAYER_LIFE;
		script_result = 0;
		p_killme = 0;		

		get_resource (1, 16384);

		// Init game script
		main_script_offset = SCRIPT_INIT + INIT_GAME;
		run_script (MAP_W * MAP_H * 2);

		while (mlplaying) {
			
			game_loop ();

			switch (success) {
				case 0:
					//_AY_PL_MUS (8);
					//game_over ();
					print_message (" GAME OVER! ");
					mlplaying = 0;
					active_sleep (250);
					break;
				case 1:
					//_AY_PL_MUS (7);
					print_message (" ZONE CLEAR ");
					++ level;
					active_sleep (250);
					//do_extern_action (0);
					break;
				case 3:
					blackout_area ();
					level = warp_to_level;
					break;
				case 4:
					get_resource (2, 16384);
					active_sleep (1000);
					_AY_ST_ALL ();
					cortina ();
					//_AY_PL_MUS (12);
					active_sleep (130);
					// credits ();
					mlplaying = 0;
			}

		}
		cortina ();
	}
}
