// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Enemy type : linear

#asm
		ld  a, 1
		ld  (_active), a

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