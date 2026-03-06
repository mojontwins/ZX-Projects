// Make some globals.

unsigned char pad0;
unsigned char gpit, idx;
unsigned int gpint;
unsigned char *gp_gen;

unsigned char rdx, rdy, rda, rdb, rdc;
unsigned char rrdx, rrdy;
unsigned char _x, _y, _n, _c;

unsigned char at1, at2;

unsigned char dothis, nd;

unsigned char bi, bj; 	// Indexes for bullets
unsigned char ei; 		// Indexes for enemies
unsigned char si;		// Indexes for spawners

unsigned char bus_count, cao;
unsigned char busi; 	// Index for enemies on screen

unsigned char xo, yo;
unsigned int whichtile;

unsigned char ntile;

// Controller

struct in_UDK keys = {
	0x017f, // .fire
	0x01df, // .right
	0x02df, // .left
	0x01fd, // .down
	0x01fb	// .up
};

// Camera

signed char cam_x;
signed char cam_y;
signed char cam_x_dest;
signed char cam_y_dest;
signed char cam_x_store;
signed char cam_y_store;

// Player

typedef struct {
	char x, y; 					// 0, 1
	char real_x, real_y;		// 2, 3
	unsigned char frame; 		// 4
	unsigned char step;			// 5
	unsigned char facing; 		// 6
	unsigned char status; 		// 7
	unsigned char lives;		// 8
	unsigned char keys;			// 9
	unsigned int energy;		// 10
	unsigned char firing; 		// 12
	unsigned long score; 		// 13
	unsigned long last_score;	// 17
	unsigned long hiscore; 		// 21
	unsigned char moved; 		// 25
	unsigned char with_bomb; 	// 26
	unsigned char collided; 	// 27
} PLAYER;

PLAYER player;
unsigned char start_x = 2, start_y = 2;
unsigned char inval;
unsigned char conveyors_on;

// Bomb

typedef struct {
	unsigned char x, y;
	unsigned char ct;
	unsigned char timer;
	unsigned char *map_idx;
} BOMB;
BOMB bomb;
unsigned char tile_bomb;

// Switch

unsigned char *level_switches;
unsigned char *current_switch;
unsigned char tile_switch;

// Enemy spawners

char spawners_x [50];
char spawners_y [50];
unsigned char spawners_en [50];
unsigned char spawners_type [50];
unsigned char spawners_last_spawned [50];
unsigned char spawners_ct [50];
unsigned char *spawners_ptr [50];
unsigned char max_spawners;

// Enemies

char enemies_x [MAX_ENEMIES];
char enemies_y [MAX_ENEMIES];
char enemies_real_x [MAX_ENEMIES];
char enemies_real_y [MAX_ENEMIES];
char enemies_en [MAX_ENEMIES];
unsigned char enemies_facing [MAX_ENEMIES];
unsigned char enemies_type [MAX_ENEMIES];
unsigned char enemies_ns [MAX_ENEMIES];
unsigned char enemies_frame [MAX_ENEMIES];
unsigned char enemies_bus [MAX_ENEMIES];

// Recharges

unsigned char max_recharges = 5;

// Shoots

char shoots_x [MAX_SHOOTS];
char shoots_y [MAX_SHOOTS];
char shoots_mx [MAX_SHOOTS];
char shoots_my [MAX_SHOOTS];
char shoots_trail_dx [MAX_SHOOTS];
char shoots_trail_dy [MAX_SHOOTS];
unsigned char shoots_active [MAX_SHOOTS];
unsigned char n_shoots;
char _sh_x, _sh_y;

// Destructors

unsigned char destructors_slots [MAX_DESTRUCTORS];
unsigned char destructors_slots_i;
unsigned char destructors_x [MAX_DESTRUCTORS];
unsigned char destructors_y [MAX_DESTRUCTORS];
unsigned char destructors_ct [MAX_DESTRUCTORS];
unsigned char *destructors_address [MAX_DESTRUCTORS];
unsigned char dei;

// Focos

unsigned char focos_slots [MAX_FOCOS];
unsigned char focos_slots_i;
unsigned char focos_x [MAX_FOCOS];
unsigned char focos_y [MAX_FOCOS];
unsigned char focos_ct [MAX_FOCOS];
unsigned char focos_propagador [MAX_FOCOS];
unsigned char foi, foic;

// Game stuff

unsigned char halflife;
unsigned char i_shat_brix;

unsigned char ca1, ca2, ca3, ca4;
signed char dx, dy;

// Control page

unsigned char video_page @ 23301;
unsigned char ram_page_act @ 23302;
unsigned char pregister @ 23303;

// More unglobals

unsigned char *dr_ptr;
unsigned char gpc;