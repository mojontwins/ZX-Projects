// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// hitter_h
// Hitter (punch/sword/whip) helper functions

//                          H  H   H
unsigned char hoffs_x [] = {8, 16, 16, 12, 8,  4, 0};
unsigned char hoffs_y [] = {4, 4,  4,  6,  8, 10, 12};
#define HITTER_MAX_FRAME 7

void hitter_do (void) {
	hitter_y = pry + hoffs_y [hitter_frame];
	if (p_facing) {
		hitter_x = prx + hoffs_x [hitter_frame];
	} else {
		hitter_x = prx - hoffs_x [hitter_frame];
	}
	
	++ hitter_frame;
	if (hitter_frame == HITTER_MAX_FRAME) p_hitting = hitter_on = 0;
}
