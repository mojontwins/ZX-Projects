// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

#pragma output STACKPTR=24199
#define FREEPOOL 	61697
#define NUMBLOCKS	54

#include <spritepack.h>

// We are using some stuff from splib2 directly.
#asm
		LIB SPMoveSprAbs
#endasm

unsigned char dynamic_memory_pool [NUMBLOCKS * 15];
#define FIXBITS 4

#include "config.h"
#include "definitions.h"

#include "ram/globals.h"
#include "autodefs.h"

#include "sound/nosoundplayer.h"
#include "system/128k.h"
#include "system/aplib.h"
#include "system/random.h"
#include "system/controls.h"

#include "my/msc-config.h"
#include "my/librarian.h"
#include "my/levelset.h"

#include "engine/general.h"
#include "engine/printer.h"

#include "my/extern_e.h"
#include "my/msc.h"

#include "assets/frames.h"

#include "engine/flickscreen.h"
#include "engine/collision.h"
#include "engine/floating_objects.h"
#include "engine/player.h"
#include "engine/enems.h"
#include "engine/screens.h"
#include "engine/level.h"
#include "engine/hitter.h"
#include "engine/scripting.h"

#include "engine/game.h"

void main (void) {
	cortina ();

	#asm
		di
	#endasm

	// System initialization
	#include "system/initialization.h"

	// Sprite creation
	#include "system/sprdefs.h"

	// Music player initialization here TODO

	#asm
		ei
	#endasm

	game_do ();
}
