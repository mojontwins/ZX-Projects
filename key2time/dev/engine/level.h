// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

void prepare_level (void) {
	get_resource (levels [level].resource, (unsigned int) (level_data));
		
	// 32-47 general objects strip
	_t = ITEMSTS_BIN; _n = 2; load_subtileset ();
	
	cur_map_attr = 99; 				// Force load of subts just in case.
	n_pant = level_data.scr_ini;
	prx = level_data->ini_x << 4; p_x = prx << FIXBITS;
	pry = level_data->ini_y << 4; p_y = pry << FIXBITS;
	
	main_script_offset = levels [level].script_offset;
}
