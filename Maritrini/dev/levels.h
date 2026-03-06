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

extern unsigned char intro_cad1 [];
extern unsigned char intro_cad2 [];
extern unsigned char intro_cad3 [];
extern unsigned char intro_cad4 [];
extern unsigned char intro_cad5 [];

extern unsigned char behs [64];

// Anjuel always reverses , and . in the charsets XD

#asm
	._behs
		defs 16
	._intro_cad1
		defm "MARITRINI ARRIVES IN THE"
		defb 13
		defm "FOREST, "
		defb 34
		defm "I'M SURE THIS IS"
		defb 13
		defm "THE RIGHT PLACE"
		defb 34
		defm ". SHE"
		defb 13
		defm "THINKS TO HERSELF,"
		defb 0
	._intro_cad2
		defm "IN THE MIDDLE OF THE WOOD."
		defb 13
		defm "SHE FINDS A SCHOOL-LIKE"
		defb 13
		defm "COMPLEX, "
		defb 34
		defm "VERY SUSPICIOUS!"
		defb 34
		defb 13
		defm "SHE THINKS,"
		defb 0
	._intro_cad3
		defm "MARITRINI DISCOVERS THE"
		defb 13
		defm "SECRET ENTRANCE TO AN"
		defb 13
		defm "UNDERGROUND INSTALLATION"
		defb 13
		defb 34
		defm "INTERESTING,,,"
		defb 34
		defb 0
	._intro_cad4
		defm "MARITRINI KEEP DESCENDING"
		defb 13
		defm "UNTIL SHE HITS WHAT LOOKS"
		defb 13
		defm "LIKE AN UNDERGROUND MINE"
		defb 13
		defb 34
		defm "MISCHIEVOUS!"
		defb 34
		defb 0
	._intro_cad5
		defb 34
		defm "FINALLY, I THINK I FOUND"
		defb 13
		defm "IT!. THINKS MARITRINI,"
		defb 13
		defb 34
		defm "THIS MUST BE WHERE IT"
		defb 13
		defm "ALL CAME FROM!"
		defb 34
		defb 0
#endasm

WORLD worlds [] = {
	{
		SCR_INTRO_FOREST_BIN, 
		intro_cad1,  
		TILESET_FOREST_BIN,
		FOREST_BEHS_BIN,
		MAP_FOREST1_BIN,
		MAP_FOREST2_BIN,
		MAP_FOREST3_BIN,
		MAP_FOREST4_BIN
	},
	{
		SCR_INTRO_SCHOOL_BIN,
		intro_cad2,
		TILESET_SCHOOL_BIN,
		SCHOOL_BEHS_BIN,
		MAP_SCHOOL1_BIN,
		MAP_SCHOOL2_BIN,
		MAP_SCHOOL3_BIN,
		MAP_SCHOOL4_BIN
	},
	{
		SCR_INTRO_BASEMENT_BIN,
		intro_cad3,
		TILESET_BASEMENT_BIN,
		BASEMENT_BEHS_BIN,
		MAP_BASEMENT1_BIN,
		MAP_BASEMENT2_BIN,
		MAP_BASEMENT3_BIN,
		MAP_BASEMENT4_BIN
	},
	{
		SCR_INTRO_MINE_BIN,
		intro_cad4,
		TILESET_MINE_BIN,
		MINE_BEHS_BIN,
		MAP_MINE1_BIN,
		MAP_MINE2_BIN,
		MAP_MINE3_BIN,
		MAP_MINE4_BIN
	},
	{
		SCR_INTRO_HITECH_BIN,
		intro_cad5,
		TILESET_HITECH_BIN,
		HITECH_BEHS_BIN,
		MAP_HITECH1_BIN,
		MAP_HITECH2_BIN,
		MAP_HITECH3_BIN,
		MAP_HITECH4_BIN
	},
	{
		0,
		0,
		TILESET_TRAINING_BIN,
		TRAINING_BEHS_BIN,
		MAP_TRAINING_BIN,
		0,
		0,
		0
	},
	{
		0,
		0,
		TILESET_SECRET_BIN,
		SECRET_BEHS_BIN,
		MAP_SECRET_BIN,
		0,
		0,
		0
	},
	// Luca level 1 : 7
	{
		0, 
		0,  
		TILESET_FOREST_BIN,
		FOREST_BEHS_BIN,
		MAP_LUCA1_BIN,
		0,
		0,
		0
	},
	// Luca level 2 : 8
	{
		0,
		0,
		TILESET_SCHOOL_BIN,
		SCHOOL_BEHS_BIN,
		MAP_LUCA2_BIN,
		0,
		0,
		0
	},
	// Luca level 3 : 9
	{
		0, 
		0,  
		TILESET_BASEMENT_BIN,
		BASEMENT_BEHS_BIN,
		MAP_LUCA3_BIN,
		0,
		0,
		0
	},
	// Luca level 4 : 10
	{
		0,
		0,
		TILESET_MINE_BIN,
		MINE_BEHS_BIN,
		MAP_LUCA4_BIN,
		0,
		0,
		0
	}
};

// Switch / open data
// Goes like this:
// X+Y*64, X1, Y1, X2, Y2
// (X, Y) -> location of the switch
// (X1,Y1)->(X2,Y") -> area to erase (with tile 0)

extern unsigned char *switches_data_0;
extern unsigned char *switches_data_1;
extern unsigned char *switches_data_2;
extern unsigned char *switches_data_3;
extern unsigned char *switches_data_4;
extern unsigned char *switches_data_5;
extern unsigned char *switches_data_6;
extern unsigned char *switches_data_7;
extern unsigned char *switches_data_8;
extern unsigned char *switches_data_9;
extern unsigned char *switches_data_10;
extern unsigned char *switches_data_11;
extern unsigned char *switches_data_12;
extern unsigned char *switches_data_13;
extern unsigned char *switches_data_empty;

unsigned char *switches_data [] = {
	switches_data_4, switches_data_5, switches_data_6, switches_data_7,
	switches_data_0, switches_data_1, switches_data_2, switches_data_3,
	switches_data_8, switches_data_9, switches_data_10, switches_data_11,
	switches_data_empty, switches_data_empty, switches_data_empty, switches_data_12,
	switches_data_empty, switches_data_13, switches_data_empty, switches_data_empty
};

#asm
	// Empty (so you can reuse it)
	._switches_data_empty
		defb 0

	// School

	._switches_data_0
		//   X + Y*64, 
		defw 4 + 13*64
		//   X1, Y1, X2, Y2
		defb 3, 15, 5, 15

		defw 24 + 24*64
		defb 16, 31, 19, 31

		defw 62 + 20*64
		defb 57, 31, 61, 31

		defb 0

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

	._switches_data_2
		defw 1 + 15*64
		defb 59, 14, 62, 14

		defw 48 + 15*64
		defb 22, 23, 22, 24
		
		defb 0

	._switches_data_3
		defw 62 + 1*64
		defb 21, 35, 23, 35
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

	._switches_data_5
		defw 23 + 24*64
		defb 38, 9, 40, 9

		defw 43 + 27*64
		defb 32, 9, 34, 9

		defw 12 + 14*64
		defb 13, 27, 15, 27

		defb 0

	._switches_data_6
		defw 10 + 38*64
		defb 3, 26, 8, 26

		defw 62 + 25*64
		defb 51, 34, 54, 34
		
		defw 24 + 3*64
		defb 59, 5, 61, 5
		
		defb 0


	._switches_data_7
		defw 16 + 9*64
		defb 30, 27, 31, 27

		defw 61 + 6*64
		defb 16, 27, 18, 27

		defb 0

	._switches_data_8
		defw 57 + 17*64
		defb 38, 3, 38, 6

		defb 0

	._switches_data_9
		defw 53 + 38*64
		defb 59, 30, 60, 30

		defw 2 + 23*64
		defb 11, 35, 13, 35

		defw 33 + 1*64
		defb 30, 15, 30, 19

		defb 0

	._switches_data_10
		defw 28 + 20*64
		defb 38, 19, 38, 20

		defw 14 + 36*64
		defb 29, 5, 30, 5

		defw 5 + 11*64
		defb 56, 12, 59, 12

		defb 0

	._switches_data_11
		defw 33 + 36*64
		defb 40, 31, 40, 34

		defb 0

	._switches_data_12
		defw 10 + 4*64
		defb 57, 2, 57, 4
		
		defb 0

	._switches_data_13
		defw 1 + 10*64
		defb 8, 16, 8, 19

		defw 25 + 13*64
		defb 7, 25, 10, 25

		defw 46 + 10*64
		defb 55, 1, 55, 7

		defw 24 + 4*64
		defb 54, 18, 61, 18

		defb 0

#endasm

void prepare_world (unsigned char world, unsigned char level) {
	// Show title screen & wait for keypress

	if (worlds [world - 1].title_screen_address != 0 && level == 0) {
		wyz_play_music (0);
		//unpack_RAMn (3, worlds [world - 1].title_screen_address, 16384, 1);
		get_resource (worlds [world - 1].title_screen_address, 16384, 1);
		draw_char_by_char (3, 14, worlds [world - 1].intro_cad);
		while (in_Inkey ());
		while (!in_Inkey ());
		wyz_stop_sound ();
		fade_out ();
	}
	
	// Unpack tileset
	//unpack_RAMn (worlds [world - 1].ram_page, worlds [world - 1].tileset_address, (unsigned int) (dt_tileset), 0);
	get_resource (worlds [world - 1].tileset_address, DT_TILESET, 0);
	#asm
		.yuruguero
	#endasm
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
