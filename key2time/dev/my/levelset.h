// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// levels128.h
// Level definition for 128k games

// This is the level manager used in Ninjajar!

// This can be considered completely custom but also can be reused/refined.
// I will probably come with something more simple for future games.

// Right away, the levelset is containted in two structures, the
// levels [] array, which has an entry for each unique level, and the
// level_sequence [] array, which defines an order for the levels
// (in case you want to reuse a level - like we do in Ninjajar!)

// Definitions
// This is fixed. 32 bolts per level.
#define MAX_bolts 32

// Space reserved for levels
// This will be overwritten with the unpacked data

#asm
	._level_data 
		defs 16
	._map 
		defs MAP_W * MAP_H * 75
	._map_attrs 
		defs MAP_W * MAP_H
	._tileset 
		BINARY "../bin/basicts.bin"
#endasm
#include "assets/sprites-empty.h"
#asm
	._sprite_e 
		defs 144 * EXTRA_SPRITES
	._baddies 
		defs MAP_W * MAP_H * 3 * 10
	._behs 
		defs 48
#endasm

// This is different - we take extrasprites.h from the main chunk
// so we can use level bundles without having to worry.
#include "assets/extrasprites.h"

extern unsigned char arrow_sprites [0];
#asm
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
._arrow_sprites
	BINARY "../bin/sparrow.bin"
#endasm

// Level struct
LEVEL levels [] = {
	{LEVEL0C_BIN, 0, SCRIPT_INIT + LEVEL_0},
	{0, 0, 0},
	{LEVEL2C_BIN, 2, SCRIPT_INIT + LEVEL_2},
	{0, 0, 0},
	{0, 0, 0},
	{LEVEL5C_BIN, 5, SCRIPT_INIT + LEVEL_5},
	{LEVEL6C_BIN, 6, SCRIPT_INIT + LEVEL_6},
	{0, 0, 0},
	{0, 0, 0},
	{LEVELTC_BIN, 9, SCRIPT_INIT + LEVEL_TARDIS}
};
