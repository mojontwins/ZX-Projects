// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

unsigned int keyscancodes [] = {
	0x02fb, 0x02fd, 0x01fd, 0x04fd, 0x047f, 0x087f,		// WSADMN
	0x01fb, 0x01fd, 0x02df, 0x01df, 0x047f, 0x087f 		// QAOPMN
};

void select_joyfunc (void) {
	while (1) {
		gpit = sp_GetKey ();
		if (gpit == '1' || gpit == '2') {
			joyfunc = sp_JoyKeyboard;
			gpjt = (gpit - '1') ? 6 : 0;
			keys.up = keyscancodes [gpjt]; ++ gpjt;
			keys.down = keyscancodes [gpjt]; ++ gpjt;
			keys.left = keyscancodes [gpjt]; ++ gpjt;
			keys.right = keyscancodes [gpjt]; ++ gpjt;
			key_fire = keys.fire = keyscancodes [gpjt]; ++ gpjt;
			key_jump = keyscancodes [gpjt];
			break;
		} else if (gpit == '3') {
			joyfunc = sp_JoyKempston;
			break;
		} else if (gpit == '4') {
			joyfunc = sp_JoySinclair1;
			break;
		}
	}
	
	_AY_PL_SND (0);
	sp_WaitForNoKey ();
}
