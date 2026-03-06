//

void ending (void) {
	fade_out ();
	wyz_play_music (0);
	get_resource (SCR_COMINGSOON_BIN, 16384, 0);

	mywaitkey ();
	wyz_stop_sound ();
}
