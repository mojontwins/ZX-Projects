// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// globals.h

// General externs

extern unsigned int asm_int [1];
extern unsigned int asm_int_2 [1];

#asm
._asm_int
	defw 0
._asm_int_2
	defw 0
#endasm

// Gigaglobals

struct sp_UDK keys;
void *joyfunc;				

unsigned char *gen_pt;
 
void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}

void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];
struct sp_SS *sp_hitter;
struct sp_SS *sp_shadow;

struct sp_Rect spritesClipValues;
struct sp_Rect *spritesClip;

#asm
	.vpClipStruct defb VIEWPORT_Y, VIEWPORT_Y + 20, VIEWPORT_X, VIEWPORT_X + 30
#endasm

unsigned char enoffs;

// Aux

unsigned char half_life = 0;
unsigned int offs_attr, offs_behs;

// Player

signed int p_x, p_y;
signed char p_vx, p_vy, ptgmx, ptgmy;
signed int p_z;
signed char p_vz;
unsigned char p_jmp_facing;
signed char p_g;
signed char p_ax, p_rx;
signed char p_thrust;
unsigned char p_jmp_ct;
unsigned char *p_c_f, *p_n_f;
unsigned char p_jmp_on;
unsigned char p_frame, p_subframe, p_facing;
unsigned char p_state;
unsigned char p_state_ct;
unsigned char p_gotten;
unsigned char p_life, p_objs, p_keys;
unsigned char objs_old, keys_old, life_old, killed_old;
unsigned char p_disparando;
unsigned char p_hitting;
unsigned char p_facing_v, p_facing_h;
unsigned char p_killme, p_safe_pant, p_safe_x, p_safe_y;
unsigned char p_ct_hole;
unsigned char ptx1, ptx2, pty1, pty2, pty3, pt1, pt2;

// Enems on screen

unsigned char en_an_base_frame [3];
unsigned char en_an_frame [3];
unsigned char en_an_count [3];
unsigned char *en_an_c_f [3], *en_an_n_f [3];
unsigned char en_an_state [3];

#ifdef ENABLE_PURSUERS
unsigned char en_an_alive [3];
unsigned char en_an_dead_row [3];
unsigned char en_an_rawv [3];
#endif

unsigned char pregotten;
unsigned char enemy_shoots;

// Bullets

unsigned char hitter_on;
unsigned char hitter_type;
unsigned char hitter_frame;
unsigned char hitter_x, hitter_y;
unsigned char *hitter_c_f, *hitter_n_f;
unsigned char hitter_hit;

// Current screen buffers
unsigned char map_attr [160];
unsigned char map_buff [160];
// There's XXX bytes free at FREEPOOL according to splib2's doc.
// (240 if in 128K mode, 512 - stack size (do not risk!) in 48K mode)
// Why not use them?
//unsigned char *map_buff = FREEPOOL;
//

// Current screen hotspot
unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char orig_tile;
unsigned char do_respawn; 
unsigned char no_draw; 

// Flags para scripting
unsigned char flags[MAX_FLAGS];

// Globalized
unsigned char n_pant, o_pant;
unsigned char level = 0;
unsigned char silent_level;

unsigned char maincounter;

// Breakable walls/etc

// Fire zone
unsigned char fzx1, fzy1, fzx2, fzy2, f_zone_ac;

// Timer
typedef struct {
	unsigned char on;
	unsigned char t;
	unsigned char frames;
	unsigned char count;
	unsigned char zero;
} CTIMER;
CTIMER ctimer;

int key_jump, key_fire;
unsigned char x_pant, y_pant;
unsigned char do_gravity = 1, p_engine;
unsigned char enoffsmasi;
unsigned char invalidate_fire = 0;
unsigned char cur_map_attr = 99;
unsigned char action_pressed;
unsigned char mlplaying;
unsigned char success;
unsigned char playing;

// Engine globals (for speed) & size!

unsigned char prx, pry, gpd, gpc, gpt, gps;
unsigned char prxx, pryy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit, wall_h, wall_v;
unsigned char gpen_x, gpen_y, gpen_cx, gpen_cy, gpen_xx, gpen_yy, gpaux;
unsigned char tocado, active, killable, animate;
unsigned char gpit, gpjt, pad;
unsigned char *map_pointer, *gp_gen;

// Mimick the enems. structure

unsigned char _en_x, _en_y, _en_x1, _en_y1, _en_x2, _en_y2;
signed char _en_mx, _en_my;
unsigned char _en_t, _en_life; 
unsigned char rda, rdb, rdc, rdd, rde;
unsigned char rdx, rdy, rdz;
signed char rds;
signed int rdint;

unsigned char _x, _y, _n, _t; 	// Variables to undo parameters!
unsigned char _x1, _y1;

// Floating objects

unsigned char f_o_t [MAX_FLOATING_OBJECTS];
unsigned char f_o_x [MAX_FLOATING_OBJECTS];
unsigned char f_o_y [MAX_FLOATING_OBJECTS];
unsigned char f_o_s [MAX_FLOATING_OBJECTS];

unsigned char fo_it, fo_gp, fo_au, d_prs = 0;
unsigned char fo_idx;
unsigned char fo_x, fo_y, fo_st;

//

unsigned char isr_c;

// Extern data

extern LEVELHEADER level_data [0];
extern unsigned char map [0];
extern unsigned char map_attrs [0];
extern unsigned char tileset [0];
extern unsigned char spriteset [0];
extern unsigned char sprite_e [0];
extern BADDIE baddies [0];
extern unsigned char behs [0];
