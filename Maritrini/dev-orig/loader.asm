; loader.asm
; loads the loader
; by na_th_an - Thanks to Antonio Villena for his tutorials and utilities.

	org $5ccb
	ld  sp, 23999
	di
	db	$de, $c0, $37, $0e, $8f, $39, $96 ;OVER USR 7 ($5ccb)
	
	call blackout

	ld  hl, ULA_VALUES

	ld  bc, $BF3B
	ld  a, $40
	out (c), a

	ld  a, $1
	ld  b, $FF
	out (c), a

	xor a

ULA_LOOP:
	ld  b, $BF
	out (c), a

	ex  af, af'
	ld  a, (hl)
	ld  b, $FF
	out (c), a
	ex  af, af'

	inc hl
	inc a
	cp  $40
	jr  nz, ULA_LOOP

; load screen
	scf
	ld	a, $ff
	ld	ix, $4000
	ld	de, 6912
	call $0556
	di

; RAM1
	ld	a, $11 		; ROM 1, RAM 1
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 11123
	call $0556
	di

; RAM3
	ld	a, $13 		; ROM 1, RAM 3
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 16375
	call $0556
	di

; RAM4
	ld	a, $14 		; ROM 1, RAM 4
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 16369
	call $0556
	di

; RAM6
	ld	a, $16 		; ROM 1, RAM 6
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, $C000
	ld	de, 14039
	call $0556
	di

; Main binary
	ld	a, $10 		; ROM 1, RAM 0
	ld	bc, $7ffd
	out (C), a

	scf
	ld	a, $ff
	ld	ix, 32768
	ld	de, 29228
	call $0556
	di
	
; run game!
	jp 32768

blackout:
	; screen 0
	ld  bc, 767
	ld	hl, $5800
	ld	de, $5801
	ld	(hl), l
	ldir
	ret
	
ULA_VALUES:
	defb $00, $0B, $30, $51, $68, $67, $94, $B7
	defb $00, $0B, $34, $52, $80, $67, $94, $B7
	defb $00, $43, $54, $76, $CC, $A3, $B9, $FF
	defb $00, $43, $58, $76, $CC, $A3, $B9, $FF
	defb $DB, $D8, $C3, $C0, $1B, $18, $02, $00
	defb $DB, $D8, $C3, $C0, $1B, $18, $02, $00
	defb $FF, $FC, $E3, $E0, $1F, $1C, $03, $00 
	defb $FF, $FC, $E3, $E0, $1F, $1C, $03, $00 

