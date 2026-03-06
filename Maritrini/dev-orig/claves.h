// Functions for password manipulation
// And stuff like that.

// First some auxiliary shit

unsigned char digits [] = {
	'0', '1', '2', '3', '4', '5', '6', '7', 
	'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
};

unsigned char hexstring [2];
unsigned char hexvalue;
unsigned char password [10];
unsigned char pass_string [21];

unsigned long ps_score;
unsigned int ps_energy;
unsigned char ps_world;
unsigned char ps_level;

void hex2char () {
	// Puts the value in hexstring into hexvalue.
	unsigned char i;
	hexvalue = 0;
	for (i = 0; i < 2; i ++) {
		if (hexstring [i] >= '0' && hexstring [i] <= '9') {
			hexvalue += (hexstring [i] - '0') << ((1 - i) << 2);
		} else {
			hexvalue += (hexstring [i] - 'A' + 10) << ((1 - i) << 2);
		}	
	}
}

void char2hex () {
	// Puts the value in hexvalue into hexstring.
	hexstring [0] = digits [hexvalue >> 4];
	hexstring [1] = digits [hexvalue & 15];
}

void build_password (unsigned long score, unsigned int energy, unsigned char world, unsigned char level) {
	unsigned char i;
	
	// Builds a password using
	// player.score		S1 S2 S3 S4
	// player.energy    E1 E2
	// world            W1
	// level	        L1
	
	// Password generated is
	// L1* = 69 + L1
	// W1* = W1 + L1
	
	// C1 = (L1 + E2 + S1 + W1) & 255
	// C2 = (E1 + S2 + S4 + L1) & 255
	
	// S1 S3 - S4 W1* - E2 L1* - E1 S2 - C1 C2
	
	password [0] = (score & 255);
	password [1] = ((score >> 16) & 255);
	
	password [2] = ((score >> 24) & 255);
	password [3] = world + level;
	
	password [4] = (energy >> 8) & 255;
	password [5] = 69 + level;
	
	password [6] = (energy & 255);
	password [7] = (score >> 8) & 255;
	
	password [8] = (level + password [4] + password [0] + world) & 255;
	password [9] = (password [6] + password [7] + password [2] + level) & 255;
	
	// Generate string
	
	for (i = 0; i < 10; i ++) {
		hexvalue = password [i];
		char2hex ();
		pass_string [i + i] = hexstring [0];
		pass_string [1 + i + i] = hexstring [1];
	}
}

void whiteout_everything () {
	unsigned char *origin;

	origin = (unsigned char *) 22528;
	while (origin < 23296) {
		*origin = 7;
		origin ++;
	}
}

unsigned char check_password () {
	// Checks the password in pass_string and stuff.
	unsigned char i;
	unsigned char result = 0;
	unsigned char f = 1;
	for (i = 0; i < 20; i ++) {
		if (pass_string [i] != 'F') {
			f = 0;
			break;
		}
	}
	
	if (f) {
		ps_score = 0;
		ps_energy = 200;
		ps_level = 0;
		ps_world = 7;
		return 1;
	}
	
	for (i = 0; i < 10; i ++) {
		hexstring [0] = pass_string [i + i];
		hexstring [1] = pass_string [1 + i + i];
		hex2char ();
		password [i] = hexvalue;	
	}
	
	// Read values
	
	ps_score = (password [2] << 24)	+ (password [1] << 16) + (password [7] << 8) + password [0];
	ps_energy = (password [4] << 8) + password [6];
	ps_level = password [5] - 69;
	ps_world = password [3] - ps_level;
	
	 
	// SOME DEBUG PRINTS
	/*
	whiteout_everything ();
	pass_string [20] = 0;
	draw_fast (0, 8, 71, pass_string);
	
	draw_5_digit (0, 0, ps_score);
	draw_5_digit (0, 2, ps_energy);
	draw_3_digit (0, 4, ps_level);
	draw_3_digit (0, 6, ps_world);
	
	for (i = 0; i < 10; i ++) {
		draw_3_digit (i << 2, 16, password [i]);	
	}
	
	while (in_Inkey ());
	while (!in_Inkey ());
	*/
	
	// Control
	
	if ((password [8] == ((ps_level + password [4] + password [0] + ps_world) & 255)) &&
		(password [9] == ((password [6] + password [7] + password [2] + ps_level) & 255))) {
		result = 1;		
	}
	
	// Done.
	
	return result;
}
