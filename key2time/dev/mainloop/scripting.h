// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	/*
	if ((pad & sp_FIRE) == 0) {
		if (action_pressed == 0)  {
			action_pressed = 1;
			// Any scripts to run in this screen?
			run_fire_script ();
		}
	} else {
		action_pressed = 0;
	}

	if (f_zone_ac) {
		if (prx >= fzx1 && prx <= fzx2 && pry >= fzy1 && pry <= fzy2) {
			run_fire_script ();
		}
	}
	*/

	#asm
		._mainloop_scripting

			ld  a, (_pad)
			and sp_FIRE
			jr  nz, mainloop_scripting_action_not_pressed

			ld  a, (_action_pressed)
			jr  nz, mainloop_scripting_action_pressed_done

			ld  a, 1
			ld  (_action_pressed), a

			call _run_fire_script

			jr mainloop_scripting_action_pressed_done

		.mainloop_scripting_action_not_pressed
			xor a
			ld  (_action_pressed), a

		.mainloop_scripting_action_pressed_done
			
			ld  a, (_f_zone_ac)
			jr  z, mainloop_scripting_firezone_done

			// prx >= fzx1
			ld  a, (_fzx1)
			ld  c, a
			ld  a, (_prx)
			cp  c
			jr  c, mainloop_scripting_firezone_done

			// fzx2 >= prx
			ld  a, (_prx)
			ld  c, a
			ld  a, (_fzx2)
			cp  c
			jr  c, mainloop_scripting_firezone_done

			// pry >= fzy1
			ld  a, (_fzy1)
			ld  c, a
			ld  a, (_pry)
			cp  c
			jr  c, mainloop_scripting_firezone_done

			// fzy2 >= pry
			ld  a, (_pry)
			ld  c, a
			ld  a, (_fzy2)
			cp  c
			jr  c, mainloop_scripting_firezone_done

			call _run_fire_script

		.mainloop_scripting_firezone_done

	#endasm
