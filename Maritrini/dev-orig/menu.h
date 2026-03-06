// Menu shit

unsigned char menu () {
	unsigned char resutls;
	unsigned char key;
	unsigned char val;
	
	//unpack_RAMn (3, SCR_MENU, 16384, 0);
	get_resource (SCR_MENU_BIN, 16384, 1);
	
	wyz_play_music (5);
	
	//draw_fast (5, 23, 65, "BY THE MOJON TWINS 2011");
	draw_fast (2, 22, 66, "2011/2020 BY THE MOJON TWINS");
	draw_fast (7, 23, 66, "2020 PHOENIXWARE");
	
	// Main menu
	while (1) {
	
		draw_fast (11, 16, 70, "1 PLAY    ");
		draw_fast (11, 18, 70, "2 CONTROLS");
		draw_fast (11, 20, 70, "          ");
		val = 0;
		while (val == 0) {
			key = in_Inkey ();
			if (key == '1' || key == '2')
				val = key - '0';	
		}
		clear_keybuff ();
		
		if (val == 1) {
			draw_fast (11, 16, 70, "1 START   ");
			draw_fast (11, 18, 70, "2 PASSWORD");
			draw_fast (11, 20, 70, "3 TRAINING");
			
			while (1) {
				key = in_Inkey ();
				if (key == '1')
					return 1;
				else if (key == '2')
					return 2;
				else if (key == '3')
					return 3;
			};
			clear_keybuff ();
			
		} else {			
			draw_fast (11, 16, 70, "1 KEYBOARD");
			draw_fast (11, 18, 70, "2 KEMPSTON");
			draw_fast (11, 20, 70, "3 SINCLAIR");
			
			val = 0;
			while (!val) {
				key = in_Inkey ();
				if (key == '1') {
					joyfunc = in_JoyKeyboard;
					val = 1;
				} else if (key == '2') {
					joyfunc = in_JoyKempston;
					val = 1;
				} else if (key == '3') {
					joyfunc = in_JoySinclair1;
					val = 1;
				}
			}
			clear_keybuff ();
		}
	}
}
