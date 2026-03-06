// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// nosoundplayer.h

// Sound player which does nothing.
// Use this while developing (at least, until your musician delivers)

// isr
#asm
	defw 0
#endasm

void ISR(void) {	
	// Do nothing
	++ isr_c;
}

void __FASTCALL__ nosound_play_sound (unsigned char fx_number) {
	// Do nothing
}

void __FASTCALL__ nosound_play_music (unsigned char song_number) {
	// Do nothing
}

void nosound_stop_sound (void)
{
	// Do nothing
}
