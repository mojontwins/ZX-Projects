;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Tue Nov 12 10:51:41 2019



	MODULE	game.c


	INCLUDE "z80_crt0.hdr"


	LIB SPMoveSprAbs
	._asm_int
	defw 0
	._asm_int_2
	defw 0
;	SECTION	code


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

	.vpClipStruct defb 1, 1 + 20, 1, 1 + 30
;	SECTION	text

._half_life
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._level
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._do_gravity
	defm	""
	defb	1

;	SECTION	code


;	SECTION	text

._invalidate_fire
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._cur_map_attr
	defm	"c"
;	SECTION	code


;	SECTION	text

._d_prs
	defm	""
	defb	0

;	SECTION	code


	defw 0

._ISR
	ld	hl,(_isr_c)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_isr_c),a
	ret



._nosound_play_sound
	ret



._nosound_play_music
	ret



._nosound_stop_sound
	ret



._SetRAMBank
	.SetRAMBank
	ld a, b
	or a
	jp z, restISR
	xor a
	ld i, a
	jp keepGoing
	.restISR
	ld a, $f0
	ld i, a
	.keepGoing
	ld a, 16
	or b
	ld bc, $7ffd
	out (C), a
	ret


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
	._ram_address
	defw 0
	._ram_destination
	defw 0
	._ram_page
	defb 0

._unpack_RAMn
	ld	de,_ram_address
	ld	hl,6-2	;const
	add	hl,sp
	call	l_gint	;
	call	l_pint
	ld	hl,_ram_page
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_ram_destination
	ld	hl,4-2	;const
	add	hl,sp
	call	l_gint	;
	call	l_pint
	di
	ld a, (_ram_page)
	ld b, a
	call SetRAMBank
	ld hl, (_ram_address)
	ld de, (_ram_destination)
	call depack
	ld b, 0
	call SetRAMBank
	ei
	ret


	._randres defb 0

._rand
	.rnd
	ld hl,0xA280
	ld de,0xC0DE
	ld a,h ; t = x ^ (x << 1)
	add a,a
	xor h
	ld h,l ; x = y
	ld l,d ; y = z
	ld d,e ; z = w
	ld e,a
	rra ; t = t ^ (t >> 1)
	xor e
	ld e,a
	ld a,d ; w = w ^ ( w << 3 ) ^ t
	add a,a
	add a,a
	add a,a
	xor d
	xor e
	ld e,a
	ld (rnd+1),hl
	ld (rnd+4),de
	ld (_randres), a
	ld	hl,(_randres)
	ld	h,0
	ret


;	SECTION	text

._keyscancodes
	defw	763,765,509,1277,1151,2175,507,509,735,479
	defw	1151,2175
;	SECTION	code



._select_joyfunc
.i_12
	call	sp_GetKey
	ld	h,0
	ld	a,l
	ld	(_gpit),a
	cp	#(49 % 256)
	jp	z,i_15
	ld	a,(_gpit)
	cp	#(50 % 256)
	jp	nz,i_14
.i_15
	ld	hl,sp_JoyKeyboard
	ld	(_joyfunc),hl
	ld	hl,(_gpit)
	ld	h,0
	ld	bc,-49
	add	hl,bc
	ld	a,h
	or	l
	jp	z,i_17
	ld	hl,6	;const
	jp	i_18
.i_17
	ld	hl,0	;const
.i_18
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys+8
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys+6
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys+4
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys+1+1
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	call	l_pint
	ld	(_key_fire),hl
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_key_jump),hl
	jp	i_13
.i_14
	ld	a,(_gpit)
	cp	#(51 % 256)
	jp	nz,i_20
	ld	hl,sp_JoyKempston
	ld	(_joyfunc),hl
	jp	i_13
.i_20
	ld	a,(_gpit)
	cp	#(52 % 256)
	jp	nz,i_22
	ld	hl,sp_JoySinclair1
	ld	(_joyfunc),hl
	jp	i_13
.i_22
.i_21
.i_19
	jp	i_12
.i_13
	ld	hl,0 % 256	;const
	call	_nosound_play_sound
	call	sp_WaitForNoKey
	ret


;	SECTION	text

._script_result
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._sc_terminado
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._sc_continuar
	defm	""
	defb	0

;	SECTION	code


	._script defw 0
;	SECTION	text

._key_z_pressed
	defm	""
	defb	0

;	SECTION	code



._draw_cursor
	ld	hl,8	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ne
	jp	nc,i_27
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_28
.i_27
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,66 % 256	;const
	push	hl
	ld	hl,62 % 256	;const
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,66 % 256	;const
	push	hl
	ld	hl,63 % 256	;const
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_28
	ret



._display_items
	ld	a,#(2 % 256 % 256)
	ld	(_its_p),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_its_it),a
	jp	i_31
.i_29
	ld	hl,_its_it
	ld	a,(hl)
	inc	(hl)
.i_31
	ld	a,(_its_it)
	cp	#(3 % 256)
	jp	z,i_30
	jp	nc,i_30
	ld	hl,(_its_p)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,#(21 % 256 % 256)
	ld	(__y),a
	ld	de,_items
	ld	hl,(_its_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_32
	ld	de,_items
	ld	hl,(_its_it)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__t),a
	jp	i_33
.i_32
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__t),a
.i_33
	call	_draw_coloured_tile
	ld	hl,(_its_it)
	ld	h,0
	push	hl
	ld	hl,(_flags+30)
	ld	h,0
	push	hl
	ld	hl,(_its_p)
	ld	h,0
	push	hl
	ld	hl,23 % 256	;const
	push	hl
	call	_draw_cursor
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_its_p)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_its_p),a
	jp	i_29
.i_30
	ret



._do_inventory_fiddling
	ld	hl,(_key_z)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_34
	ld	hl,(_key_z_pressed)
	ld	h,0
	call	l_lneg
	jp	nc,i_35
	ld	hl,2 % 256	;const
	call	_nosound_play_sound
	ld	hl,_flags+30
	push	hl
	ld	l,(hl)
	ld	h,0
	inc	hl
	ld	de,3	;const
	ex	de,hl
	call	l_div_u
	ex	de,hl
	pop	de
	ld	a,l
	ld	(de),a
	call	_display_items
.i_35
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_key_z_pressed),a
	jp	i_36
.i_34
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_key_z_pressed),a
.i_36
	ret


;	SECTION	text

._resources
	defb	3
	defw	49152
	defb	3
	defw	50584
	defb	3
	defw	51757
	defb	3
	defw	52097
	defb	3
	defw	52576
	defb	3
	defw	53129
	defb	3
	defw	53997
	defb	3
	defw	57546
	defb	3
	defw	57991
	defb	3
	defw	59853
	defb	3
	defw	60317
	defb	3
	defw	60667
	defb	3
	defw	62340
	defb	3
	defw	62786
	defb	3
	defw	63136
	defb	3
	defw	65069
	defb	4
	defw	49152
	defb	4
	defw	50955
	defb	4
	defw	51434
	defb	4
	defw	53003
	defb	4
	defw	53411
	defb	4
	defw	53774

;	SECTION	code


._get_resource
	ld	hl,_resources
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,6	;const
	add	hl,sp
	call	l_gint	;
	push	hl
	call	_unpack_RAMn
	pop	bc
	pop	bc
	pop	bc
	ret



._read_offset
	ld	hl,_ram_page
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_ram_address
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,6	;const
	add	hl,sp
	call	l_gint	;
	pop	de
	add	hl,de
	pop	de
	call	l_pint
	di
	ld a, (_ram_page)
	ld b, a
	call SetRAMBank
	ld hl, (_ram_address)
	ld de, _asm_int
	ldi
	ldi
	ld b, 0
	call SetRAMBank
	ei
	ld	hl,(_asm_int)
	ret


	._level_data
	defs 16
	._map
	defs 4 * 4 * 75
	._map_attrs
	defs 4 * 4
	._tileset
	BINARY "../bin/basicts.bin"
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_1_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_1_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_1_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_2_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_2_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_2_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_3_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_3_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_3_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_4_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_4_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_4_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_5_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_5_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_5_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_6_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_6_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_6_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_7_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_7_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_7_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_8_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_8_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_8_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_9_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_9_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_9_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_10_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_10_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_10_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_11_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_11_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_11_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_12_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_12_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_12_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_13_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_13_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_13_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_14_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_14_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_14_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_15_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_15_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_15_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_16_a
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_16_b
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_16_c
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	defb 85, 170
	._sprite_e
	defs 144 * 2
	._baddies
	defs 4 * 4 * 3 * 10
	._behs
	defs 48
	._sprite_17_a
	defb 0, 128, 56, 0, 117, 0, 123, 0, 127, 0, 57, 0, 0, 0, 96, 0, 238, 0, 95, 0, 31, 0, 62, 0, 53, 128, 42, 128, 20, 128, 0, 192, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_17_b
	defb 0, 3, 240, 1, 248, 0, 236, 0, 212, 0, 248, 0, 224, 1, 24, 0, 124, 0, 120, 0, 244, 0, 168, 0, 0, 1, 0, 3, 0, 63, 0, 127, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_17_c
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_a
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_b
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_18_c
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_19_a
	defb 0, 255
	defb 0, 195
	defb 24, 129
	defb 60, 0
	defb 60, 0
	defb 24, 129
	defb 0, 195
	defb 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_19_b
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_whip
	defb @00000000, @10000011
	defb @01111100, @00000000
	defb @10000011, @00000000
	defb @10000000, @00111100
	defb @01000000, @00011111
	defb @00000000, @10111111
	defb @00000000, @11111111
	defb @00000000, @11111111
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb @00000000, @11111101
	defb @00000010, @11111000
	defb @00000001, @00111100
	defb @11000001, @00000000
	defb @00111110, @00000000
	defb @00000000, @11000001
	defb @00000000, @11111111
	defb @00000000, @11111111
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	._sprite_shadow
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, @11110000
	defb 0, @11000000
	defb 0, @11110000
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, @00001111
	defb 0, @00000011
	defb 0, @00001111
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255, 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._arrow_sprites
	BINARY "../bin/sparrow.bin"
;	SECTION	text

._levels
	defb	8
	defb	0
	defw	49311
	defb	0
	defb	0
	defw	0
	defb	11
	defb	2
	defw	49920
	defb	0
	defb	0
	defw	0
	defb	0
	defb	0
	defw	0
	defb	14
	defb	5
	defw	50243
	defb	16
	defb	6
	defw	50722
	defb	0
	defb	0
	defw	0
	defb	0
	defb	0
	defw	0
	defb	18
	defb	9
	defw	51011

;	SECTION	code


._addons_between
	ld	hl,8	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ult
	jp	nc,i_39
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	jp	i_40
.i_39
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_40
	push	hl
	ld	hl,12	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	call	l_ule
	jp	nc,i_41
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,10	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,10-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ult
	jp	nc,i_42
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	jp	i_43
.i_42
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_43
	ex	de,hl
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	call	l_ule
	jp	nc,i_41
	ld	hl,1	;const
	jr	i_44
.i_41
	ld	hl,0	;const
.i_44
	ld	h,0
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



._cortina
	ld b, 7
	.fade_out_extern
	push bc
	ld e, 3 ; 3 tercios
	ld hl, 22528 ; aquí empiezan los atributos
	halt ; esperamos retrazo.
	.fade_out_bucle
	ld a, (hl ) ; nos traemos el atributo actual
	ld d, a ; tomar atributo
	and 7 ; aislar la tinta
	jr z, ink_done ; si vale 0, no se decrementa
	dec a ; decrementamos tinta
	.ink_done
	ld b, a ; en b tenemos ahora la tinta ya procesada.
	ld a, d ; tomar atributo
	and 56 ; aislar el papel, sin modificar su posiciÃ³n en el byte
	jr z, paper_done ; si vale 0, no se decrementa
	sub 8 ; decrementamos papel restando 8
	.paper_done
	ld c, a ; en c tenemos ahora el papel ya procesado.
	ld a, d
	and 192 ; nos quedamos con bits 6 y 7 (0x40 y 0x80)
	or c ; añadimos paper
	or b ; e ink, con lo que recompuesto el atributo
	ld (hl),a ; lo escribimos,
	inc l ; e incrementamos el puntero.
	jr nz, fade_out_bucle ; continuamos hasta acabar el tercio (cuando L valga 0)
	inc h ; siguiente tercio
	dec e
	jr nz, fade_out_bucle ; repetir las 3 veces
	pop bc
	djnz fade_out_extern
	ret



._addsign
	ld	hl,4	;const
	call	l_gintspsp	;
	ld	hl,0	;const
	pop	de
	call	l_eq
	jp	nc,i_45
	ld	hl,0	;const
	jp	i_46
.i_45
	ld	hl,4	;const
	call	l_gintspsp	;
	ld	hl,0	;const
	pop	de
	call	l_gt
	jp	nc,i_47
	pop	bc
	pop	hl
	push	hl
	push	bc
	jp	i_48
.i_47
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
.i_48
.i_46
	ret



._abs
	pop	bc
	pop	hl
	push	hl
	push	bc
	xor	a
	or	h
	jp	p,i_49
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_neg
	ret


.i_49
	pop	bc
	pop	hl
	push	hl
	push	bc
	ret


.i_50
	ret



._hide_sprites
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_51
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
	ld ix, (_sp_shadow)
	ld iy, vpClipStruct
	ld bc, 0
	ld hl, 0xfefe
	ld de, 0
	call SPMoveSprAbs
.i_51
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



._active_sleep
.i_54
	halt
	ld	a,(_p_killme)
	ld	e,a
	ld	d,0
	ld	hl,0	;const
	call	l_eq
	jp	nc,i_56
	call	_button_pressed
	ld	a,h
	or	l
	jr	nz,i_57_i_56
.i_56
	jp	i_55
.i_57_i_56
	jp	i_53
.i_55
.i_52
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	ld	a,h
	or	l
	jp	nz,i_54
.i_53
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	ret



._update_hud
	ld	hl,(_p_life)
	ld	h,0
	ex	de,hl
	ld	hl,(_life_old)
	ld	h,0
	call	l_ne
	jp	nc,i_58
	ld	a,#(26 % 256 % 256)
	ld	(__x),a
	ld	a,#(21 % 256 % 256)
	ld	(__y),a
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(__n),a
	call	_print_number2
	ld	hl,(_p_life)
	ld	h,0
	ld	a,l
	ld	(_life_old),a
.i_58
	ret


;	SECTION	text

._spacer
	defw	i_1+0
;	SECTION	code


._print_number2
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,7 % 256	;const
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,7 % 256	;const
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ret



._draw_coloured_tile
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	l,#(2 % 256)
	call	l_asl
	ld	de,64
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__n),a
	ld	de,_tileset+2048
	ld	hl,(__n)
	ld	h,0
	add	hl,de
	ld	(_gen_pt),hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gen_pt)
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(__n)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_gen_pt)
	inc	hl
	ld	(_gen_pt),hl
	ld	hl,(__n)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(__n),a
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gen_pt)
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(__n)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_gen_pt)
	inc	hl
	ld	(_gen_pt),hl
	ld	hl,(__n)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(__n),a
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gen_pt)
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(__n)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_gen_pt)
	inc	hl
	ld	(_gen_pt),hl
	ld	hl,(__n)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(__n),a
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gen_pt)
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(__n)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ret



._draw_coloured_tile_gamearea
	ld	a,(__x)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,1
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(__y)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,1
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_draw_coloured_tile
	ret



._print_str
.i_60
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a,(hl)
	and	a
	jp	z,i_61
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,__x
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(__t)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
	ld	h,(hl)
	ld	l,a
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_60
.i_61
	ret



._blackout_area
	ld	hl,22561	;const
	ld	(_asm_int),hl
	ld hl, _asm_int
	ld a, (hl)
	ld e, a
	inc hl
	ld a, (hl)
	ld d, a
	ld b, 20
	.bal1
	push bc
	push de
	pop hl
	ld (hl), 0
	inc de
	ld bc, 29
	ldir
	inc de
	inc de
	pop bc
	djnz bal1
	ret


;	SECTION	text

._utaux
	defm	""
	defb	0

;	SECTION	code



._update_tile
	ld	a,(__y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ex	de,hl
	ld	hl,(__x)
	ld	h,0
	call	l_or
	ld	h,0
	ld	a,l
	ld	(_utaux),a
	ld	de,_map_attr
	ld	hl,(_utaux)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,__n
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_map_buff
	ld	hl,(_utaux)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,__t
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_draw_coloured_tile_gamearea
	ret



._print_message
	ld	a,#(79 % 256 % 256)
	ld	(__t),a
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(11 % 256 % 256)
	ld	(__y),a
	ld	hl,(_spacer)
	push	hl
	call	_print_str
	pop	bc
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_print_str
	pop	bc
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(13 % 256 % 256)
	ld	(__y),a
	ld	hl,(_spacer)
	push	hl
	call	_print_str
	pop	bc
	call	sp_UpdateNow
	call	sp_WaitForNoKey
	ret



._button_pressed
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_63
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_64
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_64
	pop	bc
	ld	de,128	;const
	ex	de,hl
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_63
	ld	hl,0	;const
	jr	i_65
.i_63
	ld	hl,1	;const
.i_65
	ld	h,0
	ret



._load_subtileset
	ld	hl,(__t)
	ld	h,0
	push	hl
	ld	hl,0	;const
	push	hl
	call	_read_offset
	pop	bc
	pop	bc
	ld	(_offs_attr),hl
	ld	hl,(__t)
	ld	h,0
	push	hl
	ld	hl,2	;const
	push	hl
	call	_read_offset
	pop	bc
	pop	bc
	ld	(_offs_behs),hl
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	call	l_gint	;
	ld	bc,4
	add	hl,bc
	push	hl
	ld	hl,_tileset
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	l,#(9 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	bc,512
	add	hl,bc
	push	hl
	call	_unpack_RAMn
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_offs_attr)
	add	hl,de
	push	hl
	ld	hl,_tileset
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	bc,2112
	add	hl,bc
	push	hl
	call	_unpack_RAMn
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_resources
	push	hl
	ld	hl,(__t)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_offs_behs)
	add	hl,de
	push	hl
	ld	hl,_behs
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	call	_unpack_RAMn
	pop	bc
	pop	bc
	pop	bc
	ret



._print_digitH
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	cp	#(10 % 256)
	jp	z,i_66
	jp	nc,i_66
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,7 % 256	;const
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,16
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_67
.i_66
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,7 % 256	;const
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,23
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_67
	ret



._print_numberH
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	push	hl
	call	_print_digitH
	pop	bc
	pop	bc
	pop	bc
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	a,(hl)
	and	#(15 % 256)
	ld	l,a
	ld	h,0
	push	hl
	call	_print_digitH
	pop	bc
	pop	bc
	pop	bc
	ret



._draw_scr_background
	ld hl, (_n_pant)
	ld h, 0
	ld (rnd + 1),hl
	ld hl, (_level)
	ld h, 0
	ld (rnd + 4),hl
	ld	hl,_map
	push	hl
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	ld	(_map_pointer),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_rdy),a
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	h,0
	ld	a,l
	ld	(_gpit),a
	xor a
	ld (_rdx), a
	ld (_rdy), a
	ld (_gpjt), a
	.draw_scr_background_loop
	ld (_gpit), a
	ld c, a
	ld a, (_gpjt)
	and 1
	jr z, draw_scr_background_new_byte
	ld a, (_rdc)
	and 15
	jr draw_scr_background_set_t
	.draw_scr_background_new_byte
	ld hl, (_map_pointer)
	ld a, (hl)
	inc hl
	ld (_map_pointer), hl
	ld (_rdc), a
	srl a
	srl a
	srl a
	srl a
	.draw_scr_background_set_t
	ld (__t), a
	ld b, 0 ; BC = gpit
	ld hl, _map_buff
	add hl, bc
	ld (hl), a
	ld hl, _map_attr
	add hl, bc
	ex de, hl ; DE = map_attr [gpit]
	ld c, a ; BC = _t
	ld hl, _behs
	add hl, bc ; HL = behs [_t]
	ldi ; Corrupts BC!
	ld a, (_rdx)
	ld (__x), a
	ld a, (_rdy)
	ld (__y), a
	call _draw_coloured_tile_gamearea
	ld a, (_rdx)
	inc a
	cp 15
	jr nz, draw_scr_background_continue
	ld hl, _gpit ; Skip one as buffers are 16 tiles wide
	inc (hl)
	ld hl, _rdy
	inc (hl)
	xor a
	.draw_scr_background_continue
	ld (_rdx), a
	ld a, (_gpjt)
	inc a
	ld (_gpjt), a
	ld a, (_gpit)
	inc a
	cp 160
	jr nz, draw_scr_background_loop
	ret



._draw_scr
	ld	hl,(_cur_map_attr)
	ld	h,0
	push	hl
	ld	de,_map_attrs
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	call	l_ne
	jp	nc,i_68
	ld	de,_map_attrs
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_cur_map_attr),a
	and	a
	jp	z,i_69
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,(_cur_map_attr)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__t),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(__n),a
	call	_load_subtileset
.i_69
.i_68
	ld	a,(_no_draw)
	and	a
	jp	z,i_70
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_no_draw),a
	jp	i_71
.i_70
	call	_draw_scr_background
.i_71
	ld	a,#(0 % 256 % 256)
	ld	(_f_zone_ac),a
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffs),a
	ld	a,#(1 % 256 % 256)
	ld	(_do_respawn),a
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data)
	ld	h,0
	call	l_div_u
	ex	de,hl
	ld	h,0
	ld	a,l
	ld	(_x_pant),a
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data)
	ld	h,0
	call	l_div_u
	ld	h,0
	ld	a,l
	ld	(_y_pant),a
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_p_safe_pant),a
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_p_safe_x),a
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_p_safe_y),a
	ret


	._k2t_menu_text
	defm "000233"
	defm "001001"
	defm "003322"
	defm "005992"
	defm "006800"
	defm "010000"
	defm "050000"
	defm "THRUST"
	._k2t_code
	defb 0
;	SECTION	text

._k2t_flag
	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._k2t_is_cutscene
	defm	""
	defb	0

;	SECTION	code



._k2t_tint_middle_third
	; fastcall. Parameter is in L
	ld a, l
	ld hl, $5900
	ld de, $5901
	ld bc, $fe
	ld (hl), a
	ldir
	ret



._k2t_tint
	ld a, l
	ld de, 22561
	ld b, 20
	halt
	.k2t_bal1
	push bc
	push de
	pop hl
	ld (hl), a
	inc de
	ld bc, 29
	ldir
	inc de
	inc de
	pop bc
	djnz k2t_bal1
	ret



._k2t_print_limited_text
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_76
.i_74
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_76
	ld	hl,(_k2t_i)
	ld	h,0
	ex	de,hl
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ult
	jp	nc,i_75
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	dec	l
	push	hl
	ld	hl,71 % 256	;const
	push	hl
	ld	hl,(_k2t_gpp)
	inc	hl
	ld	(_k2t_gpp),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_74
.i_75
	ret



._k2t_show_time_prx_pry
	ld	hl,_k2t_menu_text
	push	hl
	ld	hl,(_flags+127)
	ld	h,0
	ld	de,6
	call	l_mult
	pop	de
	add	hl,de
	ld	(_k2t_gpp),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_79
.i_77
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_79
	ld	a,(_k2t_i)
	cp	#(6 % 256)
	jp	z,i_78
	jp	nc,i_78
	ld	hl,(_pry)
	ld	h,0
	push	hl
	ld	hl,(_prx)
	ld	h,0
	ex	de,hl
	ld	hl,(_k2t_i)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,(_gpt)
	ld	h,0
	push	hl
	ld	hl,(_k2t_gpp)
	inc	hl
	ld	(_k2t_gpp),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_77
.i_78
	ret



._k2t_show_time
	ld	a,#(0 % 256 % 256)
	ld	(_pry),a
	ld	a,#(13 % 256 % 256)
	ld	(_prx),a
	ld	hl,42 % 256	;const
	ld	a,l
	ld	(_gpt),a
	call	_k2t_show_time_prx_pry
	ret



._k2t_cls
	ld	hl,0 % 256	;const
	push	hl
	call	_hide_sprites
	pop	bc
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_82
.i_80
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_82
	ld	a,(_k2t_i)
	cp	#(10 % 256)
	jp	z,i_81
	jp	nc,i_81
	ld	hl,(_k2t_i)
	ld	h,0
	ld	a,l
	ld	(_k2t_x),a
	jp	i_85
.i_83
	ld	hl,(_k2t_x)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_x),a
.i_85
	ld	hl,(_k2t_x)
	ld	h,0
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,30
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_ult
	jp	nc,i_84
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,(_k2t_x)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,20
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	push	hl
	ld	hl,(_k2t_x)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_k2t_x)
	ld	h,0
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,19
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_ult
	jp	nc,i_86
	ld	hl,(_k2t_x)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_k2t_x)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,30
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_86
	jp	i_83
.i_84
	halt
	call	sp_UpdateNow
	jp	i_80
.i_81
	ret



._k2t_effect
	ld	hl,(_flags+127)
	ld	h,0
	ex	de,hl
	ld	hl,(_k2t_time)
	ld	h,0
	call	l_eq
	jp	nc,i_87
	ret


.i_87
	ld	hl,(_flags+127)
	ld	h,0
	ld	a,l
	ld	(_k2t_time),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_90
.i_88
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_90
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	hl,16	;const
	call	l_ult
	jp	nc,i_89
	call	_rand
	ld	de,7	;const
	ex	de,hl
	call	l_and
	ld	h,0
	call	_k2t_tint
	jp	i_88
.i_89
	ret



._k2t_menu_display
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	de,7
	add	hl,de
	ld	de,6
	call	l_mult
	ld	h,0
	ld	a,l
	ld	(_k2t_length),a
	ld	hl,_k2t_menu_text
	ld	(_k2t_ptr),hl
	ld	a,#(13 % 256 % 256)
	ld	(_k2t_x),a
	ld	a,#(7 % 256 % 256)
	ld	(_k2t_y),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_93
.i_91
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_93
	ld	hl,(_k2t_i)
	ld	h,0
	ex	de,hl
	ld	hl,(_k2t_length)
	ld	h,0
	call	l_ult
	jp	nc,i_92
	ld	a,(_k2t_x)
	cp	#(13 % 256)
	jp	nz,i_94
	ld	hl,(_k2t_y)
	ld	h,0
	ld	bc,-7
	add	hl,bc
	ex	de,hl
	ld	hl,(_k2t_selected)
	ld	h,0
	call	l_eq
	jp	nc,i_95
	ld	hl,120 % 256	;const
	ld	a,l
	ld	(_k2t_color),a
	jp	i_96
.i_95
	ld	hl,71 % 256	;const
	ld	a,l
	ld	(_k2t_color),a
.i_96
.i_94
	ld	hl,(_k2t_y)
	ld	h,0
	push	hl
	ld	hl,_k2t_x
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(_k2t_color)
	ld	h,0
	push	hl
	ld	hl,(_k2t_ptr)
	inc	hl
	ld	(_k2t_ptr),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	a,(_k2t_x)
	cp	#(19 % 256)
	jp	nz,i_97
	ld	a,#(13 % 256 % 256)
	ld	(_k2t_x),a
	ld	hl,(_k2t_y)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_y),a
.i_97
	jp	i_91
.i_92
	ret



._k2t_do_menu
	ld	hl,6 % 256	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	call	_k2t_show_time
	call	_update_hud
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_k2t_selected),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_98
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_k2t_menu_display
	pop	bc
	call	sp_UpdateNow
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_100
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_100
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_k2t_i),a
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_102
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_102
	ld	hl,0	;const
	jr	i_103
.i_102
	ld	hl,1	;const
.i_103
	ld	a,h
	or	l
	jp	nz,i_101
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_101
	ld	hl,_k2t_i
	ld	a,(hl)
	rrca
	jp	c,i_104
	ld	a,(_k2t_last_key)
	and	a
	jp	z,i_105
	ld	a,(_k2t_selected)
	and	a
	jp	z,i_106
	ld	hl,(_k2t_selected)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_k2t_selected),a
.i_106
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_105
.i_104
	ld	hl,_k2t_i
	ld	a,(hl)
	and	#(2 % 256)
	jp	nz,i_107
	ld	a,(_k2t_last_key)
	and	a
	jp	z,i_108
	ld	hl,(_k2t_selected)
	ld	h,0
	push	hl
	ld	hl,(_k2t_selected)
	ld	h,0
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	de,6
	add	hl,de
	pop	de
	call	l_ult
	ld	hl,0	;const
	rl	l
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_k2t_selected),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_108
.i_107
	ld	hl,_k2t_i
	ld	a,(hl)
	rlca
	jp	c,i_109
	ld	hl,(_k2t_selected)
	ld	h,0
	ret


.i_109
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_110
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ret


.i_110
	jp	i_98
.i_99
	call	_k2t_cls
	ret



._k2t_display_portrait
	ld	hl,_asm_int
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	de,192
	call	l_mult
	ld	de,49876
	add	hl,de
	pop	de
	call	l_pint
	; Display a 192 bytes portrait.
	; Set RAM page with texts file
	halt
	halt
	di
	ld b, 6
	call SetRAMBank
	ld a, (_asm_int)
	ld l, a
	ld a, (_asm_int + 1)
	ld h, a
	ld de, 18465
	ld b, 8
	.ptpl1
	ld c, b
	ld b, 6
	push de
	.ptpl2
	push bc
	ldi
	ldi
	ldi
	ldi
	ex de, hl
	ld bc, 28
	add hl, bc
	ex de, hl
	pop bc
	djnz ptpl2
	pop de
	inc d
	ld b, c
	djnz ptpl1
	; Page back RAM 0
	ld b, 0
	call SetRAMBank
	ei
	; Paint white
	ld a, 71
	ld b, 6
	ld hl, 22817
	.ptpl3
	ld (hl), a
	inc l
	ld (hl), a
	inc l
	ld (hl), a
	inc l
	ld (hl), a
	ld d, b
	ld bc, 29
	add hl, bc
	ld b, d
	djnz ptpl3
	ret



._k2t_show_text
	ld	a,#(1 % 256 % 256)
	ld	(_k2t_stepbystep),a
	ld	hl,_asm_int
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_gint	;
	dec	hl
	add	hl,hl
	pop	de
	call	l_pint
	; Set RAM page with texts file
	halt
	halt
	di
	ld b, 6
	call SetRAMBank
	; First we get where to look for the packed string
	ld a, (_asm_int)
	ld e, a
	ld a, (_asm_int + 1)
	ld d, a
	; Index is at $C000 in selected page.
	ld hl, $C000
	add hl, de
	ld c, (hl)
	inc hl
	ld b, (hl)
	push bc
	pop hl
	; HL = Address of text line.
	; Read first byte (code) and store it.
	ld a, (hl)
	inc hl
	ld (_k2t_code), a
	; Write to buffer
	ld de, 24200-256-168
	; 5-bit scaped depacker by na_th_an
	; Contains code by Antonio Villena
	ld a, $80
	.fbsd_mainb
	call fbsd_unpackc
	ld c, a
	ld a, b
	and a
	jr z, fbsd_fin
	call fbsd_stor
	ld a, c
	jr fbsd_mainb
	.fbsd_stor
	cp 31
	jr z, fbsd_escaped
	add a, 64
	jr fbsd_stor2
	.fbsd_escaped
	ld a, c
	call fbsd_unpackc
	ld c, a
	ld a, b
	add a, 32
	.fbsd_stor2
	ld (de), a
	inc de
	ret
	.fbsd_unpackc
	ld b, 0x08
	.fbsd_bucle
	call fbsd_getbit
	rl b
	jr nc, fbsd_bucle
	ret
	.fbsd_getbit
	add a, a
	ret nz
	ld a, (hl)
	inc hl
	rla
	ret
	.fbsd_fin
	ld (de), a
	; Page back RAM 0
	ld b, 0
	call SetRAMBank
	ei
	ld	hl,0 % 256	;const
	push	hl
	call	_hide_sprites
	pop	bc
	call	sp_UpdateNow
	ld	a,(_k2t_is_cutscene)
	and	a
	jp	nz,i_111
	ld	hl,(_k2t_last_character)
	ld	h,0
	ex	de,hl
	ld	hl,(_k2t_code)
	ld	h,0
	call	l_ne
	jp	nc,i_112
	ld	hl,(_k2t_code)
	ld	h,0
	ld	a,l
	ld	(_k2t_last_character),a
	ld	hl,0 % 256	;const
	call	_k2t_tint_middle_third
	ld	a,(_k2t_last_character)
	cp	#(255 % 256)
	jp	nz,i_113
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,18432	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,65 % 256	;const
	call	_k2t_tint_middle_third
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_k2t_x0),a
	jp	i_114
.i_113
	ld	hl,4 % 256	;const
	push	hl
	ld	hl,18432	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,65 % 256	;const
	call	_k2t_tint_middle_third
	ld	hl,(_k2t_last_character)
	ld	h,0
	push	hl
	call	_k2t_display_portrait
	pop	bc
	ld	hl,7 % 256	;const
	ld	a,l
	ld	(_k2t_x0),a
.i_114
.i_112
	ld	hl,9 % 256	;const
	ld	a,l
	ld	(_k2t_y),a
	jp	i_115
.i_111
	ld	a,#(13 % 256 % 256)
	ld	(_k2t_y),a
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_k2t_x0),a
.i_115
	ld	hl,10	;const
	push	hl
	call	_active_sleep
	pop	bc
	ld	hl,(_k2t_x0)
	ld	h,0
	ld	a,l
	ld	(_k2t_x),a
	ld	hl,23777	;const
	ld	(_k2t_gpp),hl
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_116
	ld	hl,(_k2t_gpp)
	inc	hl
	ld	(_k2t_gpp),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_k2t_i),a
	ld	a,h
	or	l
	jp	z,i_117
	ld	a,(_k2t_i)
	cp	#(37 % 256)
	jp	nz,i_118
	ld	hl,(_k2t_x0)
	ld	h,0
	ld	a,l
	ld	(_k2t_x),a
	ld	hl,(_k2t_y)
	ld	h,0
	push	hl
	ld	hl,(_k2t_is_cutscene)
	ld	h,0
	ld	de,1
	add	hl,de
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_k2t_y),a
	jp	i_119
.i_118
	ld	hl,(_k2t_y)
	ld	h,0
	push	hl
	ld	hl,(_k2t_x)
	ld	h,0
	push	hl
	ld	hl,71 % 256	;const
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_k2t_x)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_x),a
.i_119
	ld	hl,(_k2t_stepbystep)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_120
	halt
	ld	a,(_k2t_i)
	cp	#(32 % 256)
	jp	z,i_122
	ld	a,(_k2t_is_cutscene)
	cp	#(0 % 256)
	jr	z,i_123_i_122
.i_122
	jp	i_121
.i_123_i_122
	ld	hl,10 % 256	;const
	call	_nosound_play_sound
.i_121
	halt
	halt
	call	sp_UpdateNow
.i_120
	call	_button_pressed
	ld	a,h
	or	l
	jp	z,i_124
	ld	a,(_k2t_last_key)
	and	a
	jp	nz,i_125
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_stepbystep),a
.i_125
	jp	i_126
.i_124
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_126
	jp	i_116
.i_117
	call	sp_UpdateNow
	call	sp_WaitForNoKey
.i_127
	call	_button_pressed
	ld	a,h
	or	l
	jp	nz,i_127
.i_128
	ld	hl,5000	;const
	push	hl
	call	_active_sleep
	pop	bc
	ld	a,(_k2t_is_cutscene)
	and	a
	jp	z,i_129
	ld	hl,11 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_132
.i_130
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_132
	ld	a,(_k2t_i)
	cp	#(24 % 256)
	jp	z,i_131
	jp	nc,i_131
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	hl,(_k2t_i)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	a,#(71 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+13
	push	hl
	call	_print_str
	pop	bc
	call	sp_UpdateNow
	jp	i_130
.i_131
	jp	i_133
.i_129
	ld	hl,9 % 256	;const
	ld	a,l
	ld	(_k2t_y),a
	jp	i_136
.i_134
	ld	hl,(_k2t_y)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_y),a
.i_136
	ld	a,(_k2t_y)
	cp	#(14 % 256)
	jr	z,i_135_ule
	jp	nc,i_135
.i_135_ule
	ld	hl,(_k2t_x0)
	ld	h,0
	ld	a,l
	ld	(_k2t_x),a
	jp	i_139
.i_137
	ld	hl,(_k2t_x)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_x),a
.i_139
	ld	a,(_k2t_x)
	cp	#(29 % 256)
	jr	z,i_138_ule
	jp	nc,i_138
.i_138_ule
	ld	hl,(_k2t_y)
	ld	h,0
	push	hl
	ld	hl,(_k2t_x)
	ld	h,0
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_137
.i_138
	jp	i_134
.i_135
.i_133
	call	sp_UpdateNow
	ret



._k2t_init
	ld	a,#(254 % 256 % 256)
	ld	(_k2t_last_character),a
	ld	a,#(0 % 256 % 256)
	ld	(_k2t_cursor),a
	ld	hl,(_flags+127)
	ld	h,0
	ld	a,l
	ld	(_k2t_time),a
	ret



._k2t_end_of_conversation
	call	_k2t_init
	ret



._k2t_show_items
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_i),a
	jp	i_142
.i_140
	ld	hl,(_k2t_i)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_k2t_i),a
.i_142
	ld	a,(_k2t_i)
	cp	#(7 % 256)
	jp	z,i_141
	jp	nc,i_141
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,6
	add	hl,de
	ex	de,hl
	ld	hl,(_k2t_i)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,#(9 % 256 % 256)
	ld	(__y),a
	ld	hl,_flags
	push	hl
	ld	hl,(_k2t_i)
	ld	h,0
	ld	de,120
	add	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__n),a
	call	_draw_coloured_tile
	ld	hl,(_k2t_i)
	ld	h,0
	push	hl
	ld	hl,(_k2t_cursor)
	ld	h,0
	push	hl
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	ld	de,6
	add	hl,de
	ex	de,hl
	ld	hl,(_k2t_i)
	ld	h,0
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,11 % 256	;const
	push	hl
	call	_draw_cursor
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_140
.i_141
	ret



._k2t_storage
	ld	hl,0 % 256	;const
	push	hl
	call	_hide_sprites
	pop	bc
	call	sp_UpdateNow
	ld	hl,0 % 256	;const
	call	_k2t_tint_middle_third
	ld	hl,5 % 256	;const
	push	hl
	ld	hl,18432	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,65 % 256	;const
	call	_k2t_tint_middle_third
	ld	a,#(1 % 256 % 256)
	ld	(_k2t_last_key),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_k2t_flag),a
.i_143
	ld	hl,(_k2t_flag)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_144
	call	_k2t_show_items
	call	_display_items
	ld	hl,_flags
	push	hl
	ld	hl,(_k2t_cursor)
	ld	h,0
	ld	de,120
	add	hl,de
	pop	de
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_145
	ld	hl,_flags
	push	hl
	ld	hl,(_k2t_cursor)
	ld	h,0
	ld	de,120
	add	hl,de
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_k2t_i),a
	ld	hl,_asm_int
	push	hl
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	l,#(6 % 256)
	call	l_asl
	ld	de,50260
	add	hl,de
	push	hl
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	pop	de
	call	l_pint
	jp	i_146
.i_145
	ld	hl,51540	;const
	ld	(_asm_int),hl
.i_146
	di
	ld b, 6
	call SetRAMBank
	ld a, (_asm_int)
	ld l, a
	ld a, (_asm_int + 1)
	ld h, a
	ld de, 24200-256-168
	ld bc, 80
	ldir
	ld b, 0
	call SetRAMBank
	ei
	ld	hl,23776	;const
	ld	(_k2t_gpp),hl
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,12 % 256	;const
	push	hl
	ld	hl,24 % 256	;const
	push	hl
	call	_k2t_print_limited_text
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,13 % 256	;const
	push	hl
	ld	hl,28 % 256	;const
	push	hl
	call	_k2t_print_limited_text
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,14 % 256	;const
	push	hl
	ld	hl,28 % 256	;const
	push	hl
	call	_k2t_print_limited_text
	pop	bc
	pop	bc
	pop	bc
.i_147
	call	sp_UpdateNow
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_149
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_149
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_k2t_i),a
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_151
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	hl,8	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_151
	ld	a,(_k2t_i)
	ld	e,a
	ld	d,0
	ld	hl,128	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_151
	ld	hl,0	;const
	jr	i_152
.i_151
	ld	hl,1	;const
.i_152
	call	l_lneg
	jp	nc,i_150
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
.i_150
	ld	hl,_k2t_i
	ld	a,(hl)
	and	#(4 % 256)
	jp	nz,i_153
	ld	a,(_k2t_last_key)
	and	a
	jp	z,i_154
	ld	a,(_k2t_cursor)
	and	a
	jp	z,i_155
	ld	hl,(_k2t_cursor)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_k2t_cursor),a
	jp	i_156
.i_155
	ld	hl,6 % 256	;const
	ld	a,l
	ld	(_k2t_cursor),a
.i_156
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
	jp	i_148
.i_154
.i_153
	ld	hl,_k2t_i
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_157
	ld	a,(_k2t_last_key)
	and	a
	jp	z,i_158
	ld	hl,(_k2t_cursor)
	ld	h,0
	inc	hl
	ld	de,7	;const
	ex	de,hl
	call	l_div_u
	ex	de,hl
	ld	h,0
	ld	a,l
	ld	(_k2t_cursor),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
	jp	i_148
.i_158
.i_157
	call	_do_inventory_fiddling
	ld	hl,_k2t_i
	ld	a,(hl)
	rlca
	jp	c,i_159
	ld	a,(_k2t_last_key)
	and	a
	jp	z,i_160
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_k2t_i),a
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_flags
	push	hl
	ld	hl,(_k2t_cursor)
	ld	h,0
	ld	de,120
	add	hl,de
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_flags
	push	hl
	ld	hl,(_k2t_cursor)
	ld	h,0
	ld	de,120
	add	hl,de
	pop	de
	add	hl,de
	push	hl
	ld	hl,_k2t_i
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_last_key),a
	jp	i_148
.i_160
.i_159
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_161
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_k2t_flag),a
	jp	i_148
.i_161
	jp	i_147
.i_148
	jp	i_143
.i_144
	ret



._do_extern_action
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	cp	#(4 % 256)
	jp	z,i_162
	jp	nc,i_162
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	l,#(8 % 256)
	call	l_asl
	ex	de,hl
	ld	hl,4-2	;const
	add	hl,sp
	call	l_gint	;
	add	hl,de
	push	hl
	call	_k2t_show_text
	pop	bc
	jp	i_163
.i_162
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_166
	ld	a,l
	cp	#(240% 256)
	jp	z,i_167
	cp	#(241% 256)
	jp	z,i_168
	cp	#(242% 256)
	jp	z,i_169
	cp	#(243% 256)
	jp	z,i_170
	cp	#(244% 256)
	jp	z,i_171
	cp	#(245% 256)
	jp	z,i_172
	cp	#(255% 256)
	jp	z,i_173
	jp	i_165
.i_167
	call	_k2t_end_of_conversation
	jp	i_165
.i_168
	call	_k2t_storage
	jp	i_165
.i_169
	ld	hl,_flags+127
	push	hl
	ld	hl,(_flags+10)
	ld	h,0
	push	hl
	ld	hl,(_flags+127)
	ld	h,0
	push	hl
	call	_k2t_do_menu
	pop	bc
	pop	bc
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_165
.i_170
	call	_k2t_cls
	jp	i_165
.i_171
	call	_k2t_show_time
	jp	i_165
.i_172
	call	_k2t_effect
	jp	i_165
.i_173
	call	_k2t_init
.i_165
.i_163
	ret



._read_byte
	dec	sp
	di
	ld b, 7
	call SetRAMBank
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,(_script)
	inc	hl
	ld	(_script),hl
	dec	hl
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	ld b, 0
	call SetRAMBank
	ei
	ld	hl,0	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	sp
	ret



._read_vbyte
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_c),a
	ld	hl,_sc_c
	ld	a,(hl)
	rlca
	jp	nc,i_174
	ld	hl,_flags
	push	hl
	ld	a,(_sc_c)
	ld	e,a
	ld	d,0
	ld	hl,127	;const
	call	l_and
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	jp	i_175
.i_174
	ld	hl,(_sc_c)
	ld	h,0
.i_175
	ld	h,0
	ret



._readxy
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_sc_y),a
	ret



._stop_player
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ret



._reloc_player
	call	_read_vbyte
	ld	h,l
	ld	l,0
	ld	(_p_x),hl
	call	_read_vbyte
	ld	h,l
	ld	l,0
	ld	(_p_y),hl
	call	_stop_player
	ret



._run_script
	ld	hl,_asm_int
	push	hl
	ld	de,(_main_script_offset)
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	call	l_pint
	di
	ld b, 7
	call SetRAMBank
	ld hl, (_asm_int)
	ld a, (hl)
	ld (_asm_int_2), a
	inc hl
	ld a, (hl)
	ld (_asm_int_2 + 1), a
	ld	hl,(_asm_int_2)
	ld	(_script),hl
	ld b, 0
	call SetRAMBank
	ei
	ld	hl,(_script)
	ld	a,h
	or	l
	jp	nz,i_176
	ret


.i_176
	ld	de,(_script)
	ld	hl,(_main_script_offset)
	add	hl,de
	ld	(_script),hl
	ld	hl,_flags+31
	push	hl
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
.i_177
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_c),a
	ld	de,255	;const
	ex	de,hl
	call	l_ne
	jp	nc,i_178
	ld	de,(_script)
	ld	hl,(_sc_c)
	ld	h,0
	add	hl,de
	ld	(_next_script),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_sc_continuar),a
	ld	h,0
	ld	a,l
	ld	(_sc_terminado),a
.i_179
	ld	hl,(_sc_terminado)
	ld	h,0
	call	l_lneg
	jp	nc,i_180
	call	_read_byte
.i_183
	ld	a,l
	cp	#(16% 256)
	jp	z,i_184
	cp	#(32% 256)
	jp	z,i_185
	cp	#(33% 256)
	jp	z,i_188
	cp	#(34% 256)
	jp	z,i_191
	cp	#(240% 256)
	jp	z,i_194
	cp	#(255% 256)
	jp	z,i_195
	jp	i_182
.i_184
	call	_readxy
	ld	de,_flags
	ld	hl,(_sc_x)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,(_sc_y)
	ld	h,0
	call	l_ne
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_sc_terminado),a
	jp	i_182
.i_185
	call	_readxy
	ld	a,(_sc_x)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	ld	a,(_sc_y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_sc_y),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	hl,(_sc_x)
	ld	h,0
	call	l_uge
	jp	nc,i_186
	ld	hl,(_prx)
	ld	h,0
	push	hl
	ld	hl,(_sc_x)
	ld	h,0
	ld	bc,7
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_186
	ld	hl,(_pry)
	ld	h,0
	ld	bc,29
	add	hl,bc
	ex	de,hl
	ld	hl,(_sc_y)
	ld	h,0
	call	l_uge
	jp	nc,i_186
	ld	hl,(_pry)
	ld	h,0
	push	hl
	ld	hl,(_sc_y)
	ld	h,0
	inc	hl
	pop	de
	call	l_ule
	jp	nc,i_186
	ld	hl,1	;const
	jr	i_187
.i_186
	ld	hl,0	;const
.i_187
	ld	de,0
	call	l_eq
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_sc_terminado),a
	jp	i_182
.i_188
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_y),a
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ex	de,hl
	ld	hl,(_sc_x)
	ld	h,0
	call	l_ge
	jp	nc,i_189
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ex	de,hl
	ld	hl,(_sc_y)
	ld	h,0
	call	l_le
	jp	nc,i_189
	ld	hl,1	;const
	jr	i_190
.i_189
	ld	hl,0	;const
.i_190
	call	l_lneg
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_sc_terminado),a
	jp	i_182
.i_191
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_y),a
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ex	de,hl
	ld	hl,(_sc_x)
	ld	h,0
	call	l_ge
	jp	nc,i_192
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ex	de,hl
	ld	hl,(_sc_y)
	ld	h,0
	call	l_le
	jp	nc,i_192
	ld	hl,1	;const
	jr	i_193
.i_192
	ld	hl,0	;const
.i_193
	call	l_lneg
	ld	hl,0	;const
	rl	l
	ld	h,0
	ld	a,l
	ld	(_sc_terminado),a
.i_194
	jp	i_182
.i_195
	ld	a,#(1 % 256 % 256)
	ld	(_sc_terminado),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_sc_continuar),a
.i_182
	jp	i_179
.i_180
	ld	a,(_sc_continuar)
	and	a
	jp	z,i_196
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_sc_terminado),a
.i_197
	ld	hl,(_sc_terminado)
	ld	h,0
	call	l_lneg
	jp	nc,i_198
	call	_read_byte
.i_201
	ld	a,l
	cp	#(0% 256)
	jp	z,i_202
	cp	#(1% 256)
	jp	z,i_203
	cp	#(81% 256)
	jp	z,i_204
	cp	#(104% 256)
	jp	z,i_205
	cp	#(105% 256)
	jp	z,i_206
	cp	#(110% 256)
	jp	z,i_207
	cp	#(130% 256)
	jp	z,i_212
	cp	#(225% 256)
	jp	z,i_213
	cp	#(232% 256)
	jp	z,i_214
	cp	#(229% 256)
	jp	z,i_215
	cp	#(244% 256)
	jp	z,i_218
	cp	#(255% 256)
	jp	z,i_221
	jp	i_200
.i_202
	call	_readxy
	ld	de,_items
	ld	hl,(_sc_x)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_sc_y
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_display_items
	jp	i_200
.i_203
	call	_readxy
	ld	de,_flags
	ld	hl,(_sc_x)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_sc_y
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	jp	i_200
.i_204
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_fzx1),a
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_fzy1),a
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_fzx2),a
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_fzy2),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_f_zone_ac),a
	jp	i_200
.i_205
	call	_reloc_player
	jp	i_200
.i_206
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_warp_to_level),a
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,99 % 256	;const
	ld	a,l
	ld	(_o_pant),a
	call	_reloc_player
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_silent_level),a
	ld	a,#(1 % 256 % 256)
	ld	(_sc_terminado),a
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_script_result),a
	ret


.i_207
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_sc_y),a
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_sc_c),a
	jp	i_210
.i_208
	ld	hl,_sc_c
	ld	a,(hl)
	inc	(hl)
.i_210
	ld	a,(_sc_c)
	cp	#(160 % 256)
	jp	z,i_209
	jp	nc,i_209
	ld	hl,(_sc_x)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	hl,(_sc_y)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	de,_map_attr
	ld	hl,(_sc_c)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__n),a
	ld	de,_map_buff
	ld	hl,(_sc_c)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_update_tile
	ld	hl,_sc_x
	ld	a,(hl)
	inc	(hl)
	ld	a,(_sc_x)
	cp	#(15 % 256)
	jp	nz,i_211
	ld	a,#(0 % 256 % 256)
	ld	(_sc_x),a
	ld	hl,_sc_y
	ld	a,(hl)
	inc	(hl)
	ld	hl,_sc_c
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
.i_211
	jp	i_208
.i_209
	call	_FO_paint_all
	jp	i_200
.i_212
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_n),a
	call	_readxy
	ld	hl,(_sc_x)
	ld	h,0
	push	hl
	ld	hl,(_sc_y)
	ld	h,0
	push	hl
	ld	hl,(_sc_n)
	ld	h,0
	push	hl
	call	_FO_add
	pop	bc
	pop	bc
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_sc_m),a
	ld	hl,(_sc_m)
	ld	h,0
	push	hl
	call	_FO_paint
	pop	bc
	jp	i_200
.i_213
	call	sp_UpdateNow
	jp	i_200
.i_214
	call	_read_byte
	ld	h,0
	push	hl
	call	_read_byte
	push	hl
	call	_do_extern_action
	pop	bc
	pop	bc
	jp	i_200
.i_215
	call	_read_vbyte
	ld	h,0
	ld	a,l
	ld	(_sc_n),a
.i_216
	ld	hl,_sc_n
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_217
	halt
	jp	i_216
.i_217
	jp	i_200
.i_218
.i_219
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_x),a
	ld	de,255
	call	l_ne
	jp	nc,i_220
	call	_read_byte
	ld	h,0
	ld	a,l
	ld	(_sc_n),a
	ld	a,(_sc_x)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(_sc_x)
	ld	e,a
	ld	d,0
	ld	hl,15	;const
	call	l_and
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	de,_behs
	ld	hl,(_sc_n)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__n),a
	ld	hl,(_sc_n)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_update_tile
	jp	i_219
.i_220
	jp	i_200
.i_221
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_sc_terminado),a
.i_200
	jp	i_197
.i_198
.i_196
	ld	hl,(_next_script)
	ld	(_script),hl
	jp	i_177
.i_178
	ret


;	SECTION	text

._player_frames
	defw	_sprite_1_a
	defw	_sprite_2_a
	defw	_sprite_3_a
	defw	_sprite_4_a
	defw	_sprite_5_a
	defw	_sprite_6_a
	defw	_sprite_7_a
	defw	_sprite_8_a

;	SECTION	code

;	SECTION	text

._enem_frames
	defw	_sprite_9_a
	defw	_sprite_10_a
	defw	_sprite_11_a
	defw	_sprite_12_a
	defw	_sprite_13_a
	defw	_sprite_14_a
	defw	_sprite_15_a
	defw	_sprite_16_a

;	SECTION	code


._flick_screen
	ld	hl,(_p_x)
	ld	de,0	;const
	call	l_eq
	jp	nc,i_225
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jr	c,i_226_i_225
.i_225
	jp	i_224
.i_226_i_225
	ld	a,(_x_pant)
	cp	#(0 % 256)
	jp	z,i_227
	jp	c,i_227
	ld	hl,(_n_pant)
	ld	h,0
	dec	hl
	jp	i_228
.i_227
	ld	hl,(_n_pant)
	ld	h,0
	inc	hl
	inc	hl
	inc	hl
.i_228
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,3584	;const
	ld	(_p_x),hl
.i_224
	ld	hl,(_p_x)
	ld	de,3584	;const
	call	l_eq
	jp	nc,i_230
	ld	hl,_p_vx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_231_i_230
.i_230
	jp	i_229
.i_231_i_230
	ld	a,(_x_pant)
	cp	#(3 % 256)
	jp	z,i_232
	jp	nc,i_232
	ld	hl,(_n_pant)
	ld	h,0
	inc	hl
	jp	i_233
.i_232
	ld	hl,(_n_pant)
	ld	h,0
	dec	hl
	dec	hl
	dec	hl
.i_233
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_x),hl
.i_229
	ld	hl,(_p_y)
	ld	de,0	;const
	call	l_eq
	jp	nc,i_235
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jr	c,i_236_i_235
.i_235
	jp	i_234
.i_236_i_235
	ld	a,(_y_pant)
	cp	#(0 % 256)
	jp	z,i_237
	jp	c,i_237
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,-4
	add	hl,bc
	jp	i_238
.i_237
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,12
	add	hl,bc
.i_238
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,2304	;const
	ld	(_p_y),hl
.i_234
	ld	hl,(_p_y)
	ld	de,2304	;const
	call	l_eq
	jp	nc,i_240
	ld	hl,_p_vy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_gt
	jr	c,i_241_i_240
.i_240
	jp	i_239
.i_241_i_240
	ld	a,(_y_pant)
	cp	#(3 % 256)
	jp	z,i_242
	jp	nc,i_242
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,4
	add	hl,bc
	jp	i_243
.i_242
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,-12
	add	hl,bc
.i_243
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	hl,0	;const
	ld	(_p_y),hl
.i_239
	ret



._FO_clear
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_fo_it),a
.i_244
	ld	a,(_fo_it)
	cp	#(8 % 256)
	jp	z,i_245
	jp	nc,i_245
	ld	hl,_f_o_t
	push	hl
	ld	hl,_fo_it
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	pop	de
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_244
.i_245
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_fo_idx),a
	ret



._FO_add
	ld	de,_f_o_t
	ld	hl,(_fo_idx)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_f_o_x
	ld	hl,(_fo_idx)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_f_o_y
	ld	hl,(_fo_idx)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_f_o_s
	ld	hl,(_fo_idx)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_fo_idx
	ld	a,(hl)
	inc	(hl)
	ld	hl,(_fo_idx)
	ld	h,0
	dec	hl
	ld	h,0
	ret



._FO_paint
	ld	de,_f_o_t
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_fo_au),a
	ld	hl,_fo_au
	ld	a,(hl)
	rlca
	jp	nc,i_246
	ld	hl,_flags
	push	hl
	ld	a,(_fo_au)
	ld	e,a
	ld	d,0
	ld	hl,127	;const
	call	l_and
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_fo_au),a
.i_246
	ld	hl,(_fo_au)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_247
	ret


.i_247
	ld	de,_f_o_x
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	de,_f_o_y
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	hl,(_fo_au)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_draw_coloured_tile_gamearea
	ld	hl,_map_attr
	push	hl
	ld	de,_f_o_x
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_f_o_y
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	ld	de,_f_o_y
	ld	hl,8-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	add	hl,de
	push	hl
	ld	de,_behs
	ld	hl,(_fo_au)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	or	#(128 % 256)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	ret



._FO_unpaint
	ld	de,_f_o_x
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_f_o_y
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	push	hl
	ld	de,_f_o_y
	ld	hl,6-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_fo_au),a
	ld	de,_f_o_x
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	de,_f_o_y
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__y),a
	ld	de,_map_buff
	ld	hl,(_fo_au)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_draw_coloured_tile_gamearea
	ld	de,_map_attr
	ld	hl,(_fo_au)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_behs
	push	hl
	ld	de,_map_buff
	ld	hl,(_fo_au)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	ret



._FO_paint_all
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_fo_it),a
.i_248
	ld	a,(_fo_it)
	cp	#(8 % 256)
	jp	z,i_249
	jp	nc,i_249
	ld	de,_f_o_t
	ld	hl,(_fo_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_250
	ld	hl,(_fo_it)
	ld	h,0
	push	hl
	call	_FO_paint
	pop	bc
.i_250
	ld	hl,_fo_it
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_248
.i_249
	ret



._FO_do
	ld	hl,_pad
	ld	a,(hl)
	rlca
	jp	c,i_251
	ld	a,(_d_prs)
	and	a
	jp	nz,i_252
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_fo_it),a
.i_253
	ld	a,(_fo_it)
	cp	#(8 % 256)
	jp	z,i_254
	jp	nc,i_254
	ld	de,_f_o_x
	ld	hl,(_fo_it)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_fo_x),a
	ld	de,_f_o_y
	ld	hl,(_fo_it)
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_fo_y),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	hl,(_fo_x)
	ld	h,0
	call	l_uge
	jp	nc,i_256
	ld	hl,(_prx)
	ld	h,0
	push	hl
	ld	hl,(_fo_x)
	ld	h,0
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_ule
	jp	nc,i_256
	ld	hl,(_pry)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	hl,(_fo_y)
	ld	h,0
	call	l_uge
	jp	nc,i_256
	ld	hl,(_pry)
	ld	h,0
	push	hl
	ld	hl,(_fo_y)
	ld	h,0
	ld	bc,8
	add	hl,bc
	pop	de
	call	l_ule
	jr	c,i_257_i_256
.i_256
	jp	i_255
.i_257_i_256
	ld	de,_f_o_t
	ld	hl,(_fo_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	rlca
	jp	nc,i_258
	ld	de,_f_o_t
	ld	hl,(_fo_it)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	#(127 % 256)
	ld	l,a
	ld	h,0
	ld	h,0
	ld	a,l
	ld	(_fo_st),a
	ld	de,_flags
	ld	hl,(_fo_st)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_fo_au),a
	ld	de,_flags
	ld	hl,(_fo_st)
	ld	h,0
	add	hl,de
	push	hl
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_fo_au
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_display_items
	ld	de,_flags
	ld	hl,(_fo_st)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_259
	ld	hl,(_fo_it)
	ld	h,0
	push	hl
	call	_FO_paint
	pop	bc
	jp	i_260
.i_259
	ld	hl,(_fo_it)
	ld	h,0
	push	hl
	call	_FO_unpaint
	pop	bc
.i_260
	ld	hl,11 % 256	;const
	call	_nosound_play_sound
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_invalidate_fire),a
.i_258
.i_255
	ld	hl,_fo_it
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_253
.i_254
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_d_prs),a
.i_252
	jp	i_261
.i_251
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_d_prs),a
.i_261
	ret



._init_player
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
	ld	(_p_z),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_jmp_facing),a
	xor	a
	ld	(_p_vy),a
	xor	a
	ld	(_p_vx),a
	ld	a,#(1 % 256 % 256)
	ld	(_p_jmp_ct),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_jmp_on),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_frame),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_subframe),a
	ld	a,#(6 % 256 % 256)
	ld	(_p_facing),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_p_facing_h),a
	ld	h,0
	ld	a,l
	ld	(_p_facing_v),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_state),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_state_ct),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_objs),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_keys),a
	ld	hl,_flags+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	a,#(0 % 256 % 256)
	ld	(_p_disparando),a
	ld	hl,_ctimer+1+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_ctimer+4
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_ctimer+1+1
	ld	(hl),#(32 % 256 % 256)
	ld	hl,_ctimer+1
	ld	(hl),#(99 % 256 % 256)
	ld	hl,_ctimer
	ld	(hl),#(0 % 256 % 256)
	ld	a,#(0 % 256 % 256)
	ld	(_p_killme),a
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_p_safe_pant),a
	ld	hl,(_p_x)
	ld	a,h
	call	l_sxt
	ld	h,0
	ld	a,l
	ld	(_p_safe_x),a
	ld	hl,(_p_y)
	ld	a,h
	call	l_sxt
	ld	h,0
	ld	a,l
	ld	(_p_safe_y),a
	ret



._player_kill
	ld	hl,(_p_life)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_p_life),a
	call	_nosound_stop_sound
	ld	hl,8 % 256	;const
	call	_nosound_play_sound
	ld	a,#(0 % 256 % 256)
	ld	(_p_killme),a
	ld	a,#(2 % 256 % 256)
	ld	(_p_state),a
	ld	a,#(50 % 256 % 256)
	ld	(_p_state_ct),a
	ld	hl,50	;const
	push	hl
	call	_active_sleep
	pop	bc
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_p_safe_pant)
	ld	h,0
	call	l_ne
	jp	nc,i_262
	ld	hl,(_p_safe_pant)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	h,0
	ld	a,l
	ld	(_o_pant),a
	call	_draw_scr
.i_262
	ld	a,(_p_safe_x)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	a,(_p_safe_y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	xor	a
	ld	(_p_vx),a
	xor	a
	ld	(_p_vy),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_jmp_on),a
	ld	hl,18 % 256	;const
	call	_nosound_play_sound
	ret



._player_move
	xor a
	ld (_wall_v), a
	ld (_wall_h), a
	ld (_p_thrust), a
	ld a, (_p_state)
	ld c, a
	or a
	jr z, player_move_p_state_done
	ld a, (_p_state_ct)
	dec a
	ld (_p_state_ct), a
	jr nz, player_move_p_state_zero_done
	ld a, c
	and 8
	jr z, player_move_p_state_set_normal
	ld a, 1
	ld (_p_killme), a
	jr player_move_p_state_zero_done
	.player_move_p_state_set_normal
	xor a
	ld (_p_state), a
	.player_move_p_state_zero_done
	ld a, c
	and 8
	jr z, player_move_p_state_done
	ld a, 255
	ld (_pad), a
	.player_move_p_state_done
	ld a, (_prx)
	add 8
	srl a
	srl a
	srl a
	srl a
	ld (_prxx), a
	ld a, (_pry)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_pryy), a
	ld  a, (_prxx)
	ld  c,a
	ld  a, (_pryy)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld a, (_possee)
	or a
	jr z, player_move_conveyors_done
	ld a, (_pt1)
	bit 5, a
	jr z, player_move_conveyors_done
	srl a
	and 3
	or a
	jr z, player_move_conveyors_beh_not0
	ld a, -64
	ld (_ptgmy), a
	jr player_move_conveyors_beh_done
	.player_move_conveyors_beh_not0
	cp 1
	jr z, player_move_conveyors_beh_not1
	ld a, 64;
	ld (_ptgmy), a
	jr player_move_conveyors_beh_done
	.player_move_conveyors_beh_not1
	cp 2
	jr z, player_move_conveyors_beh_not2
	ld a, -64
	ld (_ptgmx), a
	jr player_move_conveyors_beh_done
	.player_move_conveyors_beh_not2
	ld a, 64
	ld (_ptgmx), a
	.player_move_conveyors_beh_done
	ld a, 1
	ld (_p_gotten), a
	.player_move_conveyors_done
	ld	a,#(8 % 256)
	ld	(_p_ax),a
	ld	a,#(12 % 256)
	ld	(_p_rx),a
	ld	hl,_pt1
	ld	a,(hl)
	and	#(64 % 256)
	jp	z,i_263
	ld	a,(_possee)
	and	a
	jp	z,i_264
	ld	hl,(_half_life)
	ld	h,0
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_ax),a
	ld	hl,(_half_life)
	ld	h,0
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_rx),a
.i_264
.i_263
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_266
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_266
	ld	hl,0	;const
	jr	i_267
.i_266
	ld	hl,1	;const
.i_267
	call	l_lneg
	jp	nc,i_268
	ld	hl,(_p_z)
	ld	de,0	;const
	call	l_eq
	jr	c,i_269_i_268
.i_268
	jp	i_265
.i_269_i_268
	ld	a,#(255 % 256 % 256)
	ld	(_p_facing_v),a
	ld	hl,_p_vy
	call	l_gchar
	xor	a
	or	h
	jp	m,i_270
	or	l
	jp	z,i_270
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_p_rx
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	ld	hl,_p_vy
	call	l_gchar
	xor	a
	or	h
	jp	p,i_271
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_271
	jp	i_272
.i_270
	ld	hl,_p_vy
	call	l_gchar
	xor	a
	or	h
	jp	p,i_273
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_p_rx
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	ld	hl,_p_vy
	call	l_gchar
	xor	a
	or	h
	jp	m,i_274
	or	l
	jp	z,i_274
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_274
.i_273
.i_272
.i_265
	ld	hl,_pad
	ld	a,(hl)
	rrca
	jp	c,i_275
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_p_facing_v),a
	ld	a,#(1 % 256)
	ld	(_p_thrust),a
	ld	hl,_p_vy
	call	l_gchar
	ld	de,65472	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_276
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_p_ax
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_276
.i_275
	ld	hl,_pad
	ld	a,(hl)
	and	#(2 % 256)
	jp	nz,i_277
	ld	hl,6 % 256	;const
	ld	a,l
	ld	(_p_facing_v),a
	ld	a,#(1 % 256)
	ld	(_p_thrust),a
	ld	hl,_p_vy
	call	l_gchar
	ld	de,64	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_278
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_p_ax
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
.i_278
.i_277
	ld	hl,_p_vz
	call	l_gchar
	ld	de,48	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_279
	ld	hl,_p_vz
	call	l_gchar
	ld	bc,16
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
	jp	i_280
.i_279
	ld	hl,48	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
.i_280
	ld	hl,(_p_y)
	push	hl
	ld	hl,_p_vy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_y),hl
	ld	a,(_p_gotten)
	and	a
	jp	z,i_281
	ld	hl,(_p_y)
	push	hl
	ld	hl,_ptgmy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_y),hl
.i_281
	ld	hl,(_p_z)
	push	hl
	ld	hl,_p_vz
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_z),hl
	xor	a
	or	h
	jp	m,i_282
	or	l
	jp	z,i_282
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
	ld	(_p_z),hl
.i_282
	ld	hl,(_p_y)
	xor	a
	or	h
	jp	p,i_283
	ld	hl,0	;const
	ld	(_p_y),hl
.i_283
	ld	hl,(_p_y)
	ld	de,2304	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_284
	ld	hl,2304	;const
	ld	(_p_y),hl
.i_284
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_ptgmy
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_rdint),hl
	ld	a,h
	or	l
	jp	z,i_285
	ld	hl,(_prx)
	ld	h,0
	ld	bc,4
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx1),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,11
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx2),a
	ld	a,#(0 % 256 % 256)
	ld	(_hit_v),a
	ld	hl,(_rdint)
	xor	a
	or	h
	jp	p,i_286
	ld	hl,(_pry)
	ld	h,0
	ld	bc,14
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty1),a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld  a, (_ptx2)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt2), a
	ld	hl,_pt1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_288
	ld	hl,_pt2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_287
.i_288
	xor	a
	ld	(_p_vy),a
	ld	hl,(_pty1)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,-14
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_wall_v),a
	jp	i_290
.i_287
	ld	a,(_pt1)
	cp	#(1 % 256)
	jp	z,i_292
	ld	a,(_pt2)
	cp	#(1 % 256)
	jp	nz,i_291
.i_292
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_hit_v),a
.i_291
.i_290
	jp	i_294
.i_286
	ld	hl,(_pry)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty2),a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty2)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld  a, (_ptx2)
	ld  c,a
	ld  a, (_pty2)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt2), a
	ld	hl,_pt1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_296
	ld	hl,_pt2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_295
.i_296
	xor	a
	ld	(_p_vy),a
	ld	hl,(_pty2)
	ld	h,0
	dec	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(_wall_v),a
	jp	i_298
.i_295
	ld	a,(_pt1)
	cp	#(1 % 256)
	jp	z,i_300
	ld	a,(_pt2)
	cp	#(1 % 256)
	jp	nz,i_299
.i_300
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_hit_v),a
.i_299
.i_298
.i_294
.i_285
	ld	hl,(_p_y)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	hl,(_pry)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty1),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx1),a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld	hl,(_p_z)
	ld	de,0	;const
	call	l_eq
	jp	nc,i_302
	ld	a,(_pt1)
	cp	#(3 % 256)
	jp	z,i_302
	ld	hl,1	;const
	jr	i_303
.i_302
	ld	hl,0	;const
.i_303
	ld	h,0
	ld	a,l
	ld	(_possee),a
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_305
	ld	a,(_p_jmp_on)
	cp	#(0 % 256)
	jp	nz,i_305
	ld	a,(_possee)
	and	a
	jp	nz,i_306
	ld	a,(_p_gotten)
	and	a
	jp	z,i_305
.i_306
	jr	i_308_i_305
.i_305
	jp	i_304
.i_308_i_305
	ld	a,#(1 % 256 % 256)
	ld	(_p_jmp_on),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_jmp_ct),a
	ld	hl,(_p_facing)
	ld	h,0
	ld	a,l
	ld	(_p_jmp_facing),a
	ld	a,#(65512 % 256)
	ld	(_p_vz),a
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_ptgmx
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,_p_vy
	call	l_gchar
	push	hl
	ld	hl,_ptgmy
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vy),a
	ld	hl,2 % 256	;const
	call	_nosound_play_sound
	ld	hl,(_p_gotten)
	ld	h,0
	call	l_lneg
	jp	nc,i_309
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_p_safe_pant),a
	ld	hl,(_prx)
	ld	h,0
	ld	a,l
	ld	(_p_safe_x),a
	ld	hl,(_pry)
	ld	h,0
	ld	a,l
	ld	(_p_safe_y),a
.i_309
.i_304
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_311
	ld	a,(_p_jmp_on)
	and	a
	jr	nz,i_312_i_311
.i_311
	jp	i_310
.i_312_i_311
	ld	hl,_p_vz
	call	l_gchar
	push	hl
	ld	a,(_p_jmp_ct)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asr_u
	ld	de,24
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
	ld	hl,_p_vz
	call	l_gchar
	ld	de,65488	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_313
	ld	hl,65488	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vz),a
.i_313
	ld	hl,(_p_jmp_ct)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_jmp_ct),a
	cp	#(4 % 256)
	jp	nz,i_314
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_jmp_on),a
.i_314
.i_310
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	call	l_lneg
	jp	nc,i_315
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_jmp_on),a
.i_315
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_317
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,8	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_317
	ld	hl,0	;const
	jr	i_318
.i_317
	ld	hl,1	;const
.i_318
	call	l_lneg
	jp	nc,i_319
	ld	hl,(_p_z)
	ld	de,0	;const
	call	l_eq
	jr	c,i_320_i_319
.i_319
	jp	i_316
.i_320_i_319
	ld	a,#(255 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	m,i_321
	or	l
	jp	z,i_321
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_p_rx
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	p,i_322
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_322
	jp	i_323
.i_321
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	p,i_324
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_p_rx
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
	ld	hl,_p_vx
	call	l_gchar
	xor	a
	or	h
	jp	m,i_325
	or	l
	jp	z,i_325
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_325
.i_324
.i_323
.i_316
	ld	hl,_pad
	ld	a,(hl)
	and	#(4 % 256)
	jp	nz,i_326
	ld	a,#(1 % 256)
	ld	(_p_thrust),a
	ld	a,#(2 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,_p_vx
	call	l_gchar
	ld	de,65472	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_327
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_p_ax
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_327
.i_326
	ld	hl,_pad
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_328
	ld	a,#(1 % 256)
	ld	(_p_thrust),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_facing_h),a
	ld	hl,_p_vx
	call	l_gchar
	ld	de,64	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_329
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_p_ax
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_p_vx),a
.i_329
.i_328
	ld	hl,(_p_x)
	push	hl
	ld	hl,_p_vx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
	ld	a,(_p_gotten)
	and	a
	jp	z,i_330
	ld	hl,(_p_x)
	push	hl
	ld	hl,_ptgmx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_p_x),hl
.i_330
	ld	hl,(_p_x)
	xor	a
	or	h
	jp	p,i_331
	ld	hl,0	;const
	ld	(_p_x),hl
.i_331
	ld	hl,(_p_x)
	ld	de,3584	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_332
	ld	hl,3584	;const
	ld	(_p_x),hl
.i_332
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	hl,_p_vx
	call	l_gchar
	push	hl
	ld	hl,_ptgmx
	call	l_gchar
	pop	de
	add	hl,de
	ld	(_rdint),hl
	ld	a,h
	or	l
	jp	z,i_333
	ld	hl,(_pry)
	ld	h,0
	ld	bc,14
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty1),a
	ld	hl,(_pry)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty2),a
	ld	a,#(0 % 256 % 256)
	ld	(_hit_h),a
	ld	hl,(_rdint)
	xor	a
	or	h
	jp	p,i_334
	ld	hl,(_prx)
	ld	h,0
	ld	bc,4
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx1),a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty2)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt2), a
	ld	hl,_pt1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_336
	ld	hl,_pt2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_335
.i_336
	xor	a
	ld	(_p_vx),a
	ld	hl,(_ptx1)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,-4
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_wall_h),a
	jp	i_338
.i_335
	ld	a,(_pt1)
	cp	#(1 % 256)
	jp	z,i_340
	ld	a,(_pt2)
	cp	#(1 % 256)
	jp	nz,i_339
.i_340
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_hit_h),a
.i_339
.i_338
	jp	i_342
.i_334
	ld	hl,(_prx)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx2),a
	ld  a, (_ptx2)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld  a, (_ptx2)
	ld  c,a
	ld  a, (_pty2)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt2), a
	ld	hl,_pt1
	ld	a,(hl)
	and	#(8 % 256)
	jp	nz,i_344
	ld	hl,_pt2
	ld	a,(hl)
	and	#(8 % 256)
	jp	z,i_343
.i_344
	xor	a
	ld	(_p_vx),a
	ld	hl,(_ptx2)
	ld	h,0
	dec	hl
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asl
	ld	bc,4
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_wall_h),a
	jp	i_346
.i_343
	ld	a,(_pt1)
	cp	#(1 % 256)
	jp	z,i_348
	ld	a,(_pt2)
	cp	#(1 % 256)
	jp	nz,i_347
.i_348
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_hit_h),a
.i_347
.i_346
.i_342
.i_333
	ld a, (_p_facing_h)
	cp 255
	jr nz, player_moving_facing_set
	.player_moving_facing_sel_not_h
	ld a, (_p_facing_v)
	cp 255
	jr z, player_moving_facing_done
	.player_moving_facing_set
	ld (_p_facing), a
	.player_moving_facing_done
	ld	a,(_gpit)
	ld	e,a
	ld	d,0
	ld	hl,128	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_351
	ld	hl,(_key_fire)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	nz,i_351
	jr	i_352
.i_351
	ld	hl,1	;const
.i_352
	ld	a,h
	or	l
	jp	z,i_353
	ld	hl,(_p_disparando)
	ld	h,0
	call	l_lneg
	jp	nc,i_353
	ld	de,_items
	ld	hl,(_flags+30)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(46 % 256)
	jp	nz,i_353
	ld	a,(_invalidate_fire)
	cp	#(0 % 256)
	jr	z,i_354_i_353
.i_353
	jp	i_350
.i_354_i_353
	ld	a,#(1 % 256 % 256)
	ld	(_p_disparando),a
	ld	a,(_hitter_on)
	and	a
	jp	nz,i_355
	ld	a,#(0 % 256 % 256)
	ld	(_hitter_hit),a
	ld	a,#(1 % 256 % 256)
	ld	(_hitter_on),a
	ld	a,#(0 % 256 % 256)
	ld	(_hitter_frame),a
	ld	a,#(1 % 256 % 256)
	ld	(_p_hitting),a
	ld	hl,7 % 256	;const
	call	_nosound_play_sound
.i_355
.i_350
	ld	a,(_gpit)
	ld	e,a
	ld	d,0
	ld	hl,128	;const
	call	l_and
	ld	de,0	;const
	ex	de,hl
	call	l_eq
	jp	c,i_357
	ld	hl,(_key_fire)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	nz,i_357
	jr	i_358
.i_357
	ld	hl,1	;const
.i_358
	ld	a,h
	or	l
	jp	nz,i_356
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_invalidate_fire),a
	ld	h,0
	ld	a,l
	ld	(_p_disparando),a
.i_356
	ld	a,#(0 % 256 % 256)
	ld	(_hit),a
	ld	a,(_hit_v)
	cp	#(1 % 256)
	jp	nz,i_359
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
	jp	i_360
.i_359
	ld	a,(_hit_h)
	cp	#(1 % 256)
	jp	nz,i_361
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
.i_361
.i_360
	ld	a,(_hit)
	and	a
	jp	z,i_362
	ld	a,(_p_life)
	cp	#(0 % 256)
	jp	z,i_364
	jp	c,i_364
	ld	a,(_p_state)
	cp	#(0 % 256)
	jr	z,i_365_i_364
.i_364
	jp	i_363
.i_365_i_364
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_p_killme),a
.i_363
.i_362
	ld	hl,(_p_x)
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	hl,(_pry)
	ld	h,0
	ld	bc,15
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_pty1),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,4
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx1),a
	ld	hl,(_prx)
	ld	h,0
	ld	bc,12
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_ptx2),a
	ld  a, (_ptx1)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt1), a
	ld  a, (_ptx2)
	ld  c,a
	ld  a, (_pty1)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_pt2), a
	ld	hl,(_p_z)
	ld	de,0	;const
	call	l_eq
	jp	nc,i_367
	ld	a,(_p_gotten)
	cp	#(0 % 256)
	jp	nz,i_367
	ld	a,(_pt1)
	cp	#(3 % 256)
	jp	nz,i_367
	ld	a,(_pt2)
	cp	#(3 % 256)
	jp	nz,i_367
	ld	a,(_p_state)
	cp	#(8 % 256)
	jr	nz,i_368_i_367
.i_367
	jp	i_366
.i_368_i_367
	ld	a,(_p_ct_hole)
	cp	#(2 % 256)
	jp	z,i_369
	jp	nc,i_369
	ld	hl,(_p_ct_hole)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_p_ct_hole),a
	jp	i_370
.i_369
	ld	hl,_p_vy
	call	l_gchar
	xor	a
	or	h
	jp	m,i_371
	or	l
	jp	z,i_371
	ld	hl,(_pry)
	ld	h,0
	ld	bc,8
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
.i_371
	ld	a,#(8 % 256 % 256)
	ld	(_p_state),a
	ld	hl,50 % 256	;const
	ld	a,l
	ld	(_p_state_ct),a
.i_370
	jp	i_372
.i_366
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_p_ct_hole),a
.i_372
	ld a, (_p_state)
	and 8
	jr z, _player_move_af_not_holed
	ld a, (_p_state_ct)
	cp 1
	jr nc, _playe_move_af_holed_falling
	ld hl, _sprite_18_a
	jr _player_move_af_holed_set
	._playe_move_af_holed_falling
	ld hl, _sprite_e;
	cp 25
	jr nc, _player_move_af_holed_set
	ld bc, 144
	add hl, bc
	._player_move_af_holed_set
	ld (_p_n_f), hl
	jr _player_move_af_done
	._player_move_af_not_holed
	ld a, (_p_z)
	ld c, a
	ld a, (_p_z+1)
	or c
	jr z, _player_move_af_floor
	ld de, (_p_jmp_facing)
	ld d, 0
	inc de
	ld hl, _player_frames
	add hl, de
	add hl, de
	jr _player_move_af_set
	._player_move_af_floor
	ld a, (_p_vx)
	and a
	jr nz, _player_move_af_floor_moving
	ld a, (_p_vy)
	and a
	jr nz, _player_move_af_floor_moving
	ld de, (_p_facing)
	ld d, 0
	ld hl, _player_frames
	add hl, de
	add hl, de
	jr _player_move_af_set
	._player_move_af_floor_moving
	ld a, (_p_subframe)
	inc a
	ld (_p_subframe), a
	cp 4
	jr nz, _player_move_af_incframe_done
	ld a, (_p_frame)
	xor 1
	ld (_p_frame), a
	call _step
	xor a
	._player_move_af_incframe_done
	ld (_p_subframe), a
	ld a, (_p_facing)
	ld c, a
	ld a, (_p_frame)
	add c
	sla a
	ld b, 0
	ld c, a
	ld hl, _player_frames
	add hl, bc
	jr _player_move_af_set
	._player_move_af_set
	ld de, _p_n_f
	ldi
	ldi
	._player_move_af_done
	ret



._enemy_kill
	ld	hl,__en_mx
	call	l_gchar
	call	l_neg
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_mx),a
	ld	hl,__en_my
	call	l_gchar
	call	l_neg
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_my),a
	ld	hl,14 % 256	;const
	call	_nosound_play_sound
	ret



._enems_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_375
.i_373
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_375
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_374
	jp	nc,i_374
	ld	de,_en_an_frame
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	de,_en_an_count
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(3 % 256 % 256)
	ld	de,_en_an_state
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,(_enoffs)
	ld	h,0
	ex	de,hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_enoffsmasi),a
	ld	a,(_do_respawn)
	and	a
	jp	z,i_376
	ld	hl,_baddies
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	a,(hl)
	and	#(127 % 256)
	pop	de
	ld	(de),a
	ld	de,_en_an_state
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
.i_376
	ld	hl,_baddies
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	e,(hl)
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_gpt),a
	and	a
	jp	z,i_378
	ld	a,(_gpt)
	cp	#(16 % 256)
	jp	z,i_378
	jr	c,i_379_i_378
.i_378
	jp	i_377
.i_379_i_378
	ld	de,_en_an_base_frame
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_baddies
	push	hl
	ld	hl,(_enoffsmasi)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	a,(hl)
	and	#(3 % 256)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,(_gpt)
	ld	h,0
.i_382
	ld	a,l
.i_383
.i_381
	jp	i_384
.i_377
	ld	hl,_en_an_n_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
.i_384
	jp	i_373
.i_374
	ret



._enems_move
	ld	a,#(0 % 256 % 256)
	ld	(_p_gotten),a
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmy),a
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_ptgmx),a
	ld	a,#(0 % 256 % 256)
	ld	(_tocado),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_387
.i_385
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_387
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_386
	jp	nc,i_386
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_animate),a
	ld	h,0
	ld	a,l
	ld	(_killable),a
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
	ld a, (_enoffsmasi)
	sla a
	ld b, a
	sla a
	ld l, a
	ld h, 0
	add hl, hl
	ld e, b
	ld d, 0
	add hl, de
	ld de, _baddies
	add hl, de
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
	inc hl
	ld a, (hl)
	ld (__en_life), a
	ld bc, (_gpit)
	ld b, 0
	ld hl, _en_an_state
	add hl, bc
	ld a, (hl)
	cp 4
	jr nz, _enems_general_dying_done
	ld hl, _en_an_count;
	add hl, bc
	dec (hl)
	jr nz, _enems_general_dying_done
	ld hl, _en_an_state
	add hl, bc
	xor a
	ld (hl), a
	ld hl, _en_an_n_f
	add hl, bc
	add hl, bc
	ld (hl), _sprite_18_a
	jp _continue_enems_loop_a
	._enems_general_dying_done
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
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 15
	cp c
	jp c, _enems_move_pregotten_not
	ld a, (_pry)
	ld c, a
	ld a, (__en_y)
	cp c
	jp c, _enems_move_pregotten_not
	ld a, 1
	jr _enems_move_pregotten_set
	._enems_move_pregotten_not
	xor a
	._enems_move_pregotten_set
	ld (_pregotten), a
	ld a, (__en_t)
	ld c, a
	and 4
	ld (_enemy_shoots), a
	ld a, c
	srl a
	srl a
	srl a
	ld (_gpt), a
	ld	hl,(_gpt)
	ld	h,0
.i_390
	ld	a,l
	cp	#(1% 256)
	jp	z,i_391
	cp	#(8% 256)
	jp	z,i_392
	cp	#(10% 256)
	jp	z,i_393
	jp	i_405
.i_391
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_killable),a
.i_392
	ld a, 1
	ld (_active), a
	ld (_animate), a
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
	jp	i_389
.i_393
	ld	a,#(0 % 256 % 256)
	ld	(__en_y2),a
	ld	hl,__en_my
	call	l_gchar
	ld	a,h
	or	l
	jp	z,i_394
	ld	hl,(__en_x)
	ld	h,0
	push	hl
	ld	hl,__en_mx
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__en_x),a
	ld	hl,_en_an_n_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_arrow_sprites
	push	hl
	ld	hl,__en_mx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_395
	ld	hl,0	;const
	jp	i_396
.i_395
	ld	hl,144	;const
.i_396
	pop	de
	add	hl,de
	pop	de
	call	l_pint
	ld	hl,(__en_x)
	ld	h,0
	ex	de,hl
	ld	hl,(__en_x2)
	ld	h,0
	call	l_eq
	jp	nc,i_397
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(__en_my),a
.i_397
	jp	i_398
.i_394
	ld	hl,_en_an_n_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
	ld	hl,(_enemy_shoots)
	ld	h,0
	ld	de,0
	call	l_eq
	jp	c,i_400
	ld	hl,(_pry)
	ld	h,0
	push	hl
	ld	hl,(__en_y1)
	ld	h,0
	push	hl
	ld	hl,(__en_y1)
	ld	h,0
	push	hl
	ld	hl,15 % 256	;const
	push	hl
	push	hl
	call	_addons_between
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	a,h
	or	l
	jp	z,i_401
	ld	hl,(_prx)
	ld	h,0
	push	hl
	ld	hl,(__en_x1)
	ld	h,0
	push	hl
	ld	hl,(__en_x2)
	ld	h,0
	push	hl
	ld	hl,15 % 256	;const
	push	hl
	ld	hl,31 % 256	;const
	push	hl
	call	_addons_between
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	a,h
	or	l
	jp	z,i_401
	ld	hl,1	;const
	jr	i_402
.i_401
	ld	hl,0	;const
.i_402
	ld	a,h
	or	l
	jp	nz,i_400
	jr	i_403
.i_400
	ld	hl,1	;const
.i_403
	ld	a,h
	or	l
	jp	z,i_399
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(__en_y2),a
.i_399
.i_398
	ld	a,(__en_y2)
	and	a
	jp	z,i_404
	ld	a,#(1 % 256)
	ld	(__en_my),a
	ld	hl,(__en_x1)
	ld	h,0
	ld	a,l
	ld	(__en_x),a
	ld	hl,7 % 256	;const
	call	_nosound_play_sound
.i_404
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_active),a
	jp	i_389
.i_405
	ld	a,(_gpt)
	cp	#(15 % 256)
	jp	z,i_407
	jp	c,i_407
	ld	de,_en_an_state
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	#(4 % 256)
	jr	nz,i_408_i_407
.i_407
	jp	i_406
.i_408_i_407
	ld	hl,_en_an_n_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_18_a
	pop	de
	call	l_pint
.i_406
.i_389
	ld	a,(_active)
	and	a
	jp	z,i_409
	ld	hl,(_animate)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_410
	ld de, (_gpit)
	ld d, 0
	ld hl, _en_an_count
	add hl, de
	inc (hl)
	ld a, (hl)
	cp 4
	jr nz, _enems_animate_change_frame_don
	xor a
	ld (hl), a
	ld hl, _en_an_frame
	add hl, de
	ld a, (hl)
	xor 1
	ld (hl), a
	ld c, a
	ld hl, _en_an_base_frame
	add hl, de
	ld a, (hl)
	add c
	sla a
	ld c, a
	ld b, 0
	ld hl, _enem_frames
	add hl, bc
	ld a, (hl)
	inc hl
	ld c, (hl)
	ld hl, _en_an_n_f
	add hl, de
	add hl, de
	ld (hl), a
	inc hl
	ld (hl), c
	._enems_animate_change_frame_don
.i_410
	ld a, (_gpt)
	cp 8
	jr nz, _enems_platforms_25d_done
	ld a, (_pregotten)
	and a
	jp z, _enems_collision_skip
	ld a, (_p_gotten)
	jp nz, _enems_collision_skip
	ld a, (_p_z)
	jp nz, _enems_collision_skip
	ld a, 1
	ld (_p_gotten), a
	ld a, (__en_mx)
	sla a
	sla a
	sla a
	sla a
	ld (_ptgmx), a
	ld a, (__en_my)
	sla a
	sla a
	sla a
	sla a
	ld (_ptgmy), a
	jp _enems_collision_skip
	._enems_platforms_25d_done
	._enems_collision
	ld a, (__en_t)
	and 8
	ld a, (__en_y)
	jr z, _enems_collision_no_pixel_shift
	sub 8
	._enems_collision_no_pixel_shift
	ld (_gpen_y), a
	ld a, (_tocado)
	or a
	jr nz, _enems_collision_skip
	ld a, (_p_state)
	or a
	jr nz, _enems_collision_skip
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 8
	cp c
	jr c, _enems_collision_skip
	ld a, (_prx)
	ld c, a
	ld a, (__en_x)
	add 8
	cp c
	jr c, _enems_collision_skip
	ld a, (_gpen_y)
	ld c, a
	ld a, (_pry)
	add 8
	cp c
	jr c, _enems_collision_skip
	ld a, (_pry)
	ld c, a
	ld a, (_gpen_y)
	add 8
	cp c
	jr c, _enems_collision_skip
	ld a, 1
	ld (_tocado), a
	ld (_p_killme), a
	._enems_collision_skip
.i_409
.i_411
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
	inc hl
	ld a, (__en_life)
	ld (hl), a
	jp	i_385
.i_386
	ret



._screen_level
	call	_blackout_area
	ld	a,#(12 % 256 % 256)
	ld	(_prx),a
	ld	a,#(10 % 256 % 256)
	ld	(_pry),a
	ld	hl,71 % 256	;const
	ld	a,l
	ld	(_gpt),a
	call	_k2t_show_time_prx_pry
	ld	a,#(18 % 256 % 256)
	ld	(__x),a
	ld	a,#(10 % 256 % 256)
	ld	(__y),a
	ld	a,#(70 % 256 % 256)
	ld	(__t),a
	ld	hl,i_1+39
	push	hl
	call	_print_str
	pop	bc
	call	sp_UpdateNow
	ld	hl,250	;const
	push	hl
	call	_active_sleep
	pop	bc
	ret



._prepare_level
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_level_data
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	a,#(7 % 256 % 256)
	ld	(__t),a
	ld	hl,2 % 256	;const
	ld	a,l
	ld	(__n),a
	call	_load_subtileset
	ld	a,#(99 % 256 % 256)
	ld	(_cur_map_attr),a
	ld	hl,(_level_data+1+1)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ld	a,(_level_data+1+1+1)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_x),hl
	ld	a,(_level_data+4)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_p_y),hl
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	call	l_gint	;
	ld	(_main_script_offset),hl
	ret


;	SECTION	text

._hoffs_x
	defm	""
	defb	8

	defm	""
	defb	16

	defm	""
	defb	16

	defm	""
	defb	12

	defm	""
	defb	8

	defm	""
	defb	4

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._hoffs_y
	defm	""
	defb	4

	defm	""
	defb	4

	defm	""
	defb	4

	defm	""
	defb	6

	defm	""
	defb	8

	defm	""
	defb	10

	defm	""
	defb	12

;	SECTION	code



._hitter_do
	ld	hl,(_pry)
	ld	h,0
	push	hl
	ld	de,_hoffs_y
	ld	hl,(_hitter_frame)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_hitter_y),a
	ld	a,(_p_facing)
	and	a
	jp	z,i_414
	ld	hl,(_prx)
	ld	h,0
	push	hl
	ld	de,_hoffs_x
	ld	hl,(_hitter_frame)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_hitter_x),a
	jp	i_415
.i_414
	ld	hl,(_prx)
	ld	h,0
	push	hl
	ld	de,_hoffs_x
	ld	hl,(_hitter_frame)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(_hitter_x),a
.i_415
	ld	hl,(_hitter_frame)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_hitter_frame),a
	cp	#(7 % 256)
	jp	nz,i_416
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_hitter_on),a
	ld	h,0
	ld	a,l
	ld	(_p_hitting),a
.i_416
	ret



._run_entering_script
	ld	hl,33 % 256	;const
	push	hl
	call	_run_script
	pop	bc
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	push	hl
	call	_run_script
	pop	bc
	ret



._run_fire_script
	ld	hl,34 % 256	;const
	push	hl
	call	_run_script
	pop	bc
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_n_pant)
	ld	h,0
	add	hl,de
	inc	hl
	push	hl
	call	_run_script
	pop	bc
	ret



._game_loop
	call	_prepare_level
	ld	hl,(_silent_level)
	ld	h,0
	call	l_lneg
	call	c,_screen_level
.i_417
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_silent_level),a
	call	_init_player
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_no_draw),a
	ld	h,0
	ld	a,l
	ld	(_success),a
	ld	h,0
	ld	a,l
	ld	(_script_result),a
	ld	h,0
	ld	a,l
	ld	(_maincounter),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_do_respawn),a
	ld	h,0
	ld	a,l
	ld	(_playing),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_o_pant),a
	ld	h,0
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
	ld	hl,32 % 256	;const
	push	hl
	call	_run_script
	pop	bc
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	l,(hl)
	ld	h,0
	call	_nosound_play_music
	call	_display_items
.i_418
	ld	a,(_playing)
	and	a
	jp	z,i_419
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_420
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_420
	pop	bc
	ld	h,0
	ld	a,l
	ld	(_pad),a
	ld	a,(_ctimer)
	and	a
	jp	z,i_421
	ld	hl,_ctimer+1+1+1
	inc	(hl)
	ld	a,(_ctimer+1+1)
	cp	(hl)
	jp	nz,i_422
	ld	hl,_ctimer+1+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	a,(_ctimer+1)
	and	a
	jp	z,i_423
	ld	hl,_ctimer+1
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	jp	i_424
.i_423
	ld	hl,_ctimer+4
	ld	(hl),#(1 % 256 % 256)
	ld	l,(hl)
	ld	h,0
.i_424
.i_422
.i_421
	ld	a,(_ctimer+4)
	and	a
	jp	z,i_425
	ld	hl,_ctimer+4
	ld	(hl),#(0 % 256 % 256)
	ld	hl,35 % 256	;const
	push	hl
	call	_run_script
	pop	bc
.i_425
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_o_pant)
	ld	h,0
	call	l_ne
	jp	nc,i_426
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_o_pant),a
	call	_draw_scr
	call	_enems_init
	call	_FO_clear
	call	_run_entering_script
.i_426
	call	_update_hud
	ld	hl,(_maincounter)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_maincounter),a
	ld	a,(_half_life)
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_xor
	ld	h,0
	ld	a,l
	ld	(_half_life),a
	call	_player_move
	ld	hl,(_hitter_on)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_hitter_do
.i_427
	ld	hl,4 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	call	_enems_move
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	xor a
	.update_sprites_baddies_loop
	ld (_gpit), a
	ld c, a
	ld a, (_enoffs)
	add c
	ld (_enoffsmasi), a
	sla a
	ld b, a
	sla a
	ld l, a
	ld h, 0
	add hl, hl
	ld e, b
	ld d, 0
	add hl, de
	ld de, _baddies
	add hl, de
	ld a, (hl)
	ld (_gpen_x), a
	inc hl
	ld a, (hl)
	ld (_gpen_y), a
	ld bc, 7
	add hl, bc
	ld a, (hl)
	and $78
	cp 8
	jr nz, update_sprites_baddies_pixel_sh
	ld a, (_gpen_y)
	sub 8
	ld (_gpen_y), a
	.update_sprites_baddies_pixel_sh
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
	ld hl, _en_an_c_f
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	ld hl, _en_an_n_f
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
	ld a, (_gpen_y)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_gpen_x)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_gpen_x)
	and 7
	ld d, a
	ld a, (_gpen_y)
	and 7
	ld e, a
	call SPMoveSprAbs
	pop bc
	ld hl, _en_an_c_f
	add hl, bc
	ex de, hl
	ld hl, _en_an_n_f
	add hl, bc
	ldi
	ldi
	ld a, (_gpit)
	inc a
	cp 3
	jp nz, update_sprites_baddies_loop
	ld a, (_p_killme)
	jp nz, update_sprites_player_else
	ld a, (_p_state)
	and 2
	jr z, update_sprites_player
	ld a, (_half_life)
	or a
	jp nz, update_sprites_player_else
	.update_sprites_player
	ld a, (_prx)
	ld (_rdx), a
	ld a, (_pry)
	ld (_rdy), a
	ld de, (_p_z)
	xor a
	sub e
	ld e, a
	sbc a, a
	sub d
	ld d, a
	ld l, 4
	call l_asr
	ld c, l
	ld a, (_rdy)
	sub c
	ld (_rdz), a
	jp update_sprites_player_do
	.update_sprites_player_else
	ld a, -16
	ld (_rdx), a
	ld (_rdy), a
	ld (_rdz), a
	.update_sprites_player_do
	; enter: IX = sprite structure address
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	; BC = animate bitdef displacement (0 for no animation)
	; H = new row coord in chars
	; L = new col coord in chars
	; D = new horizontal rotation (0..7) ie horizontal pixel position
	; E = new vertical rotation (0..7) ie vertical pixel position
	ld ix, (_sp_shadow)
	ld iy, vpClipStruct
	ld bc, 0
	ld a, (_rdy)
	srl a
	srl a
	srl a
	add 1
	inc a
	ld h, a
	ld a, (_rdx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_rdx)
	and 7
	ld d, a
	ld a, (_rdy)
	and 7
	ld e, a
	call SPMoveSprAbs
	; enter: IX = sprite structure address
	; IY = clipping rectangle, set it to "ClipStruct" for full screen
	; BC = animate bitdef displacement (0 for no animation)
	; H = new row coord in chars
	; L = new col coord in chars
	; D = new horizontal rotation (0..7) ie horizontal pixel position
	; E = new vertical rotation (0..7) ie vertical pixel position
	ld ix, (_sp_player)
	ld iy, vpClipStruct
	ld hl, (_p_n_f)
	ld de, (_p_c_f)
	or a
	sbc hl, de
	ld b, h
	ld c, l
	ld a, (_rdz)
	srl a
	srl a
	srl a
	add 1
	ld h, a
	ld a, (_prx)
	srl a
	srl a
	srl a
	add 1
	ld l, a
	ld a, (_prx)
	and 7
	ld d, a
	ld a, (_rdz)
	and 7
	ld e, a
	call SPMoveSprAbs
	ld hl, (_p_n_f)
	ld (_p_c_f), hl
	ld c, 254
	ld a, 2
	out (c), a
.i_428
	ld	a,(_isr_c)
	ld	e,a
	ld	d,0
	ld	hl,2	;const
	call	l_ult
	jp	nc,i_429
	halt
	jp	i_428
.i_429
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_isr_c),a
	ld c, 254
	xor a
	out (c), a
	call	sp_UpdateNow
	ld	hl,(_p_killme)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_kill
.i_430
	call	_do_inventory_fiddling
	._mainloop_scripting
	ld a, (_pad)
	and 0x80
	jr nz, mainloop_scripting_action_not_p
	ld a, (_action_pressed)
	jr nz, mainloop_scripting_action_press
	ld a, 1
	ld (_action_pressed), a
	call _run_fire_script
	jr mainloop_scripting_action_press
	.mainloop_scripting_action_not_p
	xor a
	ld (_action_pressed), a
	.mainloop_scripting_action_press
	ld a, (_f_zone_ac)
	jr z, mainloop_scripting_firezone_don
	ld a, (_fzx1)
	ld c, a
	ld a, (_prx)
	cp c
	jr c, mainloop_scripting_firezone_don
	ld a, (_prx)
	ld c, a
	ld a, (_fzx2)
	cp c
	jr c, mainloop_scripting_firezone_don
	ld a, (_fzy1)
	ld c, a
	ld a, (_pry)
	cp c
	jr c, mainloop_scripting_firezone_don
	ld a, (_pry)
	ld c, a
	ld a, (_fzy2)
	cp c
	jr c, mainloop_scripting_firezone_don
	call _run_fire_script
	.mainloop_scripting_firezone_don
	call	_FO_do
	ld	a,(_level_data+7)
	cp	#(0 % 256)
	jp	nz,i_432
	ld	hl,(_p_objs)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data+5)
	ld	h,0
	call	l_eq
	jp	c,i_434
.i_432
	jr	i_432_i_433
.i_433
	ld	a,h
	or	l
	jp	nz,i_434
.i_432_i_433
	ld	a,(_level_data+7)
	cp	#(1 % 256)
	jp	nz,i_435
	ld	hl,(_n_pant)
	ld	h,0
	ex	de,hl
	ld	hl,(_level_data+8)
	ld	h,0
	call	l_eq
	jp	c,i_434
.i_435
	jr	i_435_i_436
.i_436
	ld	a,h
	or	l
	jp	nz,i_434
.i_435_i_436
	ld	a,(_level_data+7)
	cp	#(2 % 256)
	jp	nz,i_437
	ld	a,(_script_result)
	cp	#(1 % 256)
	jp	nz,i_437
	ld	hl,1	;const
	jr	i_438
.i_437
	ld	hl,0	;const
.i_438
	ld	a,h
	or	l
	jp	nz,i_434
	jr	i_439
.i_434
	ld	hl,1	;const
.i_439
	ld	a,h
	or	l
	jp	z,i_431
	ld	a,#(1 % 256 % 256)
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_431
	ld	a,(_p_life)
	cp	#(0 % 256)
	jp	z,i_441
	ld	a,(_script_result)
	cp	#(2 % 256)
	jp	nz,i_440
.i_441
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_440
	ld	a,(_script_result)
	cp	#(2 % 256)
	jp	z,i_443
	jp	c,i_443
	ld	hl,(_script_result)
	ld	h,0
	ld	a,l
	ld	(_success),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_playing),a
.i_443
	call	_flick_screen
	jp	i_418
.i_419
	call	_nosound_stop_sound
	ld	hl,0 % 256	;const
	push	hl
	call	_hide_sprites
	pop	bc
	call	sp_UpdateNow
	ret



._game_do
.i_444
	call	sp_UpdateNow
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,0 % 256	;const
	call	_nosound_play_music
	call	_select_joyfunc
	call	_nosound_stop_sound
	call	_cortina
	ld	a,#(1 % 256 % 256)
	ld	(_mlplaying),a
	ld	a,#(0 % 256 % 256)
	ld	(_silent_level),a
	ld	a,#(9 % 256 % 256)
	ld	(_level),a
	ld	a,#(99 % 256 % 256)
	ld	(_p_life),a
	ld	a,#(0 % 256 % 256)
	ld	(_script_result),a
	ld	a,#(0 % 256 % 256)
	ld	(_p_killme),a
	ld	hl,1 % 256	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,49152	;const
	ld	(_main_script_offset),hl
	ld	hl,32 % 256	;const
	push	hl
	call	_run_script
	pop	bc
.i_446
	ld	hl,(_mlplaying)
	ld	h,0
	ld	a,h
	or	l
	jp	z,i_447
	call	_game_loop
	ld	hl,(_success)
	ld	h,0
.i_450
	ld	a,l
	cp	#(0% 256)
	jp	z,i_451
	cp	#(1% 256)
	jp	z,i_452
	cp	#(3% 256)
	jp	z,i_453
	cp	#(4% 256)
	jp	z,i_454
	jp	i_449
.i_451
	ld	hl,i_1+42
	push	hl
	call	_print_message
	pop	bc
	ld	a,#(0 % 256 % 256)
	ld	(_mlplaying),a
	ld	hl,250	;const
	push	hl
	call	_active_sleep
	pop	bc
	jp	i_449
.i_452
	ld	hl,i_1+55
	push	hl
	call	_print_message
	pop	bc
	ld	hl,(_level)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_level),a
	ld	hl,250	;const
	push	hl
	call	_active_sleep
	pop	bc
	jp	i_449
.i_453
	call	_blackout_area
	ld	hl,(_warp_to_level)
	ld	h,0
	ld	a,l
	ld	(_level),a
	jp	i_449
.i_454
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	ld	hl,1000	;const
	push	hl
	call	_active_sleep
	pop	bc
	call	_nosound_stop_sound
	call	_cortina
	ld	hl,130	;const
	push	hl
	call	_active_sleep
	pop	bc
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_mlplaying),a
.i_449
	jp	i_446
.i_447
	call	_cortina
	jp	i_444
.i_445
	ret



._main
	call	_cortina
	di
	ld	hl,61937	;const
	push	hl
	call	sp_InitIM2
	pop	bc
	ld	hl,61937	;const
	push	hl
	call	sp_CreateGenericISR
	pop	bc
	ld	hl,255 % 256	;const
	push	hl
	ld	hl,_ISR
	push	hl
	call	sp_RegisterHook
	pop	bc
	pop	bc
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
	ld	hl,54 % 256	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,_dynamic_memory_pool
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,766	;const
	ld	(_key_z),hl
	ld	hl,sp_JoyKeyboard
	ld	(_joyfunc),hl
	ld	hl,_tileset
	ld	(_gen_pt),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_457
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	ld	hl,(_gen_pt)
	push	hl
	call	sp_TileArray
	pop	bc
	pop	bc
	ld	hl,(_gen_pt)
	ld	bc,8
	add	hl,bc
	ld	(_gen_pt),hl
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_455
	ld	hl,(_gpit)
	ld	h,0
	ld	a,h
	or	l
	jp	nz,i_457
.i_456
	ld	hl,_spritesClipValues
	ld	(hl),#(1 % 256 % 256)
	ld	hl,_spritesClipValues+1
	ld	(hl),#(1 % 256 % 256)
	ld	hl,_spritesClipValues+1+1
	ld	(hl),#(20 % 256 % 256)
	ld	hl,_spritesClipValues+1+1+1
	ld	(hl),#(30 % 256 % 256)
	ld	hl,_spritesClipValues
	ld	(_spritesClip),hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_sprite_2_a
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
	ld	hl,_sprite_2_b
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_sp_player)
	push	hl
	ld	hl,_sprite_2_c
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_sprite_2_a
	ld	(_p_n_f),hl
	ld	(_p_c_f),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_460
.i_458
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
.i_460
	ld	a,(_gpit)
	cp	#(3 % 256)
	jp	z,i_459
	jp	nc,i_459
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
	ld	de,_sprite_9_a
	push	de
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
	ld	hl,_sprite_9_b
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
	ld	hl,_sprite_9_c
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_en_an_c_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_en_an_n_f
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_sprite_9_a
	pop	de
	call	l_pint
	pop	de
	call	l_pint
	jp	i_458
.i_459
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	ld	de,_sprite_whip
	push	de
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_hitter),hl
	push	hl
	ld	hl,_sprite_whip+32
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_sp_hitter)
	push	hl
	ld	hl,_sprite_whip+64
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_sprite_whip
	ld	(_hitter_c_f),hl
	ld	(_hitter_n_f),hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,2 % 256	;const
	push	hl
	ld	hl,_sprite_shadow
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	(_sp_shadow),hl
	push	hl
	ld	hl,_sprite_shadow+32
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_sp_shadow)
	push	hl
	ld	hl,_sprite_shadow+64
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ei
	call	_game_do
	ret


;	SECTION	text

.i_1
	defm	"            "
	defb	0

	defm	"                         "
	defb	0

	defm	"AD"
	defb	0

	defm	" GAME OVER! "
	defb	0

	defm	" ZONE CLEAR "
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._k2t_cursor	defs	1
._sp_moviles	defs	6
._hitter_type	defs	1
._gpen_cx	defs	1
._gpen_cy	defs	1
.__en_x1	defs	1
.__en_y1	defs	1
.__en_x2	defs	1
.__en_y2	defs	1
._f_o_t	defs	8
._f_o_s	defs	8
._f_o_x	defs	8
._f_o_y	defs	8
._en_an_base_frame	defs	3
._spritesClip	defs	2
._hotspot_x	defs	1
._hotspot_y	defs	1
._p_hitting	defs	1
._en_an_c_f	defs	6
._gpen_xx	defs	1
._gpen_yy	defs	1
._map_pointer	defs	2
.__en_mx	defs	1
.__en_my	defs	1
._en_an_state	defs	3
._flags	defs	128
._fo_au	defs	1
._p_facing	defs	1
._fo_gp	defs	1
._p_frame	defs	1
._en_an_n_f	defs	6
._fo_it	defs	1
._p_c_f	defs	2
._hitter_on	defs	1
._fo_st	defs	1
._pregotten	defs	1
._hit_h	defs	1
._map_buff	defs	160
._k2t_last_key	defs	1
._hit_v	defs	1
._killed_old	defs	1
._p_n_f	defs	2
._gpaux	defs	1
._map_attr	defs	160
._active	defs	1
._k2t_time	defs	1
._key_z	defs	2
._sp_hitter	defs	2
._isr_c	defs	1
._items	defs	3
._its_p	defs	1
.__n	defs	1
._do_respawn	defs	1
.__t	defs	1
._rdint	defs	2
.__x	defs	1
.__y	defs	1
._mlplaying	defs	1
._life_old	defs	1
._p_engine	defs	1
._hitter_c_f	defs	2
._gen_pt	defs	2
._no_draw	defs	1
._p_state	defs	1
._k2t_color	defs	1
._fo_idx	defs	1
._sp_shadow	defs	2
._ptgmx	defs	1
._ptgmy	defs	1
._p_jmp_facing	defs	1
._hitter_n_f	defs	2
._warp_to_level	defs	1
._hitter_hit	defs	1
._sp_player	defs	2
._gp_gen	defs	2
._offs_behs	defs	2
._spritesClipValues	defs	4
._killable	defs	1
._enoffs	defs	1
._silent_level	defs	1
._ctimer	defs	5
._key_fire	defs	2
._gpen_x	defs	1
._gpen_y	defs	1
._p_killme	defs	1
._offs_attr	defs	2
._p_jmp_ct	defs	1
._n_pant	defs	1
._p_jmp_on	defs	1
._fo_x	defs	1
._o_pant	defs	1
._p_life	defs	1
._hitter_x	defs	1
._hitter_y	defs	1
._fo_y	defs	1
._k2t_gpp	defs	2
._p_safe_x	defs	1
._p_safe_y	defs	1
._joyfunc	defs	2
._p_ax	defs	1
._p_objs	defs	1
._p_gotten	defs	1
._fzx1	defs	1
._fzx2	defs	1
._fzy1	defs	1
._fzy2	defs	1
._gpcx	defs	1
._key_jump	defs	2
._playing	defs	1
._p_keys	defs	1
._gpcy	defs	1
._gpit	defs	1
._gpjt	defs	1
._sc_c	defs	1
._main_script_offset	defs	2
._sc_m	defs	1
._sc_n	defs	1
._keys	defs	10
._k2t_ptr	defs	2
._p_rx	defs	1
._sc_x	defs	1
._sc_y	defs	1
._p_vx	defs	1
._p_vy	defs	1
._p_vz	defs	1
._objs_old	defs	1
._maincounter	defs	1
._ptx1	defs	1
._ptx2	defs	1
._pty1	defs	1
._pty2	defs	1
._pty3	defs	1
._f_zone_ac	defs	1
._dynamic_memory_pool	defs	810
.__x1	defs	1
.__y1	defs	1
._action_pressed	defs	1
.__en_life	defs	1
._enemy_shoots	defs	1
._prxx	defs	1
._p_subframe	defs	1
._pryy	defs	1
._its_it	defs	1
._k2t_x0	defs	1
._p_state_ct	defs	1
._animate	defs	1
._next_script	defs	2
._pt1	defs	1
._pt2	defs	1
._gpc	defs	1
._gpd	defs	1
._p_g	defs	1
._hit	defs	1
._pad	defs	1
._p_ct_hole	defs	1
._gps	defs	1
._gpt	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._p_x	defs	2
._p_y	defs	2
._p_z	defs	2
._rdd	defs	1
._rde	defs	1
._keys_old	defs	1
._rds	defs	1
._rdx	defs	1
._rdy	defs	1
._rdz	defs	1
._prx	defs	1
._pry	defs	1
._wall_h	defs	1
._enoffsmasi	defs	1
._k2t_stepbystep	defs	1
._wall_v	defs	1
._k2t_i	defs	1
._tocado	defs	1
._x_pant	defs	1
._k2t_x	defs	1
._k2t_y	defs	1
._p_facing_h	defs	1
._y_pant	defs	1
._p_facing_v	defs	1
._p_thrust	defs	1
._possee	defs	1
._orig_tile	defs	1
._en_an_frame	defs	3
._hitter_frame	defs	1
._success	defs	1
._k2t_selected	defs	1
._en_an_count	defs	3
._k2t_last_character	defs	1
._p_disparando	defs	1
._p_safe_pant	defs	1
._k2t_length	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	LIB	sp_GetKey
	LIB	sp_BlockAlloc
	XDEF	__en_t
	XDEF	_k2t_end_of_conversation
	XDEF	_read_vbyte
	LIB	sp_ScreenStr
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_draw_scr
	LIB	sp_PixelUp
	XDEF	_k2t_show_time
	XDEF	_prepare_level
	XDEF	_nosound_play_music
	LIB	sp_JoyFuller
	XDEF	_k2t_cursor
	LIB	sp_MouseAMXInit
	XDEF	_k2t_menu_text
	XDEF	_k2t_show_text
	XDEF	_blackout_area
	XDEF	_invalidate_fire
	LIB	sp_MouseAMX
	XDEF	_k2t_show_items
	XDEF	_sp_moviles
	XDEF	_hitter_type
	XDEF	_gpen_cx
	XDEF	_gpen_cy
	XDEF	_k2t_menu_display
	XDEF	__en_x1
	LIB	sp_SetMousePosAMX
	XDEF	__en_y1
	XDEF	_u_malloc
	LIB	sp_Validate
	LIB	sp_HashAdd
	XDEF	__en_x2
	XDEF	__en_y2
	XDEF	_f_o_t
	XDEF	_f_o_s
	XDEF	_cortina
	XDEF	_f_o_x
	XDEF	_f_o_y
	LIB	sp_Border
	LIB	sp_Inkey
	XDEF	_d_prs
	XDEF	_en_an_base_frame
	XDEF	_enems_init
	XDEF	_spritesClip
	XDEF	_nosound_play_sound
	XDEF	_hotspot_x
	XDEF	_hotspot_y
	LIB	sp_CreateSpr
	LIB	sp_MoveSprAbs
	LIB	sp_BlockCount
	LIB	sp_AddMemory
	XDEF	_half_life
	XDEF	_p_hitting
	XDEF	_en_an_c_f
	XDEF	_gpen_xx
	XDEF	_gpen_yy
	XDEF	_map_pointer
	XDEF	__en_mx
	XDEF	__en_my
	XDEF	_k2t_code
	XDEF	_k2t_flag
	XDEF	_hoffs_x
	XDEF	_hoffs_y
	XDEF	_en_an_state
	XDEF	_flags
	LIB	sp_PrintAt
	LIB	sp_Pause
	XDEF	_enems_move
	LIB	sp_ListFirst
	LIB	sp_HeapSiftUp
	LIB	sp_ListCount
	XDEF	_fo_au
	XDEF	_k2t_tint_middle_third
	XDEF	_p_facing
	XDEF	_fo_gp
	XDEF	_p_frame
	XDEF	_en_an_n_f
	XDEF	_hitter_do
	LIB	sp_Heapify
	XDEF	_fo_it
	XDEF	_k2t_display_portrait
	XDEF	_sprite_e
	XDEF	_p_c_f
	XDEF	_hitter_on
	XDEF	_sprite_whip
	LIB	sp_MoveSprRel
	XDEF	_fo_st
	XDEF	_hide_sprites
	XDEF	_arrow_sprites
	XDEF	_k2t_init
	XDEF	_pregotten
	XDEF	_hit_h
	LIB	sp_TileArray
	LIB	sp_MouseSim
	LIB	sp_BlockFit
	XDEF	_map_buff
	XDEF	_k2t_last_key
	XDEF	_resources
	XDEF	_hit_v
	LIB	sp_HeapExtract
	LIB	sp_HuffExtract
	XDEF	_killed_old
	LIB	sp_SetMousePosSim
	XDEF	_p_n_f
	XDEF	_gpaux
	LIB	sp_ClearRect
	XDEF	_print_message
	LIB	sp_HuffGetState
	XDEF	_map_attr
	XDEF	_baddies
	XDEF	_active
	XREF	_seed1
	XREF	_seed2
	XDEF	_k2t_time
	LIB	sp_ListAppend
	XDEF	_keyscancodes
	XDEF	_level
	XDEF	_key_z
	LIB	sp_ListCreate
	LIB	sp_ListConcat
	XDEF	_sp_hitter
	XDEF	_k2t_tint
	XDEF	_enemy_kill
	XDEF	_isr_c
	XDEF	_items
	LIB	sp_JoyKempston
	LIB	sp_UpdateNow
	LIB	sp_MouseKempston
	LIB	sp_PrintString
	LIB	sp_PixelDown
	LIB	sp_MoveSprAbsC
	LIB	sp_PixelLeft
	XDEF	_enem_frames
	LIB	sp_InitAlloc
	LIB	sp_DeleteSpr
	XDEF	_its_p
	XDEF	_get_resource
	LIB	sp_JoyTimexEither
	XDEF	__n
	XDEF	_unpack_RAMn
	XDEF	_flick_screen
	XDEF	_do_respawn
	XDEF	_player_kill
	XDEF	__t
	XDEF	_rdint
	XDEF	__x
	XDEF	__y
	XDEF	_mlplaying
	XDEF	_life_old
	LIB	sp_Invalidate
	LIB	sp_CreateGenericISR
	LIB	sp_JoyKeyboard
	LIB	sp_FreeBlock
	LIB	sp_PrintAtDiff
	XDEF	_run_fire_script
	XDEF	_p_engine
	XDEF	_addons_between
	XDEF	_player_move
	XDEF	_hitter_c_f
	XDEF	_gen_pt
	XDEF	_no_draw
	XDEF	_read_byte
	XDEF	_sprite_10_a
	XDEF	_sprite_10_b
	XDEF	_sprite_10_c
	XDEF	_addsign
	XDEF	_sprite_11_a
	XDEF	_sprite_11_b
	XDEF	_sprite_11_c
	XDEF	_sprite_12_a
	XDEF	_sprite_12_b
	XDEF	_p_state
	XDEF	_sprite_12_c
	XDEF	_sprite_13_a
	XDEF	_sprite_13_b
	XDEF	_sprite_13_c
	XDEF	_sprite_14_a
	XDEF	_sprite_14_b
	XDEF	_sprite_14_c
	XDEF	_k2t_color
	XDEF	_sprite_15_a
	XDEF	_fo_idx
	XDEF	_sp_shadow
	LIB	sp_RegisterHookLast
	LIB	sp_IntLargeRect
	LIB	sp_IntPtLargeRect
	LIB	sp_HashDelete
	LIB	sp_GetCharAddr
	XDEF	_ptgmx
	XDEF	_ptgmy
	LIB	sp_RemoveHook
	XDEF	_p_jmp_facing
	XDEF	_hitter_n_f
	XDEF	_warp_to_level
	XDEF	_sprite_15_b
	XDEF	_sprite_15_c
	XDEF	_sprite_16_a
	XDEF	_sprite_16_b
	XDEF	_sprite_16_c
	XDEF	_hitter_hit
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_sprite_17_a
	XDEF	_sprite_18_a
	XDEF	_sprite_19_a
	XDEF	_sprite_19_b
	XDEF	_randres
	XDEF	_player_frames
	XDEF	_FO_do
	XDEF	_sp_player
	XDEF	_stop_player
	XDEF	_init_player
	XDEF	_gp_gen
	LIB	sp_GetTiles
	XDEF	_offs_behs
	XDEF	_spritesClipValues
	LIB	sp_Pallette
	LIB	sp_WaitForNoKey
	XDEF	_killable
	XDEF	_enoffs
	XDEF	_silent_level
	XDEF	_utaux
	XDEF	_ctimer
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	LIB	sp_ListPrepend
	XDEF	_behs
	XDEF	_key_fire
	LIB	sp_GetAttrAddr
	XDEF	_gpen_x
	XDEF	_gpen_y
	LIB	sp_HashCreate
	XDEF	_p_killme
	XDEF	_offs_attr
	LIB	sp_Random32
	LIB	sp_ListInsert
	XDEF	_p_jmp_ct
	LIB	sp_ListFree
	XDEF	_n_pant
	XDEF	_k2t_cls
	XREF	_spriteset
	XDEF	_p_jmp_on
	XDEF	_ISR
	LIB	sp_IntRect
	LIB	sp_ListLast
	LIB	sp_ListCurr
	XDEF	_fo_x
	XDEF	_o_pant
	XDEF	_p_life
	XDEF	_hitter_x
	XDEF	_hitter_y
	XDEF	_fo_y
	XDEF	_k2t_gpp
	XDEF	_p_safe_x
	XDEF	_p_safe_y
	XDEF	_print_number2
	XDEF	_main
	LIB	sp_ListSearch
	LIB	sp_WaitForKey
	XDEF	_draw_coloured_tile
	LIB	sp_Wait
	LIB	sp_GetScrnAddr
	XDEF	_joyfunc
	LIB	sp_PutTiles
	XDEF	_p_ax
	XDEF	_p_objs
	XDEF	_p_gotten
	XDEF	_fzx1
	XDEF	_fzx2
	XDEF	_fzy1
	XDEF	_fzy2
	XDEF	_gpcx
	LIB	sp_RemoveDList
	XDEF	_key_jump
	XDEF	_playing
	XDEF	_p_keys
	XDEF	_gpcy
	XDEF	_gpit
	XDEF	_gpjt
	XDEF	_map_attrs
	XDEF	_sc_c
	XDEF	_main_script_offset
	LIB	sp_ListNext
	XDEF	_print_numberH
	XDEF	_sc_m
	XDEF	_sc_n
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_k2t_ptr
	XDEF	_rand
	XDEF	_k2t_show_time_prx_pry
	LIB	sp_Swap
	XDEF	_p_rx
	XDEF	_run_entering_script
	XDEF	_sc_x
	XDEF	_sc_y
	XDEF	_print_str
	XDEF	_levels
	XDEF	_asm_int_2
	XDEF	_p_vx
	XDEF	_p_vy
	XDEF	_p_vz
	XDEF	_objs_old
	LIB	sp_ListPrev
	XDEF	_maincounter
	XDEF	_ptx1
	XDEF	_ptx2
	XDEF	_pty1
	XDEF	_pty2
	XDEF	_pty3
	XDEF	_FO_unpaint
	XDEF	_active_sleep
	LIB	sp_RegisterHook
	LIB	sp_ListRemove
	LIB	sp_ListTrim
	XDEF	_f_zone_ac
	LIB	sp_MoveSprAbsNC
	XDEF	_game_do
	LIB	sp_HuffDelete
	XDEF	_update_tile
	XDEF	_readxy
	XDEF	_dynamic_memory_pool
	XDEF	__x1
	XDEF	_level_data
	XDEF	__y1
	LIB	sp_ListAdd
	XDEF	_draw_cursor
	LIB	sp_KeyPressed
	XDEF	_action_pressed
	XDEF	_button_pressed
	XDEF	__en_life
	LIB	sp_PrintAtInv
	XDEF	_key_z_pressed
	XDEF	_step
	XDEF	_k2t_do_menu
	XDEF	_draw_coloured_tile_gamearea
	XDEF	_enemy_shoots
	XDEF	_prxx
	LIB	sp_CompDListAddr
	XDEF	_p_subframe
	XDEF	_pryy
	XDEF	_u_free
	XDEF	_its_it
	XDEF	_abs
	XDEF	_k2t_x0
	XDEF	_p_state_ct
	XDEF	_k2t_effect
	LIB	sp_CharRight
	XDEF	_animate
	XDEF	_next_script
	XDEF	_pt1
	XDEF	_pt2
	XDEF	_run_script
	LIB	sp_InstallISR
	XDEF	_print_digitH
	XDEF	_gpc
	XDEF	_gpd
	LIB	sp_HuffAccumulate
	LIB	sp_HuffSetState
	XDEF	_p_g
	XDEF	_hit
	XDEF	_pad
	XDEF	_map
	XDEF	_p_ct_hole
	XDEF	_sprite_1_a
	XDEF	_sprite_1_b
	XDEF	_sprite_1_c
	XDEF	_gps
	XDEF	_gpt
	XDEF	_rda
	XDEF	_rdb
	XDEF	_rdc
	LIB	sp_SwapEndian
	LIB	sp_CharLeft
	XDEF	_p_x
	XDEF	_p_y
	LIB	sp_CharDown
	LIB	sp_HeapSiftDown
	LIB	sp_HuffCreate
	XDEF	_p_z
	XDEF	_rdd
	XDEF	_rde
	XDEF	_update_hud
	XDEF	_sprite_2_a
	XDEF	_keys_old
	LIB	sp_HuffEncode
	XDEF	_rds
	XDEF	_sprite_2_b
	XDEF	_sprite_2_c
	XDEF	_sprite_3_a
	XDEF	_ram_page
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	XDEF	_rdz
	LIB	sp_Initialize
	XDEF	_script_result
	XDEF	_sprite_3_b
	XDEF	_sprite_3_c
	XDEF	_sprite_4_a
	XDEF	_tileset
	XDEF	_sprite_4_b
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	XDEF	_sprite_4_c
	XDEF	_sprite_5_a
	XDEF	_script
	LIB	sp_ComputePos
	XDEF	_sprite_5_b
	XDEF	_sprite_5_c
	XDEF	_prx
	XDEF	_pry
	XDEF	_nosound_stop_sound
	XDEF	_sprite_6_a
	XDEF	_sprite_6_b
	XDEF	_sprite_6_c
	XDEF	_sprite_7_a
	XDEF	_sprite_7_b
	XDEF	_sprite_7_c
	XDEF	_sprite_8_a
	XDEF	_wall_h
	XDEF	_sprite_8_b
	XDEF	_sprite_8_c
	XDEF	_sprite_9_a
	XDEF	_sprite_9_b
	XDEF	_enoffsmasi
	XDEF	_sprite_9_c
	XDEF	_sprite_shadow
	XDEF	_load_subtileset
	XDEF	_k2t_stepbystep
	XDEF	_spacer
	XDEF	_reloc_player
	XDEF	_FO_clear
	XDEF	_wall_v
	XDEF	_k2t_i
	XDEF	_read_offset
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	XDEF	_tocado
	XDEF	_x_pant
	XDEF	_do_gravity
	XDEF	_k2t_x
	XDEF	_do_inventory_fiddling
	LIB	sp_inp
	XDEF	_k2t_y
	XDEF	_k2t_print_limited_text
	XDEF	_SetRAMBank
	LIB	sp_IterateSprChar
	LIB	sp_AddColSpr
	LIB	sp_outp
	XDEF	_FO_add
	XDEF	_sc_terminado
	XDEF	_asm_int
	XDEF	_k2t_is_cutscene
	XDEF	_p_facing_h
	XDEF	_y_pant
	LIB	sp_IntPtInterval
	LIB	sp_RegisterHookFirst
	LIB	sp_HashLookup
	XDEF	_p_facing_v
	LIB	sp_PFill
	XDEF	_p_thrust
	XDEF	_FO_paint_all
	XDEF	_possee
	LIB	sp_HashRemove
	XDEF	_sc_continuar
	LIB	sp_CharUp
	XDEF	_orig_tile
	XDEF	_en_an_frame
	XDEF	_hitter_frame
	XDEF	_success
	LIB	sp_MoveSprRelNC
	XDEF	_FO_paint
	XDEF	_ram_destination
	XDEF	_do_extern_action
	XDEF	_k2t_selected
	XDEF	_en_an_count
	XDEF	_display_items
	XDEF	_select_joyfunc
	XDEF	_k2t_last_character
	XDEF	_p_disparando
	XDEF	_game_loop
	LIB	sp_IterateDList
	XDEF	_draw_scr_background
	XDEF	_screen_level
	LIB	sp_LookupKey
	LIB	sp_HeapAdd
	LIB	sp_CompDirtyAddr
	XDEF	_cur_map_attr
	LIB	sp_EmptyISR
	XDEF	_p_safe_pant
	XDEF	_k2t_length
	XDEF	_k2t_storage
	XDEF	_ram_address
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
