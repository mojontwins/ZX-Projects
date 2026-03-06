// Tenebra Macabre R - Code based on MK1
// Copyleft 2011, 2019 by The Mojon Twins

extern const unsigned char tileset [];
extern const unsigned char metatile_attrs [];

#asm
	._tileset
		BINARY "bin/tileset.bin"
	._metatile_attrs
		BINARY "bin/metatile_attrs.bin"
#endasm
