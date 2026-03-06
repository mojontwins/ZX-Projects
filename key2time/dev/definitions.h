// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// definitions.h
// Main definitions

// General defines

#define EST_NORMAL 		0
#define EST_PARP 		2
#define EST_MUR 		4
#define EST_HOLED		8
#define sgni(n)			(n < 0 ? -1 : 1)
#define saturate(n)		(n < 0 ? 0 : n)
#define WTOP 1
#define WBOTTOM 2
#define WLEFT 3
#define WRIGHT 4

#define FACING_RIGHT 0
#define FACING_LEFT 2
#define FACING_UP 4
#define FACING_DOWN 6

#define SENG_JUMP 0
#define SENG_SWIM 1
#define SENG_COPT 2
#define SENG_JETP 3
#define SENG_BOOT 4

#define TYPE_6_IDLE 		0
#define TYPE_6_PURSUING		1
#define TYPE_6_RETREATING	2
#define GENERAL_DYING		4

#define MAX_FLAGS 128
#define BUFFER_IDX(x,y) x+(y<<4)-y

#define TILE_EVIL 1
#define TILE_HOLE 2

// Predefine button detection
#define BUTTON_FIRE	((gpit & sp_FIRE) == 0 || sp_KeyPressed (key_fire))
#define BUTTON_JUMP	(sp_KeyPressed (key_jump))

// Types:
// This contains the level data for current level. Not really needed, but
// this is here because of legacy support of 128K full-contained levels like
// those found in Goku Mal.
typedef struct {
	unsigned char map_w, map_h;
	unsigned char scr_ini, ini_x, ini_y;
	unsigned char max_objs;
	unsigned char enems_life;
	unsigned char win_condition;
	unsigned char scr_fin;
	unsigned char activate_scripting;
	unsigned char music_id;
	unsigned char d05;
	unsigned char d06;
	unsigned char d07;
	unsigned char d08;
	unsigned char d09;
} LEVELHEADER;

typedef struct {
    unsigned char np, x, y, st;
} BOLTS;

typedef struct {
	unsigned char x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	unsigned char t, life;
} BADDIE;

typedef struct {
	unsigned char resource;
	unsigned char music_id;
	unsigned int script_offset;
} LEVEL;

// Dale-fran macros

#define ATTR(x,y,d) asm("ld  a, (_"#x")\nld  c,a\nld  a, (_"#y")\nsla a\nsla a\nsla a\nsla a\nor  c\nld  c, a\nld  b,0\nld hl, _map_attr\nadd hl, bc\nld  a, (hl)\nld (_"#d"), a")
#define BUFF(x,y,d) asm("ld  a, (_"#x")\nld  c,a\nld  a, (_"#y")\nsla a\nsla a\nsla a\nsla a\nor  c\nld  c, a\nld  b,0\nld hl, _map_buff\nadd hl, bc\nld  a, (hl)\nld (_"#d"), a")
