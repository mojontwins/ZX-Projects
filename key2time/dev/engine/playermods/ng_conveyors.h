// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// New Genital Conveyors
	
	/*
	if (possee) {
		if (pt1 & 32) {
			p_gotten = 1;
			// Read behaviour bits
			switch ((pt1 >> 1) & 3) {
				case 0:	// Up
					ptgmy = -PLAYER_VX_MAX;
					break;
				case 1: // Down
					ptgmy = PLAYER_VX_MAX;
					break;
				case 2: // Left
					ptgmx = -PLAYER_VX_MAX;
					break;
				case 3: // Right
					ptgmx = PLAYER_VX_MAX;
					break;
			}
		}
	}
	*/

	#asm
			ld  a, (_possee)
			or  a
			jr  z, player_move_conveyors_done

			ld  a, (_pt1)
			bit 5, a
			jr  z, player_move_conveyors_done

			// Read behaviour bits
			srl a
			and 3

			or  a
			jr  z, player_move_conveyors_beh_not0

			// 0 == UP
			ld  a, -PLAYER_VX_MAX
			ld  (_ptgmy), a
			jr  player_move_conveyors_beh_done

		.player_move_conveyors_beh_not0

			cp  1
			jr  z, player_move_conveyors_beh_not1

			// 1 = DOWN
			ld  a, PLAYER_VX_MAX;
			ld  (_ptgmy), a
			jr  player_move_conveyors_beh_done

		.player_move_conveyors_beh_not1

			cp 2
			jr  z, player_move_conveyors_beh_not2

			// 2 = LEFT
			ld  a, -PLAYER_VX_MAX
			ld  (_ptgmx), a
			jr  player_move_conveyors_beh_done

		.player_move_conveyors_beh_not2

			// 3 = RIGHT
			ld  a, PLAYER_VX_MAX
			ld  (_ptgmx), a

		.player_move_conveyors_beh_done

			ld  a, 1
			ld  (_p_gotten), a
		.player_move_conveyors_done
	#endasm
