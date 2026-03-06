// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

// Simple AY sounds

extern unsigned char ay_regs [0];

#asm
	._ay_regs
		; Rayo (Francisco Manjón, Microhobby 194)
		defb 1, 4, 0, 16, 36, 67, 8, 4, 31, 245, 1, 6, 30, 2
#endasm

void fx_ay (unsigned char n) {
	rda = n; gp_gen = (unsigned char *) (ay_regs + (rda << 4) - (rda << 2));

	for (gpit = 0; gpit < 14; ++ gpit) {
		#asm
			ld  bc, $fffd
			ld  a, (_gpit)
			out (c), a

			ld  hl, (_gp_gen)
			ld  bc, $bffd
			ld  a, (hl)
			out (c), a

			ld  hl, _gp_gen
			inc (hl)
		#endasm
	}
}
