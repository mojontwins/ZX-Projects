// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

#define sgni(n)					(n < 0 ? -1 : 1)
#define saturate(n)				(n < 0 ? 0 : n)
#define WTOP 					1
#define WBOTTOM 				2
#define WLEFT 					3
#define WRIGHT 					4
#define FACING_RIGHT 			0
#define FACING_LEFT 			2
#define FACING_UP 				4
#define FACING_DOWN 			6
#define TYPE_6_IDLE 			0
#define TYPE_6_PURSUING			1
#define TYPE_6_RETREATING		2
#define MAX_FLAGS 				16
#define SPR_CELL(n) 			(spriteset+(n)*144)
#define _SPR_CELL(n)			_spriteset+(n)*144
#define ABS(n) 					((n)<0?-(n):(n))

#define PLAYER_STATE_NORMAL 	0
#define PLAYER_STATE_FLICKERING 2
#define PLAYER_STATE_DYING 		4
#define PLAYER_CELL_IDLE 		0
#define PLAYER_CELL_WALK_BASE 	1
#define PLAYER_CELL_AIRBORNE 	5
#define PLAYER_FACING_LEFT 		6
#define PLAYER_FACING_RIGHT 	0

#define ENEMS_STATE_NORMAL		0
#define ENEMS_STATE_DYING 		1
#define ENEMS_STATE_DEAD		2
#define ENEMS_STATE_PAUSED 		3
#define ENEMS_STATE_HIT 		4

typedef struct {
	unsigned char x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
} BADDIE;

typedef struct {
	unsigned char xy, t, act;
} HOTSPOT;

