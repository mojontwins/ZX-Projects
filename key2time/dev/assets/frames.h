// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// frames.h
// Animation frames

// right: 0 + frame
// left: 2 + frame
// up: 4 + frame
// down: 6 + frame
// when jumping, frame == 1 ALWAYS, facing = p_jmp_facing.
unsigned char *player_frames [] = {
	sprite_1_a, sprite_2_a, sprite_3_a, sprite_4_a,
	sprite_5_a, sprite_6_a, sprite_7_a, sprite_8_a
};
unsigned char *enem_frames [] = {
	sprite_9_a, sprite_10_a, sprite_11_a, sprite_12_a, 
	sprite_13_a, sprite_14_a, sprite_15_a, sprite_16_a
};
