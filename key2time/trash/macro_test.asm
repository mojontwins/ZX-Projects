;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Thu Nov 07 10:16:13 2019



	MODULE	macro_test.c


	INCLUDE "z80_crt0.hdr"


;	SECTION	code


._main
	ld  a, (_rdx)
	ld  c,a
	ld  a, (_rdy)
	lsa a
	lsa a
	lsa a
	lsa a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_rda), a
	ret




; --- Start of Static Variables ---

;	SECTION	bss

._map_buff	defs	160
._map_attr	defs	160
._attr_r	defs	1
._rda	defs	1
._rdx	defs	1
._rdy	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	XDEF	_map_buff
	XDEF	_map_attr
	XDEF	_attr_r
	XDEF	_main
	XDEF	_rda
	XDEF	_rdx
	XDEF	_rdy


; --- End of Scope Defns ---


; --- End of Compilation ---
