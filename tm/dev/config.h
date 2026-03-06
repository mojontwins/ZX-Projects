// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// ============================================================================
// I. General configuration
// ============================================================================

// In this section we define map dimmensions, initial and authomatic ending conditions, etc.

#define MAP_W					8		//
#define MAP_H					3		// Map dimmensions in screens
#define SCR_INICIO				8		// Initial screen
#define PLAYER_INI_X			3		//
#define PLAYER_INI_Y			1		// Initial tile coordinates
#define SCR_FIN 				99		// Last screen. 99 = deactivated.
#define PLAYER_FIN_X			99		//
#define PLAYER_FIN_Y			99		// Player tile coordinates to finish game
#define PLAYER_NUM_OBJETOS		24		// Objects to get to finish game
#define PLAYER_LIFE 			9		// Max and starting life gauge.
#define PLAYER_REFILL			1		// Life recharge

// Spriteset
#define CELL_EMPTY 				16		// Empty sprite face
#define CELL_EXPLOSION			17 		// Explosion

// ============================================================================
// II. Engine type
// ============================================================================

#define TITLE_HAS_FRAME					// If defined, title screen is also the game frame.
//#define ENABLE_KEYS					// If defined, keys are not present. [TODO]
#define ENABLE_COLLECTIBLES				// If defined, hotspots type 1 are collectibles
#define ENABLE_EVIL_TILES				// If defined, tiles with beh=1 kill
//#define PLAYER_BOUNCES				// If defined, collisions make player bounce
#define PLAYER_FLICKERS 			 	// If defined, collisions make player flicker instead.
//#define MAP_BOTTOM_KILLS				// If defined, exiting the map bottomwise kills.

// Enemies general
// ---------------
//#define ENEMS_RESPAWN_ON_ENTER		// Enemies respawn when entering screen
//#define WALLS_STOP_ENEMS				// If defined, enemies react to the scenery [TODO]
//#define EVERYTHING_IS_A_WALL			// If defined, any tile <> type 0 is a wall, otherwise just 8 [TODO]
//#define ENABLE_CUSTOM_TYPE_6			// If defined, add code to type 6 enemies.

#define ENEMS_LIFE_GAUGE		2		// Amount of damage needed to kill enemies.
#define ENEMS_DYING_FRAMES 		8		// Show an explosion for # frames when enemy dies.
#define ENEMS_HIT_FRAMES 		4		// Show an explosion for # frames when enemy is hit.

// Pushable tile [TODO]
// -------------
/*
#define PLAYER_PUSH_BOXES 				// If defined, tile #14 is pushable. Must be type 10.
#define FIRE_TO_PUSH					// If defined, you have to press FIRE+direction to push.
#define ENABLE_PUSHED_SCRIPTING			// If defined, nice goodies (below) are activated:
#define MOVED_TILE_FLAG 		1		// Current tile "overwritten" with block is stored here.
#define MOVED_X_FLAG 			2		// X after pushing is stored here.
#define MOVED_Y_FLAG 			3		// Y after pushing is stored here.
#define PUSHING_ACTION					// If defined, pushing a tile runs PRESS_FIRE script
*/
// Shooting behaviour [TODO]
// ------------------

//#define PLAYER_CAN_FIRE 				// If defined, shooting engine is enabled.
//#define PLAYER_BULLET_SPEED 	8		// Pixels/frame. 
//#define MAX_BULLETS 			3		// Max number of bullets on screen. Be careful!.
//#define PLAYER_BULLET_Y_OFFSET	6	// vertical offset from the player's top.
//#define PLAYER_BULLET_X_OFFSET	0	// vertical offset from the player's left/right.
//#define FIRE_MIN_KILLABLE 	3		// If defined, only enemies >= N can be killed.
//#define CAN_FIRE_UP					// If defined, player can fire upwards and diagonal.
//#define MAX_AMMO				99		// If defined, ammo is not infinite!
//#define AMMO_REFILL			50		// ammo refill, using tile 20 (hotspot #4)
//#define INITIAL_AMMO 			0		// If defined, ammo = X when entering game.

// Hitter [TODO]
// -------------
//#define PLAYER_HITTER

// Breakable walls [TODO]
// ---------------
//#define BREAKABLE_WALLS				// Breakable walls
//#define BREAKABLE_WALLS_LIFE	1		// Amount of hits to break wall

// Scripting [TODO]
// ---------
//#define ACTIVATE_SCRIPTING			// Activates msc scripting and flag related stuff.
//#define SCRIPTING_DOWN				// Use DOWN as the action key.
//#define SCRIPTING_KEY_M				// Use M as the action key instead.
//#define SCRIPTING_KEY_FIRE			// User FIRE as the action key instead.
//#define ENABLE_EXTERN_CODE			// Enables custom code to be run from the script using EXTERN n
//#define ENABLE_FIRE_ZONE				// Allows to define a zone which auto-triggers "FIRE"

// Timer [TODO] [SIMPLIFY]
// -----
//#define TIMER_ENABLE					// Enable timer
//#define TIMER_INITIAL		99			// For unscripted games, initial value.
//#define TIMER_REFILL		30			// Timer refill, using tile 21 (hotspot #5)
//#define TIMER_LAPSE 		32			// # of frames between decrements
//#define TIMER_START					// If defined, start timer from the beginning
//#define TIMER_SCRIPT_0				// If defined, timer = 0 runs "ON_TIMER_OFF" in the script
//#define TIMER_GAMEOVER_0				// If defined, timer = 0 causes "game over"
//#define TIMER_KILL_0					// If defined, timer = 0 causes "one life less".
//#define TIMER_WARP_TO 0				// If defined, warp to screen X after "one life less".
//#define TIMER_WARP_TO_X 	1			//
//#define TIMER_WARP_TO_Y 	1			// "warp to" coordinates.
//#define TIMER_AUTO_RESET				// If defined, timer resets after "one life less"
//#define SHOW_TIMER_OVER				// If defined, "TIME OVER" shows when time is up.

// Top view [TODO]
// --------
//#define PLAYER_GENITAL				// Enable top view.
//#define TOP_OVER_SIDE					// UP/DOWN has priority over LEFT/RIGHT

// Side view:
// ----------
#define PLAYER_HAS_JUMP               	// If defined, player is able to jump.
//#define PLAYER_HAS_JETPAC             // If defined, player can thrust a vertical jetpac [TODO]
//#define PLAYER_STEPS_ON_ENEMS       // If defined, stepping on enemies kills them
//#define PLAYER_STEPS_IS_KILLABLE (_en_t==4)  // If defined, use this expression. If not defined, enemies can't be killed
#define PLAYER_STEP_SOUND             	// Sound while walking. No effect in the BOOTEE engine.

// ============================================================================
// III. Screen configuration
// ============================================================================

// This sections defines how stuff is rendered, where to show counters, etcetera

#define VIEWPORT_X				1		//
#define VIEWPORT_Y				1		// Viewport character coordinates
#define LIFE_X					4		//
#define LIFE_Y					22		// Life gauge counter character coordinates
#define OBJECTS_X				26		//
#define OBJECTS_Y				22		// Objects counter character coordinates
#define OBJECTS_ICON_X			99		// 
#define OBJECTS_ICON_Y			99		// Objects icon character coordinates (use with ONLY_ONE_OBJECT)
#define KEYS_X					99		//
#define KEYS_Y					99		// Keys counter character coordinates
#define KILLED_X				99		//
#define KILLED_Y				99		// Kills counter character coordinates
//#define PLAYER_SHOW_KILLS				// If defined, show kill counter.
#define AMMO_X					99		// 
#define AMMO_Y					99		// Ammo counter character coordinates
#define TIMER_X					99		//
#define TIMER_Y					99		// Timer counter coordinates
//#define PLAYER_SHOW_TIMER				// If defined, show timer counter

// Graphic FX, uncomment which applies...

#define MAP_FORMAT_RLE 
#define RLE_FORMAT				62 		// Possible values: 44, 53, 62.


// ============================================================================
// IV. Player movement configuration
// ============================================================================

// This section is used to define which constants are used in the gravity/acceleration engine.
// If a side-view engine is configured, we have to define vertical and horizontal constants
// separately. If a top-view engine is configured instead, the horizontal values are also
// applied to the vertical component, vertical values are ignored.

// IV.1. Vertical movement. Only for side-view.

#define PLAYER_MAX_VY_CAYENDO   120     // Max falling speed (512/64 = 8 pixels/frame)
#define PLAYER_G                16      // Gravity acceleration (32/64 = 0.5 píxeles/frame^2)

#define PLAYER_VY_INICIAL_SALTO 24      // Initial junp velocity (64/64 = 1 píxel/frame)
#define PLAYER_MAX_VY_SALTANDO  78      // Max jump velocity (320/64 = 5 píxels/frame)
#define PLAYER_INCR_SALTO       12      // acceleration while JUMP is pressed (48/64 = 0.75 píxeles/frame^2)

// IV.2. Horizontal (side view) or general (top view) movement.

#define PLAYER_MAX_VX           64     // Max velocity (192/64 = 3 píxels/frame)
#define PLAYER_AX               16      // Acceleration (24/64 = 0,375 píxels/frame^2)
#define PLAYER_RX               24      // Friction (32/64 = 0,5 píxels/frame^2)

// ============================================================================
// V. Tile behaviour
// ============================================================================

// Defines the behaviour for each tile. Remember that if keys are activated, tile #15 is a bolt
// and, therefore, it should be made a full obstacle!

// 0 = Walkable (no action)
// 1 = Walkable and kills.
// 2 = Walkable and hides.
// 4 = Platform (only stops player if falling on it)
// 8 = Full obstacle (blocks player from all directions)
// 10 = special obstacle (pushing blocks OR locks!)
// 16 = Breakable (#ifdef BREAKABLE_WALLS)
// You can add the numbers to get combined behaviours
// Save for 10 (special), but that's obvious, innit?
unsigned char behs [] = {
	0, 8, 8, 8, 4, 0, 0, 8, 8, 8, 8, 8, 8, 0, 0, 0,
	0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 4, 4, 8, 8, 1, 4,
	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};

// Don't touch:
#if defined PLAYER_CAN_FIRE || defined PLAYER_STEPS_ON_ENEMS || defined PLAYER_HITTER
	#define ENEMS_MAY_DIE
#endif

// TODO:
// #define ENEMS_MAY_PAUSE

#if defined ENEMS_MAY_DIE || defined ENEMS_MAY_PAUSE
	#define ENEMS_NEED_STATES
#endif
