// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Revamped for better size + speed in 2019

#define FIXBITS 4
#define NUMBLOCKS 40 	// Just 4 16x16 sprites

#include <spritepackt2.h>

// We are using some stuff from splib2 directly.
#asm
		LIB SPMoveSprAbs
		LIB SPPrintAtInv
		LIB SPTileArray
		LIB SPInvalidate
		LIB SPCompDListAddr
#endasm

#pragma output STACKPTR=61952

// It's safer to put this into the main binary
unsigned char AD_FREE [NUMBLOCKS * 15];

#include "config.h"
#include "definitions.h"

#include "ram/globals.h"
#include "my/custom_globals.h"

#include "assets/mapa.h"
#include "assets/tileset.h"
#include "assets/sprites.h"
#include "assets/enems.h"
#include "assets/metasprites.h"
#include "assets/screens.h"

#include "sound/simpleay.h"
#include "sound/beeper.h"

#include "my/overlay.h"
#include "engine/aplib.h"
#include "engine/printer.h"
#include "engine/general.h"
#include "engine/screen_renderer.h"
#include "engine/player.h"
#include "engine/enems.h"
#include "engine/fixed_screens.h"
#include "engine/system.h"

#include "my/custom_routines.h"

#include "mainloop.h"

// Y el main

void main (void) {
	system_init ();
	do_game ();
}

// From beepola. Phaser engine by Shiru.
#include "assets/music.h"
