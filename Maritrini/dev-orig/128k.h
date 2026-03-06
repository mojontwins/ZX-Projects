
void SetRAMBank() {
#asm
	.SetRAMBank
			ld	A, ($5B5C)
			and F8h
			or	B
			ld	BC, $7FFD
			ld	($5B5C), A
			out (C), A	
#endasm
}
