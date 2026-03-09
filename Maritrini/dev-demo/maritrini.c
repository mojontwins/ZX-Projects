#pragma output STACKPTR=32767

// Memory map

#define DT_TILESET 0x8000
#define DT_MAPDATA 0x8900
#define DT_BUFFER  0x9300

// Need to place ISR vector @9800, so
// Compile main bin to 0x9999 (39321)

// ISR will point to $7e7e

// Handy

#define INITIAL_SCORE	0
#define INITIAL_ENERGY	200

// Some defines.

#define MAX_ENEMIES		128
#define MAX_SHOOTS		4
#define MAX_ATTEMPTS	6
#define MAX_DESTRUCTORS 20
#define MAX_FOCOS		20

#define DIRECTION_UP 	1
#define DIRECTION_DOWN 	2
#define DIRECTION_LEFT	3
#define DIRECTION_RIGHT	4

#define TILE_SPAWNER	12
#define TILE_KEY		13
#define TILE_GATE		14
#define TILE_EXIT		15
#define TILE_RECHARGE	31

#define BOMB_TICK 		8

// Includes

#include <input.h>
#include <im2.h>
#include "globals.h"
#include "128k.h"
#include "librarian.h"
#include "aplib.h"
#include "dostercioszx.h"
#include "wyzplay.h"
#include "printer.h"
#include "levels.h"

uint (*joyfunc)(struct in_UDK *) __z88dk_fastcall = in_JoyKeyboard;
const void *joyfuncs [] = {
	in_JoyKeyboard, in_JoyKempston, in_JoySinclair1
};

void clear_keybuff () {
	while (in_Inkey ());
}
extern unsigned char scr_ending_2 [0];

#include "claves.h"
#include "ending.h"
#include "engine.h"
#include "menu.h"

// Main

void main (void) {

	video_page = 0;
	ram_page_act = 0;
	pregister = 0x17;

	#asm
		di
	#endasm
	
	im2_Init (0x9898);

	#asm
		ld  a, 0x7e
		ld  hl, 0x9800
		ld  (hl), a
		ld  de, 0x9801
		ld  bc, 256
		ldir

		ld  hl, 0x7e7e
		ld  a, 195
		ld  (hl), a
		inc hl
		ld  a, _isr % 256
		ld  (hl), a
		inc hl
		ld  a, _isr / 256
		ld  (hl), a
	#endasm
	
	wyz_init_soundsystem ();
	
	//zx_border (0);
	#asm
		ld a, 0
		out (254),a
	#endasm
	
	blackout_everything ();
	player.hiscore = 0;
	
	#asm
		ei
	#endasm
	
	while (1) {	
		switch (menu ()) {

			case 1:
			case 3: 	// DEMO = NO TRAINING
				player.score = INITIAL_SCORE;
				player.energy = INITIAL_ENERGY;
				wyz_stop_sound ();
				fade_out ();
				game (1, 0);
				break;

			case 2:
				// Enter password routine	
				get_resource (SCR_MENU_DEMO_BIN, 16384, 0);	
				
				draw_fast (9, 16, 71, "ENTER PASSWORD");
				draw_fast (4, 18, 71, "0000 0000 0000 0000 0000");
				draw_fast (8, 20, 71, "PRESS ENTER TO GO");
				draw_fast (7, 21, 71, "PRESS SPACE TO EXIT");
				
				for (gpit = 0; gpit < 20; gpit ++)
					pass_string [gpit] = '0';
				
				clear_keybuff ();
					
				rdx = 0;
				ncy [0] = 18;
				while (1) {
					// Show position
					gp_gen = (unsigned char *) (23104 + 4 + 5 * (rdx >> 2) + (rdx & 3));
					*gp_gen = 48;
					
					gpit = in_Inkey ();
					
					// Shift to caps
					if (gpit >= 'a' && gpit <= 'f') 
						gpit -= 32;		
					
					// gp_gen = (unsigned char *) (23104 + 4 + 5 * (rdx >> 2) + (rdx & 3));
					
					// Do stuff
					if (gpit != 0) {
						if (gpit == 13) {
							// DEMO: Fixed to world 1-5 and 1st level
							if (check_password () && ps_world < 6 && ps_level < 2) {
								player.score = ps_score;
								player.energy = ps_energy;
								wyz_stop_sound ();
								fade_out ();
								game (ps_world, ps_level);
								break;
							} else {
								draw_fast (9, 16, 66, "WRONG PASSWORD");
								while (in_Inkey ());
								while (!in_Inkey ());
								draw_fast (9, 16, 71, "ENTER PASSWORD");
								ncy [0] = 18;
							}
						} else if (gpit == 32) {
							break;
						} else if ((gpit == 12 || gpit == 8) && rdx > 0) {
							*gp_gen = 71;
							rdx --;
						} else if (gpit == 9 && rdx < 19) {
							*gp_gen = 71;
							rdx ++;
						} else if ((gpit >= 'A' && gpit <= 'F') || (gpit >= '0' && gpit <= '9')) {
							pass_string [rdx] = gpit;
							ncx [0] = 4 + 5 * (rdx >> 2) + (rdx & 3);
							ncn [0] = gpit - 32;
							draw_char ();
							*gp_gen = 71;
							if (rdx < 19)
								rdx ++;
						}
						while (gpit == in_Inkey () || gpit == in_Inkey () - 32);
					}
				}
				break;
			
		}
	}
}
