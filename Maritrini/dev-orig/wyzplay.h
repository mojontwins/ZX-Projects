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
		; ** fix **
		xor a
		ld i, a
		; ** fix **
			
		ld b, 1
		call SetRAMBank
		call WYZPLAYERISR
		ld b, 0
		call SetRAMBank			
		
		; ** fix **
		ld a, $FD
		ld i, a
		; ** fix **	
	#endasm
}
M_END_ISR

void wyz_init_soundsystem () {
	#asm
		di
		; ** fix **
		xor a
		ld i, a
		; ** fix **
		
		ld b,1
		call SetRAMBank
		call WYZPLAYERINIT	
		ld b,0
		call SetRAMBank
		; ** fix **
		ld a, $FD
		ld i, a
		; ** fix **	
	#endasm
}

void wyz_play_sound (unsigned char fx_number) {
	asm_int [0] = fx_number;
	
	#asm
		di
		; ** fix **
		xor a
		ld i, a
		; ** fix **
		ld b,1
		call SetRAMBank
		ld a, (_asm_int)
		ld b, a
		call INICIAEFECTO
		ld b,0
		call SetRAMBank
		; ** fix **
		ld a, $FD
		ld i, a
		; ** fix **	
		ei
	#endasm
}

void wyz_play_music (unsigned char song_number) {
	asm_int [0] = song_number;

	#asm
		di
		; ** fix **
		xor a
		ld i, a
		; ** fix **
		ld b, 1
		call SetRAMBank
		ld a, (_asm_int)
		call CARGA_CANCION
		ld b, 0
		call SetRAMBank
		; ** fix **
		ld a, $FD
		ld i, a
		; ** fix **	
		ei
	#endasm
}

void wyz_stop_sound ()
{
	#asm
		di
		; ** fix **
		xor a
		ld i, a
		; ** fix **
		ld b,1
		call SetRAMBank
		call SILENCIA_PLAYER
		ld b,0
		call SetRAMBank
		; ** fix **
		ld a, $FD
		ld i, a
		; ** fix **	
		ei
	#endasm
}
