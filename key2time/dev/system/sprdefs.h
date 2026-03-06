
	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprite_2_a, 1, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_b, TRANSPARENT);
	sp_AddColSpr (sp_player, sprite_2_c, TRANSPARENT);
	p_c_f = p_n_f = sprite_2_a;

	for (gpit = 0; gpit < 3; ++ gpit) {
		sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a, 3, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_b, TRANSPARENT);
		sp_AddColSpr (sp_moviles [gpit], sprite_9_c, TRANSPARENT);
		en_an_c_f [gpit] = en_an_n_f [gpit] = sprite_9_a;
	}

#ifdef PLAYER_CAN_FIRE
	for (gpit = 0; gpit < MAX_BULLETS; ++ gpit) {
		sp_bullets [gpit] = sp_CreateSpr (sp_OR_SPRITE, 2, sprite_19_a, 1, TRANSPARENT);
		sp_AddColSpr (sp_bullets [gpit], sprite_19_a + 32, TRANSPARENT);
	}
#endif

#ifdef ENABLE_FO_CARRIABLE_BOXES
	sp_carriable = sp_CreateSpr (sp_MASK_SPRITE, 3, carriable_a, 2, TRANSPARENT);
	sp_AddColSpr (sp_carriable, carriable_b, TRANSPARENT);
	sp_AddColSpr (sp_carriable, carriable_c, TRANSPARENT);
#endif

	sp_hitter = sp_CreateSpr (sp_MASK_SPRITE, 2, sprite_whip, 2, TRANSPARENT);
	sp_AddColSpr (sp_hitter, sprite_whip + 32, TRANSPARENT);
	sp_AddColSpr (sp_hitter, sprite_whip + 64, TRANSPARENT);
	hitter_n_f = hitter_c_f = sprite_whip;

	sp_shadow = sp_CreateSpr (sp_MASK_SPRITE, 2, sprite_shadow, 3, TRANSPARENT);
	sp_AddColSpr (sp_shadow, sprite_shadow + 32, TRANSPARENT);
	sp_AddColSpr (sp_shadow, sprite_shadow + 64, TRANSPARENT);
