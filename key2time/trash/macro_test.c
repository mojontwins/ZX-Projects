#define ATTR(x,y,d) asm("ld  a, (_"#x")\nld  c,a\nld  a, (_"#y")\nlsa a\nlsa a\nlsa a\nlsa a\nor  c\nld  c, a\nld  b,0\nld hl, _map_attr\nadd hl, bc\nld  a, (hl)\nld (_"#d"), a")

unsigned char rdx, rdy, rda, attr_r;
unsigned char map_attr [160], map_buff [160];

void main (void) {
	ATTR (rdx, rdy, rda);
}
