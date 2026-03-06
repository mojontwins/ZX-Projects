// levels.h

// Just to keep track of where levels are in RAM and
// to unpack them into main RAM.

// In a future, possible 48K version, here be code
// to load levels from tape and unpack them into the
// "current level buffers"

typedef struct {
	unsigned char title_screen_address; // 0
	char *intro_cad; 					// 1
	unsigned char tileset_address; 		// 3
	unsigned char behs_address; 		// 4
	unsigned char stage_1; 				// 5
	unsigned char stage_2; 				// 6
	unsigned char stage_3; 				// 7
	unsigned char stage_4; 				// 8
} WORLD;

extern unsigned char behs [64];

// Anjuel always reverses , and . in the charsets XD

#asm
	._behs
		defs 16
#endasm

WORLD worlds [] = {
	{
		0, 
		0,  
		TILESET_FOREST_BIN,
		FOREST_BEHS_BIN,
		MAP_FOREST1_BIN,
		0, 0, 0
	},
	{
		0,
		0,
		TILESET_SCHOOL_BIN,
		SCHOOL_BEHS_BIN,
		MAP_SCHOOL2_BIN,
		0, 0, 0
	},
	{
		0,
		0,
		TILESET_BASEMENT_BIN,
		BASEMENT_BEHS_BIN,
		MAP_BASEMENT1_BIN,
		0, 0, 0
	},
	{
		0,
		0,
		TILESET_MINE_BIN,
		MINE_BEHS_BIN,
		MAP_MINE3_BIN,
		0, 0, 0
	},
	{
		0,
		0,
		TILESET_HITECH_BIN,
		HITECH_BEHS_BIN,
		MAP_HITECH1_BIN,
		0, 0, 0
	}
};

// Switch / open data
// Goes like this:
// X+Y*64, X1, Y1, X2, Y2
// (X, Y) -> location of the switch
// (X1,Y1)->(X2,Y") -> area to erase (with tile 0)

extern unsigned char *switches_data_1;
extern unsigned char *switches_data_4;
extern unsigned char *switches_data_8;
extern unsigned char *switches_data_empty;

unsigned char *switches_data [] = {
	switches_data_4, switches_data_empty, switches_data_empty, switches_data_empty,
	switches_data_1, switches_data_empty, switches_data_empty, switches_data_empty,
	switches_data_8, switches_data_empty, switches_data_empty, switches_data_empty,
	switches_data_empty, switches_data_empty, switches_data_empty, switches_data_empty,
	switches_data_empty, switches_data_empty, switches_data_empty, switches_data_empty
};

#asm
	// Empty (so you can reuse it)
	._switches_data_empty
		defb 0

	// School

	._switches_data_1
		defw 1 + 25*64
		defb 6, 26, 8, 26

		defw 13+ 27*64
		defb 1, 33, 2, 33

		defw 15 + 31*64
		defb 22, 37, 22, 38

		defw 29 + 29*64
		defb 17, 20, 17, 27

		defw 46 + 9*64
		defb 25, 1, 25, 5

		defw 31 + 21*64
		defb 36, 29, 42, 29

		defb 0

	// Forest

	._switches_data_4
		defw 7 + 6*64
		defb 4, 7, 5, 7

		defw 25 + 22*64
		defb 1, 35, 4, 35

		defw 42 + 9*64
		defb 17, 15, 20, 15

		defb 0

	// Bleh

	._switches_data_8
		defw 57 + 17*64
		defb 38, 3, 38, 6

		defb 0


#endasm

void prepare_world (unsigned char world, unsigned char level) {
	// Show title screen & wait for keypress
	
	// Unpack tileset
	get_resource (worlds [world - 1].tileset_address, DT_TILESET, 0);

	// Unpack behs
	get_resource (worlds [world - 1].behs_address, (unsigned int) (behs), 0);	
}

void prepare_stage (unsigned char world, unsigned char stage) {

	#asm
		// world structure is 9 bytes wide.
		// level assets are @ offsets 5, 6, 7 & 8

			ld  hl, 4
			add hl, sp
			ld  a, (hl) 	// world
			dec a 			// world - 1

			dec hl
			dec hl
			ld  c, (hl) 	// stage

			// A * 9 = A + A << 3
			ld  b, a
			sla a
			sla a
			sla a
			add b

			// stage = 1..4, need 5..8 so
			add 4
			add c

			ld  d, 0
			ld  e, a
			ld  hl, _worlds
			add hl, de 		// worlds [world - 1].stage_X

			ld  a, (hl)
			ld  (_rda), a
	#endasm

	get_resource (rda, DT_MAPDATA, 0);
}
