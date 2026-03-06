// Hyper ugly code ahead.
// Just some functions to output text and big numbers.
// If you know how to make them relatively faster,
// please do and give us a call.

extern unsigned char ncx [];
extern unsigned char ncy [];
extern unsigned char ncn [];
extern unsigned char ncc [];

#asm
	.Ashl6_HL
		// A shl 6 -> BBBBBBAA -> 00BBBBBB AA000000
		ld  l, 0

		ld  h, a
		srl h 			// H = 0BBBBBBA, C = A
		rr  l 			// L = A0000000
		srl h 			// H = 00BBBBBB, C = A
		rr  l 			// L = AA000000
		ret

	.HLshr6_A
		// HL shr 6 -> CCBBBBBB AAxxxxxx -> BBBBBBAA
		sla h 
		sla h 			// BBBBBB00

		ld  a, l 
		rlca
		rlca 
		and 0x03 		// 000000AA

		or  h 			// BBBBBBAA
		ret 

	.copy_screen0_to_screen1
		di
		ld  a, 7
		ld	BC, $7FFD
		out (C), A	

		ld  hl, 0x4000
		ld  de, 0xC000
		ld  bc, 6912
		ldir

		xor a
		ld	BC, $7FFD
		out (C), A	
		ei
		ret

	._numbers
		defb   0,  0, 60, 60,102,102,102,102
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0, 56, 56, 24, 24, 24, 24
		defb  24,  0, 24,  0, 60,  0,  0,  0
		defb   0,  0,124,124,  6,  6, 60, 60
		defb  96,  0, 96,  0,126,  0,  0,  0
		defb   0,  0,124,124,  6,  6, 60, 60
		defb   6,  0,  6,  0,124,  0,  0,  0
		defb   0,  0,100,100,100,100,100,100
		defb 100,  0,126,  0,  4,  0,  0,  0
		defb   0,  0,124,124, 96, 96,124,124
		defb  14,  0, 14,  0,124,  0,  0,  0
		defb   0,  0, 60, 60, 96, 96,124,124
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0,126,126,  6,  6,  6,  6
		defb  12,  0, 24,  0, 48,  0,  0,  0
		defb   0,  0, 60, 60,102,102, 60, 60
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0, 60, 60,102,102,102,102
		defb  62,  0,  6,  0, 60,  0,  0,  0
	
	._letters
		defb   0,  0,  0,  0,  0,  0,  0,  0
		defb   0, 24, 24, 24, 24,  0, 24,  0
		defb   0,108,108,  0,  0,  0,  0,  0
		defb   0,108,124,108,108,124,108,  0
		defb   0, 56, 96,112,112, 96, 56,  0
		defb   0, 12, 88, 24, 48, 52, 96,  0
		defb   0,  0, 56, 40, 92, 72, 60,  0
		defb   0, 96, 96,  0,  0,  0,  0,  0
		defb   0,112, 96, 96, 96, 96,112,  0
		defb   0,112, 48, 48, 48, 48,112,  0
		defb   0,  0, 36, 24, 24, 36,  0,  0
		defb   0,  0, 16,124,124, 16,  0,  0
		defb   0,  0,  0,  0,  0, 24, 24,  0
		defb   0,  0,  0,  0,124,  0,  0,  0
		defb   0,  0,  0,  0, 24,  8, 16,  0
		defb   0,  6, 12, 24, 48, 96, 64,  0
		defb   0, 60,102,102,102,102, 60,  0
		defb   0, 56, 24, 24, 24, 24, 60,  0
		defb   0,124,  6, 60, 96, 96,126,  0
		defb   0,124,  6, 60,  6,  6,124,  0
		defb   0,100,100,100,100,126,  4,  0
		defb   0,124, 96,124, 14, 14,124,  0
		defb   0, 60, 96,124,102,102, 60,  0
		defb   0,126,  6,  6, 12, 24, 48,  0
		defb   0, 60,102, 60,102,102, 60,  0
		defb   0, 60,102,102, 62,  6, 60,  0
		defb   0,  0, 24, 24,  0, 24, 24,  0
		defb   0,  0, 24, 24,  0, 24, 16,  0
		defb   0, 24, 48, 96, 48, 24,  0,  0
		defb   0,124,124,  0,  0,124,124,  0
		defb   0, 96, 48, 24, 48, 96,  0,  0
		defb   0,124,  6, 28, 48,  0, 48,  0
		defb   0,126,110,110, 96, 98,126,  0
		defb   0, 60,102,102,126,102,102,  0
		defb   0,124,102,124,102,102,124,  0
		defb   0, 60,102, 96, 96,102, 60,  0
		defb   0,120,108,102,102,102,124,  0
		defb   0,126, 96,124, 96, 96,126,  0
		defb   0,126, 96,124, 96, 96, 96,  0
		defb   0, 60,102, 96,110,102, 60,  0
		defb   0,102,102,126,102,102,102,  0
		defb   0, 24, 24, 24, 24, 24, 24,  0
		defb   0,  6,  6,  6,102,102, 60,  0
		defb   0,102,108,120,120,108,102,  0
		defb   0, 96, 96, 96, 96, 96,126,  0
		defb   0,124, 86, 86, 86, 86, 86,  0
		defb   0,124,102,102,102,102,102,  0
		defb   0, 60,102,102,102,102, 60,  0
		defb   0,124,102,102,124, 96, 96,  0
		defb   0, 60,102,102,102,108, 58,  0
		defb   0,124,102,102,124,100,102,  0
		defb   0, 62, 96,124,  6,126,124,  0
		defb   0,126, 24, 24, 24, 24, 24,  0
		defb   0,102,102,102,102,102, 60,  0
		defb   0,102,102,102, 36, 60, 24,  0
		defb   0, 86, 86, 86, 86, 86,124,  0
		defb   0, 70, 44, 24, 48,100, 66,  0
		defb   0,102,102,126, 24, 24, 24,  0
		defb   0,126, 12, 24, 48, 96,126,  0
		defb   0,112, 96, 96, 96, 96,112,  0
		defb   0, 96, 48, 24, 12,  6,  2,  0
		defb   0, 56, 24, 24, 24, 24, 56,  0
		defb   0, 24, 60,102,  0,  0,  0,  0
		defb   0,  0,  0,  0,  0,  0,  0,  0
		
	._ncx
		defb 0
	._ncy
		defb 0
	._ncc
		defb 0
	._ncn
		defb 0
		
	._line_buffer
		defw $4000, $4020, $4040, $4060, $4080, $40A0, $40C0, $40E0
		defw $4800, $4820, $4840, $4860, $4880, $48A0, $48C0, $48E0
		defw $5000, $5020, $5040, $5060, $5080, $50A0, $50C0, $50E0
#endasm

void draw_big_digit (void) {

	// Modified to draw in BOTH buffers.

#asm
		// Paint in RAM 5

		di
		ld  a, 5
		ld  (_ram_page_act), a

		ld  a, (_pregister)
		and 0xf8
		or  5 					
		ld  bc, $7ffd
		out (c), a
		ei

		call _drawbigdigit

		// Paint in RAM 7

		di
		ld  a, 7
		ld  (_ram_page_act), a
		
		ld  a, (_pregister)
		and 0xf8
		or  7					
		ld  bc, $7ffd
		out (c), a
		ei

		call _drawbigdigit

		// Restore RAM 0

		di
		xor a
		ld  (_ram_page_act), a
		ld  a, (_pregister)
		and 0xf8
		ld  bc, $7ffd
		out (c), a
		ei

		ld  hl, _ncx
		inc (hl)
		ret
#endasm

#asm	
	._drawbigdigit
		ld	a, (_ncy)
		add	a, a
		ld	b, 0
		ld	c, a
		ld	hl, _line_buffer
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	a, (hl)	 		// 0x40-0x50
		add 0x80		 	// 0xC0-0xD0
		ld  d, a
		ex	de, hl	
		; hl <= principio de la linea _ncy
		ld	a, (_ncx)
		ld	b, 0
		ld	c, a
		add	hl, bc
		; hl <= address.
		ex	de, hl
		; de <= address.
		
		ld	a, (_ncn)
		ld	h, 0
		ld	l, a
		add	hl, hl	; * 2
		add	hl, hl	; * 4
		add	hl, hl	; * 8
		add hl, hl	; * 16
		ld	bc, _numbers
		add	hl, bc
		
		push de
		
		; Copy 16 bytes
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc hl
		
		pop	de
		ex	de, hl
		ld	bc, 32
		add	hl, bc
		ex	de, hl
		
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		ret
#endasm	
}

void draw_char () {
#asm
	._drawchar
		ld	a, (_ncy)
		add	a, a
		ld	b, 0
		ld	c, a
		ld	hl, _line_buffer
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		ex	de, hl	
		; hl <= principio de la linea _ncy
		ld	a, (_ncx)
		ld	b, 0
		ld	c, a
		add	hl, bc
		; hl <= address.
		ex	de, hl
		; de <= address.
		
		ld	a, (_ncn)
		ld	h, 0
		ld	l, a
		add	hl, hl	; * 2
		add	hl, hl	; * 4
		add	hl, hl	; * 8
		ld	bc, _letters
		add	hl, bc
		
		; Copy 8 bytes
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
#endasm
	ncx [0] ++;
}
#asm

#endasm
void clear_viewport (unsigned char attr) {
	ncc [0] = attr;
	#asm
		ld	bc, 1
		
	cv_l0:
		xor a
		ld	hl, _line_buffer
		add	hl, bc
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	de
		push bc
		ld	b, 30
		
	cv_l1:
		push de
		
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
	
		pop	de
		inc	de
		
		djnz cv_l1
		pop	bc
		inc	bc
		ld	a, c
		cp	16
		jr	nz, cv_l0
	
	;; Y whiteout
		
		ld	a, (_ncc)
		ld	de, 22561 ; 22528 + 33
		ld	b, 15
	cv_l2:
		push bc
		ld	b, 30
	cv_l3:
		ld	(de), a
		inc	de
		djnz cv_l3
		
		inc	de
		inc	de
		
		pop	bc
		djnz cv_l2
	#endasm
}

void draw_1_digit (unsigned char x, unsigned char y, unsigned char n) {
	ncx [0] = x;
	ncy [0] = y;
	ncn [0] = n;
	draw_big_digit ();
}

void draw_3_digit (unsigned char x, unsigned char y, unsigned char n) {
	ncx [0] = x;
	ncy [0] = y;
	ncn [0] = n / 100;
	draw_big_digit ();
	ncn [0] = (n % 100) / 10;
	draw_big_digit ();
	ncn [0] = n % 10;
	draw_big_digit ();
}

void draw_5_digit (unsigned char x, unsigned char y, unsigned long n) {
	ncx [0] = x;
	ncy [0] = y;
	ncn [0] = n / 100000;
	draw_big_digit ();
	ncn [0] = (n % 100000) / 10000;
	draw_big_digit ();
	ncn [0] = (n % 10000) / 1000;
	draw_big_digit ();
	ncn [0] = (n % 1000) / 100;
	draw_big_digit ();
	ncn [0] = (n % 100) / 10;
	draw_big_digit ();
	ncn [0] = n % 10;
	draw_big_digit ();
}

void mywaitcycles (unsigned int cycles) {
	while (in_Inkey ());
	while (cycles > 0) {
		if (in_Inkey ()) break;
		cycles --;
		#asm
			halt
		#endasm
	};
}

void draw_fast (unsigned char x, unsigned char y, unsigned char clr, char *s) {
	//whiteout_everything ();
	
	dr_ptr = (unsigned char *) (22528 + x + (y << 5));
	ncx [0] = x;
	ncy [0] = y;
	while ((*s) != 0) {
		_c = (*s);
		ncn [0] = _c - 32;
		draw_char ();
		*dr_ptr = clr;
		dr_ptr ++;
		s++;
	}
}

void draw_char_by_char (unsigned char x, unsigned char y, char *s) {
	
	//whiteout_everything ();
	
	dr_ptr = (unsigned char *) (22528 + x + (y << 5));
	ncx [0] = x;
	ncy [0] = y;
	while ((*s) != 0) {
		_c = (*s);
		if (_c == 13) {
			ncx [0] = x;
			ncy [0] += 2;
			dr_ptr = (unsigned char *) (22528 + x + (ncy [0] << 5));
		} else {
			ncn [0] = _c - 32;
			draw_char ();
			for (gpit = 1; gpit < 8; gpit += 2) {
				*dr_ptr = gpit + 64;
				#asm
					halt
				#endasm
				if (in_Inkey ()) {
					*dr_ptr = 71;
					break;	
				}
			}
			dr_ptr ++;
		}
		s++;
	}
}

void puchini () {
	dr_ptr = (unsigned char *) (23265);
	for (gpit = 0; gpit < 32; gpit ++) {
		*(dr_ptr + gpit) = 0;
		#asm
			halt
		#endasm
	}	
}

void draw_char_by_char2 (unsigned char *s) {
	_x = 1;
	
	//whiteout_everything ();
	
	dr_ptr = (unsigned char *) (23265); // (22528 + x + (23 << 5));
	ncx [0] = _x;
	ncy [0] = 23;
	while ((*s) != 0) {
		_c = (*s);
		if (_c == 13) {
			ncx [0] = _x;
			dr_ptr = (unsigned char *) (23265); //(22528 + x + (ncy [0] << 5));
			mywaitcycles (50);
			puchini ();
		} else {
			ncn [0] = _c - 32;
			draw_char ();
			for (gpit = 1; gpit < 8; gpit += 2) {
				*dr_ptr = gpit + 64;
				#asm
					halt
				#endasm
				if (in_Inkey ()) {
					*dr_ptr = 71;
					break;	
				}
			}
			dr_ptr ++;
		}
		s++;
	}
	mywaitcycles (100);
	puchini ();
}

void fade_out () { 
	for (gpit = 0; gpit < 8; gpit ++) {	
		#asm 
			ld   e, 3               ; 3 tercios 
			ld   hl, 22528          ; aquí empiezan los atributos 
			halt                    ; esperamos retrazo. 
		.fade_out_bucle  
			ld   a, (hl )           ; nos traemos el atributo actual 
		 	
			ld   d, a               ; tomar atributo 
			and  7                  ; aislar la tinta 
			jr   z, ink_done        ; si vale 0, no se decrementa 
			dec  a                  ; decrementamos tinta 
		.ink_done 
			ld   b, a               ; en b tenemos ahora la tinta ya procesada. 
			
			ld   a, d               ; tomar atributo 
			and  56                 ; aislar el papel, sin modificar su posiciÃ³n en el byte 
			jr   z, paper_done      ; si vale 0, no se decrementa 
			sub  8                  ; decrementamos papel restando 8 
		.paper_done 
			ld   c, a               ; en c tenemos ahora el papel ya procesado. 
			ld   a, d  
			and  192                ; nos quedamos con bits 6 y 7 (BRIGHT y FLASH) 
			or   c                  ; añadimos paper 
			or   b                  ; e ink, con lo que recompuesto el atributo 
			ld   (hl),a             ; lo escribimos, 
			inc  l                  ; e incrementamos el puntero. 
			jr   nz, fade_out_bucle ; continuamos hasta acabar el tercio (cuando L valga 0) 
			inc  h                  ; siguiente tercio 
			dec  e 
			jr   nz, fade_out_bucle ; repetir las 3 veces 
		#endasm 
	}
}

void mywaitkey () {
	while (in_Inkey ());
	while (!in_Inkey ());
}

void reset_double_buffer (void) {
	ram_page_act = 0;
	video_page = 0;
	pregister = 0x15;
	#asm
			xor a
			call SetRAMBank
	#endasm
}
