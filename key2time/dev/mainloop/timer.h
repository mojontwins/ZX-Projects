			// Timer
			if (ctimer.on) {
				++ ctimer.count;
				if (ctimer.count == ctimer.frames) {
					ctimer.count = 0;
					if (ctimer.t) -- ctimer.t; else ctimer.zero = 1;
				}
			}

			if (ctimer.zero) {
				ctimer.zero = 0;
				run_script (MAP_W * MAP_H * 2 + 3);
			}
