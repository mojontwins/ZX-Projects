;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Wed Nov 27 13:58:57 2019



	MODULE	tm.c


	INCLUDE "z80_crt0.hdr"


	LIB SPMoveSprAbs
	LIB SPPrintAtInv
	LIB SPTileArray
	LIB SPInvalidate
	LIB SPCompDListAddr
;	SECTION	text

._behs
	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	4

	defm	""
	defb	4

	defm	""
	defb	8

	defm	""
	defb	8

	defm	""
	defb	1

	defm	""
	defb	4

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


	.vpClipStruct defb 1, 1 + 20, 1, 1 + 30

._my_malloc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_BlockAlloc
	pop	bc
	ret


;	SECTION	text

._u_malloc
	defw	_my_malloc

;	SECTION	code

;	SECTION	text

._u_free
	defw	sp_FreeBlock

;	SECTION	code

;	SECTION	text

._keys
	defw	383
	defw	479
	defw	735
	defw	509
	defw	507

;	SECTION	code

;	SECTION	text

._joyfunc
	defw	sp_JoyKeyboard

;	SECTION	code

;	SECTION	text

._joyfuncs
	defw	sp_JoyKeyboard
	defw	sp_JoyKempston
	defw	sp_JoySinclair1

;	SECTION	code

;	SECTION	text

._spacer
	defw	i_1+0
;	SECTION	code

	._mapa
	BINARY "bin/mapa.map.bin"
	._tileset
	BINARY "bin/tileset.bin"
	._metatile_attrs
	BINARY "bin/metatile_attrs.bin"
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._spriteset
	BINARY "bin/spriteset.bin"
	._baddies
	BINARY "bin/baddies.bin"
	._hotspots
	BINARY "bin/hotspots.bin"
	._player_frames
	defw _spriteset+(1)*144
	defw _spriteset+(0)*144, _spriteset+(1)*144, _spriteset+(2)*144, _spriteset+(1)*144
	defw _spriteset+(3)*144
	defw _spriteset+(5)*144
	defw _spriteset+(4)*144, _spriteset+(5)*144, _spriteset+(6)*144, _spriteset+(5)*144
	defw _spriteset+(7)*144
	._enem_frames
	defw _spriteset+(8)*144, _spriteset+(9)*144, _spriteset+(10)*144, _spriteset+(11)*144
	defw _spriteset+(12)*144, _spriteset+(13)*144, _spriteset+(14)*144, _spriteset+(15)*144
	._s_title
	BINARY "bin/title.bin"
	._s_ending
	BINARY "bin/ending.bin"
	._ovl_halo defb 0, 0, 1, 1, 1, 1, 0, 0
	defb 0, 1, 5, 5, 5, 5, 1, 0
	defb 1, 5, 6, 6, 6, 6, 5, 1
	defb 1, 5, 6, 6, 6, 6, 5, 1
	defb 1, 5, 6, 6, 6, 6, 5, 1
	defb 1, 5, 6, 6, 6, 6, 5, 1
	defb 0, 1, 5, 5, 5, 5, 1, 0
	defb 0, 0, 1, 1, 1, 1, 0, 0
	._ovl_buff defs 936, 0

._lightning
	ld a, 120
	ld hl, 22561
	ld de, 22561
	ld b, 20
	.mb1 push bc
	ld (hl), a
	inc de
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	inc hl
	inc hl
	inc hl
	push hl
	pop de
	pop bc
	djnz mb1
	ret



._draw_buff
	._ovl_draw_buff
	; hl => ovl_buff + 36 * 3 + 3 = ovl_buff + 111
	ld hl, _ovl_buff + 111
	ld b, 20
	; de => 22528 + 32 + 1 = 22561
	ld de, 22561
	._ovldbl
	push bc
	; Copy 30 attrs
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	; Next line
	inc de
	inc de
	ld bc, 6
	add hl, bc
	pop bc
	djnz _ovldbl
	ret


	._ovl_draw_scr
	; First we calculate the address
	; address = ovl_buff + ovl_y * 36 + ovl_x
	ld a, (_ovl_y)
	ld h, 0
	ld l, a
	add hl, hl ; hl = ovl_y * 2
	add hl, hl ; hl = ovl_y * 4
	push hl
	add hl, hl ; hl = ovl_y * 8
	add hl, hl ; hl = ovl_y * 16
	add hl, hl ; hl = ovl_y * 32
	pop bc
	add hl, bc ; hl = ovl_y * 36
	ld a, (_ovl_x)
	ld d, 0
	ld e, a
	add hl, de ; hl = ovl_y * 36 + ovl_x
	ld de, _ovl_buff
	add hl, de ; hl = _ovl_buff + ovl_y * 32 + ovl_x
	ld de, _ovl_halo
	ex de, hl
	; DE -> buffer, HL -> ovl_halo
	; Start the tint. 8x8 lines, unrolled.
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	ret
	._ovl_del
	; First we calculate the address
	; address = ovl_buff + ovl_y * 36 + ovl_x
	ld a, (_ovl_y)
	ld h, 0
	ld l, a
	add hl, hl ; hl = ovl_y * 2
	add hl, hl ; hl = ovl_y * 4
	push hl
	add hl, hl ; hl = ovl_y * 8
	add hl, hl ; hl = ovl_y * 16
	add hl, hl ; hl = ovl_y * 32
	pop bc
	add hl, bc ; hl = ovl_y * 36
	ld a, (_ovl_x)
	ld d, 0
	ld e, a
	add hl, de ; hl = ovl_y * 36 + ovl_x
	ld de, _ovl_buff
	add hl, de ; hl = _ovl_buff + ovl_y * 32 + ovl_x
	xor a
	; Start the tint. 8x8 lines, unrolled.
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld bc, 29
	add hl, bc
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ret
	ld hl, 22528
	ld de, 22529
	ld bc, 767
	ld (hl), 0
	ldir
	; aPPack decompressor
	; original source by dwedit
	; very slightly adapted by utopian
	; optimized by Metalbrain
	;hl = source
	;de = dest
	.depack ld ixl,128
	.apbranch1 ldi
	.aploop0 ld ixh,1 ;LWM = 0
	.aploop call ap_getbit
	jr nc,apbranch1
	call ap_getbit
	jr nc,apbranch2
	ld b,0
	call ap_getbit
	jr nc,apbranch3
	ld c,16 ;get an offset
	.apget4bits call ap_getbit
	rl c
	jr nc,apget4bits
	jr nz,apbranch4
	ld a,b
	.apwritebyte ld (de),a ;write a 0
	inc de
	jr aploop0
	.apbranch4 and a
	ex de,hl ;write a previous byte (1-15 away from dest)
	sbc hl,bc
	ld a,(hl)
	add hl,bc
	ex de,hl
	jr apwritebyte
	.apbranch3 ld c,(hl) ;use 7 bit offset, length = 2 or 3
	inc hl
	rr c
	ret z ;if a zero is encountered here, it is EOF
	ld a,2
	adc a,b
	push hl
	ld iyh,b
	ld iyl,c
	ld h,d
	ld l,e
	sbc hl,bc
	ld c,a
	jr ap_finishup2
	.apbranch2 call ap_getgamma ;use a gamma code * 256 for offset, another gamma code for length
	dec c
	ld a,c
	sub ixh
	jr z,ap_r0_gamma ;if gamma code is 2, use old r0 offset,
	dec a
	;do I even need this code?
	;bc=bc*256+(hl), lazy 16bit way
	ld b,a
	ld c,(hl)
	inc hl
	ld iyh,b
	ld iyl,c
	push bc
	call ap_getgamma
	ex (sp),hl ;bc = len, hl=offs
	push de
	ex de,hl
	ld a,4
	cp d
	jr nc,apskip2
	inc bc
	or a
	.apskip2 ld hl,127
	sbc hl,de
	jr c,apskip3
	inc bc
	inc bc
	.apskip3 pop hl ;bc = len, de = offs, hl=junk
	push hl
	or a
	.ap_finishup sbc hl,de
	pop de ;hl=dest-offs, bc=len, de = dest
	.ap_finishup2 ldir
	pop hl
	ld ixh,b
	jr aploop
	.ap_r0_gamma call ap_getgamma ;and a new gamma code for length
	push hl
	push de
	ex de,hl
	ld d,iyh
	ld e,iyl
	jr ap_finishup
	.ap_getbit ld a,ixl
	add a,a
	ld ixl,a
	ret nz
	ld a,(hl)
	inc hl
	rla
	ld ixl,a
	ret
	.ap_getgamma ld bc,1
	.ap_getgammaloop call ap_getbit
	rl c
	rl b
	call ap_getbit
	jr c,ap_getgammaloop
	ret
	.sound_play
	ld hl, soundEffectsData ;address of sound effects data
	;di
	push iy
	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld a,(hl)
	inc hl
	ld h,(hl)
	ld l,a
	push hl
	pop ix ;put it into ix
	.readData
	ld a,(ix+0) ;read block type
	or a
	jr nz,readData_sound
	pop iy
	;ei
	ret
	.readData_sound
	ld c,(ix+1) ;read duration 1
	ld b,(ix+2)
	ld e,(ix+3) ;read duration 2
	ld d,(ix+4)
	push de
	pop iy
	dec a
	jr nz,sfxRoutineNoise
	;this routine generate tone with many parameters
	.sfxRoutineTone
	ld e,(ix+5) ;freq
	ld d,(ix+6)
	ld a,(ix+9) ;duty
	ld (sfxRoutineTone_duty + 1),a
	ld hl,0
	.sfxRoutineTone_l0
	push bc
	push iy
	pop bc
	.sfxRoutineTone_l1
	add hl,de
	ld a,h
	.sfxRoutineTone_duty
	cp 0
	sbc a,a
	and 16
	.sfxRoutineTone_border
	or 0
	out ($fe),a
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l1
	ld a,(sfxRoutineTone_duty + 1)
	add a,(ix+10) ;duty change
	ld (sfxRoutineTone_duty + 1),a
	ld c,(ix+7) ;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineTone_l0
	ld c,11
	.nextData
	add ix,bc ;skip to the next block
	jr readData
	;this routine generate noise with two parameters
	.sfxRoutineNoise
	ld e,(ix+5) ;pitch
	ld d,1
	ld h,d
	ld l,d
	.sfxRoutineNoise_l0
	push bc
	push iy
	pop bc
	.sfxRoutineNoise_l1
	ld a,(hl)
	and 16
	.sfxRoutineNoise_border
	or 0
	out ($fe),a
	dec d
	jr nz,sfxRoutineNoise_l2
	ld d,e
	inc hl
	ld a,h
	and $1f
	ld h,a
	.sfxRoutineNoise_l2
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l1
	ld a,e
	add a,(ix+6) ;slide
	ld e,a
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRoutineNoise_l0
	ld c,7
	jr nextData
	.soundEffectsData
	defw soundEffectsData_sfx0
	defw soundEffectsData_sfx1
	defw soundEffectsData_sfx2
	defw soundEffectsData_sfx3
	defw soundEffectsData_sfx4
	defw soundEffectsData_sfx5
	defw soundEffectsData_sfx6
	defw soundEffectsData_sfx7
	defw soundEffectsData_sfx8
	defw soundEffectsData_sfx9
	defw soundEffectsData_sfx10
	defw soundEffectsData_sfx11
	.soundEffectsData_sfx0
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0x0016,0x1680
	defb 0x00
	.soundEffectsData_sfx1
	defb 0x01
	defw 0x0064,0x0014,0x01f4,0x0002,0x0010
	defb 0x00
	.soundEffectsData_sfx2
	defb 0x02
	defw 0x0001,0x03e8,0x000a
	defb 0x01
	defw 0x0014,0x0064,0x0190,0xfff0,0x0080
	defb 0x02
	defw 0x0001,0x07d0,0x0001
	defb 0x00
	.soundEffectsData_sfx3
	defb 0x01
	defw 0x0014,0x00c8,0x0d48,0x000a,0x0040
	defb 0x00
	.soundEffectsData_sfx4
	defb 0x01
	defw 0x0050,0x0014,0x03e8,0xffff,0x0080
	defb 0x00
	.soundEffectsData_sfx5
	defb 0x01
	defw 0x0004,0x03e8,0x03e8,0x0190,0x0080
	defb 0x00
	.soundEffectsData_sfx6
	defb 0x01
	defw 0x0002,0x0fa0,0x0190,0x00c8,0x0040
	defb 0x01
	defw 0x0002,0x0fa0,0x00c8,0x00c8,0x0020
	defb 0x00
	.soundEffectsData_sfx7
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0x0002,0x0010
	defb 0x01
	defw 0x0001,0x0fa0,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x000a,0x03e8,0x00c8,0xfffe,0x0010
	defb 0x01
	defw 0x0001,0x07d0,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x000a,0x03e8,0x00b4,0xfffe,0x0010
	defb 0x01
	defw 0x0001,0x0fa0,0x0000,0x0000,0x0000
	defb 0x00
	.soundEffectsData_sfx8
	defb 0x02
	defw 0x0001,0x03e8,0x0014
	defb 0x01
	defw 0x0001,0x03e8,0x0000,0x0000,0x0000
	defb 0x02
	defw 0x0001,0x03e8,0x0001
	defb 0x00
	.soundEffectsData_sfx9
	defb 0x02
	defw 0x0014,0x0032,0x0101
	defb 0x00
	.soundEffectsData_sfx10
	defb 0x02
	defw 0x0064,0x01f4,0x0264
	defb 0x00
	.soundEffectsData_sfx11
	defb 0x01
	defw 0x0014,0x01f4,0x00c8,0x0005,0x0110
	defb 0x01
	defw 0x0001,0x03e8,0x0000,0x0000,0x0000
	defb 0x01
	defw 0x001e,0x01f4,0x00c8,0x0008,0x0110
	defb 0x01
	defw 0x0001,0x07d0,0x0000,0x0000,0x0000
	defb 0x00

._fx_beeper
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_rda),a
	push ix
	push iy
	ld a, (_rda)
	call sound_play
	pop ix
	pop iy
	ret



._step
	ld a, 16
	out (254), a
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	xor 16
	out (254), a
	ret


	._ay_regs
	; Rayo (Francisco Manj�n, Microhobby 194)
	defb 1, 4, 0, 16, 36, 67, 8, 4, 31, 245, 1, 6, 30, 2

._fx_ay
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_rda),a
	ld	hl,_ay_regs
	push	hl
	ld	hl,_rda
	call	l_gchar
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_rda
	call	l_gchar
	ex	de,hl
	ld	l,#(2 % 256)
	call	l_asl
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_12
.i_10
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_12
	ld	a,(_gpit)
	ld	e,a
	ld	d,0
	ld	hl,14	;const
	call	l_ult
	jp	nc,i_11
	ld bc, $fffd
	ld a, (_gpit)
	out (c), a
	ld hl, (_gp_gen)
	ld bc, $bffd
	ld a, (hl)
	out (c), a
	ld hl, _gp_gen
	inc (hl)
	jp	i_10
.i_11
	ret



._draw_coloured_tile
	ld a, (__x)
	ld c, a
	ld a, (__y)
	call SPCompDListAddr
	ex de, hl
	ld a, (__t)
	sla a
	sla a
	ld hl, _metatile_attrs
	ld b, 0
	ld c, a
	add hl, bc
	add 64
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc a
	ex de, hl
	ld bc, 123
	add hl, bc
	ex de, hl
	ld c, a
	ld a, (hl)
	ld (de), a
	inc de
	inc hl
	ld a, c
	ld (de), a
	inc de
	inc a
	ld c, a
	inc de
	inc de
	ld a, (hl)
	ld (de), a
	inc de
	ld a, c
	ld (de), a
	ret



._invalidate_tile
	; Invalidate Rectangle
	;
	; enter: B = row coord top left corner
	; C = col coord top left corner
	; D = row coord bottom right corner
	; E = col coord bottom right corner
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	ld a, (__x)
	inc a
	ld e, a
	ld a, (__y)
	inc a
	ld d, a
	ld a, (__x)
	ld c, a
	ld a, (__y)
	ld iy, vpClipStruct
	call SPInvalidate
	ret



._invalidate_viewport
	; Invalidate Rectangle
	;
	; enter: B = row coord top left corner
	; C = col coord top left corner
	; D = row coord bottom right corner
	; E = col coord bottom right corner
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	ld b, 1
	ld c, 1
	ld d, 1+19
	ld e, 1+29
	ld iy, vpClipStruct
	call SPInvalidate
	ret



._print_number2
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_rda),a
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_rdb),a
	; enter: A = row position (0..23)
	; C = col position (0..31/63)
	; D = pallette #
	; E = graphic #
	ld a, (_rda)
	ld e, a
	ld d, 7
	ld a, (__x)
	ld c, a
	ld a, (__y)
	call SPPrintAtInv
	ld a, (_rdb)
	ld e, a
	ld d, 7
	ld a, (__x)
	inc a
	ld c, a
	ld a, (__y)
	call SPPrintAtInv
	ret



._draw_objs
	ld	a,#(26 % 256 % 256)
	ld	(__x),a
	ld	a,#(22 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ret



._print_str
	.print_str_loop
	ld hl, (_gp_gen)
	ld a, (hl)
	or a
	ret z
	inc hl
	ld (_gp_gen), hl
	sub 32
	ld e, a
	ld a, (__t)
	ld d, a
	ld hl, __x
	ld c, (hl)
	inc (hl)
	ld a, (__y)
	call SPPrintAtInv
	jr print_str_loop
	ret



._cortina
	;; Antes que nada vamos a limpiar el PAPER de toda la pantalla
	;; para que no queden artefactos feos
	ld de, 22528 ; Apuntamos con DE a la zona de atributos
	ld b, 3 ; Procesamos 3 tercios
	.clearb1
	push bc
	ld b, 0 ; Procesamos los 256 atributos de cada tercio
	.clearb2
	ld a, (de) ; Nos traemos un atributo
	and 199 ; Le hacemos la máscara 11000111 y dejamos PAPER a 0
	ld (de), a ; Y lo volvemos a poner
	inc de ; Siguiente atributo
	djnz clearb2
	pop bc
	djnz clearb1
	;; Y ahora el código original que escribí para UWOL:
	ld a, 8
	.repitatodo
	ld c, a ; Salvamos el contador de "repitatodo" en 'c'
	ld hl, 16384
	ld a, 12
	.bucle
	ld b, a ; Salvamos el contador de "bucle" en 'b'
	ld a, 0
	.bucle1
	sla (hl)
	inc hl
	dec a
	jr nz, bucle1
	ld a, 0
	.bucle2
	srl (hl)
	inc hl
	dec a
	jr nz, bucle2
	ld a, b ; Restituimos el contador de "bucle" a 'a'
	dec a
	jr nz, bucle
	ld a, c ; Restituimos el contador de "repitatodo" a 'a'
	dec a
	jr nz, repitatodo
	ret



._rand
	.rand16
	ld de, (_seed)
	ld a, d
	ld h, e
	ld l, 253
	or a
	sbc hl, de
	sbc a, 0
	sbc hl, de
	ld d, 0
	sbc a, d
	ld e, a
	sbc hl, de
	jr nc, nextrand
	inc hl
	.nextrand
	ld (_seed), hl
	ld hl, _seed
	ld l, (hl)
	ld h, 0
	ret



._addsign
	ld	hl,4	;const
	add	hl,sp
	call	l_gint	;
	xor	a
	or	h
	jp	m,i_13
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_13
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_14
	ret



._busy_wait
.i_17
	ld	hl,250 % 256	;const
	ld	a,l
	ld	(_gpjt),a
.i_20
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_18
	ld	hl,(_gpjt)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpjt),a
	ld	a,h
	or	l
	jp	nz,i_20
.i_19
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_16
.i_21
.i_15
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	ld	a,h
	or	l
	jp	nz,i_17
.i_16
	ret



._cm_two_points
	ld a, (_cx1)
	cp 15
	jr nc, _cm_two_points_at1_reset
	ld a, (_cy1)
	cp 10
	jr c, _cm_two_points_at1_do
	._cm_two_points_at1_reset
	xor a
	jr _cm_two_points_at1_done
	._cm_two_points_at1_do
	ld a, (_cy1)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	ld b, a
	ld a, (_cx1)
	add b
	ld e, a
	ld d, 0
	ld hl, _map_attr
	add hl, de
	ld a, (hl)
	._cm_two_points_at1_done
	ld (_at1), a
	ld a, (_cx2)
	cp 15
	jr nc, _cm_two_points_at2_reset
	ld a, (_cy2)
	cp 10
	jr c, _cm_two_points_at2_do
	._cm_two_points_at2_reset
	xor a
	jr _cm_two_points_at2_done
	._cm_two_points_at2_do
	ld a, (_cy2)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	ld b, a
	ld a, (_cx2)
	add b
	ld e, a
	ld d, 0
	ld hl, _map_attr
	add hl, de
	ld a, (hl)
	._cm_two_points_at2_done
	ld (_at2), a
	ret



._select_joyfunc
	; Music generated by beepola
	call musicstart
.i_22
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
	cp	#(49 % 256)
	jr	z,i_25_uge
	jp	c,i_25
.i_25_uge
	ld	a,(_gpjt)
	cp	#(51 % 256)
	jr	z,i_26_i_25
	jr	c,i_26_i_25
.i_25
	jp	i_24
.i_26_i_25
	ld	hl,_joyfuncs
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	ld	bc,-49
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_joyfunc),hl
	jp	i_23
.i_24
	jp	i_22
.i_23
	ret



._sprites_off
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	xor a
	.hide_sprites_enems_loop
	ld (_gpit), a
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_moviles
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	ld a, (_gpit)
	inc a
	cp 3
	jr nz, hide_sprites_enems_loop
	ret



._advance_worm
	ld bc, (_gpit)
	ld b, 0
	ld de, (_rdt)
	ld d, 0
	ld hl, _behs
	add hl, de
	ld a, (hl)
	ld hl, _map_attr
	add hl, bc
	ld (hl), a
	ld a, (_rdt)
	ld hl, _map_buff
	add hl, bc
	ld (hl), a
	ld (__t), a
	call _draw_coloured_tile
	ld a, (__x)
	add a, 2
	cp 1 + 30
	jr c, _advance_worm_continue
	ld a, (__y)
	add a, 2
	ld (__y), a
	ld a, 1
	._advance_worm_continue
	ld (__x), a
	ld hl, _gpit
	inc (hl)
	ret



._draw_scr
	ld	hl,(_n_pant)
	ld	h,0
	ld	(_seed),hl
	._draw_scr_get_scr_address
	ld a, (_n_pant)
	sla a
	ld d, 0
	ld e, a
	ld hl, _mapa
	add hl, de ; HL = map + (n_pant << 1)
	ld e, (hl)
	inc hl
	ld d, (hl) ; DE = index
	ld hl, _mapa
	add hl, de ; HL = map + index
	ld (_gp_map), hl
	._draw_scr_rle
	xor a
	ld (_gpit), a
	ld a, 1
	ld (__x), a
	ld a, 1
	ld (__y), a
	._draw_scr_loop
	ld a, (_gpit)
	cp 150
	jr z, _draw_scr_loop_done
	ld hl, (_gp_map)
	ld a, (hl)
	inc hl
	ld (_gp_map), hl
	ld c, a
	and 0x3f
	ld (_rdt), a
	ld a, c
	ld (_rdct), a
	._draw_scr_advance_loop
	ld a, (_rdct)
	cp 0x40
	jr c, _draw_scr_advance_loop_done
	sub 0x40
	ld (_rdct), a
	call _advance_worm
	jr _draw_scr_advance_loop
	._draw_scr_advance_loop_done
	call _advance_worm
	jr _draw_scr_loop
	._draw_scr_loop_done
	._hotspots_setup
	ld a, (_n_pant)
	ld b, a
	sla a
	add b
	ld d, 0
	ld e, a
	ld hl, _hotspots
	add hl, de
	ld (_gp_gen), hl
	ld bc, 2
	add hl, bc
	ld a, (hl)
	or a
	jr z, _hotspots_setup_done
	dec hl
	ld a, (hl)
	or a
	jr z, _hotspots_setup_done
	._hotspots_setup_do
	ld (_hotspot_t), a
	add 16
	ld (__t), a
	dec hl
	ld a, (hl)
	ld c, a
	and 0xf0
	ld (_hotspot_x), a
	srl a
	srl a
	srl a
	srl a
	ld (_gpx), a
	sla a
	add 1
	ld (__x), a
	ld a, c
	and 15
	ld (_gpy), a
	sla a
	ld c, a
	sla a
	sla a
	sla a
	ld (_hotspot_y), a
	ld a, c
	add 1
	ld (__y), a
	ld a, (_gpx)
	ld c, a
	ld a, (_gpy)
	ld b, a
	sla a
	sla a
	sla a
	sla a
	sub b
	add c
	ld d, 0
	ld e, a
	ld hl, _map_buff
	add hl, de
	ld a, (hl)
	ld (_orig_tile), a
	call _draw_coloured_tile
	._hotspots_setup_done
	call _invalidate_viewport
	ret



._player_init
	ld	a,#(48 % 256 % 256)
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	a,#(16 % 256 % 256)
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	xor a
	ld (_p_vy), a
	ld (_p_vx), a
	ld (_p_saltando), a
	ld (_p_frame), a
	ld (_p_subframe), a
	ld (_p_objs), a
	ld (_p_state), a
	ld (_p_ct_state), a
	ld	a,#(1 % 256 % 256)
	ld	(_p_jump_ct),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_facing),a
	ld	hl,9 % 256	;const
	ld	a,l
	ld	(_p_life),a
	ret



._player_kill
	ld	hl,(_p_killme)
	ld	h,0
	push	hl
	call	_fx_beeper
	pop	bc
	ld	a,#(0 % 256 % 256)
	ld	(_p_killme),a
	ld	a,(_p_life)
	and	a
	jp	z,i_27
	ld	hl,(_p_life)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_p_life),a
	jp	i_28
.i_27
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_28
	ld	a,#(2 % 256 % 256)
	ld	(_p_state),a
	ld	hl,50 % 256	;const
	ld	a,l
	ld	(_p_ct_state),a
	ret



._player_move
	ld a, (_p_state)
	or a
	jr z, _player_move_state_done
	ld a, (_p_ct_state)
	dec a
	or a
	jr nz, _player_move_state_set
	xor a
	._player_move_state_set
	ld (_p_state), a
	._player_move_state_done
	ld	hl,_p_vy
	call	l_gchar
	ld	de,104	;const
	ex	de,hl
	call	l_le
	jp	nc,i_29
	ld	hl,_p_vy
	call	l_gchar
	ld	bc,16
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	jp	i_30
.i_29
	ld	hl,120	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_30
	ld	a,(_p_gotten)
	and	a
	jp	z,i_31
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_31
	ld	hl,(_p_y)
	push	hl
	ld	hl,_p_vy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_y),hl
	xor	a
	or	h
	jp	p,i_32
	ld	hl,0	;const
	ld	(_p_y),hl
.i_32
	ld	hl,(_p_y)
	ld	de,2304	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_33
	ld	hl,2304	;const
	ld	(_p_y),hl
.i_33
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_hit_v),a
	ld hl, _ptgmy
	ld a, (_p_vy)
	add a, (hl)
	ld (_rds), a
	or a
	jp z, _player_move_vert_col_done
	ld a, (_prx)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld a, (_prx)
	add 11
	srl a
	srl a
	srl a
	srl a
	ld (_cx2), a
	ld a, (_rds)
	and 0x80
	jr z, _player_move_vert_col_down
	._player_move_vert_col_up
	ld a, (_pry)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jr nz, _player_move_vert_col_up_do
	ld a, (_at2)
	and 8
	jp z, _player_move_vert_col_else
	._player_move_vert_col_up_do
	xor a
	ld (_p_vy), a
	ld a, (_cy1)
	inc a
	sla a
	sla a
	sla a
	sla a
	sub 4
	ld (_pry), a
	; shift left 4 times, 16 bits
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	jr _player_move_vert_col_done
	._player_move_vert_col_down
	ld a, (_pry)
	add 16
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_p_vy)
	srl a
	srl a
	srl a
	srl a
	inc a
	ld b, a
	ld a, (_pry)
	and 15
	cp b
	jr nc, _player_move_vert_col_else
	ld a, (_at1)
	and 12
	jr nz, _player_move_vert_col_down_do
	ld a, (_at2)
	and 12
	jr z, _player_move_vert_col_else
	._player_move_vert_col_down_do
	xor a
	ld (_p_vy), a
	ld a, (_cy1)
	dec a
	sla a
	sla a
	sla a
	sla a
	ld (_pry), a
	; shift left 4 times, 16 bits
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	jr _player_move_vert_col_done
	._player_move_vert_col_else
	._player_move_vert_col_done
	ld a, (_pry)
	add 16
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_at1)
	and 12
	ld c, a
	ld a, (_at2)
	and 12
	or c
	ld (_possee), a
	ld a, (_pad)
	and 0x80
	jr z, _player_move_rda_set_1
	ld a, (_pad)
	and 0x01
	jr nz, _player_move_rda_set_0
	._player_move_rda_set_1
	ld a, 1
	jr _player_move_rda_set
	._player_move_rda_set_0
	xor a
	._player_move_rda_set
	ld (_rda), a
	or a
	jr z, _player_move_jump_reset
	ld a, (_p_saltando)
	or a
	jr nz, _player_move_jump_start_done
	ld a, (_possee)
	or a
	jr nz, _player_move_jump_start
	ld a, (_p_gotten)
	or a
	jr nz, _player_move_jump_start
	ld a, (_hit_v)
	or a
	jr z, _player_move_jump_start_done
	._player_move_jump_start
	ld a, 1
	ld (_p_saltando), a
	xor a
	ld (_p_jump_ct), a
	ld hl, 1
	push hl
	call _fx_beeper
	pop bc
	._player_move_jump_start_done
	ld a, (_p_saltando)
	and a
	jr z, _player_move_jump_done
	._player_move_jump_do
	ld a, (_p_jump_ct)
	srl a
	ld b, a
	ld a, 24 + 12
	sub b
	ld b, a
	ld a, (_p_vy)
	sub b
	ld (_p_vy), a
	ld a, (_p_vy)
	cp -78
	jp m, _player_move_jump_do_p_vy_s
	jr _player_move_jump_do_p_vy_ns
	._player_move_jump_do_p_vy_s
	ld a, -78
	ld (_p_vy), a
	._player_move_jump_do_p_vy_ns
	ld hl, _p_jump_ct
	inc (hl)
	ld a, (hl)
	cp 8
	jr nz, _player_move_jump_done
	xor a
	ld (_p_saltando), a
	jr _player_move_jump_done
	._player_move_jump_reset
	xor a
	ld (_p_saltando), a
	._player_move_jump_done
	ld a, (_pad)
	and 0x04
	jr z, _player_move_horz_pad_left_1
	xor a
	jr _player_move_horz_pad_left_set
	._player_move_horz_pad_left_1
	ld a, 1
	._player_move_horz_pad_left_set
	ld (_rda), a
	ld a, (_pad)
	and 0x08
	jr z, _player_move_horz_pad_right_1
	xor a
	jr _player_move_horz_pad_right_set
	._player_move_horz_pad_right_1
	ld a, 1
	._player_move_horz_pad_right_set
	ld (_rdb), a
	or a
	jr z, _player_move_horz_pad_cancel_no
	ld a, (_rda)
	or a
	jr z, _player_move_horz_pad_cancel_no
	._player_move_horz_pad_cancel
	jp _player_move_horz_pad_done
	._player_move_horz_pad_cancel_no
	ld a, (_rda)
	or a
	jr z, _player_move_horz_pad_left_done
	._player_move_horz_pad_left
	ld a, 6
	ld (_p_facing), a
	ld a, (_p_vx)
	cp -64+16
	jp m, _player_move_horz_pad_left_A
	ld a, (_p_vx)
	sub 16
	jr _player_move_set_pvx
	._player_move_horz_pad_left_A
	ld a, -64
	._player_move_horz_pad_left_done
	ld a, (_rdb)
	or a
	jr z, _player_move_horz_pad_right_don
	._player_move_horz_pad_right
	ld a, 0
	ld (_p_facing), a
	ld a, (_p_vx)
	cp 64-16+1
	jp m, _player_move_horz_pad_right_A
	ld a, 64
	jr _player_move_set_pvx
	._player_move_horz_pad_right_A
	ld a, (_p_vx)
	add 16
	jr _player_move_set_pvx
	._player_move_horz_pad_right_don
	ld a, (_p_vx)
	bit 7, a
	jr nz, _player_move_horz_pad_no_neg
	._player_move_horz_pad_no_pos
	sub 24
	bit 7, a
	jr z, _player_move_set_pvx
	xor a
	jr _player_move_set_pvx
	._player_move_horz_pad_no_neg
	add 24
	bit 7, a
	jr nz, _player_move_set_pvx
	xor a
	._player_move_set_pvx
	ld (_p_vx), a
	._player_move_horz_pad_done
	ld a, (_rda)
	ld c, a
	ld a, (_rdb)
	or c
	ld (_p_pad), a
	ld	hl,(_p_x)
	push	hl
	ld	hl,_p_vx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
	push	hl
	ld	hl,_ptgmx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
	xor	a
	or	h
	jp	p,i_34
	ld	hl,0	;const
	ld	(_p_x),hl
.i_34
	ld	hl,(_p_x)
	ld	de,3584	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_35
	ld	hl,3584	;const
	ld	(_p_x),hl
.i_35
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_hit_h),a
	ld hl, _ptgmx
	ld a, (_p_vx)
	add a, (hl)
	ld (_rds), a
	or a
	jp z, _player_move_horz_col_done
	ld a, (_pry)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld a, (_pry)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_cy2), a
	ld a, (_rds)
	and 0x80
	jr z, _player_move_horz_col_right
	._player_move_horz_col_left
	ld a, (_prx)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld (_cx2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jr nz, _player_move_horz_col_left_do
	ld a, (_at2)
	and 8
	jr z, _player_move_horz_col_else
	._player_move_horz_col_left_do
	xor a
	ld (_p_vx), a
	ld a, (_cx1)
	inc a
	sla a
	sla a
	sla a
	sla a
	sub 4
	ld (_prx), a
	; shift left 4 times, 16 bits
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_x), hl
	jr _player_move_horz_col_done
	._player_move_horz_col_right
	ld a, (_prx)
	add 12
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld (_cx2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jr nz, _player_move_horz_col_right_do
	ld a, (_at2)
	and 8
	jr z, _player_move_horz_col_else
	._player_move_horz_col_right_do
	xor a
	ld (_p_vx), a
	ld a, (_cx1)
	dec a
	sla a
	sla a
	sla a
	sla a
	add 4
	ld (_prx), a
	; shift left 4 times, 16 bits
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_x), hl
	jr _player_move_horz_col_done
	._player_move_horz_col_else
	ld a, (_at1)
	and 1
	jr nz, _player_move_horz_evil_do
	ld a, (_at2)
	and 1
	jr z, _player_move_horz_col_done
	._player_move_horz_evil_do
	ld a, 1
	ld (_hit_h), a
	._player_move_horz_col_done
	ld	a,#(0 % 256 % 256)
	ld	(_hit),a
	ld	a,(_hit_v)
	and	a
	jp	z,i_36
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,_p_vy
	call	l_gchar
	call	l_neg
	push	hl
	ld	hl,64	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	jp	i_37
.i_36
	ld	a,(_hit_h)
	and	a
	jp	z,i_38
	ld	a,#(1 % 256 % 256)
	ld	(_hit),a
	ld	hl,_p_vx
	call	l_gchar
	call	l_neg
	push	hl
	ld	hl,64	;const
	push	hl
	call	_addsign
	pop	bc
	pop	bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_38
.i_37
	ld	a,(_hit)
	and	a
	jp	z,i_40
	ld	a,(_p_state)
	cp	#(0 % 256)
	jr	z,i_41_i_40
.i_40
	jp	i_39
.i_41_i_40
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_p_killme),a
.i_39
	ld a, (_p_state)
	and 2
	jr z, _player_move_select_cell
	ld a, (_half_life)
	or a
	jr z, _player_move_select_cell
	ld hl, _spriteset+(16)*144
	jr _player_move_select_cell_done
	._player_move_select_cell
	ld a, (_possee)
	or a
	jr nz, _player_move_select_cell_not_ai
	ld a, (_p_gotten)
	or a
	jr nz, _player_move_select_cell_not_ai
	ld c, 5
	jr _player_select_cell_set
	._player_move_select_cell_not_ai
	ld a, (_p_pad)
	or a
	jr nz, _player_move_select_cell_walk
	ld c, 0
	jr _player_select_cell_set
	._player_move_select_cell_walk
	ld a, (_p_subframe)
	or a
	jr nz, _player_move_select_cell_A
	call _step
	ld a, (_p_frame)
	inc a
	and 3
	ld (_p_frame), a
	ld a, 4
	jr _player_move_select_cell_B
	._player_move_select_cell_A
	dec a
	._player_move_select_cell_B
	ld (_p_subframe), a
	ld a, (_p_frame)
	add 1
	ld c, a
	._player_select_cell_set
	ld a, (_p_facing)
	add c
	sla a
	ld b, 0
	ld c, a
	ld hl, _player_frames
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	ex de, hl
	._player_move_select_cell_done
	ld (_p_next_frame), hl
	ld a, (_prx)
	srl a
	srl a
	srl a
	ld (_prxc), a
	ld a, (_pry)
	srl a
	srl a
	srl a
	ld (_pryc), a
	ret



._enems_get_pointer
	ld e, a
	sla a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld d, 0
	add hl, de
	ld de, _baddies
	add hl, de
	ret



._enems_init
	ld a, (_n_pant)
	ld b, a
	sla a
	add b
	ld (_enoffs), a
	ld bc, 3
	._enems_init_loop
	dec c
	ld a, (_enoffs)
	add c
	ld (_enoffsmasi), a
	xor a
	ld hl, _en_an_frame
	add hl, bc
	ld (hl), a
	ld a, 3
	ld hl, _en_an_count
	add hl, bc
	ld (hl), a
	ld a, (_enoffsmasi)
	call _enems_get_pointer
	ld de, 8
	add hl, de
	ld a, (hl)
	ld (__en_t), a
	ld a, (__en_t)
	cp 1
	jr z, _enems_init_linear
	cp 2
	jr z, _enems_init_linear
	cp 3
	jr z, _enems_init_linear
	cp 4
	jr nz, _enems_init_linear_done
	._enems_init_linear
	dec a
	sla a
	ld hl, _en_an_base_frame
	add hl, bc
	ld (hl), a
	jr _enems_init_type_done
	._enems_init_linear_done
	._enems_init_type_done
	xor a
	or c
	jr nz, _enems_init_loop
	ret



._enems_move
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmy),a
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmx),a
	ld	h,0
	ld	a,l
	ld	(_p_gotten),a
	ld	h,0
	ld	a,l
	ld	(_tocado),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_44
.i_42
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_44
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_43
	jp	nc,i_43
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_animate),a
	ld	h,0
	ld	a,l
	ld	(_active),a
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	ld a, (_gpit)
	ld c, a
	ld a, (_enoffs)
	add c
	ld (_enoffsmasi), a
	call _enems_get_pointer
	ld (_gp_gen), hl
	ld a, (hl)
	ld (__en_x), a
	inc hl
	ld a, (hl)
	ld (__en_y), a
	inc hl
	ld a, (hl)
	ld (__en_x1), a
	inc hl
	ld a, (hl)
	ld (__en_y1), a
	inc hl
	ld a, (hl)
	ld (__en_x2), a
	inc hl
	ld a, (hl)
	ld (__en_y2), a
	inc hl
	ld a, (hl)
	ld (__en_mx), a
	inc hl
	ld a, (hl)
	ld (__en_my), a
	inc hl
	ld a, (hl)
	ld (__en_t), a
	ld a, 1
	ld (_update), a
	ld (_animate), a
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 12
	cp c
	jp c, _enems_move_pregotten_not
	ld a, (_prx)
	ld c, a
	ld a, (__en_x)
	add 12
	cp c
	jp c, _enems_move_pregotten_not
	ld a, 1
	jr _enems_move_pregotten_set
	._enems_move_pregotten_not
	xor a
	._enems_move_pregotten_set
	ld (_pregotten), a
	ld	a,(_update)
	and	a
	jp	z,i_45
	ld	hl,(__en_t)
	ld	h,0
.i_48
	ld	a,l
	cp	#(1% 256)
	jp	z,i_49
	cp	#(2% 256)
	jp	z,i_50
	cp	#(3% 256)
	jp	z,i_51
	cp	#(4% 256)
	jp	z,i_52
	jp	i_53
.i_49
.i_50
.i_51
.i_52
	ld a, 1
	ld (_active), a
	ld a, (__en_mx)
	ld c, a
	ld a, (__en_x)
	add a, c
	ld (__en_x), a
	ld c, a
	ld a, (__en_x1)
	cp c
	jr z, _enems_lm_change_axis_x
	ld a, (__en_x2)
	cp c
	jr nz, _enems_lm_change_axis_x_done
	._enems_lm_change_axis_x
	ld a, (__en_mx)
	neg
	ld (__en_mx), a
	._enems_lm_change_axis_x_done
	ld a, (__en_my)
	ld c, a
	ld a, (__en_y)
	add a, c
	ld (__en_y), a
	ld c, a
	ld a, (__en_y1)
	cp c
	jr z, _enems_lm_change_axis_y
	ld a, (__en_y2)
	cp c
	jr nz, _enems_lm_change_axis_y_done
	._enems_lm_change_axis_y
	ld a, (__en_my)
	neg
	ld (__en_my), a
	._enems_lm_change_axis_y_done
	jp	i_47
.i_53
	ld	a,#(0 % 256 % 256)
	ld	(_animate),a
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_spriteset+2304
	pop	de
	call	l_pint
.i_47
.i_45
	ld	hl,(_animate)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_54
	ld bc, (_gpit)
	ld b, 0
	ld hl, _en_an_count
	add hl, bc
	ld a, (hl)
	inc a
	cp 4
	jr nz, _enems_move_animate_count_set
	._enems_move_animate_frame_flip
	ld hl, _en_an_frame
	add hl, bc
	ld d, (hl)
	ld a, 1
	sub d
	ld (hl), a
	ld d, a
	ld hl, _en_an_base_frame
	add hl, bc
	ld a, (hl)
	add d
	sla a
	ld e, a
	ld d, 0
	ld hl, _enem_frames
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, _en_an_next_frame
	add hl, bc
	add hl, bc
	ld (hl), e
	inc hl
	ld (hl), d
	ld hl, _en_an_count
	add hl, bc
	xor a
	._enems_move_animate_count_set
	ld (hl), a
.i_54
	ld	a,(_active)
	and	a
	jp	z,i_55
	ld	a,(__en_t)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_eq
	jp	nc,i_56
	ld a, (_pregotten)
	or a
	jp z, _enems_collision_done
	ld a, (_p_gotten)
	or a
	jp nz, _enems_collision_done
	ld a, (__en_mx)
	or a
	jr z, _enems_plats_horz_done
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 17
	cp c
	jr c, _enems_plats_horz_done
	ld a, (_pry)
	add 10
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, _enems_plats_horz_done
	._enems_plats_horz_do
	ld a, 1
	ld (_p_gotten), a
	ld a, (__en_mx)
	sla a
	sla a
	sla a
	sla a ; times 4
	ld (_ptgmx), a
	jr _enems_plats_pry_set
	._enems_plats_horz_done
	._enems_plats_vert_check_1
	ld a, (_pry)
	add 10
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, _enems_plats_vert_done
	ld a, (__en_my)
	bit 7, a
	jr z, _enems_plats_vert_check_2 ; _en_my is positive
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 18
	cp c
	jr nc, _enems_plats_vert_do
	._enems_plats_vert_check_2
	ld a, (__en_y)
	ld c, a
	ld a, (__en_my)
	ld b, a
	ld a, (_pry)
	add 17
	add b
	cp c
	jr c, _enems_plats_vert_done
	._enems_plats_vert_do
	ld a, 1
	ld (_p_gotten), a
	ld a, (__en_my)
	sla a
	sla a
	sla a
	sla a ; times 4
	ld (_ptgmy), a
	xor a
	ld (_p_vy), a
	._enems_plats_pry_set
	ld a, (__en_y)
	sub 16
	ld (_pry), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_p_y), hl
	._enems_plats_vert_done
	jp _enems_collision_done
	jp	i_57
.i_56
	._enems_collision
	ld a, (_tocado)
	or a
	jr nz, _enems_collision_done
	ld a, (_p_state)
	or a
	jr nz, _enems_collision_done
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 8
	cp c
	jr c, _enems_collision_done
	ld a, (_prx)
	ld c, a
	ld a, (__en_x)
	add 8
	cp c
	jr c, _enems_collision_done
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 8
	cp c
	jr c, _enems_collision_done
	ld a, (_pry)
	ld c, a
	ld a, (__en_y)
	add 8
	cp c
	jr c, _enems_collision_done
	._enems_collision_do
	ld a, 1
	ld (_tocado), a
	ld a, 2
	ld (_p_killme), a
	._enems_collision_done
.i_57
.i_55
.i_58
	._continue_enems_loop_a
	ld hl, (_gp_gen)
	ld a, (__en_x)
	ld (hl), a
	inc hl
	ld a, (__en_y)
	ld (hl), a
	inc hl
	ld a, (__en_x1)
	ld (hl), a
	inc hl
	ld a, (__en_y1)
	ld (hl), a
	inc hl
	ld a, (__en_x2)
	ld (hl), a
	inc hl
	ld a, (__en_y2)
	ld (hl), a
	inc hl
	ld a, (__en_mx)
	ld (hl), a
	inc hl
	ld a, (__en_my)
	ld (hl), a
	inc hl
	ld a, (__en_t)
	ld (hl), a
	jp	i_42
.i_43
	ret



._game_ending
	ld	hl,1 % 256	;const
	push	hl
	call	sp_UpdateNow
	pop	bc
	ld hl, _s_ending;
	ld de, 16384;
	call depack
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_61
	ld	hl,7 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
	ld	hl,2 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
.i_59
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	a,h
	or	l
	jp	nz,i_61
.i_60
	ld	hl,9 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
	ld	hl,500	;const
	push	hl
	call	_busy_wait
	pop	bc
	ret



._game_over
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(11 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(_gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+13
	ld	(_gp_gen),hl
	call	_print_str
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(13 % 256 % 256)
	ld	(__y),a
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	hl,(_spacer)
	ld	(_gp_gen),hl
	call	_print_str
	ld	hl,1 % 256	;const
	push	hl
	call	sp_UpdateNow
	pop	bc
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_64
	ld	hl,7 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
	ld	hl,2 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
.i_62
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	a,h
	or	l
	jp	nz,i_64
.i_63
	ld	hl,9 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
	ld	hl,500	;const
	push	hl
	call	_busy_wait
	pop	bc
	ret



._system_init
	di
	call	_cortina
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_Initialize
	pop	bc
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,40 % 256	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,_AD_FREE
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld de, _tileset
	ld hl, SPTileArray
	ld a, 0
	ld bc, 8
	._load_tileset_loop
	ld (hl), e
	inc h
	ld (hl), d
	dec h
	inc hl
	ex de, hl
	add hl, bc
	ex de, hl
	inc a
	jr nz, _load_tileset_loop
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_spriteset+144
	push	hl
	ld	hl,1 % 256	;const
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_player),hl
	push	hl
	ld	hl,_spriteset+144+(48)
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_sp_player)
	push	hl
	ld	hl,_spriteset+144+(96)
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_spriteset+144
	ld	(_p_next_frame),hl
	ld	(_p_current_frame),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_67
.i_65
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_67
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_66
	jp	nc,i_66
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_spriteset+1152
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	de
	call	l_pint
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_spriteset+1152+(48)
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_sp_moviles
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_spriteset+1152+(96)
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_en_an_current_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_en_an_next_frame
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_spriteset+1152
	pop	de
	call	l_pint
	pop	de
	call	l_pint
	jp	i_65
.i_66
	ret



._on_entering_screen
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	a,(hl)
	cp	#(1 % 256)
	jp	nz,i_69
	ld	hl,_hotspots
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	a,(hl)
	cp	#(1 % 256)
	jr	z,i_70_i_69
.i_69
	jp	i_68
.i_70_i_69
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_lit),a
	jp	i_71
.i_68
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_lit),a
.i_71
	ret



._my_extra_routines
	ld	hl,(_lit)
	ld	h,0
	call	l_lneg
	jp	nc,i_72
	call	_rand
	ld	de,127	;const
	ex	de,hl
	call	l_and
	ld	de,4	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_74
	ld	a,(_ray_on)
	cp	#(0 % 256)
	jr	z,i_75_i_74
.i_74
	jp	i_73
.i_75_i_74
	ld	hl,8 % 256	;const
	ld	a,l
	ld	(_ray_on),a
.i_73
	ld	a,(_ray_on)
	and	a
	jp	z,i_76
	ld	hl,(_ray_on)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_ray_on),a
	and	a
	jp	nz,i_77
	ld	hl,0 % 256	;const
	push	hl
	call	_fx_ay
	pop	bc
.i_77
.i_76
	ld	hl,(_ray_on)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_79
	call	_rand
	ld	de,3	;const
	ex	de,hl
	call	l_and
	ld	de,2	;const
	ex	de,hl
	call	l_lt
	jr	c,i_80_i_79
.i_79
	jp	i_78
.i_80_i_79
	call	_lightning
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_justlit),a
	jp	i_81
.i_78
	ld	a,(_justlit)
	and	a
	jp	nz,i_83
	ld	hl,(_prxc)
	ld	h,0
	ex	de,hl
	ld	hl,(_ovl_x)
	ld	h,0
	call	l_ne
	jp	c,i_83
	ld	hl,(_pryc)
	ld	h,0
	ex	de,hl
	ld	hl,(_ovl_y)
	ld	h,0
	call	l_ne
	jp	nc,i_82
.i_83
	ld	hl,(_prxc)
	ld	h,0
	ld	a,l
	ld	(_ovl_x),a
	ld	hl,(_pryc)
	ld	h,0
	ld	a,l
	ld	(_ovl_y),a
	call _ovl_draw_scr
	call _ovl_draw_buff
	call _ovl_del
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_justlit),a
.i_82
.i_81
.i_72
	ld	hl,(_lit)
	ld	h,0
	ld	a,l
	ld	(_do_attrs),a
	ret



._game_win_condition
	ld	a,(_p_objs)
	ld	e,a
	ld	d,0
	ld	hl,24	;const
	call	l_eq
	ld	hl,0	;const
	rl	l
	ld	h,0
	ret



._on_collected
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_lit),a
	call	_invalidate_viewport
	ld	hl,_p_objs
	ld	a,(hl)
	and	#(0 % 256)
	jp	z,i_86
	ld	a,(_p_life)
	cp	#(9 % 256)
	jp	z,i_86
	jr	c,i_87_i_86
.i_86
	jp	i_85
.i_87_i_86
	ld	hl,7 % 256	;const
	push	hl
	call	_fx_beeper
	pop	bc
	ld	hl,(_p_life)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_life),a
.i_85
	ld	hl,1 % 256	;const
	ret



._do_game
.i_88
	ld	hl,1 % 256	;const
	push	hl
	call	sp_UpdateNow
	pop	bc
	ld hl, _s_title;
	ld de, 16384;
	call depack
	call	_select_joyfunc
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_playing),a
	call	_player_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_90
	ld	a,(_gpit)
	cp	#(24 % 256)
	jp	z,i_91
	jp	nc,i_91
	ld	hl,_hotspots
	push	hl
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl),#(1 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_90
.i_91
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_killed_old),a
	ld	h,0
	ld	a,l
	ld	(_life_old),a
	ld	h,0
	ld	a,l
	ld	(_keys_old),a
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
	ld	a,#(8 % 256 % 256)
	ld	(_n_pant),a
	ld	a,#(255 % 256 % 256)
	ld	(_on_pant),a
	ld	a,#(0 % 256 % 256)
	ld	(_maincounter),a
	ld	a,#(0 % 256 % 256)
	ld	(_half_life),a
	ld	a,#(0 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_justlit),a
	ld	h,0
	ld	a,l
	ld	(_ray_on),a
	ld	hl,153 % 256	;const
	ld	a,l
	ld	(_ovl_y),a
	ld	h,0
	ld	a,l
	ld	(_ovl_x),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_do_attrs),a
.i_92
	ld	a,(_playing)
	and	a
	jp	z,i_93
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_on_pant)
	ld	h,0
	call	l_ne
	jp	nc,i_94
	call	_draw_scr
	call	_enems_init
	call	_on_entering_screen
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_on_pant),a
.i_94
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_95
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_95
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_pad),a
	ld	hl,(_p_objs)
	ld	h,0
	ex	de,hl
	ld	hl,(_objs_old)
	ld	h,0
	call	l_ne
	jp	nc,i_96
	call	_draw_objs
	ld	hl,(_p_objs)
	ld	h,0
	ld	a,l
	ld	(_objs_old),a
.i_96
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_life_old)
	ld	h,0
	call	l_ne
	jp	nc,i_97
	ld	a,#(4 % 256 % 256)
	ld	(__x),a
	ld	a,#(22 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_print_number2
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(_life_old),a
.i_97
	ld	hl,_maincounter
	ld	a,(hl)
	inc	(hl)
	ld	hl,(_half_life)
	ld	h,0
	call	l_lneg
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_half_life),a
	call	_enems_move
	call	_player_move
	xor a
	.update_sprites_baddies_loop
	ld (_gpit), a
	ld c, a
	ld a, (_enoffs)
	add c
	ld (_enoffsmasi), a
	call _enems_get_pointer
	ld a, (hl)
	ld (_gpx), a
	inc hl
	ld a, (hl)
	ld (_gpy), a
	; enter: IX = sprite structure address
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	; BC = animate bitdef displacement (0 for no animation)
	; H = new row coord in chars
	; L = new col coord in chars
	; D = new horizontal rotation (0..7) ie horizontal pixel position
	; E = new vertical rotation (0..7) ie vertical pixel position
	ld a, (_gpit)
	sla a
	ld c, a
	ld b, 0
	ld hl, _sp_moviles
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	pop ix
	ld iy, vpClipStruct
	ld hl, _en_an_current_frame
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, _en_an_next_frame
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	or a
	sbc hl, de
	push bc
	ld b, h
	ld c, l
	ld a, (_gpy)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_gpx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_gpx)
	and 7
	ld d, a
	ld a, (_gpy)
	and 7
	ld e, a
	call SPMoveSprAbs
	pop bc
	ld hl, _en_an_current_frame
	add hl, bc
	ex de, hl
	ld hl, _en_an_next_frame
	add hl, bc
	ldi
	ldi
	ld a, (_gpit)
	inc a
	cp 3
	jp nz, update_sprites_baddies_loop
	.update_sprites_player
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld hl, (_p_next_frame)
	ld de, (_p_current_frame)
	or a
	sbc hl, de
	ld b, h
	ld c, l
	ld a, (_pryc)
	;srl a
	;srl a
	;srl a
	add 1
	ld h, a
	ld a, (_prxc)
	;srl a
	;srl a
	;srl a
	add 1
	ld l, a
	ld a, (_prx)
	and 7
	ld d, a
	ld a, (_pry)
	and 7
	ld e, a
	call SPMoveSprAbs
	ld hl, (_p_next_frame)
	ld (_p_current_frame), hl
	call	_my_extra_routines
	ld	hl,(_do_attrs)
	ld	h,0
	push	hl
	call	sp_UpdateNow
	pop	bc
	ld	hl,(_p_killme)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_kill
.i_98
	._hotspots_collision
	ld a, (_hotspot_x)
	ld c, a
	ld a, (_prx)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_prx)
	ld c, a
	ld a, (_hotspot_x)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_hotspot_y)
	ld c, a
	ld a, (_pry)
	add 12
	cp c
	jp c, _hotspots_done
	ld a, (_pry)
	ld c, a
	ld a, (_hotspot_y)
	add 12
	cp c
	jp c, _hotspots_done
	._hotspots_do
	xor a
	ld (_gpit), a
	ld a, (_hotspot_t)
	cp 1
	jr nz, _hotspots_type_1_done
	._hotspots_type_1_do
	call _on_collected
	xor a
	or l
	jp z, _hotspots_clear_check
	ld hl, _p_objs
	inc (hl)
	ld hl, 6
	push hl
	call _fx_beeper
	pop bc
	ld a, 1
	ld (_gpit), a
	jp _hotspots_clear_check
	._hotspots_type_1_done
	._hotspots_clear_check
	ld a, (_gpit)
	or a
	jr z, _hotspots_done
	ld a, (_hotspot_x)
	srl a
	srl a
	srl a
	add 1
	ld (__x), a
	ld a, (_hotspot_y)
	srl a
	srl a
	srl a
	add 1
	ld (__y), a
	ld a, (_orig_tile)
	ld (__t), a
	call _draw_coloured_tile
	call _invalidate_tile
	ld a, (_n_pant)
	ld b, a
	sla a
	add b
	add 2 ; (n_pant * 3) + 2
	ld d, 0
	ld e, a
	ld hl, _hotspots
	add hl, de
	xor a
	ld (hl), a
	ld a, 240
	ld (_hotspot_y), a
	._hotspots_done
	ld	a,(_prx)
	cp	#(0 % 256)
	jp	nz,i_100
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jr	c,i_101_i_100
.i_100
	jp	i_99
.i_101_i_100
	ld	hl,(_n_pant)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(224 % 256 % 256)
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
.i_99
	ld	a,(_prx)
	cp	#(224 % 256)
	jp	nz,i_103
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_104_i_103
.i_103
	jp	i_102
.i_104_i_103
	ld	hl,(_n_pant)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_x),hl
	ld	h,0
	ld	a,l
	ld	(_prx),a
.i_102
	ld	a,(_pry)
	cp	#(0 % 256)
	jp	nz,i_106
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_106
	ld	a,(_n_pant)
	cp	#(8 % 256)
	jr	z,i_106_uge
	jp	c,i_106
.i_106_uge
	jr	i_107_i_106
.i_106
	jp	i_105
.i_107_i_106
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,-8
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	a,#(144 % 256 % 256)
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
.i_105
	ld	a,(_pry)
	cp	#(144 % 256)
	jp	nz,i_109
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_110_i_109
.i_109
	jp	i_108
.i_110_i_109
	ld	a,(_n_pant)
	cp	#(16 % 256)
	jp	z,i_111
	jp	nc,i_111
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_y),hl
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	hl,_p_vy
	call	l_gchar
	ld	de,127	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_112
	ld	hl,127	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_112
.i_111
.i_108
	call	_game_win_condition
	ld	a,h
	or	l
	jp	z,i_113
	ld	a,#(1 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_113
	jp	i_92
.i_93
	call	_sprites_off
	ld	hl,0 % 256	;const
	push	hl
	call	sp_UpdateNow
	pop	bc
	ld	hl,(_success)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_114
	call	_game_ending
	jp	i_115
.i_114
	call	_game_over
.i_115
	call	_cortina
	jp	i_88
.i_89
	ret



._main
	call	_system_init
	call	_do_game
	ret


	; *****************************************************************************
	; * Phaser1 Engine, with synthesised drums
	; *
	; * Original code by Shiru - .http
	; * Modified by Chris Cowley
	; *
	; * Produced by Beepola v1.05.01
	; ******************************************************************************
	.musicstart
	LD HL,MUSICDATA ; <- Pointer to Music Data. Change
	; this to play a different song
	LD A,(HL) ; Get the loop start pointer
	LD (PATTERN_LOOP_BEGIN),A
	INC HL
	LD A,(HL) ; Get the song end pointer
	LD (PATTERN_LOOP_END),A
	INC HL
	LD E,(HL)
	INC HL
	LD D,(HL)
	INC HL
	LD (INSTRUM_TBL),HL
	LD (CURRENT_INST),HL
	ADD HL,DE
	LD (PATTERN_ADDR),HL
	XOR A
	LD (PATTERN_PTR),A ; Set the pattern pointer to zero
	LD H,A
	LD L,A
	LD (NOTE_PTR),HL ; Set the note offset (within this pattern) to 0
	.player
	DI
	PUSH IY
	;LD A,BORDER_COL
	xor a
	LD H,$00
	LD L,A
	LD (CNT_1A),HL
	LD (CNT_1B),HL
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD (CNT_2),HL
	LD (DIV_2),HL
	LD (OUT_1),A
	LD (OUT_2),A
	JR MAIN_LOOP
	; ********************************************************************************************************
	; * NEXT_PATTERN
	; *
	; * Select the next pattern in sequence (and handle looping if weve reached PATTERN_LOOP_END
	; * Execution falls through to PLAYNOTE to play the first note from our next pattern
	; ********************************************************************************************************
	.next_pattern
	LD A,(PATTERN_PTR)
	INC A
	INC A
	DEFB $FE ; CP n
	.pattern_loop_end DEFB 0
	JR NZ,NO_PATTERN_LOOP
	; Handle Pattern Looping at and of song
	DEFB $3E ; LD A,n
	.pattern_loop_begin DEFB 0
	.no_pattern_loop LD (PATTERN_PTR),A
	LD HL,$0000
	LD (NOTE_PTR),HL ; Start of pattern (NOTE_PTR = 0)
	.main_loop
	LD IYL,0 ; Set channel = 0
	.read_loop
	LD HL,(PATTERN_ADDR)
	LD A,(PATTERN_PTR)
	LD E,A
	LD D,0
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL) ; Now DE = Start of Pattern data
	LD HL,(NOTE_PTR)
	INC HL ; Increment the note pointer and...
	LD (NOTE_PTR),HL ; ..store it
	DEC HL
	ADD HL,DE ; Now HL = address of note data
	LD A,(HL)
	OR A
	JR Z,NEXT_PATTERN ; select next pattern
	BIT 7,A
	JP Z,RENDER ; Play the currently defined note(S) and drum
	LD IYH,A
	AND $3F
	CP $3C
	JP NC,OTHER ; Other parameters
	ADD A,A
	LD B,0
	LD C,A
	LD HL,FREQ_TABLE
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD A,IYL ; IYL = 0 for channel 1, or = 1 for channel 2
	OR A
	JR NZ,SET_NOTE2
	LD (DIV_1A),DE
	EX DE,HL
	DEFB $DD,$21 ; LD IX,nn
	.current_inst
	DEFW $0000
	LD A,(IX+$00)
	OR A
	JR Z,L809B ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
	LD B,A
	.l8098 ADD HL,HL
	DJNZ L8098
	.l809b LD E,(IX+$01)
	LD D,(IX+$02)
	ADD HL,DE
	LD (DIV_1B),HL
	LD IYL,1 ; Set channel = 1
	LD A,IYH
	AND $40
	JR Z,READ_LOOP ; No phase reset
	LD HL,OUT_1 ; Reset phaser
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_1A),HL
	LD H,(IX+$03)
	LD (CNT_1B),HL
	JR READ_LOOP
	.set_note2
	LD (DIV_2),DE
	LD A,IYH
	LD HL,OUT_2
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_2),HL
	JP READ_LOOP
	.set_stop
	LD HL,$0000
	LD A,IYL
	OR A
	JR NZ,SET_STOP2
	; Stop channel 1 note
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD HL,OUT_1
	RES 4,(HL)
	LD IYL,1
	JP READ_LOOP
	.set_stop2
	; Stop channel 2 note
	LD (DIV_2),HL
	LD HL,OUT_2
	RES 4,(HL)
	JP READ_LOOP
	.other CP $3C
	JR Z,SET_STOP ; Stop note
	CP $3E
	JR Z,SKIP_CH1 ; No changes to channel 1
	INC HL ; Instrument change
	LD L,(HL)
	LD H,$00
	ADD HL,HL
	LD DE,(NOTE_PTR)
	INC DE
	LD (NOTE_PTR),DE ; Increment the note pointer
	DEFB $01 ; LD BC,nn
	.instrum_tbl
	DEFW $0000
	ADD HL,BC
	LD (CURRENT_INST),HL
	JP READ_LOOP
	.skip_ch1
	LD IYL,$01
	JP READ_LOOP
	.exit_player
	LD HL,$2758
	EXX
	POP IY
	RET
	.render
	AND $7F ; L813A
	CP $76
	JP NC,DRUMS
	LD D,A
	EXX
	DEFB $21 ; LD HL,nn
	.cnt_1a DEFW $0000
	DEFB $DD,$21 ; LD IX,nn
	.cnt_1b DEFW $0000
	DEFB $01 ; LD BC,nn
	.div_1a DEFW $0000
	DEFB $11 ; LD DE,nn
	.div_1b DEFW $0000
	DEFB $3E ; LD A,n
	.out_1 DEFB $0
	EXX
	EX AF,AF ; beware!
	DEFB $21 ; LD HL,nn
	.cnt_2 DEFW $0000
	DEFB $01 ; LD BC,nn
	.div_2 DEFW $0000
	DEFB $3E ; LD A,n
	.out_2 DEFB $00
	.play_note
	; Read keyboard
	LD E,A
	XOR A
	IN A,($FE)
	OR $E0
	INC A
	.player_wait_key
	JR NZ,EXIT_PLAYER
	LD A,E
	LD E,0
	.l8168 EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L8171
	JR L8173
	.l8171 XOR $10
	.l8173 ADD IX,DE
	JR C,L8179
	JR L817B
	.l8179 XOR $10
	.l817b EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L8184
	JR L8186
	.l8184 XOR $10
	.l8186 NOP
	JP L818A
	.l818a EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L8193
	JR L8195
	.l8193 XOR $10
	.l8195 ADD IX,DE
	JR C,L819B
	JR L819D
	.l819b XOR $10
	.l819d EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81A6
	JR L81A8
	.l81a6 XOR $10
	.l81a8 NOP
	JP L81AC
	.l81ac EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81B5
	JR L81B7
	.l81b5 XOR $10
	.l81b7 ADD IX,DE
	JR C,L81BD
	JR L81BF
	.l81bd XOR $10
	.l81bf EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81C8
	JR L81CA
	.l81c8 XOR $10
	.l81ca NOP
	JP L81CE
	.l81ce EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81D7
	JR L81D9
	.l81d7 XOR $10
	.l81d9 ADD IX,DE
	JR C,L81DF
	JR L81E1
	.l81df XOR $10
	.l81e1 EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81EA
	JR L81EC
	.l81ea XOR $10
	.l81ec DEC E
	JP NZ,L8168
	EXX
	EX AF,AF ; beware!
	ADD HL,BC
	OUT ($FE),A
	JR C,L81F9
	JR L81FB
	.l81f9 XOR $10
	.l81fb ADD IX,DE
	JR C,L8201
	JR L8203
	.l8201 XOR $10
	.l8203 EX AF,AF ; beware!
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L820C
	JR L820E
	.l820c XOR $10
	.l820e DEC D
	JP NZ,PLAY_NOTE
	LD (CNT_2),HL
	LD (OUT_2),A
	EXX
	EX AF,AF ; beware!
	LD (CNT_1A),HL
	LD (CNT_1B),IX
	LD (OUT_1),A
	JP MAIN_LOOP
	; ************************************************************
	; * DRUMS - Synthesised
	; ************************************************************
	.drums
	ADD A,A ; On entry A=$75+Drum number (i.e. $76 to $7E)
	LD B,0
	LD C,A
	LD HL,DRUM_TABLE - 236
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	EX DE,HL
	JP (HL)
	.drum_tone1 LD L,16
	JR DRUM_TONE
	.drum_tone2 LD L,12
	JR DRUM_TONE
	.drum_tone3 LD L,8
	JR DRUM_TONE
	.drum_tone4 LD L,6
	JR DRUM_TONE
	.drum_tone5 LD L,4
	JR DRUM_TONE
	.drum_tone6 LD L,2
	.drum_tone
	LD DE,3700
	LD BC,$0101
	xor a
	.dt_loop0 OUT ($FE),A
	DEC B
	JR NZ,DT_LOOP1
	XOR 16
	LD B,C
	EX AF,AF ; beware!
	LD A,C
	ADD A,L
	LD C,A
	EX AF,AF ; beware!
	.dt_loop1 DEC E
	JR NZ,DT_LOOP0
	DEC D
	JR NZ,DT_LOOP0
	JP MAIN_LOOP
	.drum_noise1 LD DE,2480
	LD IXL,1
	JR DRUM_NOISE
	.drum_noise2 LD DE,1070
	LD IXL,10
	JR DRUM_NOISE
	.drum_noise3 LD DE,365
	LD IXL,101
	.drum_noise
	LD H,D
	LD L,E
	xor a
	LD C,A
	.dn_loop0 LD A,(HL)
	AND 16
	OR C
	OUT ($FE),A
	LD B,IXL
	.dn_loop1 DJNZ DN_LOOP1
	INC HL
	DEC E
	JR NZ,DN_LOOP0
	DEC D
	JR NZ,DN_LOOP0
	JP MAIN_LOOP
	.pattern_addr DEFW $0000
	.pattern_ptr DEFB 0
	.note_ptr DEFW $0000
	; **************************************************************
	; * Frequency Table
	; **************************************************************
	.freq_table
	DEFW 178,189,200,212,225,238,252,267,283,300,318,337
	DEFW 357,378,401,425,450,477,505,535,567,601,637,675
	DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
	DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
	DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400
	; *****************************************************************
	; * Synth Drum Lookup Table
	; *****************************************************************
	.drum_table
	DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
	DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3
	.musicdata
	DEFB 0 ; Pattern loop begin * 2
	DEFB 12 ; Song length * 2
	DEFW 12 ; Offset to start of song (length of instrument table)
	DEFB 0 ; Multiple
	DEFW 20 ; Detune
	DEFB 0 ; Phase
	DEFB 1 ; Multiple
	DEFW 5 ; Detune
	DEFB 1 ; Phase
	DEFB 0 ; Multiple
	DEFW 5 ; Detune
	DEFB 1 ; Phase
	.patterndata DEFW PAT0
	DEFW PAT0
	DEFW PAT1
	DEFW PAT1
	DEFW PAT2
	DEFW PAT3
	; *** Pattern data - $00 marks the end of a pattern ***
	.pat0
	DEFB $BD,0
	DEFB 173
	DEFB 140
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 140
	DEFB 118
	DEFB 4
	DEFB 172
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 169
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 142
	DEFB 123
	DEFB 4
	DEFB 173
	DEFB 122
	DEFB 4
	DEFB 190
	DEFB 142
	DEFB 121
	DEFB 4
	DEFB 172
	DEFB 142
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 169
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 173
	DEFB 143
	DEFB 5
	DEFB 190
	DEFB 121
	DEFB 4
	DEFB 172
	DEFB 142
	DEFB 122
	DEFB 4
	DEFB 190
	DEFB 123
	DEFB 4
	DEFB 173
	DEFB 140
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 140
	DEFB 118
	DEFB 4
	DEFB 172
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 169
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 142
	DEFB 123
	DEFB 4
	DEFB 173
	DEFB 122
	DEFB 4
	DEFB 190
	DEFB 142
	DEFB 121
	DEFB 4
	DEFB 172
	DEFB 142
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 169
	DEFB 142
	DEFB 5
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 172
	DEFB 143
	DEFB 123
	DEFB 4
	DEFB 190
	DEFB 126
	DEFB 4
	DEFB 173
	DEFB 145
	DEFB 126
	DEFB 4
	DEFB 190
	DEFB 126
	DEFB 4
	DEFB $00
	.pat1
	DEFB $BD,2
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 123
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 126
	DEFB 4
	DEFB 160
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 149
	DEFB 124
	DEFB 4
	DEFB 161
	DEFB 148
	DEFB 122
	DEFB 4
	DEFB 160
	DEFB 126
	DEFB 4
	DEFB 161
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 126
	DEFB 4
	DEFB 161
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 122
	DEFB 4
	DEFB 190
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 190
	DEFB 126
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 122
	DEFB 4
	DEFB 156
	DEFB 144
	DEFB 121
	DEFB 4
	DEFB 190
	DEFB 124
	DEFB 4
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 4
	DEFB 190
	DEFB 118
	DEFB 4
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 4
	DEFB 190
	DEFB 124
	DEFB 4
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 4
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 4
	DEFB $00
	.pat2
	DEFB $BD,4
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 161
	DEFB 148
	DEFB 123
	DEFB 4
	DEFB 190
	DEFB 149
	DEFB 122
	DEFB 4
	DEFB 160
	DEFB 149
	DEFB 121
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 5
	DEFB 190
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 5
	DEFB 190
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 190
	DEFB 148
	DEFB 122
	DEFB 4
	DEFB 190
	DEFB 149
	DEFB 121
	DEFB 4
	DEFB $00
	.pat3
	DEFB $BD,0
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 123
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 126
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 124
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 122
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 126
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 126
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 157
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 160
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 161
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 118
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 122
	DEFB 4
	DEFB 169
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 126
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 118
	DEFB 4
	DEFB 169
	DEFB 145
	DEFB 118
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 123
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 122
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 126
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 126
	DEFB 4
	DEFB 169
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 122
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 121
	DEFB 4
	DEFB 169
	DEFB 145
	DEFB 123
	DEFB 4
	DEFB 172
	DEFB 148
	DEFB 126
	DEFB 4
	DEFB 173
	DEFB 149
	DEFB 126
	DEFB 4
	DEFB $00
;	SECTION	text

.i_1
	defm	"            "
	defb	0

	defm	" GAME OVER! "
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._sp_moviles	defs	6
.__en_x1	defs	1
.__en_y1	defs	1
.__en_x2	defs	1
.__en_y2	defs	1
._en_an_base_frame	defs	3
._hotspot_t	defs	1
._hotspot_x	defs	1
._hotspot_y	defs	1
.__en_mx	defs	1
.__en_my	defs	1
.__taux	defs	1
._half_life	defs	1
._p_facing	defs	1
._p_frame	defs	1
._pregotten	defs	1
._hit_h	defs	1
._map_buff	defs	150
._hit_v	defs	1
._killed_old	defs	1
._gpaux	defs	1
._p_pad	defs	1
._map_attr	defs	150
._active	defs	1
._p_salto	defs	1
.__t	defs	1
.__x	defs	1
.__y	defs	1
._life_old	defs	1
._p_state	defs	1
._ovl_x	defs	1
._ovl_y	defs	1
._p_current_frame	defs	2
._ptgmx	defs	1
._ptgmy	defs	1
._en_an_current_frame	defs	6
._en_an_life	defs	3
._p_jump_ct	defs	1
._sp_player	defs	2
._gp_gen	defs	2
._gp_map	defs	2
._on_pant	defs	1
._enoffs	defs	1
._p_killed	defs	1
._p_killme	defs	1
._n_pant	defs	1
._p_life	defs	1
._p_fuel	defs	1
._gpcx	defs	1
._p_objs	defs	1
._p_gotten	defs	1
._gpcy	defs	1
._gpit	defs	1
._gpjt	defs	1
._p_keys	defs	1
._playing	defs	1
._seed	defs	2
._rdct	defs	1
._p_vx	defs	1
._p_vy	defs	1
._objs_old	defs	1
._maincounter	defs	1
._do_attrs	defs	1
._p_next_frame	defs	2
._en_an_next_frame	defs	6
._prxc	defs	1
._pryc	defs	1
._at1	defs	1
._at2	defs	1
._cx1	defs	1
._cx2	defs	1
._cy1	defs	1
._prxx	defs	1
._cy2	defs	1
._p_subframe	defs	1
._pryy	defs	1
._animate	defs	1
._gpc	defs	1
._gpd	defs	1
._ray_on	defs	1
._hit	defs	1
._pad	defs	1
._justlit	defs	1
._gpt	defs	1
._rda	defs	1
._rdb	defs	1
._p_x	defs	2
._AD_FREE	defs	600
._p_y	defs	2
._gpx	defs	1
._gpy	defs	1
._itj	defs	2
._lit	defs	1
._keys_old	defs	1
._p_ct_state	defs	1
._rds	defs	1
._rdt	defs	1
._rdx	defs	1
._rdy	defs	1
._prx	defs	1
._pry	defs	1
._enoffsmasi	defs	1
._rand_res	defs	1
._tocado	defs	1
._p_facing_h	defs	1
._p_facing_v	defs	1
._p_saltando	defs	1
._possee	defs	1
._orig_tile	defs	1
._update	defs	1
._en_an_frame	defs	3
._success	defs	1
._en_an_count	defs	3
._p_disparando	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	LIB	sp_GetKey
	LIB	sp_BlockAlloc
	XDEF	__en_t
	LIB	sp_ScreenStr
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_hotspots
	XDEF	_draw_scr
	LIB	sp_PixelUp
	LIB	sp_JoyFuller
	LIB	sp_MouseAMXInit
	XDEF	_draw_buff
	LIB	sp_MouseAMX
	XDEF	_sp_moviles
	XDEF	__en_x1
	LIB	sp_SetMousePosAMX
	XDEF	__en_y1
	XDEF	_u_malloc
	LIB	sp_Validate
	LIB	sp_HashAdd
	XDEF	__en_x2
	XDEF	__en_y2
	XDEF	_cortina
	LIB	sp_Border
	LIB	sp_Inkey
	XDEF	_en_an_base_frame
	XDEF	_enems_init
	XDEF	_draw_objs
	XDEF	_hotspot_t
	XDEF	_hotspot_x
	XDEF	_hotspot_y
	LIB	sp_CreateSpr
	LIB	sp_MoveSprAbs
	LIB	sp_BlockCount
	LIB	sp_AddMemory
	XDEF	__en_mx
	XDEF	__en_my
	XDEF	__taux
	XDEF	_half_life
	XDEF	_enems_get_pointer
	XDEF	_enems_move
	LIB	sp_PrintAt
	LIB	sp_Pause
	LIB	sp_ListFirst
	LIB	sp_HeapSiftUp
	LIB	sp_ListCount
	XDEF	_p_facing
	XDEF	_invalidate_tile
	XDEF	_p_frame
	LIB	sp_Heapify
	LIB	sp_MoveSprRel
	XDEF	_pregotten
	XDEF	_hit_h
	LIB	sp_TileArray
	LIB	sp_MouseSim
	LIB	sp_BlockFit
	XDEF	_map_buff
	XDEF	_hit_v
	LIB	sp_HeapExtract
	LIB	sp_HuffExtract
	XDEF	_killed_old
	XDEF	_busy_wait
	LIB	sp_SetMousePosSim
	XDEF	_gpaux
	XDEF	_lightning
	XDEF	_fx_ay
	XDEF	_joyfuncs
	LIB	sp_ClearRect
	XDEF	_p_pad
	LIB	sp_HuffGetState
	XDEF	_map_attr
	XDEF	_baddies
	XDEF	_invalidate_viewport
	XDEF	_active
	LIB	sp_ListAppend
	XDEF	_metatile_attrs
	LIB	sp_ListCreate
	LIB	sp_ListConcat
	LIB	sp_JoyKempston
	LIB	sp_UpdateNow
	LIB	sp_MouseKempston
	LIB	sp_PrintString
	LIB	sp_PixelDown
	LIB	sp_MoveSprAbsC
	LIB	sp_PixelLeft
	XDEF	_enem_frames
	XDEF	_p_salto
	LIB	sp_InitAlloc
	LIB	sp_DeleteSpr
	LIB	sp_JoyTimexEither
	XDEF	_player_kill
	XDEF	__t
	XDEF	__x
	XDEF	__y
	XDEF	_sprites_off
	XDEF	_player_init
	XDEF	_life_old
	LIB	sp_Invalidate
	LIB	sp_CreateGenericISR
	LIB	sp_JoyKeyboard
	LIB	sp_FreeBlock
	LIB	sp_PrintAtDiff
	XDEF	_player_move
	XDEF	_on_collected
	XDEF	_addsign
	XDEF	_p_state
	XDEF	_ovl_x
	XDEF	_ovl_y
	XDEF	_cm_two_points
	LIB	sp_RegisterHookLast
	LIB	sp_IntLargeRect
	LIB	sp_IntPtLargeRect
	LIB	sp_HashDelete
	LIB	sp_GetCharAddr
	XDEF	_p_current_frame
	XDEF	_ptgmx
	LIB	sp_RemoveHook
	XDEF	_ptgmy
	XDEF	_en_an_current_frame
	XDEF	_player_frames
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_game_win_condition
	XDEF	_en_an_life
	XDEF	_p_jump_ct
	XDEF	_sp_player
	XDEF	_gp_gen
	LIB	sp_GetTiles
	XDEF	_gp_map
	XDEF	_on_pant
	LIB	sp_Pallette
	LIB	sp_WaitForNoKey
	XDEF	_enoffs
	XDEF	_my_extra_routines
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	LIB	sp_ListPrepend
	XDEF	_behs
	XDEF	_p_killed
	LIB	sp_GetAttrAddr
	LIB	sp_HashCreate
	XDEF	_p_killme
	LIB	sp_Random32
	LIB	sp_ListInsert
	XDEF	_n_pant
	LIB	sp_ListFree
	XDEF	_spriteset
	XDEF	_advance_worm
	XDEF	_system_init
	LIB	sp_IntRect
	LIB	sp_ListLast
	LIB	sp_ListCurr
	XDEF	_p_life
	XDEF	_p_fuel
	XDEF	_print_number2
	XDEF	_on_entering_screen
	XDEF	_mapa
	LIB	sp_ListSearch
	LIB	sp_WaitForKey
	XDEF	_main
	XDEF	_draw_coloured_tile
	LIB	sp_Wait
	LIB	sp_GetScrnAddr
	XDEF	_joyfunc
	LIB	sp_PutTiles
	XDEF	_gpcx
	XDEF	_p_objs
	XDEF	_p_gotten
	XDEF	_gpcy
	XDEF	_s_title
	LIB	sp_RemoveDList
	XDEF	_gpit
	XDEF	_gpjt
	XDEF	_p_keys
	XDEF	_playing
	LIB	sp_ListNext
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_rand
	LIB	sp_Swap
	XDEF	_seed
	XDEF	_rdct
	XDEF	_print_str
	XDEF	_p_vx
	XDEF	_p_vy
	XDEF	_objs_old
	LIB	sp_ListPrev
	XDEF	_maincounter
	XDEF	_fx_beeper
	XDEF	_do_attrs
	LIB	sp_RegisterHook
	LIB	sp_ListRemove
	LIB	sp_ListTrim
	LIB	sp_MoveSprAbsNC
	LIB	sp_HuffDelete
	XDEF	_p_next_frame
	XDEF	_en_an_next_frame
	XDEF	_prxc
	XDEF	_pryc
	XDEF	_at1
	XDEF	_at2
	LIB	sp_ListAdd
	LIB	sp_KeyPressed
	XDEF	_step
	LIB	sp_PrintAtInv
	XDEF	_cx1
	XDEF	_cx2
	XDEF	_cy1
	XDEF	_prxx
	XDEF	_cy2
	LIB	sp_CompDListAddr
	XDEF	_p_subframe
	XDEF	_pryy
	XDEF	_u_free
	XDEF	_s_ending
	LIB	sp_CharRight
	XDEF	_animate
	XDEF	_game_ending
	XDEF	_do_game
	LIB	sp_InstallISR
	XDEF	_gpc
	XDEF	_gpd
	LIB	sp_HuffAccumulate
	LIB	sp_HuffSetState
	XDEF	_ray_on
	XDEF	_hit
	XDEF	_pad
	XDEF	_justlit
	XDEF	_gpt
	XDEF	_rda
	XDEF	_rdb
	LIB	sp_SwapEndian
	LIB	sp_CharLeft
	XDEF	_p_x
	XDEF	_AD_FREE
	LIB	sp_CharDown
	LIB	sp_HeapSiftDown
	LIB	sp_HuffCreate
	XDEF	_p_y
	XDEF	_gpx
	XDEF	_gpy
	XDEF	_itj
	XDEF	_lit
	XDEF	_keys_old
	LIB	sp_HuffEncode
	XDEF	_p_ct_state
	XDEF	_rds
	XDEF	_rdt
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	LIB	sp_Initialize
	XDEF	_tileset
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	LIB	sp_ComputePos
	XDEF	_prx
	XDEF	_pry
	XDEF	_enoffsmasi
	XDEF	_spacer
	XDEF	_rand_res
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	XDEF	_tocado
	LIB	sp_inp
	LIB	sp_IterateSprChar
	LIB	sp_AddColSpr
	LIB	sp_outp
	XDEF	_p_facing_h
	LIB	sp_IntPtInterval
	LIB	sp_RegisterHookFirst
	LIB	sp_HashLookup
	XDEF	_p_facing_v
	XDEF	_p_saltando
	LIB	sp_PFill
	XDEF	_possee
	LIB	sp_HashRemove
	LIB	sp_CharUp
	XDEF	_orig_tile
	XDEF	_update
	XDEF	_en_an_frame
	XDEF	_success
	LIB	sp_MoveSprRelNC
	XDEF	_en_an_count
	XDEF	_select_joyfunc
	XDEF	_ay_regs
	XDEF	_p_disparando
	LIB	sp_IterateDList
	XDEF	_game_over
	LIB	sp_LookupKey
	LIB	sp_HeapAdd
	LIB	sp_CompDirtyAddr
	LIB	sp_EmptyISR
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
