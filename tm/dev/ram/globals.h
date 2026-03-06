// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Splib2 stuff

#asm
	.vpClipStruct defb VIEWPORT_Y, VIEWPORT_Y + 20, VIEWPORT_X, VIEWPORT_X + 30
#endasm	

void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}
void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

// Controllers

struct sp_UDK keys = {
	0x017f,	// .fire
	0x01df, // .right
	0x02df, // .left
	0x01fd, // .down
	0x01fb  // .up
};
void *joyfunc = sp_JoyKeyboard;

const void *joyfuncs [] = {
	sp_JoyKeyboard, sp_JoyKempston, sp_JoySinclair1
};

// Sprite structs

struct sp_SS *sp_player;
struct sp_SS *sp_moviles [3];

// The player

signed int p_x, p_y;
signed char p_vx, p_vy;
unsigned char p_salto, p_jump_ct;
unsigned char *p_current_frame, *p_next_frame;
unsigned char p_saltando;
unsigned char p_frame, p_subframe, p_facing;
unsigned char p_state;
unsigned char p_ct_state;
unsigned char p_gotten;
unsigned char p_life, p_objs, p_keys;
unsigned char p_fuel;
unsigned char p_killed;
unsigned char p_killme;
unsigned char p_disparando;
unsigned char p_facing_v, p_facing_h;
unsigned char prx, pry, prxc, pryc;
unsigned char pregotten;
unsigned char p_pad;
signed char ptgmx, ptgmy;

// The baddies

unsigned char enoffs;
unsigned char en_an_base_frame [3];
unsigned char en_an_frame [3];
unsigned char en_an_count [3];
unsigned char *en_an_current_frame [3];
unsigned char *en_an_next_frame [3];
#ifdef ENEMS_NEED_STATES
	unsigned char en_an_state [3];
	unsigned char en_an_ct_state [3];
#endif
#if ENEMS_LIFE_GAUGE > 1
	unsigned char en_an_life [3];
#endif

unsigned char _en_x, _en_y, _en_x1, _en_y1, _en_x2, _en_y2, _en_t;
signed char _en_mx, _en_my;

unsigned char map_attr [150];
unsigned char map_buff [150];

unsigned char hotspot_x;
unsigned char hotspot_y;
unsigned char hotspot_t;
unsigned char orig_tile;	// Tile que había originalmente bajo el objeto

unsigned int seed;
unsigned char rand_res;

unsigned char n_pant, on_pant;
unsigned char maincounter;

// Aux / temp values

unsigned char gpx, gpy, gpd, gpc, gpt;
unsigned char prxx, pryy, gpcx, gpcy;
unsigned char possee, hit_v, hit_h, hit;
unsigned char gpaux;
unsigned char *gp_gen;
unsigned char tocado;
unsigned char active;
unsigned char animate;
unsigned char update;
unsigned char gpit, gpjt;
unsigned char enoffsmasi;
unsigned char *gp_map;
unsigned char pad;
signed char rds, rdx, rdy, rda, rdb, rdct, rdt;
unsigned char _x, _y, _t, _taux;

// Collision

unsigned char cx1, cx2, cy1, cy2, at1, at2;

// Spacer

unsigned char *spacer = "            ";

// Externs for enemies and hotspots
extern BADDIE baddies [0];
extern HOTSPOT hotspots [0];

// Externs for map data
extern unsigned char mapa [0];

// Mainloop

int itj;
unsigned char objs_old, keys_old, life_old, killed_old;
unsigned char playing;	
unsigned char success;
unsigned char do_attrs; 		// Set to 1 to update attrs, 0 otherwise.
unsigned char half_life;
