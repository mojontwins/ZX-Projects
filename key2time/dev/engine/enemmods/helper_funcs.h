// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

#if defined (ENABLE_FLYING_ENEMIES) || defined (ENABLE_SHOOTERS) || defined (ENABLE_HANNA_MONSTERS_11)
unsigned char distance (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2) {
	unsigned char dx = abs (x2 - x1);
	unsigned char dy = abs (y2 - y1);
	unsigned char mn = dx < dy ? dx : dy;
	return (dx + dy - (mn >> 1) - (mn >> 2) + (mn >> 4));
}
#endif

#if defined (ENABLE_HANNA_MONSTERS_11)
// TODO: add light/torch stuff here!
unsigned char i_can_see_you (void) {
	return (distance (prx, pry, _en_x, _en_y) <= HANNA_MONSTERS_11_SIGHT);
}
#endif

#if defined (ENABLE_HANNA_MONSTERS_11)
unsigned char player_hidden (void) {
	prxx = (prx + 8) >> 4; pryy = (pry + 8) >> 4;
	ATTR (prxx, pryy, pt1);
	return (pt1 & 2);
}
#endif

#if defined (ENABLE_FLYING_ENEMIES) || defined (ENABLE_RANDOM_RESPAWN)
int limit (int val, int min, int max) {
	if (val < min) return min;
	if (val > max) return max;
	return val;
}
#endif
