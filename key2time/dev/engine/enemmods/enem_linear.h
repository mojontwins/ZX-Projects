// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

	// linear movement

	/*
	active = animate = 1;
	_en_x += _en_mx;
	_en_y += _en_my;

	if (_en_x == _en_x1 || _en_x == _en_x2) _en_mx = -_en_mx;
	if (_en_y == _en_y1 || _en_y == _en_y2) _en_my = -_en_my;
	*/

	#asm
			ld 	a, 1
			ld  (_active), a
			ld  (_animate), a

			ld  a, (__en_mx)
			ld  c, a
			ld  a, (__en_x)
			add a, c
			ld  (__en_x), a

			ld  c, a
			ld  a, (__en_x1)
			cp  c
			jr  z, _enems_lm_change_axis_x
			ld  a, (__en_x2)
			cp  c
			jr  nz, _enems_lm_change_axis_x_done

		._enems_lm_change_axis_x
			ld  a, (__en_mx)
			neg
			ld  (__en_mx), a

		._enems_lm_change_axis_x_done

			ld  a, (__en_my)
			ld  c, a
			ld  a, (__en_y)
			add a, c
			ld  (__en_y), a

			ld  c, a
			ld  a, (__en_y1)
			cp  c
			jr  z, _enems_lm_change_axis_y
			ld  a, (__en_y2)
			cp  c
			jr  nz, _enems_lm_change_axis_y_done

		._enems_lm_change_axis_y
			ld  a, (__en_my)
			neg
			ld  (__en_my), a

		._enems_lm_change_axis_y_done

	#endasm