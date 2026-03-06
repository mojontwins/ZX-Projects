// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins




extern unsigned char s_title [];
#asm
	._s_title
		BINARY "bin/title.bin"
#endasm

#ifndef TITLE_HAS_FRAME
	extern unsigned char s_frame [];
	#asm
		._s_frame
			BINARY "bin/frame.bin"
	#endasm
#endif

extern unsigned char s_ending [];
#asm		
	._s_ending
		BINARY "bin/ending.bin"
#endasm
