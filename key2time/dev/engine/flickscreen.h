// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// flickscreen.h
// Flicking screen logic... REHASH!

#if defined (MDOE_128K) && defined (COMPRESSED_LEVELS)
	#define SCREEN_LEFT x_pant > 0 ? n_pant - 1 : n_pant + (level_data->map_w - 1);
	#define SCREEN_RIGHT x_pant < (level_data->map_w - 1) ? n_pant + 1 : n_pant - (level_data->map_w - 1);
	#define SCREEN_UP y_pant > 0 ? n_pant - level_data->map_w : n_pant + (level_data->map_w * (level_data->map_h - 1));
	#define SCREEN_DOWN y_pant < (level_data->map_h - 1) ? n_pant + level_data->map_w : n_pant - (level_data->map_w * (level_data->map_h - 1));
#else
	#define SCREEN_LEFT x_pant > 0 ? n_pant - 1 : n_pant + (MAP_W - 1);
	#define SCREEN_RIGHT x_pant < (MAP_W - 1) ? n_pant + 1 : n_pant - (MAP_W - 1);
	#define SCREEN_UP y_pant > 0 ? n_pant - MAP_W : n_pant + (MAP_W * (MAP_H - 1));
	#define SCREEN_DOWN y_pant < (MAP_H - 1) ? n_pant + MAP_W : n_pant - (MAP_W * (MAP_H - 1));
#endif

#define MAP_BOUNDARY_LEFT
#define MAP_BOUNDARY_RIGHT
#define MAP_BOUNDARY_TOP
#define MAP_BOUNDARY_BOTTOM

void flick_screen (void) {
	if (p_x == 0 && p_vx < 0 MAP_BOUNDARY_LEFT) {
		n_pant = SCREEN_LEFT; p_x = (224 << FIXBITS);
	}
	if (p_x == (224 << FIXBITS) && p_vx > 0 MAP_BOUNDARY_RIGHT) {
		n_pant = SCREEN_RIGHT; p_x = 0;
	}
	if (p_y == 0 && p_vy < 0 MAP_BOUNDARY_TOP) {
		n_pant = SCREEN_UP; p_y = (144 << FIXBITS);
	}
	if (p_y == (144 << FIXBITS) && p_vy > 0 MAP_BOUNDARY_TOP) {
		n_pant = SCREEN_DOWN; p_y = 0;		
	}
}
