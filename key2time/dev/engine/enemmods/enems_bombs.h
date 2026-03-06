// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	if (bomb_state == 2) {

		if (_en_x + 15 >= bomb_px && _en_x <= bomb_px + 47 &&
			_en_y + 15 >= bomb_py && _en_y <= bomb_py + 47) {
			enemy_kill (PLAYER_BOMBS_STRENGTH);
			goto continue_enems_loop;
		}
	}
