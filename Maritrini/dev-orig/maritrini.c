#pragma output STACKPTR=32767

// Packed screens addresses in RAM3

#define INITIAL_SCORE	0
#define INITIAL_ENERGY	200

// Includes

#include <input.h>
#include <im2.h>
#include "128k.h"
#include "librarian.h"
#include "aplib.h"
#include "dostercioszx.h"
#include "wyzplay.h"
#include "printer.h"
#include "levels.h"

void *joyfunc = in_JoyKeyboard;
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
	unsigned int i;
	unsigned char x = 0, y = 0, mx = 1, my = 1;
	unsigned char world, level;
	unsigned char done;
	unsigned char key;
	unsigned char *address;
	unsigned char m, passroutine;
	
	#asm
		di
	#endasm
	
	//im2_Init (0x6200);
	im2_Init (0xFDFD);
	//address = (unsigned char *) (0x6200);
	address = (unsigned char *) (0xFDFD);
	for (i = 0; i < 257; i ++) {
		//*address = 0x63;
		*address = 0xFE;
		address ++;
	}
	//address = (unsigned char *) (0x6363);
	address = (unsigned char *) (0xFEFE);
	*address = 195;
	address ++;
	*address = (isr & 255);
	address ++;
	*address = (isr >> 8);
	
	#asm
		ei
	#endasm
	
	wyz_init_soundsystem ();
	
	//zx_border (0);
	#asm
		ld a, 0
		out (254),a
	#endasm
	
	keys.up    = in_LookupKey('q');
	keys.down  = in_LookupKey('a');
	keys.left  = in_LookupKey('o');
	keys.right = in_LookupKey('p');
	keys.fire  = in_LookupKey(' ');
	
	world = 1;
	level = 0;
	
	blackout_everything ();
	player.hiscore = 0;
	
	#asm
	ei
	#endasm
		
	fade_out ();
	get_resource (SCR_MTLOGO_BIN, 16384, 0);
	wyz_play_sound (8);
	mywaitcycles (100);
	fade_out ();
	get_resource (SCR_UBHRES_BIN, 16384, 0);
	wyz_play_sound (7);
	mywaitcycles (100);
	fade_out ();
	get_resource (SCR_CREDITS_BIN, 16384, 0);
	wyz_play_sound (5);
	mywaitcycles (500);
	fade_out ();
	
	while (1) {	
		m = menu ();
	
		if (m == 1) {
			player.score = INITIAL_SCORE;
			player.energy = INITIAL_ENERGY;
			wyz_stop_sound ();
			fade_out ();
			game (1, 0);
		} else if (m == 2) {
			
			// Enter password routine	
			get_resource (SCR_MENU_BIN, 16384, 0);	
			
			draw_fast (9, 16, 71, "ENTER PASSWORD");
			draw_fast (4, 18, 71, "0000 0000 0000 0000 0000");
			draw_fast (8, 20, 71, "PRESS ENTER TO GO");
			draw_fast (7, 21, 71, "PRESS SPACE TO EXIT");
			
			for (i = 0; i < 20; i ++)
				pass_string [i] = '0';
			
			clear_keybuff ();
				
			done = 0;
			x = 0;
			ncy [0] = 18;
			while (!done) {
				// Show position
				address = (unsigned char *) (23104 + 4 + 5 * (x >> 2) + (x & 3));
				*address = 48;
				
				key = in_Inkey ();
				
				// Shift to caps
				if (key >= 'a' && key <= 'f') 
					key -= 32;		
				
				// address = (unsigned char *) (23104 + 4 + 5 * (x >> 2) + (x & 3));
				
				// Do stuff
				if (key != 0) {
					if (key == 13) {
						if (check_password ()) {
							world = ps_world;
							level = ps_level;
							player.score = ps_score;
							player.energy = ps_energy;
							wyz_stop_sound ();
							fade_out ();
							game (world, level);
							done = 1;
						} else {
							draw_fast (9, 16, 66, "WRONG PASSWORD");
							while (in_Inkey ());
							while (!in_Inkey ());
							draw_fast (9, 16, 71, "ENTER PASSWORD");
							ncy [0] = 18;
						}
					} else if (key == 32) {
						done = 1;
					} else if ((key == 12 || key == 8) && x > 0) {
						*address = 71;
						x --;
					} else if (key == 9 && x < 19) {
						*address = 71;
						x ++;
					} else if ((key >= 'A' && key <= 'F') || (key >= '0' && key <= '9')) {
						pass_string [x] = key;
						ncx [0] = 4 + 5 * (x >> 2) + (x & 3);
						ncn [0] = key - 32;
						draw_char ();
						*address = 71;
						if (x < 19)
							x ++;
					}
					while (key == in_Inkey () || key == in_Inkey () - 32);
				}
			}
			
		} else if (m == 3) {
			player.score = INITIAL_SCORE;
			player.energy = INITIAL_ENERGY;
			wyz_stop_sound ();
			fade_out ();
			game (6, 0);
		}
	}
}

