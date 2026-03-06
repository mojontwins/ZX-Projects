// msc-config.h
// Generado por Mojon Script Compiler 3 de la MT Engine MK2
// Copyleft 2014 The Mojon Twins

unsigned char sc_x, sc_y, sc_n, sc_m, sc_c;
unsigned char script_result = 0;
unsigned char sc_terminado = 0;
unsigned char sc_continuar = 0;
unsigned int main_script_offset;
#ifndef MODE_128K
extern unsigned char main_script [0];
#asm
    ._main_script
        BINARY "scripts.bin"
#endasm
#endif
unsigned char warp_to_level;
extern unsigned char *script;
#asm
    ._script defw 0
#endasm

#define INIT_GAME 0x0000
#define LEVEL_0 0x009F
#define LEVEL_2 0x0300
#define LEVEL_5 0x0443
#define LEVEL_6 0x0622
#define LEVEL_TARDIS 0x0743

// This game uses items...

#define MSC_MAXITEMS 3
#define FLAG_SLOT_SELECTED 30
#define FLAG_ITEM_SELECTED 31
#define ITEM_EMPTY 0
 
unsigned char items [MSC_MAXITEMS];
unsigned char its_it, its_p;
 
int key_z;
unsigned char key_z_pressed = 0;
 
void draw_cursor (unsigned char a, unsigned char b, unsigned char x, unsigned char y) {
	if (a != b) {
		sp_PrintAtInv (y, x, 0, 0);
		sp_PrintAtInv (y, x + 1, 0, 0);
	} else {
		sp_PrintAtInv (y, x, 66, 62);
		sp_PrintAtInv (y, x + 1, 66, 63);
	}
}
 
void display_items (void) {
    its_p = 2;
    for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {
        _x = its_p; _y = 21;
        if (items [its_it]) {
            _t = items [its_it];
        } else {
            _t = 0;
        }
        draw_coloured_tile ();
        draw_cursor (its_it, flags [FLAG_SLOT_SELECTED], its_p, 23);
        its_p += 3;
    }
}
 
void do_inventory_fiddling (void) {
	if (sp_KeyPressed (key_z)) {
		if (!key_z_pressed) {
#ifdef MODE_128K
			_AY_PL_SND (2);
#else
			peta_el_beeper (2);
#endif
#ifdef MSC_MAXITEMS
			flags [FLAG_SLOT_SELECTED] = (flags [FLAG_SLOT_SELECTED] + 1) % MSC_MAXITEMS;
#else
			flags [FLAG_SLOT_SELECTED] = (flags [FLAG_SLOT_SELECTED] + 1) % SIM_DISPLAY_MAXITEMS;
#endif
			display_items ();
		}
		key_z_pressed = 1;
	} else {
		key_z_pressed = 0;
	}
}
 

#define SCRIPT_INIT 49152 
