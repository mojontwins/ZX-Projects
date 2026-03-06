// levels.h

// Just to keep track of where levels are in RAM and
// to unpack them into main RAM.

// In a future, possible 48K version, here be code
// to load levels from tape and unpack them into the
// "current level buffers"

typedef struct {
	unsigned char title_screen_address;
	unsigned char *intro_cad;
	unsigned char tileset_address;
	unsigned char stage_1;
	unsigned char stage_2;
	unsigned char stage_3;
	unsigned char stage_4;
} WORLD;

extern unsigned char intro_cad1 [];
extern unsigned char intro_cad2 [];
extern unsigned char intro_cad3 [];
extern unsigned char intro_cad4 [];
extern unsigned char intro_cad5 [];

// Anjuel always reverses , and . in the charsets XD

#asm
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

WORLD worlds [7] = {
	{
		SCR_INTRO_FOREST_BIN, 
		intro_cad1,  
		TILESET_FOREST_BIN,
		MAP_FOREST1_BIN,
		MAP_FOREST2_BIN,
		MAP_FOREST3_BIN,
		MAP_FOREST4_BIN
	},
	{
		SCR_INTRO_SCHOOL_BIN,
		intro_cad2,
		TILESET_SCHOOL_BIN,
		MAP_SCHOOL1_BIN,
		MAP_SCHOOL2_BIN,
		MAP_SCHOOL3_BIN,
		MAP_SCHOOL4_BIN
	},
	{
		SCR_INTRO_BASEMENT_BIN,
		intro_cad3,
		TILESET_BASEMENT_BIN,
		MAP_BASEMENT1_BIN,
		MAP_BASEMENT2_BIN,
		MAP_BASEMENT3_BIN,
		MAP_BASEMENT4_BIN
	},
	{
		SCR_INTRO_MINE_BIN,
		intro_cad4,
		TILESET_MINE_BIN,
		MAP_MINE1_BIN,
		MAP_MINE2_BIN,
		MAP_MINE3_BIN,
		MAP_MINE4_BIN
	},
	{
		SCR_INTRO_HITECH_BIN,
		intro_cad5,
		TILESET_HITECH_BIN,
		MAP_HITECH1_BIN,
		MAP_HITECH2_BIN,
		MAP_HITECH3_BIN,
		MAP_HITECH4_BIN
	},
	{
		0,
		0,
		TILESET_TRAINING_BIN,
		MAP_TRAINING_BIN,
		0,
		0,
		0
	},
	{
		0,
		0,
		TILESET_SECRET_BIN,
		MAP_SECRET_BIN,
		0,
		0,
		0
	},
};

void prepare_world (unsigned char world, unsigned char level) {
	// Show title screen & wait for keypress
	
	wyz_play_music (0);
	
	if (worlds [world - 1].title_screen_address != 0 && level == 0) {
		//unpack_RAMn (3, worlds [world - 1].title_screen_address, 16384, 1);
		get_resource (worlds [world - 1].title_screen_address, 16384, 1);
		draw_char_by_char (3, 14, worlds [world - 1].intro_cad);
		while (in_Inkey ());
		while (!in_Inkey ());
		fade_out ();
	}
	
	wyz_stop_sound ();
	
	// Unpack tileset
	//unpack_RAMn (worlds [world - 1].ram_page, worlds [world - 1].tileset_address, (unsigned int) (dt_tileset), 0);
	get_resource (worlds [world - 1].tileset_address, (unsigned int) (dt_tileset), 0);
}

void prepare_stage (unsigned char world, unsigned char stage) {
	// Unpack map
	unsigned char res;
	
	switch (stage) {
		case 1:	
			res = worlds [world - 1].stage_1;
			break;
		case 2:	
			res = worlds [world - 1].stage_2;
			break;
		case 3:	
			res = worlds [world - 1].stage_3;
			break;
		case 4:	
			res = worlds [world - 1].stage_4;
			break;
	}
	
	//unpack_RAMn	(worlds [world - 1].ram_page, address, (unsigned int) (dt_mapdata), 0);
	get_resource (res, (unsigned int) (dt_mapdata), 0);
}
