// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// Hanna monsters type 11.
	// They will free-roam. They will switch to "pursue" if you are close and visible.
	// "Visible" means (Lights are on OR Torch is on) AND (You are on a non-hiding (type 2) tile).

	switch (en_an_state [gpit]) {
		case 0:
			// Free roaming.
			if (0 == en_an_count [gpit] --) {
				gpjt = rand () & 8;
				_en_mx = gpjt > 1 ? 0 : gpjt ? -1 : 1;
				_en_my = (gpjt < 2 || gpjt > 3) ? 0 : gpjt == 2 ? 1 : -1;
				en_an_count [gpit] == (2 + (rand () & 7)) << 4;
			}

			// Does the monster see you?
			if (i_can_see_you ()) {
				en_an_state [gpit] = 1;
			}
			break;
		case 1:
			// Pursuing.
			_en_mx = (signed char) (addsign (((prx >> 2) << 2) - _en_x, 2);
			_en_my = (signed char) (addsign (((pry >> 2) << 2) - _en_y, 2);
			if (0 == i_can_see_you ()) {
				en_an_state [gpit] = 0;
			}
			break;
		case 2:
			// Stunned
			if (0 == en_an_count [gpit] --) {
				en_an_state [gpit] = 0;
			}
			break;
	}

	// move / collide?

	_en_x += _en_mx;
	_en_y += _en_my;
