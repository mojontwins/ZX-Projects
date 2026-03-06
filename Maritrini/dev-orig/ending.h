//

unsigned char attr_resource [5] = {
	SCR_ENDING_1_ATTRS_0_BIN,
	SCR_ENDING_1_ATTRS_1_BIN,
	SCR_ENDING_1_ATTRS_2_BIN,
	SCR_ENDING_1_ATTRS_3_BIN,
	SCR_ENDING_1_ATTRS_4_BIN 
};
extern unsigned char ending_cad_0 [0];
extern unsigned char ending_cad_1 [1];
extern unsigned char ending_cad_2 [2];
extern unsigned char ending_cad_3 [3];
extern unsigned char ending_cad_4 [4];
unsigned char *ending_cads [5] = {
	ending_cad_0, ending_cad_1, ending_cad_2, ending_cad_3, ending_cad_4
};

#asm
	._ending_cad_0
		defm "MARITRINI FINALLY ARRIVES TO A"
		defb 13
		defm "SECRET CHAMBER,,,             "
		defb 0
	._ending_cad_1
		defm "'OH! MR, DURAN'S DAUGHTER!'"
		defb 0
	._ending_cad_2
		defm "'FEAR NOT. POOR CHILD,,,'  "
		defb 13
		defm "'THIS IS MARITRINI MCANDREWS'"
		defb 13
		defm "'I'M HERE TO RESCUE YOU,'    "
		defb 0
	._ending_cad_3
		defm "'WAIT. SOMETHING'S HAPPENING!'"
		defb 13
		defm "'A DOCTOR INJECTED SOMETHING  "
		defb 13
		defm "TO ME. I FEEL SO STRANGE!'  "
		defb 0
	._ending_cad_4
		defm "'SOMETHING'S HAPPENNING !'"
		defb 13
		defm "'HELP ME. MARITRINI!'     "
		defb 13
		defm "'HEEEEEEEEELP!!!!'   "
		defb 13
		defm "'AAAAAAAIIIIIEEEEEEEHHHHHHH!!'"
		defb 0
#endasm

void ending (void) {
	unsigned char i;
	
	fade_out ();
	wyz_play_music (0);
	get_resource (SCR_ENDING_1_BITMAP_BIN, 16384, 0);
	for (i = 0; i < 5; i ++) {
		get_resource (attr_resource [i], 22528, 0);
		draw_char_by_char2 (ending_cads [i]);
	}
	wyz_stop_sound ();
	fade_out ();
	wyz_play_music (7);
	get_resource (SCR_ENDING_2_BIN, 16384, 0);	
	mywaitkey ();
	wyz_stop_sound ();
}
