// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// Fixed screens

void screen_level (void) {
	blackout_area ();
	prx = 12; pry = 10; gpt = 71; k2t_show_time_prx_pry ();
	_x = 18; _y = 10; _t = 70; print_str ("AD");	
	
	/*
	if (level > 0) {
		gen_password ();
		_x = 12; _y = 14; _t = 71; print_str (password_text);
	}
	*/
	
	sp_UpdateNow ();

	//_AY_PL_MUS (5);				
	active_sleep (250);
}
