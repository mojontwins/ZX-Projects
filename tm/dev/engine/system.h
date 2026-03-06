// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

void system_init (void) {	
	#asm
		di
	#endasm	

	cortina ();
		
	// splib2 initialization
	sp_Initialize (0, 0);
	sp_Border (0);
	sp_AddMemory(0, NUMBLOCKS, 14, AD_FREE);

	// Load tileset	
	#asm
			ld  de, _tileset
			ld  hl, SPTileArray
			ld  a, 0
			ld  bc, 8
		._load_tileset_loop
			ld  (hl), e 	// LSB
			inc h
			ld  (hl), d
			dec h
			inc hl
			ex  de, hl
			add hl, bc
			ex  de, hl
			inc a
			jr  nz, _load_tileset_loop
	#endasm
	
	// Sprite creation
	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, SPR_CELL(1), 1, TRANSPARENT);
	sp_AddColSpr (sp_player, SPR_CELL(1)+48, TRANSPARENT);
	sp_AddColSpr (sp_player, SPR_CELL(1)+96, TRANSPARENT);
	p_current_frame = p_next_frame = SPR_CELL(1);
	
	for (gpit = 0; gpit < 3; gpit ++) {
		sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, SPR_CELL(8), 2, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], SPR_CELL(8)+48, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], SPR_CELL(8)+96, TRANSPARENT);	
		en_an_current_frame [gpit] = en_an_next_frame [gpit] = SPR_CELL(8);
	}
}
