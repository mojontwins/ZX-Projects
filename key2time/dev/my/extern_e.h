// Key To Time Engine v0.1
// Copyleft 2015, 2019 the Mojon Twins

// extern_e.h
// Extended External custom code to be run from a script

// CUSTOM {
// This file contains code with the "extern" functionality.
// it is generated preprocessing _k2t_ext_helpers.h
// Never edit THIS file, edit the "_" one instead:
#include "work\k2t_ext_helpers.h"

// This should be enough!
#define TEXT_LIMIT 4	

// } END_OF_CUSTOM

void do_extern_action (unsigned char n, unsigned m) {
	if (n < TEXT_LIMIT) {
		k2t_show_text ((n << 8) + m);
	} else {
		switch (n) {
			case 0xf0: 
				// End of conversation
				k2t_end_of_conversation ();
				break;
			case 0xf1: 
				// Arcon
				k2t_storage ();
				break;
			case 0xf2: 
				// Jump_to
				flags [127] = k2t_do_menu (flags [10], flags [127]);
				break;
			case 0xf3:
				k2t_cls ();
				break;
			case 0xf4:
				k2t_show_time ();
				break;
			case 0xf5:
				k2t_effect ();
				break;
			case 0xff: 
				k2t_init ();
				break;
		}
	}
}
