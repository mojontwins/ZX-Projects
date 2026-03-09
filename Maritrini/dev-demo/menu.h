// Menu shit

unsigned char three_opts (char *o1, char *o2, char *o3) {
	draw_fast (11, 16, 70, o1);
	draw_fast (11, 18, 70, o2);
	draw_fast (11, 20, 70, o3);
	clear_keybuff ();
	while (1) {
		gpit = in_Inkey ();
		if (gpit >= '0' && gpit <= '9') return (gpit - '0');
	}
}

unsigned char menu () {
	//unpack_RAMn (3, SCR_MENU, 16384, 0);
	get_resource (SCR_MENU_DEMO_BIN, 16384, 1);
	
	wyz_play_music (5);
	
	//draw_fast (5, 23, 65, "BY THE MOJON TWINS 2011");
	draw_fast (2, 22, 66, "2011/2026 BY THE MOJON TWINS");
	//draw_fast (7, 23, 66, "2021 PHOENIXWARE");
	
	// Main menu
	while (1) {
		do {
			_n = three_opts (
				"1 PLAY    ",
				"2 CONTROLS",
				"          "
			);
		} while (_n != 1 && _n != 2);
		
		if (_n == 1) {
			return three_opts (
				"1 START   ",
				"2 PASSWORD",
				"          "
			);
		} else {	
			do {
				_n = 0;
				rda = three_opts (
						"1 KEYBOARD",
						"2 KEMPSTON",
						"3 SINCLAIR"
					);
				switch (rda) {
					case 1:
					case 2:
					case 3:
						joyfunc = joyfuncs [rda-1];
						_n = 1;
						
						break;
				}
			} while (_n == 0);
		}
	}
}
