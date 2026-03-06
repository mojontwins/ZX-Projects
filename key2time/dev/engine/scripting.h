// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

void run_entering_script (void) {
		// Ejecutamos los scripts de entrar en pantalla:
		run_script (2 * MAP_W * MAP_H + 1);
		run_script (n_pant + n_pant);
}

void run_fire_script (void) {
	run_script (2 * MAP_W * MAP_H + 2);
	run_script (n_pant + n_pant + 1);
	// I use this for debug when further developing the engine, it comes handy:
	/*
		for (gpit = 0; gpit < 16; gpit ++) {
			sp_PrintAtInv (0, gpit + gpit, 71, 16 + flags [gpit]);
		}
	*/
	/*
		for (gpit = 0; gpit < 16; gpit ++) {
			//sp_PrintAtInv (23, gpit + gpit, 71, 16 + baddies [enoffs + gpit].t);
			print_number2(gpit+gpit,23,flags [gpit]);
		}
	*/
}
