
void SetRAMBank() {
#asm
	.SetRAMBank
			ld  hl, _video_page
			or  (hl)
			ld	BC, $7FFD
			out (C), A	
#endasm
}
