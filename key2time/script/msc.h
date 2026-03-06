// msc.h
// Generado por Mojon Script Compiler 3 de la MT Engine MK2
// Copyleft 2015 The Mojon Twins

#ifdef CLEAR_FLAGS
void msc_init_all (void) {
    for (sc_c = 0; sc_c < MSC_MAXITEMS; sc_c ++)
        items [sc_c] = 0;

    for (sc_c = 0; sc_c < MAX_FLAGS; sc_c ++)
        flags [sc_c] = 0;
}
#endif

unsigned char read_byte (void) {
    unsigned char sc_b;
#ifdef MODE_128K
    #asm
        di
        ld b, SCRIPT_PAGE
        call SetRAMBank
    #endasm
#endif
    sc_b = *script ++;
#ifdef MODE_128K
    #asm
        ld b, 0
        call SetRAMBank
        ei
    #endasm
#endif
    return sc_b;
}

unsigned char __FASTCALL__ read_vbyte (void) {
    sc_c = read_byte ();
    return (sc_c & 128) ? flags [sc_c & 127] : sc_c;
}

void __FASTCALL__ readxy (void) {
    sc_x = read_vbyte ();
    sc_y = read_vbyte ();
}

#if !(defined (PHANTOMAS_ENGINE) || defined (HANNA_ENGINE))
void __FASTCALL__ stop_player (void) {
    p_vx = p_vy = 0;
}
#endif

void __FASTCALL__ reloc_player (void) {
#if defined (PHANTOMAS_ENGINE) || defined (HANNA_ENGINE)
    p_x = read_vbyte () << 4;
    p_y = read_vbyte () << 4;
#else
    p_x = read_vbyte () << (4+FIXBITS);
    p_y = read_vbyte () << (4+FIXBITS);
    stop_player ();
#endif
}

unsigned char *next_script;
void run_script (unsigned char whichs) {

    // main_script_offset contains the address of scripts for current level
    asm_int [0] = main_script_offset + whichs + whichs;
#ifdef DEBUG
    debug_print_16bits (0, 0, asm_int [0]);
#endif

#ifdef MODE_128K
    #asm
        di
        ld b, SCRIPT_PAGE
        call SetRAMBank
    #endasm
#endif
    #asm
        ld hl, (_asm_int)
        ld a, (hl)
        ld (_asm_int_2), a
        inc hl
        ld a, (hl)
        ld (_asm_int_2 + 1), a
    #endasm

    script = (unsigned char *) (asm_int_2 [0]);

#ifdef MODE_128K
    #asm
        ld b, 0
        call SetRAMBank
        ei
    #endasm
#endif

    if (script == 0)
        return;

    script += main_script_offset;
#ifdef DEBUG
    debug_print_16bits (5, 0, script);
#endif

    // Update selected item flag
    flags [FLAG_ITEM_SELECTED] = items [flags [FLAG_SLOT_SELECTED]];

    while ((sc_c = read_byte ()) != 0xFF) {
        next_script = script + sc_c;
        sc_terminado = sc_continuar = 0;
        while (!sc_terminado) {
            switch (read_byte ()) {
                case 0x10:
                    // IF FLAG sc_x = sc_n
                    // Opcode: 10 sc_x sc_n
                    readxy ();
                    sc_terminado = (flags [sc_x] != sc_y);
                    break;
                case 0x20:
                    // IF PLAYER_TOUCHES sc_x, sc_y
                    // Opcode: 20 sc_x sc_y
                    readxy ();
                    sc_x <<= 4; sc_y <<= 4;
#if defined (PHANTOMAS_ENGINE) || defined (HANNA_ENGINE)
                    sc_terminado = (!(p_x >= sc_x - 15 && p_x <= sc_x + 15 && p_y >= sc_y - 15 && p_y <= sc_y + 15));
#elif defined (PLAYER_NEW_GENITAL)
                    //sc_terminado = (0 == (prx + 8 >= sc_x && prx + 8 <= sc_x + 15 && pry + 14 >= sc_y - 15 && pry + 14 <= sc_y + 15));
                    sc_terminado = (0 == (prx + 8 >= sc_x && prx <= sc_x + 7 && pry + 29 >= sc_y && pry <= sc_y + 1));
#else
                    sc_terminado = (!(prx + 15 >= sc_x && prx <= sc_x + 15 && pry + 15 >= sc_y && pry <= sc_y + 15));
#endif
                    break;
                case 0x21:
                    // IF PLAYER_IN_X x1, x2
                    // Opcode: 21 x1 x2
                    sc_x = read_byte ();
                    sc_y = read_byte ();
#if defined (PHANTOMAS_ENGINE) || defined (HANNA_ENGINE)
                    sc_terminado = (!(p_x >= sc_x && p_x <= sc_y));
#else
                    sc_terminado = (!((p_x >> FIXBITS) >= sc_x && (p_x >> FIXBITS) <= sc_y));
#endif
                    break;
                case 0x22:
                    // IF PLAYER_IN_Y y1, y2
                    // Opcode: 22 y1 y2
                    sc_x = read_byte ();
                    sc_y = read_byte ();
#if defined (PHANTOMAS_ENGINE) || defined (HANNA_ENGINE)
                    sc_terminado = (!(p_y >= sc_x && p_y <= sc_y));
#else
                    sc_terminado = (!((p_y >> FIXBITS) >= sc_x && (p_y >> FIXBITS) <= sc_y));
#endif
                    break;
                case 0xF0:
                     // IF TRUE
                     // Opcode: F0
                     break;
                case 0xFF:
                    // THEN
                    // Opcode: FF
                    sc_terminado = 1;
                    sc_continuar = 1;
                    break;
            }
        }
        if (sc_continuar) {
            sc_terminado = 0;
            while (!sc_terminado) {
                switch (read_byte ()) {
                    case 0x00:
                        // SET ITEM sc_x sc_n
                        // Opcode: 00 sc_x sc_n
                        readxy ();
                        items [sc_x] = sc_y;
                        display_items ();
                        break;
                    case 0x01:
                        // SET FLAG sc_x = sc_n
                        // Opcode: 01 sc_x sc_n
                        readxy ();
                        flags [sc_x] = sc_y;
                        break;
                    case 0x51:
                        // SET_FIRE_ZONE x1, y1, x2, y2
                        // Opcode: 51 x1 y1 x2 y2
                        fzx1 = read_byte ();
                        fzy1 = read_byte ();
                        fzx2 = read_byte ();
                        fzy2 = read_byte ();
                        f_zone_ac = 1;
                        break;
                    case 0x68:
                        // SETXY sc_x sc_y
                        reloc_player ();
                        break;
                    case 0x69:
                        // WARP_TO_LEVEL
                        // Opcode: 69 l n_pant x y silent
                        warp_to_level = read_vbyte ();
                        n_pant = read_vbyte ();
                        o_pant = 99;
                        reloc_player ();
                        silent_level = read_vbyte ();
                        sc_terminado = 1;
                        script_result = 3;
                        return;
                    case 0x6E:
                        // REDRAW
                        // Opcode: 6E
                        sc_x = sc_y = 0; 
                        for (sc_c = 0; sc_c < 160; sc_c ++) {
                            _x = sc_x; _y = sc_y; _n = map_attr [sc_c]; _t = map_buff [sc_c]; update_tile ();
                            sc_x ++; if (sc_x == 15) { sc_x = 0; sc_y ++; sc_c ++; }
						}
#ifdef ENABLE_FLOATING_OBJECTS
                        FO_paint_all ();
#endif
						break;
                    case 0x82:
                        // ADD_FLOATING_OBJECT n, x, y
                        sc_n = read_byte ();
                        readxy ();
                        sc_m = FO_add (sc_x, sc_y, sc_n);
                        FO_paint (sc_m);
                        break;
                    case 0xE1:
                        // SHOW
                        // Opcode: E1
                        sp_UpdateNow ();
                        break;
                    case 0xE8:
                        // EXTERN_E n, m
                        // Opcode: 0xE8 n, m
                        do_extern_action (read_byte (), read_byte ());
                        break;
                    case 0xE5:
                        // PAUSE sc_n
                        sc_n = read_vbyte ();
                        while (sc_n --) {
                            #asm
                                halt
                            #endasm
                        }
                        break;
                    case 0xF4:
                        // DECORATIONS
                        while (0xff != (sc_x = read_byte ())) {
                            sc_n = read_byte ();
                            _x = sc_x >> 4; _y = sc_x & 15; _n = behs [sc_n]; _t = sc_n; update_tile ();
                        }
                        break;
                    case 0xFF:
                        sc_terminado = 1;
                        break;
                }
            }
        }
        script = next_script;
    }
}
