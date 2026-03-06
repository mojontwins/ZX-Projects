// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// autodefs.h

// Needed prototypes

void __FASTCALL__ draw_scr_background (void);
void __FASTCALL__ draw_scr (void);
void active_sleep (int espera);
void run_fire_script (void);

void blackout_area (void);
void get_resource (unsigned char res, unsigned int dest);

void __FASTCALL__ _AY_PL_SND (unsigned char fx_number);
void __FASTCALL__ _AY_PL_MUS (unsigned char song_number);

unsigned char FO_add (unsigned char x, unsigned char y, unsigned char t);
void FO_paint (unsigned char idx);
void FO_paint_all (void);

void cortina (void);
unsigned char rand (void);
void hide_sprites (unsigned char which_ones);
void draw_coloured_tile (void);

void print_number2 (void);
unsigned char button_pressed (void);

// CUSTOM FOR K2T
void update_hud (void);
void k2t_show_time_prx_pry (void);
