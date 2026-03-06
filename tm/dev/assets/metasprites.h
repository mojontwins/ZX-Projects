// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Player & enemy animation frames

extern unsigned char *player_frames [];
#asm
	._player_frames
		// Facing right
		defw _SPR_CELL(1)                                             // IDLE 	+0
		defw _SPR_CELL(0), _SPR_CELL(1), _SPR_CELL(2), _SPR_CELL(1)   // WALKING  +1..+4
		defw _SPR_CELL(3)                                             // AIRBORNE +5

		// Facing left (+6)
		defw _SPR_CELL(5)
		defw _SPR_CELL(4), _SPR_CELL(5), _SPR_CELL(6), _SPR_CELL(5)
		defw _SPR_CELL(7)
#endasm

extern unsigned char *enem_frames []; 
#asm
	._enem_frames
		defw _SPR_CELL(8), _SPR_CELL(9), _SPR_CELL(10), _SPR_CELL(11)
		defw _SPR_CELL(12), _SPR_CELL(13), _SPR_CELL(14), _SPR_CELL(15)	
#endasm
