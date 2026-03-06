// WYZ player hook functions

// WYZ player and songs are loaded into RAM 1 ($C000).
// In each interrupt, we just page in RAM 1, call the player,
// then page back RAM 0 and exit.

// The player is, thus, compiled to $C000, and its addresses
// are:

#define WYZPLAYERINIT		0xC018	// INIT_BUFFERS		EQU 0C018H
#define WYZPLAYERISR		0xC000	// INICIO			EQU 0C000H
#define INICIAEFECTO		0xC46B	// INICIA_EFECTO	EQU 0C46BH
#define CARGA_CANCION		0xC087	// CARGA_CANCION	EQU 0C087H
#define SILENCIA_PLAYER		0xC062	// PLAYER_OFF		EQU 0C062H

// Start.

// isr
M_BEGIN_ISR (isr)
{
	#asm
		ld a, 1
		call SetRAMBank
		call WYZPLAYERISR
		ld a, (_ram_page_act)
		call SetRAMBank			
	#endasm
}
M_END_ISR

void wyz_init_soundsystem () {
	#asm
		ld a,1
		call SetRAMBank
		call WYZPLAYERINIT	
		ld a, (_ram_page_act)
		call SetRAMBank
	#endasm
}

void __FASTCALL__ wyz_play_sound (unsigned char fx_number) {
	//asm_int [0] = fx_number;
	
	#asm
		ld d, l 				// FASTCALL
		di
		ld a,1
		call SetRAMBank
		//ld a, (_asm_int)
		ld b, d
		call INICIAEFECTO
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	#endasm
}

void __FASTCALL__ wyz_play_music (unsigned char song_number) {
	//asm_int [0] = song_number;

	#asm
		ld d, l 				// FASTCALL
		di
		ld a, 1
		call SetRAMBank
		//ld a, (_asm_int)
		ld a, d
		call CARGA_CANCION
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	#endasm
}

void wyz_stop_sound ()
{
	#asm
		di
		ld a,1
		call SetRAMBank
		call SILENCIA_PLAYER
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	#endasm
}
