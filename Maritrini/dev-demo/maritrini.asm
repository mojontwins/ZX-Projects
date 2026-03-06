;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 18462-8d70c5a-20210624
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Fri Jul 09 17:17:16 2021


	C_LINE	0,"maritrini.c"

	MODULE	maritrini_c


	INCLUDE "z80_crt0.hdr"


	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/sys/compiler.h"
	C_LINE	7,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	17,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	26,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	35,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	40,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	45,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	50,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	55,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	60,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	65,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	70,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	75,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	80,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	85,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	89,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	90,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	91,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	93,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	94,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	95,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	101,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	106,"c:\z88dk\lib\config\..\..\/include/sys/types.h"
	C_LINE	8,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	79,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	80,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	81,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	82,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	84,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	85,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	86,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	87,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	88,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	89,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	90,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	91,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	92,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	161,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	169,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	150,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	151,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	152,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	153,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	154,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	155,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	156,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	157,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	158,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	159,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	160,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	161,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	162,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	163,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	164,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	165,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	166,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	167,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	168,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	169,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	170,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	171,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	172,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	179,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	180,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	181,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	182,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	183,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	191,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	195,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	198,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	201,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	202,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	205,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	206,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	209,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	210,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	212,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	213,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	214,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	215,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	227,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	228,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	230,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	232,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	239,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	247,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	248,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	249,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	251,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	252,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	276,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	277,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	278,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	279,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	280,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	281,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	288,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	289,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	290,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	292,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	293,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	294,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	305,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	306,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	307,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	309,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	310,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	336,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	341,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	349,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	350,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	352,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	353,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	368,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	400,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	401,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	403,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	404,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	406,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	407,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	409,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	410,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	412,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	414,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	415,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	416,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	417,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	419,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	420,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	421,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	422,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	424,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	425,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	426,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	427,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	428,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	440,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	441,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	443,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	444,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	446,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	447,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	449,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	450,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	452,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	454,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	455,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	456,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	457,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	459,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	460,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	6,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	19,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	21,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	23,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	26,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	28,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	30,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	34,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	35,"c:\z88dk\lib\config\..\..\/include/interrupt.h"
	C_LINE	469,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	472,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	475,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	481,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	482,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	484,"c:\z88dk\lib\config\..\..\/include/arch/zx/spectrum.h"
	C_LINE	172,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	276,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	282,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	292,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	293,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	294,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	296,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	297,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	298,"c:\z88dk\lib\config\..\..\/include/input.h"
	C_LINE	42,"maritrini.c"
	C_LINE	0,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	28,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	35,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	36,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	37,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	38,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	39,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	40,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	41,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	43,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	44,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	45,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	46,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	47,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	48,"c:\z88dk\lib\config\..\..\/include/im2.h"
	C_LINE	43,"maritrini.c"
	C_LINE	0,"globals.h"
	C_LINE	3,"globals.h"
	C_LINE	4,"globals.h"
	C_LINE	5,"globals.h"
	C_LINE	6,"globals.h"
	C_LINE	8,"globals.h"
	C_LINE	9,"globals.h"
	C_LINE	10,"globals.h"
	C_LINE	12,"globals.h"
	C_LINE	14,"globals.h"
	C_LINE	16,"globals.h"
	C_LINE	17,"globals.h"
	C_LINE	18,"globals.h"
	C_LINE	20,"globals.h"
	C_LINE	21,"globals.h"
	C_LINE	23,"globals.h"
	C_LINE	24,"globals.h"
	C_LINE	26,"globals.h"
	C_LINE	30,"globals.h"
	SECTION	data_compiler
._keys
	defw	383
	defw	479
	defw	735
	defw	509
	defw	507
	SECTION	code_compiler
	C_LINE	40,"globals.h"
	C_LINE	41,"globals.h"
	C_LINE	45,"globals.h"
	C_LINE	63,"globals.h"
	C_LINE	64,"globals.h"
	SECTION	data_compiler
._start_x
	defb	2
	SECTION	code_compiler
	SECTION	data_compiler
._start_y
	defb	2
	SECTION	code_compiler
	C_LINE	65,"globals.h"
	C_LINE	66,"globals.h"
	C_LINE	70,"globals.h"
	C_LINE	76,"globals.h"
	C_LINE	77,"globals.h"
	C_LINE	81,"globals.h"
	C_LINE	82,"globals.h"
	C_LINE	83,"globals.h"
	C_LINE	84,"globals.h"
	C_LINE	85,"globals.h"
	C_LINE	86,"globals.h"
	C_LINE	87,"globals.h"
	C_LINE	88,"globals.h"
	C_LINE	92,"globals.h"
	C_LINE	93,"globals.h"
	C_LINE	94,"globals.h"
	C_LINE	95,"globals.h"
	C_LINE	96,"globals.h"
	C_LINE	97,"globals.h"
	C_LINE	98,"globals.h"
	C_LINE	99,"globals.h"
	C_LINE	100,"globals.h"
	C_LINE	101,"globals.h"
	C_LINE	105,"globals.h"
	SECTION	data_compiler
._max_recharges
	defb	5
	SECTION	code_compiler
	C_LINE	109,"globals.h"
	C_LINE	110,"globals.h"
	C_LINE	111,"globals.h"
	C_LINE	112,"globals.h"
	C_LINE	113,"globals.h"
	C_LINE	114,"globals.h"
	C_LINE	115,"globals.h"
	C_LINE	116,"globals.h"
	C_LINE	120,"globals.h"
	C_LINE	121,"globals.h"
	C_LINE	122,"globals.h"
	C_LINE	123,"globals.h"
	C_LINE	124,"globals.h"
	C_LINE	125,"globals.h"
	C_LINE	126,"globals.h"
	C_LINE	129,"globals.h"
	C_LINE	130,"globals.h"
	C_LINE	131,"globals.h"
	C_LINE	132,"globals.h"
	C_LINE	133,"globals.h"
	C_LINE	134,"globals.h"
	C_LINE	135,"globals.h"
	C_LINE	139,"globals.h"
	C_LINE	140,"globals.h"
	C_LINE	142,"globals.h"
	C_LINE	143,"globals.h"
	C_LINE	146,"globals.h"
	C_LINE	147,"globals.h"
	C_LINE	148,"globals.h"
	C_LINE	44,"maritrini.c"
	C_LINE	0,"128k.h"
	C_LINE	2,"128k.h"

; Function SetRAMBank flags 0x00000200 __smallc 
; void SetRAMBank()
	C_LINE	2,"128k.h::SetRAMBank::0::0"
._SetRAMBank
	.SetRAMBank
			ld  hl, _video_page
			or  (hl)
			ld	BC, $7FFD
			out (C), A	
	ret


	C_LINE	45,"maritrini.c::SetRAMBank::0::1"
	C_LINE	0,"librarian.h::SetRAMBank::0::1"
	C_LINE	7,"librarian.h::SetRAMBank::0::1"
	C_LINE	12,"librarian.h::SetRAMBank::0::1"
	SECTION	data_compiler
._resources
	defb	3
	defw	49152
	defb	3
	defw	52675
	defb	3
	defw	55834
	defb	3
	defw	58103
	defb	3
	defw	59904
	defb	3
	defw	61456
	defb	3
	defw	62971
	defb	4
	defw	49152
	defb	4
	defw	50629
	defb	4
	defw	52088
	defb	4
	defw	53544
	defb	4
	defw	54980
	defb	4
	defw	56415
	defb	4
	defw	57668
	defb	4
	defw	58878
	defb	4
	defw	60081
	defb	3
	defw	64466
	defb	4
	defw	61245
	defb	4
	defw	62157
	defb	4
	defw	63062
	defb	4
	defw	63945
	defb	6
	defw	49152
	defb	6
	defw	49986
	defb	6
	defw	50818
	defb	6
	defw	51646
	defb	6
	defw	52457
	defb	6
	defw	53262
	defb	6
	defw	54054
	defb	6
	defw	54839
	defb	6
	defw	55584
	defb	4
	defw	64818
	defb	6
	defw	56313
	defb	6
	defw	57011
	defb	6
	defw	57707
	defb	6
	defw	58363
	defb	6
	defw	59009
	defb	6
	defw	59594
	defb	6
	defw	60174
	defb	6
	defw	60746
	defb	6
	defw	61278
	defb	6
	defw	61639
	defb	6
	defw	61917
	defb	6
	defw	62185
	defb	6
	defw	62429
	defb	6
	defw	62640
	defb	3
	defw	65414
	defb	3
	defw	65500
	defb	6
	defw	62792
	defb	6
	defw	62807
	defb	6
	defw	62819
	defb	6
	defw	62830
	defb	6
	defw	62839
	defb	6
	defw	62848
	defb	6
	defw	62857
	SECTION	code_compiler
	C_LINE	46,"maritrini.c::SetRAMBank::0::1"
	C_LINE	0,"aplib.h::SetRAMBank::0::1"
	C_LINE	1,"aplib.h::SetRAMBank::0::1"
	C_LINE	2,"aplib.h::SetRAMBank::0::1"
	C_LINE	3,"aplib.h::SetRAMBank::0::1"
	C_LINE	5,"aplib.h::SetRAMBank::0::1"

; Function blackout_everything flags 0x00000200 __smallc 
; void blackout_everything()
	C_LINE	5,"aplib.h::blackout_everything::0::1"
._blackout_everything
		xor a
		ld  hl, 22528
		ld  de, 22529
		ld  bc, 767
		ld  (hl), a
		ldir
	ret


	C_LINE	18,"aplib.h::blackout_everything::0::2"

; Function get_resource flags 0x00000200 __smallc 
; void get_resource(unsigned char n, unsigned int destination, unsigned char clear)
; parameter 'unsigned char clear' at sp+2 size(1)
; parameter 'unsigned int destination' at sp+4 size(2)
; parameter 'unsigned char n' at sp+6 size(1)
	C_LINE	18,"aplib.h::get_resource::0::2"
._get_resource
	ld	hl,_resources
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	a,(hl)
	ld	(_ram_page),a
	ld	hl,_resources
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	call	l_gint	;
	ld	(_ram_address),hl
	ld	hl,4	;const
	call	l_gintsp	;
	ld	(_ram_destination),hl
	ld	hl,4	;const
	call	l_gintsp	;
	ld	de,16384
	and	a
	sbc	hl,de
	jp	nz,i_8	;
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_8	;
	defc	i_8 = i_7
.i_9_i_8
	call	_blackout_everything
.i_7
		di
		ld a, (_ram_page)
		call SetRAMBank
		ld hl, (_ram_address)
		ld de, (_ram_destination)
		call depack
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	ret


	C_LINE	44,"aplib.h::get_resource::0::3"
; aPPack decompressor
; original source by dwedit
; very slightly adapted by utopian
; optimized by Metalbrain
;hl = source
;de = dest
.depack		ld	ixl,128
.apbranch1	ldi
.aploop0	ld	ixh,1		;LWM = 0
.aploop		call 	ap_getbit
		jr 	nc,apbranch1
		call 	ap_getbit
		jr 	nc,apbranch2
		ld 	b,0
		call 	ap_getbit
		jr 	nc,apbranch3
		ld	c,16		;get an offset
.apget4bits	call 	ap_getbit
		rl 	c
		jr	nc,apget4bits
		jr 	nz,apbranch4
		ld 	a,b
.apwritebyte	ld 	(de),a		;write a 0
		inc 	de
		jr	aploop0
.apbranch4	and	a
		ex 	de,hl 		;write a previous byte (1-15 away from dest)
		sbc 	hl,bc
		ld 	a,(hl)
		add	hl,bc
		ex 	de,hl
		jr	apwritebyte
.apbranch3	ld 	c,(hl)		;use 7 bit offset, length = 2 or 3
		inc 	hl
		rr 	c
		ret 	z		;if a zero is encountered here, it is EOF
		ld	a,2
		adc	a,b
		push 	hl
		ld	iyh,b
		ld	iyl,c
		ld 	h,d
		ld 	l,e
		sbc 	hl,bc
		ld 	c,a
		jr	ap_finishup2
.apbranch2	call 	ap_getgamma	;use a gamma code * 256 for offset, another gamma code for length
		dec 	c
		ld	a,c
		sub	ixh
		jr 	z,ap_r0_gamma		;if gamma code is 2, use old r0 offset,
		dec 	a
		;do I even need this code?
		;bc=bc*256+(hl), lazy 16bit way
		ld 	b,a
		ld 	c,(hl)
		inc 	hl
		ld	iyh,b
		ld	iyl,c
		push 	bc
		call 	ap_getgamma
		ex 	(sp),hl		;bc = len, hl=offs
		push 	de
		ex 	de,hl
		ld	a,4
		cp	d
		jr 	nc,apskip2
		inc 	bc
		or	a
.apskip2	ld 	hl,127
		sbc 	hl,de
		jr 	c,apskip3
		inc 	bc
		inc 	bc
.apskip3		pop 	hl		;bc = len, de = offs, hl=junk
		push 	hl
		or 	a
.ap_finishup	sbc 	hl,de
		pop 	de		;hl=dest-offs, bc=len, de = dest
.ap_finishup2	ldir
		pop 	hl
		ld	ixh,b
		jr 	aploop
.ap_r0_gamma	call 	ap_getgamma		;and a new gamma code for length
		push 	hl
		push 	de
		ex	de,hl
		ld	d,iyh
		ld	e,iyl
		jr 	ap_finishup
.ap_getbit	ld	a,ixl
		add	a,a
		ld	ixl,a
		ret	nz
		ld	a,(hl)
		inc	hl
		rla
		ld	ixl,a
		ret
.ap_getgamma	ld 	bc,1
.ap_getgammaloop	call 	ap_getbit
		rl 	c
		rl 	b
		call 	ap_getbit
		jr 	c,ap_getgammaloop
		ret
	C_LINE	47,"maritrini.c::get_resource::0::3"
	C_LINE	0,"dostercioszx.h::get_resource::0::3"
	C_LINE	7,"dostercioszx.h::get_resource::0::3"
	C_LINE	8,"dostercioszx.h::get_resource::0::3"
	C_LINE	10,"dostercioszx.h::get_resource::0::3"
	C_LINE	11,"dostercioszx.h::get_resource::0::3"
	C_LINE	12,"dostercioszx.h::get_resource::0::3"
	C_LINE	13,"dostercioszx.h::get_resource::0::3"
	C_LINE	19,"dostercioszx.h::get_resource::0::3"
	C_LINE	21,"dostercioszx.h::get_resource::0::3"
	._asm_int
		defw 0
	._seed
		defw 7
	C_LINE	29,"dostercioszx.h::get_resource::0::3"
	C_LINE	35,"dostercioszx.h::get_resource::0::3"

; Function dt_attr flags 0x00000200 __smallc 
; unsigned char dt_attr()
	C_LINE	35,"dostercioszx.h::dt_attr::0::3"
._dt_attr
	ld	hl,(__x)
	ld	h,0
	add	hl,hl
	ld	bc,37633
	add	hl,bc
	push	hl
	ld	hl,(__y)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,64
	and	(hl)
	jp	z,i_10	;
	ld	hl,0	;const
	jp	i_11	;
.i_10
	ld	hl,1	;const
.i_11
	ld	h,0
	ret


	C_LINE	47,"dostercioszx.h::dt_attr::0::4"

; Function dt_putchar flags 0x00000200 __smallc 
; void dt_putchar()
	C_LINE	47,"dostercioszx.h::dt_putchar::0::4"
._dt_putchar
		ld  a, (__y)
		ld  d, 0
		ld  e, a
		ld  hl, 6
		call	l_asl
		ld  a, (__x)
		sla a
		ld  d, 0
		ld  e, a
		add hl, de
		ld  de,  0x9300 
		add hl, de
		ld  a, (__n)
		ld  (hl), a
		ld  a, (__c)
		inc hl
		ld  (hl), a
	ret


	C_LINE	75,"dostercioszx.h::dt_putchar::0::5"

; Function draw_sprite flags 0x00000200 __smallc 
; void draw_sprite()
	C_LINE	75,"dostercioszx.h::draw_sprite::0::5"
._draw_sprite
	._mc_draw_sprite
		; 64 * y + x * 2 + dt_buffer
		ld	a, (_sy)
		ld  l, 0
		ld  h, a
		srl h
		rr  l
		srl h
		rr  l
		push hl
		ld	a, (_sx)
		ld	h, 0
		ld	l, a
		add	hl, hl	; hl = sx * 2
		pop	de
		add	hl, de	; hl = sy * 64 + sx * 2
		ld	de,  0x9300 
		add	hl, de	; hl = dt_buffer + sy * 64 + sx * 2
		ld  a, (_sc)
		ld  d, a 	; D = sc
		ld	a, (_sn)
		sla a
		sla a 		; A = sn*4
		; 4 x (char, attribute)
		ld	(hl), a
		inc	hl
		inc a
		ld  (hl), d
		inc	hl
		ld	(hl), a
		inc hl
		inc a
		ld  (hl), d
		ld	bc, 61
		add	hl, bc
		ld (hl), a
		inc hl
		inc a
		ld (hl), d
		inc hl
		ld (hl), a
		inc hl
		ld  (hl), d
	ret


	C_LINE	141,"dostercioszx.h::draw_sprite::0::6"

; Function draw_map flags 0x00000200 __smallc 
; void draw_map(unsigned char cam_x, unsigned char cam_y)
; parameter 'unsigned char cam_y' at sp+2 size(1)
; parameter 'unsigned char cam_x' at sp+4 size(1)
	C_LINE	141,"dostercioszx.h::draw_map::0::6"
._draw_map
		ld  a, (_cam_x)
		ld  b, a
		srl a
		ld  (_cx), a
		ld  a, b
		and 1
		jr  z, offx_even
	.offx_odd
		xor a
		jr  offx_set
	.offx_even
		ld  a, 2
	.offx_set
		ld  (_offx), a
		ld  a, (_cam_y)
		ld  b, a
		srl a
		ld  (_cy), a
		ld  a, b
		and 1
		jr  z, offy_even
	.offy_odd
		xor a
		jr  offy_set
	.offy_even
		ld  a, 64
	.offy_set
		ld  (_offy), a
	._mc_draw_map
		; First, calculate where to start drawing
		ld	hl,  0x9300 
		ld  bc, (_offx)
		ld  b, 0
		add hl, bc
		ld  bc, (_offy)
		ld  b, 0
		add hl, bc
		push hl
		; Now, calculate where in the map to start
		;  0x8900  + 64*cy + cx
		ld	a, (_cy)
		ld  l, 0
		ld  h, a
		srl h
		rr  l
		srl h
		rr  l
		ld	a, (_cx)
		ld	d, 0
		ld	e, a
		add	hl, de		; hl <= cy * 64 + cx
		ld	de,  0x8900 
		add hl, de
		pop	de
		; de <- where to draw tiles
		; hl <- tiles to draw
		ld	b, 8		; 9 rows of tiles
	._dm_l1
		push bc
		ld	b, 16		; 16 cols of tiles
	._dm_l2
		push bc
		ld	a, (hl)
		inc	hl
		push hl
		push de
		sla	a
		sla a
		ld	b, 0
		ld	c, a
		ld	hl,  0x8000  + 2048
		add	hl, bc
		ex de, hl
		; 4x(char,attrs)
		; HL -> BUFFER
		; DE -> ATTRIBUTES
		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a
		inc hl
		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a
		ld  a, c
		ld  bc, 61
		add hl, bc
		ld  c, a
		ld  (hl), c
		inc hl
		inc c
		ld  a, (de)
		inc de
		ld  (hl), a
		inc hl
		ld  (hl), c
		inc hl
		ld  a, (de)
		ld  (hl), a
		;;
		pop de
		pop hl
		inc de
		inc	de
		inc	de
		inc	de
		pop bc
		djnz _dm_l2
		ld	bc, 48
		add	hl, bc
		ld	bc, 64
		ex	de, hl
		add	hl, bc
		ex	de, hl
		pop	bc
		djnz _dm_l1	
	.flisflolin		
	ret


	C_LINE	333,"dostercioszx.h::draw_map::0::7"

; Function blit_buffer flags 0x00000200 __smallc 
; void blit_buffer()
	C_LINE	333,"dostercioszx.h::blit_buffer::0::7"
._blit_buffer
		di
		ld  a, (_pregister)
		ld	BC, $7FFD
		out (C), A
		ld  d, a
		and 7
		ld  (_ram_page_act), a
		ld  a, d		
		and 8
		ld  (_video_page), a
		ei
		;;
		ld		hl,  0x9300  + 66		; Inicio del buffer, Empezamos en (1, 1)
		;; PRIMER TERCIO
		;ld 		de, $4021
		ld 		de, $C021
		;call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		call	_blit_buffer_process_1	; Copiamos 30 caracteres
		;; SEGUNDO TERCIO
		;ld		de, $4801
		ld		de, $C801
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		call	_blit_buffer_process_2	; Copiamos 30 caracteres
		;; ATRIBUTOS
		ld		hl,  0x9300  + 67		; Inicio del buffer, atributos. Empezamos en (1, 1)
		ld 		de, $D800 + 33 			; Skip 1 line, 1 column
		;call	_blit_attrs				; Copiamos 30 caracteres
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		call	_blit_attrs				; Copiamos 30 atributos
		ld  a, (_pregister)
		xor 10 							 
		ld  (_pregister), a
		ld  b, a
		halt
		di
		and 8
		ld  (_video_page), a
		xor a
		ld  (_ram_page_act), a
	.finally_set_ram0
		ld  a, b
		and 0xf8						 
		ld	BC, $7FFD
		out (C), A
		ei
		ret
	;; Copia 30 atributos de buffer (HL->BUFFER) a SCREEN$
	._blit_attrs
		ldi 
		inc hl 
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
	;
		ldi 
		inc hl
		ldi 
		inc hl 
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
	;
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl 
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
		ldi 
		inc hl
	;
	; Siguiente linea
		inc de
		inc de
		ld		bc, 4
		add		hl, bc					
		ret		
	;; Copia 30 chars del buffer (HL->BUFFER) a SCREEN$
	._blit_buffer_process_1
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Siguiente linea
		inc 	de
		inc		de
		ld 		bc, 4
		add 	hl, bc
		ret
	._blit_buffer_process_2
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Char
		ld 		b,  0x8000  / 256
		ld 		c, (hl)
		call 	_docopy
		inc 	hl
		inc 	hl
		; Siguiente linea
		inc 	de
		inc		de
		ld 		bc, 4
		add 	hl, bc
		ret
	._docopy
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		inc		d
		ld		a, (bc)
		ld		(de), a
		inc b
		ld		a, d
		sub 	7
		ld		d, a
		inc		e
		ret
	ret


	C_LINE	1027,"dostercioszx.h::blit_buffer::0::8"

; Function srand flags 0x00000200 __smallc 
; void srand(unsigned int new_seed)
; parameter 'unsigned int new_seed' at sp+2 size(2)
	C_LINE	1027,"dostercioszx.h::srand::0::8"
._srand
	ld	de,_seed
	pop	bc
	pop	hl
	push	hl
	push	bc
	call	l_pint
	ret


	C_LINE	1031,"dostercioszx.h::srand::0::9"

; Function rand flags 0x00000200 __smallc 
; unsigned char rand()
	C_LINE	1031,"dostercioszx.h::rand::0::9"
._rand
	dec	sp
		.rand16
			ld	hl, _seed
			ld	a, (hl)
			ld	e, a
			inc	hl
			ld	a, (hl)
			ld	d, a
			;; Ahora DE = [SEED]
			ld	a,	d
			ld	h,	e
			ld	l,	253
			or	a
			sbc	hl,	de
			sbc	a, 	0
			sbc	hl,	de
			ld	d, 	0
			sbc	a, 	d
			ld	e,	a
			sbc	hl,	de
			jr	nc,	nextrand
			inc	hl
		.nextrand
			ld	d,	h
			ld	e,	l
			ld	hl, _seed
			ld	a,	e
			ld	(hl), a
			inc	hl
			ld	a,	d
			ld	(hl), a
			;; Ahora [SEED] = HL
			ld 	hl, _asm_int
			ld	a,	e	
			ld	(hl), a
			inc	hl
			ld	a,	d
			ld	(hl), a
			;; Ahora [ASM_INT] = HL
	ld	hl,0	;const
	add	hl,sp
	ex	de,hl
	ld	hl,(_asm_int)
	ld	a,l
	ld	(de),a
	pop	hl
	push	hl
	ld	h,0
	inc	sp
	ret


	C_LINE	48,"maritrini.c::rand::0::10"
	C_LINE	0,"wyzplay.h::rand::0::10"
	C_LINE	19,"wyzplay.h::rand::0::10"

; Function isr flags 0x00000200 __smallc 
; void isr()
	C_LINE	19,"wyzplay.h::isr::0::10"
._isr
	push	af
	push	bc
	push	de
	push	hl
	ex	af,af
	exx
	push	af
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
		ld a, 1
		call SetRAMBank
		call  0xC000 
		ld a, (_ram_page_act)
		call SetRAMBank			
	pop	iy
	pop	ix
	pop	hl
	pop	de
	pop	bc
	pop	af
	exx
	ex	af,af
	pop	hl
	pop	de
	pop	bc
	pop	af
	ei
	reti
	ret


	C_LINE	33,"wyzplay.h::isr::0::12"

; Function wyz_init_soundsystem flags 0x00000200 __smallc 
; void wyz_init_soundsystem()
	C_LINE	33,"wyzplay.h::wyz_init_soundsystem::0::12"
._wyz_init_soundsystem
		ld a,1
		call SetRAMBank
		call  0xC018 	
		ld a, (_ram_page_act)
		call SetRAMBank
	ret


	C_LINE	45,"wyzplay.h::wyz_init_soundsystem::0::13"

; Function wyz_play_sound flags 0x00000200 __smallc 
; void wyz_play_sound(unsigned char fx_number)
; parameter 'unsigned char fx_number' at sp+2 size(1)
	C_LINE	45,"wyzplay.h::wyz_play_sound::0::13"
._wyz_play_sound
	ld	de,_asm_int
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_pint
		di
		ld a,1
		call SetRAMBank
		ld a, (_asm_int)
		ld b, a
		call  0xC46B 
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	ret


	C_LINE	63,"wyzplay.h::wyz_play_sound::0::14"

; Function wyz_play_music flags 0x00000200 __smallc 
; void wyz_play_music(unsigned char song_number)
; parameter 'unsigned char song_number' at sp+2 size(1)
	C_LINE	63,"wyzplay.h::wyz_play_music::0::14"
._wyz_play_music
	ld	de,_asm_int
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_pint
		di
		ld a, 1
		call SetRAMBank
		ld a, (_asm_int)
		call  0xC087 
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	ret


	C_LINE	80,"wyzplay.h::wyz_play_music::0::15"

; Function wyz_stop_sound flags 0x00000200 __smallc 
; void wyz_stop_sound()
	C_LINE	81,"wyzplay.h::wyz_stop_sound::0::15"
._wyz_stop_sound
		di
		ld a,1
		call SetRAMBank
		call  0xC062 
		ld a, (_ram_page_act)
		call SetRAMBank
		ei
	ret


	C_LINE	49,"maritrini.c::wyz_stop_sound::0::16"
	C_LINE	0,"printer.h::wyz_stop_sound::0::16"
	C_LINE	6,"printer.h::wyz_stop_sound::0::16"
	C_LINE	7,"printer.h::wyz_stop_sound::0::16"
	C_LINE	8,"printer.h::wyz_stop_sound::0::16"
	C_LINE	9,"printer.h::wyz_stop_sound::0::16"
	C_LINE	11,"printer.h::wyz_stop_sound::0::16"
	.copy_screen0_to_screen1
		di
		ld  a, 7
		ld	BC, $7FFD
		out (C), A	
		ld  hl, 0x4000
		ld  de, 0xC000
		ld  bc, 6912
		ldir
		xor a
		ld	BC, $7FFD
		out (C), A	
		ei
		ret
	._numbers
		defb   0,  0, 60, 60,102,102,102,102
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0, 56, 56, 24, 24, 24, 24
		defb  24,  0, 24,  0, 60,  0,  0,  0
		defb   0,  0,124,124,  6,  6, 60, 60
		defb  96,  0, 96,  0,126,  0,  0,  0
		defb   0,  0,124,124,  6,  6, 60, 60
		defb   6,  0,  6,  0,124,  0,  0,  0
		defb   0,  0,100,100,100,100,100,100
		defb 100,  0,126,  0,  4,  0,  0,  0
		defb   0,  0,124,124, 96, 96,124,124
		defb  14,  0, 14,  0,124,  0,  0,  0
		defb   0,  0, 60, 60, 96, 96,124,124
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0,126,126,  6,  6,  6,  6
		defb  12,  0, 24,  0, 48,  0,  0,  0
		defb   0,  0, 60, 60,102,102, 60, 60
		defb 102,  0,102,  0, 60,  0,  0,  0
		defb   0,  0, 60, 60,102,102,102,102
		defb  62,  0,  6,  0, 60,  0,  0,  0
	._letters
		defb   0,  0,  0,  0,  0,  0,  0,  0
		defb   0, 24, 24, 24, 24,  0, 24,  0
		defb   0,108,108,  0,  0,  0,  0,  0
		defb   0,108,124,108,108,124,108,  0
		defb   0, 56, 96,112,112, 96, 56,  0
		defb   0, 12, 88, 24, 48, 52, 96,  0
		defb   0,  0, 56, 40, 92, 72, 60,  0
		defb   0, 96, 96,  0,  0,  0,  0,  0
		defb   0,112, 96, 96, 96, 96,112,  0
		defb   0,112, 48, 48, 48, 48,112,  0
		defb   0,  0, 36, 24, 24, 36,  0,  0
		defb   0,  0, 16,124,124, 16,  0,  0
		defb   0,  0,  0,  0,  0, 24, 24,  0
		defb   0,  0,  0,  0,124,  0,  0,  0
		defb   0,  0,  0,  0, 24,  8, 16,  0
		defb   0,  6, 12, 24, 48, 96, 64,  0
		defb   0, 60,102,102,102,102, 60,  0
		defb   0, 56, 24, 24, 24, 24, 60,  0
		defb   0,124,  6, 60, 96, 96,126,  0
		defb   0,124,  6, 60,  6,  6,124,  0
		defb   0,100,100,100,100,126,  4,  0
		defb   0,124, 96,124, 14, 14,124,  0
		defb   0, 60, 96,124,102,102, 60,  0
		defb   0,126,  6,  6, 12, 24, 48,  0
		defb   0, 60,102, 60,102,102, 60,  0
		defb   0, 60,102,102, 62,  6, 60,  0
		defb   0,  0, 24, 24,  0, 24, 24,  0
		defb   0,  0, 24, 24,  0, 24, 16,  0
		defb   0, 24, 48, 96, 48, 24,  0,  0
		defb   0,124,124,  0,  0,124,124,  0
		defb   0, 96, 48, 24, 48, 96,  0,  0
		defb   0,124,  6, 28, 48,  0, 48,  0
		defb   0,126,110,110, 96, 98,126,  0
		defb   0, 60,102,102,126,102,102,  0
		defb   0,124,102,124,102,102,124,  0
		defb   0, 60,102, 96, 96,102, 60,  0
		defb   0,120,108,102,102,102,124,  0
		defb   0,126, 96,124, 96, 96,126,  0
		defb   0,126, 96,124, 96, 96, 96,  0
		defb   0, 60,102, 96,110,102, 60,  0
		defb   0,102,102,126,102,102,102,  0
		defb   0, 24, 24, 24, 24, 24, 24,  0
		defb   0,  6,  6,  6,102,102, 60,  0
		defb   0,102,108,120,120,108,102,  0
		defb   0, 96, 96, 96, 96, 96,126,  0
		defb   0,124, 86, 86, 86, 86, 86,  0
		defb   0,124,102,102,102,102,102,  0
		defb   0, 60,102,102,102,102, 60,  0
		defb   0,124,102,102,124, 96, 96,  0
		defb   0, 60,102,102,102,108, 58,  0
		defb   0,124,102,102,124,100,102,  0
		defb   0, 62, 96,124,  6,126,124,  0
		defb   0,126, 24, 24, 24, 24, 24,  0
		defb   0,102,102,102,102,102, 60,  0
		defb   0,102,102,102, 36, 60, 24,  0
		defb   0, 86, 86, 86, 86, 86,124,  0
		defb   0, 70, 44, 24, 48,100, 66,  0
		defb   0,102,102,126, 24, 24, 24,  0
		defb   0,126, 12, 24, 48, 96,126,  0
		defb   0,112, 96, 96, 96, 96,112,  0
		defb   0, 96, 48, 24, 12,  6,  2,  0
		defb   0, 56, 24, 24, 24, 24, 56,  0
		defb   0, 24, 60,102,  0,  0,  0,  0
		defb   0,  0,  0,  0,  0,  0,  0,  0
	._ncx
		defb 0
	._ncy
		defb 0
	._ncc
		defb 0
	._ncn
		defb 0
	._line_buffer
		defw $4000, $4020, $4040, $4060, $4080, $40A0, $40C0, $40E0
		defw $4800, $4820, $4840, $4860, $4880, $48A0, $48C0, $48E0
		defw $5000, $5020, $5040, $5060, $5080, $50A0, $50C0, $50E0
	C_LINE	134,"printer.h::wyz_stop_sound::0::16"

; Function draw_big_digit flags 0x00000200 __smallc 
; void draw_big_digit()
	C_LINE	134,"printer.h::draw_big_digit::0::16"
._draw_big_digit
		di
		ld  a, 5
		ld  (_ram_page_act), a
		ld  a, (_pregister)
		and 0xf8
		or  5 					
		ld  bc, $7ffd
		out (c), a
		ei
		call _drawbigdigit
		di
		ld  a, 7
		ld  (_ram_page_act), a
		ld  a, (_pregister)
		and 0xf8
		or  7					
		ld  bc, $7ffd
		out (c), a
		ei
		call _drawbigdigit
		di
		xor a
		ld  (_ram_page_act), a
		ld  a, (_pregister)
		and 0xf8
		ld  bc, $7ffd
		out (c), a
		ei
		ld  hl, _ncx
		inc (hl)
		ret
	._drawbigdigit
		ld	a, (_ncy)
		add	a, a
		ld	b, 0
		ld	c, a
		ld	hl, _line_buffer
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	a, (hl)	 		 
		add 0x80		 	 
		ld  d, a
		ex	de, hl	
		; hl <= principio de la linea _ncy
		ld	a, (_ncx)
		ld	b, 0
		ld	c, a
		add	hl, bc
		; hl <= address.
		ex	de, hl
		; de <= address.
		ld	a, (_ncn)
		ld	h, 0
		ld	l, a
		add	hl, hl	; * 2
		add	hl, hl	; * 4
		add	hl, hl	; * 8
		add hl, hl	; * 16
		ld	bc, _numbers
		add	hl, bc
		push de
		; Copy 16 bytes
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc hl
		pop	de
		ex	de, hl
		ld	bc, 32
		add	hl, bc
		ex	de, hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		ret
	ret


	C_LINE	297,"printer.h::draw_big_digit::0::17"

; Function draw_char flags 0x00000208 __smallc __z88dk_fastcall 
; void draw_char()
	C_LINE	297,"printer.h::draw_char::0::17"
._draw_char
	._drawchar
		ld	a, (_ncy)
		add	a, a
		ld	b, 0
		ld	c, a
		ld	hl, _line_buffer
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		ex	de, hl	
		; hl <= principio de la linea _ncy
		ld	a, (_ncx)
		ld	b, 0
		ld	c, a
		add	hl, bc
		; hl <= address.
		ex	de, hl
		; de <= address.
		ld	a, (_ncn)
		ld	h, 0
		ld	l, a
		add	hl, hl	; * 2
		add	hl, hl	; * 4
		add	hl, hl	; * 8
		ld	bc, _letters
		add	hl, bc
		; Copy 8 bytes
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
		inc d
		inc hl
		ld a, (hl)
		ld (de), a
	ld	hl,_ncx
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	dec	l
	ret


	C_LINE	364,"printer.h::draw_char::0::18"
	C_LINE	369,"printer.h::draw_char::0::18"

; Function clear_viewport flags 0x00000200 __smallc 
; void clear_viewport(unsigned char attr)
; parameter 'unsigned char attr' at sp+2 size(1)
	C_LINE	369,"printer.h::clear_viewport::0::18"
._clear_viewport
	ld	de,_ncc
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	l,a
	ld	h,0
		ld	bc, 1
	cv_l0:
		xor a
		ld	hl, _line_buffer
		add	hl, bc
		add	hl, bc
		ld	e, (hl)
		inc	hl
		ld	d, (hl)
		inc	de
		push bc
		ld	b, 30
	cv_l1:
		push de
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		inc	d
		ld	(de), a
		pop	de
		inc	de
		djnz cv_l1
		pop	bc
		inc	bc
		ld	a, c
		cp	16
		jr	nz, cv_l0
	;; Y whiteout
		ld	a, (_ncc)
		ld	de, 22561 ; 22528 + 33
		ld	b, 15
	cv_l2:
		push bc
		ld	b, 30
	cv_l3:
		ld	(de), a
		inc	de
		djnz cv_l3
		inc	de
		inc	de
		pop	bc
		djnz cv_l2
	ret


	C_LINE	438,"printer.h::clear_viewport::0::19"

; Function draw_1_digit flags 0x00000200 __smallc 
; void draw_1_digit(unsigned char x, unsigned char y, unsigned char n)
; parameter 'unsigned char n' at sp+2 size(1)
; parameter 'unsigned char y' at sp+4 size(1)
; parameter 'unsigned char x' at sp+6 size(1)
	C_LINE	438,"printer.h::draw_1_digit::0::19"
._draw_1_digit
	ld	de,_ncx
	ld	hl,6	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncy
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncn
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_draw_big_digit
	ret


	C_LINE	445,"printer.h::draw_1_digit::0::20"

; Function draw_3_digit flags 0x00000200 __smallc 
; void draw_3_digit(unsigned char x, unsigned char y, unsigned char n)
; parameter 'unsigned char n' at sp+2 size(1)
; parameter 'unsigned char y' at sp+4 size(1)
; parameter 'unsigned char x' at sp+6 size(1)
	C_LINE	445,"printer.h::draw_3_digit::0::20"
._draw_3_digit
	ld	de,_ncx
	ld	hl,6	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncy
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,100	;const
	call	l_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,100	;const
	call	l_div_u
	ld	hl,10
	call	l_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ret


	C_LINE	456,"printer.h::draw_3_digit::0::21"

; Function draw_5_digit flags 0x00000200 __smallc 
; void draw_5_digit(unsigned char x, unsigned char y, unsigned long n)
; parameter 'unsigned long n' at sp+2 size(4)
; parameter 'unsigned char y' at sp+6 size(1)
; parameter 'unsigned char x' at sp+8 size(1)
	C_LINE	456,"printer.h::draw_5_digit::0::21"
._draw_5_digit
	ld	de,_ncx
	ld	hl,8	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncy
	ld	hl,6	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_glong2sp
	ld	hl,34464	;const
	ld	de,1
	call	l_long_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_glong2sp
	ld	hl,34464	;const
	ld	de,1
	call	l_long_mod_u
	push	de
	push	hl
	ld	hl,10000	;const
	ld	de,0
	call	l_long_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_glong2sp
	ld	hl,10000	;const
	ld	de,0
	call	l_long_mod_u
	push	de
	push	hl
	ld	hl,1000	;const
	ld	de,0
	call	l_long_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_glong2sp
	ld	hl,1000	;const
	ld	de,0
	call	l_long_mod_u
	push	de
	push	hl
	ld	hl,100	;const
	ld	de,0
	call	l_long_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_gint
	ld	de,100
	ex	de,hl
	call	l_div_u
	ex	de,hl
	ld	de,0
	push	de
	push	hl
	ld	hl,10	;const
	ld	de,0
	call	l_long_div_u
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ld	hl,_ncn
	push	hl
	ld	hl,4	;const
	add	hl,sp
	call	l_gint
	ld	de,10
	ex	de,hl
	call	l_div_u
	ex	de,hl
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_big_digit
	ret


	C_LINE	473,"printer.h::draw_5_digit::0::22"

; Function mywaitcycles flags 0x00000200 __smallc 
; void mywaitcycles(unsigned int cycles)
; parameter 'unsigned int cycles' at sp+2 size(2)
	C_LINE	473,"printer.h::mywaitcycles::0::22"
._mywaitcycles
.i_12
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_12	;EOS
.i_13
.i_14
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a,h
	or	l
	jp	z,i_15	;
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_15	;EOS
.i_16
	pop	de
	pop	hl
	dec	hl
	push	hl
	push	de
	inc	hl
			halt
	jp	i_14	;EOS
.i_15
	ret


	C_LINE	486,"printer.h::mywaitcycles::0::24"

; Function draw_fast flags 0x00000200 __smallc 
; void draw_fast(unsigned char x, unsigned char y, unsigned char clr, char * s)
; parameter 'char * s' at sp+2 size(2)
; parameter 'unsigned char clr' at sp+4 size(1)
; parameter 'unsigned char y' at sp+6 size(1)
; parameter 'unsigned char x' at sp+8 size(1)
	C_LINE	486,"printer.h::draw_fast::0::24"
._draw_fast
	push	bc
	push	bc
	ld	hl,12	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,88
	add	h
	ld	h,a
	push	hl
	ld	hl,12	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	pop	de
	pop	bc
	push	hl
	push	de
	ld	de,_ncx
	ld	hl,12	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncy
	ld	hl,10	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
.i_17
	ld	hl,6	;const
	call	l_gintsp	;
	ld	a,(hl)
	and	a
	jp	z,i_18	;
	ld	hl,0	;const
	add	hl,sp
	ex	de,hl
	ld	hl,6	;const
	call	l_gintsp	;
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncn
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_char
	ld	hl,2	;const
	call	l_gintspsp	;
	ld	hl,10	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	pop	de
	pop	hl
	inc	hl
	push	hl
	push	de
	ld	hl,6	;const
	add	hl,sp
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
	jp	i_17	;EOS
.i_18
	pop	bc
	pop	bc
	ret


	C_LINE	506,"printer.h::draw_fast::0::26"

; Function draw_char_by_char flags 0x00000200 __smallc 
; void draw_char_by_char(unsigned char x, unsigned char y, char * s)
; parameter 'char * s' at sp+2 size(2)
; parameter 'unsigned char y' at sp+4 size(1)
; parameter 'unsigned char x' at sp+6 size(1)
	C_LINE	506,"printer.h::draw_char_by_char::0::26"
._draw_char_by_char
	push	bc
	push	bc
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,88
	add	h
	ld	h,a
	push	hl
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	pop	de
	pop	bc
	push	hl
	push	de
	ld	de,_ncx
	ld	hl,10	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_ncy
	ld	hl,8	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
.i_19
	ld	hl,6	;const
	call	l_gintsp	;
	ld	a,(hl)
	and	a
	jp	z,i_20	;
	ld	hl,0	;const
	add	hl,sp
	ex	de,hl
	ld	hl,6	;const
	call	l_gintsp	;
	ld	a,(hl)
	ld	(de),a
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	cp	13
	jp	nz,i_21	;
	ld	de,_ncx
	ld	hl,10	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncy
	push	hl
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,88
	add	h
	ld	h,a
	push	hl
	ld	hl,(_ncy)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	pop	de
	pop	bc
	push	hl
	push	de
	jp	i_22	;EOS
.i_21
	ld	hl,_ncn
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_char
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),1
	jp	i_25	;EOS
.i_23
	ld	hl,1	;const
	add	hl,sp
	push	hl
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
.i_25
	pop	hl
	push	hl
	ld	l,h
	ld	a,l
	sub	8
	jp	nc,i_24	;
	ld	hl,2	;const
	call	l_gintspsp	;
	ld	hl,3	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,64
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
					halt
	call	in_Inkey
	ld	a,h
	or	l
	jp	z,i_26	;
	ld	hl,2	;const
	add	hl,sp
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,71
	ld	(de),a
	jp	i_24	;EOS
	defc	i_26 = i_23
.i_24
	pop	de
	pop	hl
	inc	hl
	push	hl
	push	de
.i_22
	ld	hl,6	;const
	add	hl,sp
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
	jp	i_19	;EOS
.i_20
	pop	bc
	pop	bc
	ret


	C_LINE	543,"printer.h::draw_char_by_char::0::32"

; Function puchini flags 0x00000200 __smallc 
; void puchini()
	C_LINE	543,"printer.h::puchini::0::32"
._puchini
	dec	sp
	ld	hl,23265	;const
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	(hl),0
	jp	i_29	;EOS
.i_27
	ld	hl,2	;const
	add	hl,sp
	inc	(hl)
.i_29
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	sub	32
	jp	nc,i_28	;
	pop	de
	push	de
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
			halt
	jp	i_27	;EOS
.i_28
	inc	sp
	pop	bc
	ret


	C_LINE	556,"printer.h::puchini::0::34"

; Function draw_char_by_char2 flags 0x00000200 __smallc 
; void draw_char_by_char2(unsigned char * s)
; parameter 'unsigned char * s' at sp+2 size(2)
	C_LINE	556,"printer.h::draw_char_by_char2::0::34"
._draw_char_by_char2
	push	bc
	push	bc
	dec	sp
	pop	hl
	ld	l,1
	push	hl
	ld	hl,3	;const
	add	hl,sp
	ld	(hl),225
	inc	hl
	ld	(hl),90
	ld	de,_ncx
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncy
	ld	(hl),23
.i_30
	ld	hl,7	;const
	call	l_gintsp	;
	ld	a,(hl)
	and	a
	jp	z,i_31	;
	ld	hl,1	;const
	add	hl,sp
	push	hl
	ld	hl,9	;const
	call	l_gintsp	;
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,1	;const
	add	hl,sp
	ld	a,(hl)
	cp	13
	jp	nz,i_32	;
	ld	de,_ncx
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,3	;const
	add	hl,sp
	ld	(hl),225
	inc	hl
	ld	(hl),90
	ld	hl,50	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	call	_puchini
	jp	i_33	;EOS
.i_32
	ld	hl,_ncn
	push	hl
	ld	hl,3	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_char
	ld	hl,2	;const
	add	hl,sp
	ld	(hl),1
	jp	i_36	;EOS
.i_34
	ld	hl,2	;const
	add	hl,sp
	push	hl
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
.i_36
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	sub	8
	jp	nc,i_35	;
	ld	hl,3	;const
	call	l_gintspsp	;
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,64
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
					halt
	call	in_Inkey
	ld	a,h
	or	l
	jp	z,i_37	;
	ld	hl,3	;const
	add	hl,sp
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,71
	ld	(de),a
	jp	i_35	;EOS
	defc	i_37 = i_34
.i_35
	ld	hl,3	;const
	add	hl,sp
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
.i_33
	ld	hl,7	;const
	add	hl,sp
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
	jp	i_30	;EOS
.i_31
	ld	hl,100	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	call	_puchini
	inc	sp
	pop	bc
	pop	bc
	ret


	C_LINE	597,"printer.h::draw_char_by_char2::0::40"

; Function fade_out flags 0x00000200 __smallc 
; void fade_out()
	C_LINE	597,"printer.h::fade_out::0::40"
._fade_out
	xor	a
	ld	(_gpit),a
	jp	i_40	;EOS
.i_38
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_40
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	sub	8
	jp	nc,i_39	;
			ld   e, 3               ; 3 tercios 
			ld   hl, 22528          ; aquí empiezan los atributos 
			halt                    ; esperamos retrazo. 
		.fade_out_bucle  
			ld   a, (hl )           ; nos traemos el atributo actual 
			ld   d, a               ; tomar atributo 
			and  7                  ; aislar la tinta 
			jr   z, ink_done        ; si vale 0, no se decrementa 
			dec  a                  ; decrementamos tinta 
		.ink_done 
			ld   b, a               ; en b tenemos ahora la tinta ya procesada. 
			ld   a, d               ; tomar atributo 
			and  56                 ; aislar el papel, sin modificar su posiciÃ³n en el byte 
			jr   z, paper_done      ; si vale 0, no se decrementa 
			sub  8                  ; decrementamos papel restando 8 
		.paper_done 
			ld   c, a               ; en c tenemos ahora el papel ya procesado. 
			ld   a, d  
			and  192                ; nos quedamos con bits 6 y 7 ( 0x40  y  0x80 ) 
			or   c                  ; añadimos paper 
			or   b                  ; e ink, con lo que recompuesto el atributo 
			ld   (hl),a             ; lo escribimos, 
			inc  l                  ; e incrementamos el puntero. 
			jr   nz, fade_out_bucle ; continuamos hasta acabar el tercio (cuando L valga 0) 
			inc  h                  ; siguiente tercio 
			dec  e 
			jr   nz, fade_out_bucle ; repetir las 3 veces 
	jp	i_38	;EOS
.i_39
	ret


	C_LINE	635,"printer.h::fade_out::0::42"

; Function mywaitkey flags 0x00000200 __smallc 
; void mywaitkey()
	C_LINE	635,"printer.h::mywaitkey::0::42"
._mywaitkey
.i_41
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_41	;EOS
.i_42
.i_43
	call	in_Inkey
	call	l_lneg
	jp	c,i_43	;EOS
.i_44
	ret


	C_LINE	50,"maritrini.c::mywaitkey::0::43"
	C_LINE	0,"levels.h::mywaitkey::0::43"
	C_LINE	10,"levels.h::mywaitkey::0::43"
	C_LINE	21,"levels.h::mywaitkey::0::43"
	C_LINE	22,"levels.h::mywaitkey::0::43"
	C_LINE	23,"levels.h::mywaitkey::0::43"
	C_LINE	24,"levels.h::mywaitkey::0::43"
	C_LINE	25,"levels.h::mywaitkey::0::43"
	C_LINE	27,"levels.h::mywaitkey::0::43"
	C_LINE	31,"levels.h::mywaitkey::0::43"
	._behs
		defs 16
	._intro_cad1
		defm "MARITRINI ARRIVES IN THE"
		defb 13
		defm "FOREST, "
		defb 34
		defm "I'M SURE THIS IS"
		defb 13
		defm "THE RIGHT PLACE"
		defb 34
		defm ". SHE"
		defb 13
		defm "THINKS TO HERSELF,"
		defb 0
	._intro_cad2
		defm "IN THE MIDDLE OF THE WOOD."
		defb 13
		defm "SHE FINDS A SCHOOL-LIKE"
		defb 13
		defm "COMPLEX, "
		defb 34
		defm "VERY SUSPICIOUS!"
		defb 34
		defb 13
		defm "SHE THINKS,"
		defb 0
	._intro_cad3
		defm "MARITRINI DISCOVERS THE"
		defb 13
		defm "SECRET ENTRANCE TO AN"
		defb 13
		defm "UNDERGROUND INSTALLATION"
		defb 13
		defb 34
		defm "INTERESTING,,,"
		defb 34
		defb 0
	._intro_cad4
		defm "MARITRINI KEEP DESCENDING"
		defb 13
		defm "UNTIL SHE HITS WHAT LOOKS"
		defb 13
		defm "LIKE AN UNDERGROUND MINE"
		defb 13
		defb 34
		defm "MISCHIEVOUS!"
		defb 34
		defb 0
	._intro_cad5
		defb 34
		defm "FINALLY, I THINK I FOUND"
		defb 13
		defm "IT!. THINKS MARITRINI,"
		defb 13
		defb 34
		defm "THIS MUST BE WHERE IT"
		defb 13
		defm "ALL CAME FROM!"
		defb 34
		defb 0
	C_LINE	97,"levels.h::mywaitkey::0::43"
	SECTION	data_compiler
._worlds
	defb	7
	defw	_intro_cad1 + 0
	defb	8
	defb	52
	defb	22
	defb	17
	defb	16
	defb	26
	defb	18
	defw	_intro_cad2 + 0
	defb	11
	defb	51
	defb	29
	defb	28
	defb	37
	defb	33
	defb	13
	defw	_intro_cad3 + 0
	defb	10
	defb	48
	defb	21
	defb	27
	defb	30
	defb	25
	defb	3
	defw	_intro_cad4 + 0
	defb	5
	defb	49
	defb	32
	defb	31
	defb	36
	defb	35
	defb	4
	defw	_intro_cad5 + 0
	defb	9
	defb	47
	defb	24
	defb	20
	defb	34
	defb	38
	defb	0
	defw	0
	defb	12
	defb	50
	defb	40
	defb	0
	defb	0
	defb	0
	defb	0
	defw	0
	defb	6
	defb	53
	defb	19
	defb	0
	defb	0
	defb	0
	SECTION	code_compiler
	C_LINE	170,"levels.h::mywaitkey::0::43"

; Function prepare_world flags 0x00000200 __smallc 
; void prepare_world(unsigned char world, unsigned char level)
; parameter 'unsigned char level' at sp+2 size(1)
; parameter 'unsigned char world' at sp+4 size(1)
	C_LINE	170,"levels.h::prepare_world::0::43"
._prepare_world
	ld	hl,_worlds
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_47	;
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	nz,i_47	;
	defc	i_47 = i_46
.i_48_i_47
	ld	hl,0	;const
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,_worlds
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,1	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,3	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,_worlds
	push	hl
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	call	l_gint	;
	push	hl
	call	_draw_char_by_char
	pop	bc
	pop	bc
	pop	bc
.i_49
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_49	;EOS
.i_50
.i_51
	call	in_Inkey
	call	l_lneg
	jp	c,i_51	;EOS
.i_52
	call	_wyz_stop_sound
	call	_fade_out
.i_46
	ld	hl,_worlds
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,32768	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
		.yuruguero
	ld	hl,_worlds
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,4
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_behs
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ret


	C_LINE	197,"levels.h::prepare_world::0::45"

; Function prepare_stage flags 0x00000200 __smallc 
; void prepare_stage(unsigned char world, unsigned char stage)
; parameter 'unsigned char stage' at sp+2 size(1)
; parameter 'unsigned char world' at sp+4 size(1)
	C_LINE	197,"levels.h::prepare_stage::0::45"
._prepare_stage
	dec	sp
	ld	hl,3	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_55
	ld	a,l
	cp	+(1% 256)
	jp	z,i_56	;
	cp	+(2% 256)
	jp	z,i_57	;
	cp	+(3% 256)
	jp	z,i_58	;
	cp	+(4% 256)
	jp	z,i_59	;
	jp	i_54	;EOS
.i_56
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,_worlds
	push	hl
	ld	hl,9	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,5
	add	hl,bc
	ld	a,(hl)
	pop	de
	ld	(de),a
	jp	i_54	;EOS
.i_57
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,_worlds
	push	hl
	ld	hl,9	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	ld	a,(hl)
	pop	de
	ld	(de),a
	jp	i_54	;EOS
.i_58
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,_worlds
	push	hl
	ld	hl,9	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,7
	add	hl,bc
	ld	a,(hl)
	pop	de
	ld	(de),a
	jp	i_54	;EOS
.i_59
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,_worlds
	push	hl
	ld	hl,9	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	dec	hl
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	ld	b,h
	ld	c,l
	add	hl,bc
	add	hl,bc
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	ld	a,(hl)
	pop	de
	ld	(de),a
.i_54
	pop	hl
	push	hl
	ld	h,0
	push	hl
	ld	hl,35072	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	inc	sp
	ret


	C_LINE	51,"maritrini.c::prepare_stage::0::47"
	C_LINE	53,"maritrini.c::prepare_stage::0::47"
	SECTION	data_compiler
._joyfunc
	defw	in_JoyKeyboard + 0
	SECTION	code_compiler
	C_LINE	54,"maritrini.c::prepare_stage::0::47"

; Function clear_keybuff flags 0x00000200 __smallc 
; void clear_keybuff()
	C_LINE	54,"maritrini.c::clear_keybuff::0::47"
._clear_keybuff
.i_61
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_61	;EOS
.i_62
	ret


	C_LINE	57,"maritrini.c::clear_keybuff::0::48"
	C_LINE	0,"claves.h::clear_keybuff::0::48"
	C_LINE	6,"claves.h::clear_keybuff::0::48"
	SECTION	data_compiler
._digits
	defb	48
	defb	49
	defb	50
	defb	51
	defb	52
	defb	53
	defb	54
	defb	55
	defb	56
	defb	57
	defb	65
	defb	66
	defb	67
	defb	68
	defb	69
	defb	70
	SECTION	code_compiler
	C_LINE	11,"claves.h::clear_keybuff::0::48"
	C_LINE	12,"claves.h::clear_keybuff::0::48"
	C_LINE	13,"claves.h::clear_keybuff::0::48"
	C_LINE	14,"claves.h::clear_keybuff::0::48"
	C_LINE	16,"claves.h::clear_keybuff::0::48"
	C_LINE	17,"claves.h::clear_keybuff::0::48"
	C_LINE	18,"claves.h::clear_keybuff::0::48"
	C_LINE	19,"claves.h::clear_keybuff::0::48"
	C_LINE	21,"claves.h::clear_keybuff::0::48"

; Function hex2char flags 0x00000200 __smallc 
; void hex2char()
	C_LINE	21,"claves.h::hex2char::0::48"
._hex2char
	dec	sp
	xor	a
	ld	(_hexvalue),a
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
	jp	i_66	;EOS
.i_64
	ld	hl,0	;const
	add	hl,sp
	inc	(hl)
.i_66
	pop	hl
	push	hl
	ld	a,l
	sub	2
	jp	nc,i_65	;
	ld	de,_hexstring
	pop	hl
	push	hl
	ld	h,0
	add	hl,de
	ld	a,47
	cp	(hl)
	jp	nc,i_68	;
	ld	de,_hexstring
	pop	hl
	push	hl
	ld	h,0
	add	hl,de
	ld	e,(hl)
	ld	d,0
	ld	hl,57	;const
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_68	;
	defc	i_68 = i_67
.i_69_i_68
	ld	hl,(_hexvalue)
	ld	h,0
	push	hl
	ld	de,_hexstring
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	bc,-48
	add	hl,bc
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,1	;const
	and	a
	sbc	hl,de
	add	hl,hl
	add	hl,hl
	pop	de
	call	l_asl
	pop	de
	add	hl,de
	ld	a,l
	ld	(_hexvalue),a
	jp	i_70	;EOS
.i_67
	ld	hl,(_hexvalue)
	ld	h,0
	push	hl
	ld	de,_hexstring
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	bc,-55
	add	hl,bc
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,1	;const
	and	a
	sbc	hl,de
	add	hl,hl
	add	hl,hl
	pop	de
	call	l_asl
	pop	de
	add	hl,de
	ld	a,l
	ld	(_hexvalue),a
	jp	i_64	;EOS
	defc	i_70 = i_64
.i_65
	inc	sp
	ret


	C_LINE	34,"claves.h::hex2char::0::52"

; Function char2hex flags 0x00000200 __smallc 
; void char2hex()
	C_LINE	34,"claves.h::char2hex::0::52"
._char2hex
	ld	hl,_hexstring
	push	hl
	ld	hl,_digits
	push	hl
	ld	hl,(_hexvalue)
	ld	h,0
	ld	a,l
	rrca
	rrca
	rrca
	rrca
	and	15
	ld	l,a
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_hexstring+1
	push	hl
	ld	hl,_digits
	push	hl
	ld	hl,(_hexvalue)
	ld	h,0
	ld	a,15
	and	l
	ld	l,a
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	ret


	C_LINE	40,"claves.h::char2hex::0::53"

; Function build_password flags 0x00000200 __smallc 
; void build_password(unsigned long score, unsigned int energy, unsigned char world, unsigned char level)
; parameter 'unsigned char level' at sp+2 size(1)
; parameter 'unsigned char world' at sp+4 size(1)
; parameter 'unsigned int energy' at sp+6 size(2)
; parameter 'unsigned long score' at sp+8 size(4)
	C_LINE	40,"claves.h::build_password::0::53"
._build_password
	dec	sp
	ld	hl,_password
	push	hl
	ld	hl,11	;const
	add	hl,sp
	call	l_glong
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_password+1
	ld	hl,11	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	de,_password+2
	ld	hl,12	;const
	add	hl,sp
	ld	a,(hl)
	ld	(de),a
	ld	hl,_password+3
	push	hl
	ld	hl,7	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,5	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_password+4
	push	hl
	ld	hl,9	;const
	call	l_gintsp	;
	ld	l,h
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_password+5
	push	hl
	ld	hl,5	;const
	add	hl,sp
	ld	a,(hl)
	add	69
	pop	de
	ld	(de),a
	ld	de,_password+6
	ld	hl,7	;const
	call	l_gintsp	;
	ld	a,l
	ld	(de),a
	ld	hl,_password+7
	push	hl
	ld	hl,12	;const
	add	hl,sp
	ld	e,(hl)
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ex	de,hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_password+8
	push	hl
	ld	hl,5	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,(_password+4)
	ld	h,d
	add	hl,de
	ex	de,hl
	ld	hl,(_password)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_password+9
	push	hl
	ld	de,(_password+6)
	ld	d,0
	ld	hl,(_password+7)
	ld	h,d
	add	hl,de
	ex	de,hl
	ld	hl,(_password+2)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,5	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
	jp	i_73	;EOS
.i_71
	ld	hl,0	;const
	add	hl,sp
	inc	(hl)
.i_73
	pop	hl
	push	hl
	ld	a,l
	sub	10
	jp	nc,i_72	;
	ld	de,_password
	pop	hl
	push	hl
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_hexvalue),a
	call	_char2hex
	ld	hl,_pass_string
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_hexstring
	ld	a,(hl)
	ld	(de),a
	ld	hl,_pass_string
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_hexstring+1
	ld	a,(hl)
	ld	(de),a
	jp	i_71	;EOS
.i_72
	inc	sp
	ret


	C_LINE	83,"claves.h::build_password::0::55"

; Function whiteout_everything flags 0x00000200 __smallc 
; void whiteout_everything()
	C_LINE	83,"claves.h::whiteout_everything::0::55"
._whiteout_everything
	ld	hl,22528	;const
	push	hl
.i_74
	pop	de
	push	de
	ld	hl,23296	;const
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_75	;
	pop	de
	push	de
	ld	a,7
	ld	(de),a
	pop	hl
	inc	hl
	push	hl
	jp	i_74	;EOS
.i_75
	pop	bc
	ret


	C_LINE	93,"claves.h::whiteout_everything::0::57"

; Function check_password flags 0x00000200 __smallc 
; unsigned char check_password()
	C_LINE	93,"claves.h::check_password::0::57"
._check_password
	dec	sp
	ld	hl,1
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	(hl),0
	jp	i_78	;EOS
.i_76
	ld	hl,2	;const
	add	hl,sp
	inc	(hl)
.i_78
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	sub	20
	jp	nc,i_77	;
	ld	de,_pass_string
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	de,70
	and	a
	sbc	hl,de
	scf
	jr	nz,ASMPC+3
	ccf
	jp	nc,i_79	;
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
	jp	i_77	;EOS
	defc	i_79 = i_76
.i_77
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_80	;
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	ld	(_ps_score),hl
	ld	(_ps_score+2),de
	ld	hl,200	;const
	ld	(_ps_energy),hl
	xor	a
	ld	(_ps_level),a
	ld	a,7
	ld	(_ps_world),a
	ld	hl,1	;const
	inc	sp
	pop	bc
	ret


.i_80
	ld	hl,2	;const
	add	hl,sp
	ld	(hl),0
	jp	i_83	;EOS
.i_81
	ld	hl,2	;const
	add	hl,sp
	inc	(hl)
.i_83
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	sub	10
	jp	nc,i_82	;
	ld	hl,_hexstring
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	e,(hl)
	ld	d,0
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_hexstring+1
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	ex	de,hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_hex2char
	ld	de,_password
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_hexvalue
	ld	a,(hl)
	ld	(de),a
	jp	i_81	;EOS
.i_82
	ld	hl,(_password+2)
	ld	h,0
	ld	hl,0	;const
	push	hl
	ld	hl,(_password+1)
	ld	h,0
	ld	hl,0	;const
	pop	de
	add	hl,de
	push	hl
	ld	hl,_password+7
	ld	h,(hl)
	ld	l,0
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_password)
	ld	h,0
	add	hl,de
	ld	de,0
	ld	(_ps_score),hl
	ld	(_ps_score+2),de
	ld	hl,_password+4
	ld	h,(hl)
	ld	l,0
	ex	de,hl
	ld	hl,(_password+6)
	ld	h,0
	add	hl,de
	ld	(_ps_energy),hl
	ld	hl,(_password+5)
	ld	h,0
	ld	bc,-69
	add	hl,bc
	ld	a,l
	ld	(_ps_level),a
	ld	de,(_password+3)
	ld	d,0
	ld	hl,(_ps_level)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_ps_world),a
	ld	hl,(_password+8)
	ld	h,0
	push	hl
	ld	de,(_ps_level)
	ld	d,0
	ld	hl,(_password+4)
	ld	h,d
	add	hl,de
	ex	de,hl
	ld	hl,(_password)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,(_ps_world)
	ld	h,0
	add	hl,de
	ld	h,0
	pop	de
	call	l_eq
	jp	nc,i_85	;
	ld	hl,(_password+9)
	ld	h,0
	push	hl
	ld	de,(_password+6)
	ld	d,0
	ld	hl,(_password+7)
	ld	h,d
	add	hl,de
	ex	de,hl
	ld	hl,(_password+2)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,(_ps_level)
	ld	h,0
	add	hl,de
	ld	h,0
	pop	de
	call	l_eq
	jp	nc,i_85	;
	defc	i_85 = i_84
.i_86_i_85
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),1
.i_84
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	inc	sp
	pop	bc
	ret


	C_LINE	59,"maritrini.c::check_password::0::63"
	C_LINE	0,"ending.h::check_password::0::63"
	C_LINE	3,"ending.h::check_password::0::63"
	SECTION	data_compiler
._attr_resource
	defb	46
	defb	45
	defb	44
	defb	43
	defb	41
	SECTION	code_compiler
	C_LINE	10,"ending.h::check_password::0::63"
	C_LINE	11,"ending.h::check_password::0::63"
	C_LINE	12,"ending.h::check_password::0::63"
	C_LINE	13,"ending.h::check_password::0::63"
	C_LINE	14,"ending.h::check_password::0::63"
	C_LINE	15,"ending.h::check_password::0::63"
	SECTION	data_compiler
._ending_cads
	defw	_ending_cad_0 + 0
	defw	_ending_cad_1 + 0
	defw	_ending_cad_2 + 0
	defw	_ending_cad_3 + 0
	defw	_ending_cad_4 + 0
	SECTION	code_compiler
	C_LINE	19,"ending.h::check_password::0::63"
	._ending_cad_0
		defm "MARITRINI FINALLY ARRIVES TO A"
		defb 13
		defm "SECRET CHAMBER,,,             "
		defb 0
	._ending_cad_1
		defm "'OH! MR, DURAN'S DAUGHTER!'"
		defb 0
	._ending_cad_2
		defm "'FEAR NOT. POOR CHILD,,,'  "
		defb 13
		defm "'THIS IS MARITRINI MCANDREWS'"
		defb 13
		defm "'I'M HERE TO RESCUE YOU,'    "
		defb 0
	._ending_cad_3
		defm "'WAIT. SOMETHING'S HAPPENING!'"
		defb 13
		defm "'A DOCTOR INJECTED SOMETHING  "
		defb 13
		defm "TO ME. I FEEL SO STRANGE!'  "
		defb 0
	._ending_cad_4
		defm "'SOMETHING'S HAPPENNING !'"
		defb 13
		defm "'HELP ME. MARITRINI!'     "
		defb 13
		defm "'HEEEEEEEEELP!!!!'   "
		defb 13
		defm "'AAAAAAAIIIIIEEEEEEEHHHHHHH!!'"
		defb 0
	C_LINE	55,"ending.h::check_password::0::63"

; Function ending flags 0x00000200 __smallc 
; void ending()
	C_LINE	55,"ending.h::ending::0::63"
._ending
	dec	sp
	call	_fade_out
	ld	hl,0	;const
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,1	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
	jp	i_91	;EOS
.i_89
	ld	hl,0	;const
	add	hl,sp
	inc	(hl)
.i_91
	pop	hl
	push	hl
	ld	a,l
	sub	5
	jp	nc,i_90	;
	ld	de,_attr_resource
	pop	hl
	push	hl
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,22528	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_ending_cads
	push	hl
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
	call	_draw_char_by_char2
	pop	bc
	jp	i_89	;EOS
.i_90
	call	_wyz_stop_sound
	call	_fade_out
	ld	hl,7	;const
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,0	;const
	push	hl
	ld	de,16384	;const
	push	de
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	call	_mywaitkey
	call	_wyz_stop_sound
	inc	sp
	ret


	C_LINE	60,"maritrini.c::ending::0::65"
	C_LINE	0,"engine.h::ending::0::65"
	C_LINE	3,"engine.h::ending::0::65"

; Function add_to_score flags 0x00000200 __smallc 
; void add_to_score(unsigned int amount)
; parameter 'unsigned int amount' at sp+2 size(2)
	C_LINE	3,"engine.h::add_to_score::0::65"
._add_to_score
	ld	hl,_player+13
	push	hl
	call	l_glong2sp
	ld	hl,8	;const
	call	l_gintsp	;
	ld	de,0
	call	l_long_add
	pop	bc
	call	l_plong
	ld	hl,25	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	ld	hl,(_player+21)
	ld	de,(_player+21+2)
	call	l_long_ugt
	jp	nc,i_92	;
	ld	bc,_player+21
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	call	l_plong
	ld	hl,25	;const
	push	hl
	ld	hl,21	;const
	push	hl
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_92
	ret


	C_LINE	12,"engine.h::add_to_score::0::67"

; Function destructors_init flags 0x00000200 __smallc 
; void destructors_init()
	C_LINE	12,"engine.h::destructors_init::0::67"
._destructors_init
			ld  bc,  20 
		.destructors_init_loop
			dec c
			ld  hl, _destructors_slots
			add hl, bc
			ld  (hl), c
			ld  hl, _destructors_ct
			add hl, bc
			xor a
			ld  (hl), a
			or  c
			jr  nz, destructors_init_loop
			ld  a,  20 
			ld  (_destructors_slots_i), a
	ret


	C_LINE	45,"engine.h::destructors_init::0::68"

; Function focos_init flags 0x00000200 __smallc 
; void focos_init()
	C_LINE	45,"engine.h::focos_init::0::68"
._focos_init
			ld  bc,  20 
		.focos_init_loop
			dec c
			ld  hl, _focos_slots
			add hl, bc
			ld  (hl), c
			ld  hl, _focos_ct
			add hl, bc
			xor a
			ld  (hl), a
			or  c
			jr  nz, focos_init_loop
			ld  a,  20 
			ld  (_focos_slots_i), a
	ret


	C_LINE	71,"engine.h::focos_init::0::69"

; Function shoots_init flags 0x00000200 __smallc 
; void shoots_init()
	C_LINE	71,"engine.h::shoots_init::0::69"
._shoots_init
			ld  hl, _shoots_active
			ld  de, _shoots_active + 1
			ld  bc,  4  - 1
			xor a
			ld  (hl), a
			ldir
	ret


	C_LINE	85,"engine.h::shoots_init::0::70"

; Function mapdata_init flags 0x00000200 __smallc 
; void mapdata_init()
	C_LINE	85,"engine.h::mapdata_init::0::70"
._mapdata_init
	xor	a
	ld	(_max_spawners),a
	ld	hl,0	;const
	ld	(_gpint),hl
	jp	i_95	;EOS
.i_93
	ld	hl,(_gpint)
	inc	hl
	ld	(_gpint),hl
.i_95
	ld	hl,(_gpint)
	ld	de,2560
	and	a
	sbc	hl,de
	jp	nc,i_94	;
	ld	hl,(_gpint)
	ld	a,l
	and	63
	ld	l,a
	ld	h,0
	add	hl,hl
	ld	a,l
	ld	(_rdx),a
	ld	hl,(_gpint)
	ld	de,6
	call	l_asr_u_hl_by_e
	add	hl,hl
	ld	a,l
	ld	(_rdy),a
	ld	hl,(_gpint)
	ld	a,137
	add	h
	ld	h,a
	ld	(_gp_gen),hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	sub	32
	ccf
	jp	nc,i_96	;
	ld	de,_spawners_y
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_rdy
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_spawners_x
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_rdx
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_spawners_type
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,(_gp_gen)
	ld	l,(hl)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	ld	a,l
	rrca
	rrca
	rrca
	and	31
	ld	l,a
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_spawners_en
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	push	hl
	ld	de,_spawners_type
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	add	4
	pop	de
	ld	(de),a
	ld	de,_spawners_last_spawned
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	hl,_spawners_ptr
	push	hl
	ld	hl,(_max_spawners)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_gp_gen)
	call	l_pint
	ld	hl,_max_spawners
	ld	a,(hl)
	inc	(hl)
	ld	hl,(_gp_gen)
	ld	(hl),12
	jp	i_97	;EOS
.i_96
	ld	hl,(_gp_gen)
	ld	a,(hl)
	cp	16
	jp	nz,i_98	;
	ld	a,(_rdy)
	ld	(_start_y),a
	ld	a,(_rdx)
	ld	(_start_x),a
	ld	hl,(_gp_gen)
	ld	(hl),0
	jp	i_93	;EOS
	defc	i_98 = i_93
	defc	i_97 = i_93
.i_94
	xor	a
	ld	(_gpit),a
	jp	i_101	;EOS
.i_99
	ld	hl,_gpit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_101
	ld	de,(_gpit)
	ld	d,0
	ld	hl,(_max_recharges)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_100	;
.i_104
	call	_rand
	ld	de,40
	ex	de,hl
	call	l_div_u
	ex	de,hl
	ld	h,0
	ld	a,l
	ld	(_rdy),a
	call	_rand
	ld	a,l
	and	63
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(_rdy)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	(_gpint),hl
	ld	a,137
	add	h
	ld	h,a
	ld	(_gp_gen),hl
	ld	a,(hl)
	ld	(_rda),a
.i_102
	ld	de,_behs
	ld	hl,(_rda)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	and	a
	jr	z,ASMPC+3
	scf
	jp	c,i_105	;
	ld	a,(_rda)
	cp	13
	jp	z,i_105	;
	cp	15
	jp	nz,i_103	;
	jp	i_104	;EOS
	defc	i_105 = i_104
.i_103
	ld	hl,(_gp_gen)
	ld	(hl),31
	jp	i_99	;EOS
.i_100
	ret


	C_LINE	132,"engine.h::mapdata_init::0::76"

; Function char_mapdata_attribute flags 0x00000200 __smallc 
; void char_mapdata_attribute()
	C_LINE	132,"engine.h::char_mapdata_attribute::0::76"
._char_mapdata_attribute
	ld	hl,_behs
	push	hl
	ld	hl,(__x)
	ld	h,0
	ld	a,l
	rrca
	and	127
	ld	l,a
	ld	a,137
	add	h
	ld	h,a
	push	hl
	ld	hl,(__y)
	ld	h,0
	ld	a,254
	and	l
	ld	l,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret


	C_LINE	138,"engine.h::char_mapdata_attribute::0::77"

; Function enemies_init flags 0x00000200 __smallc 
; void enemies_init()
	C_LINE	138,"engine.h::enemies_init::0::77"
._enemies_init
			ld  hl, _enemies_type
			ld  de, _enemies_type + 1
			ld  bc,  128  - 1
			xor a
			ld  (hl), a
			ldir
	ret


	C_LINE	155,"engine.h::enemies_init::0::78"

; Function destructors_create flags 0x00000200 __smallc 
; void destructors_create()
	C_LINE	155,"engine.h::destructors_create::0::78"
._destructors_create
	ld	hl,(__x)
	ld	h,0
	ld	a,127
	sub	l
	jp	c,i_108	;
	ld	hl,(__y)
	ld	a,79
	sub	l
	jp	nc,i_107	;
.i_108
	ret


.i_107
	ld	a,(_destructors_slots_i)
	and	a
	jp	z,i_110	;
	ld	a,20
	ld	(_dei),a
.i_111
	ld	a,(_dei)
	and	a
	jp	z,i_112	;
	ld	hl,_dei
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_114	;
	ld	hl,_destructors_address
	push	hl
	ld	hl,(_dei)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_gp_gen)
	call	l_eq
	jp	nc,i_114	;
	defc	i_114 = i_113
.i_115_i_114
	ret
	defc	i_113 = i_111
.i_112
	ld	hl,_destructors_slots_i
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_destructors_slots
	ld	hl,(_destructors_slots_i)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_dei),a
	ld	de,_destructors_x
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__x
	ld	a,(hl)
	ld	(de),a
	ld	de,_destructors_y
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__y
	ld	a,(hl)
	ld	(de),a
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	(hl),8
	ld	hl,_destructors_address
	push	hl
	ld	hl,(_dei)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,(_gp_gen)
	call	l_pint
	ld	hl,_behs
	push	hl
	ld	hl,(_gp_gen)
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	a,48
	and	(hl)
	jp	z,i_116	;
	ld	hl,(_gp_gen)
	ld	(hl),0
.i_116
	ld	hl,1	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
.i_110
	ret


	C_LINE	176,"engine.h::destructors_create::0::81"

; Function destructors_update flags 0x00000200 __smallc 
; void destructors_update()
	C_LINE	176,"engine.h::destructors_update::0::81"
._destructors_update
	ld	a,20
	ld	(_dei),a
.i_117
	ld	a,(_dei)
	and	a
	jp	z,i_118	;
	ld	hl,_dei
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_119	;
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	dec	(hl)
	ld	de,_destructors_x
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_sx),a
	ld	de,_destructors_y
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_sy),a
	ld	hl,(_sx)
	ld	h,0
	ld	a,30
	sub	l
	ccf
	jp	nc,i_121	;
	ld	hl,(_sy)
	ld	h,0
	ld	a,15
	sub	l
	ccf
	jp	nc,i_121	;
	defc	i_121 = i_120
.i_122_i_121
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	rrca
	rrca
	and	63
	ld	l,a
	ld	de,30
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_sn),a
	ld	hl,71	;const
	ld	a,l
	ld	(_sc),a
	call	_draw_sprite
.i_120
	ld	de,_destructors_ct
	ld	hl,(_dei)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	nz,i_123	;
	ld	de,_destructors_slots
	ld	hl,(_destructors_slots_i)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_dei
	ld	a,(hl)
	ld	(de),a
	ld	hl,_destructors_slots_i
	inc	(hl)
	jp	i_117	;EOS
	defc	i_123 = i_117
	defc	i_119 = i_117
.i_118
	ret


	C_LINE	197,"engine.h::destructors_update::0::86"

; Function focos_create flags 0x00000200 __smallc 
; void focos_create()
	C_LINE	197,"engine.h::focos_create::0::86"
._focos_create
	ld	hl,(__x)
	ld	h,0
	ld	a,127
	sub	l
	jp	c,i_125	;
	ld	hl,(__y)
	ld	a,79
	sub	l
	jp	nc,i_124	;
.i_125
	ret


.i_124
	ld	a,(_focos_slots_i)
	and	a
	jp	z,i_127	;
	ld	hl,_focos_slots_i
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_focos_slots
	ld	hl,(_focos_slots_i)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_foic),a
	ld	de,_focos_x
	ld	hl,(_foic)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__x
	ld	a,(hl)
	ld	(de),a
	ld	de,_focos_y
	ld	hl,(_foic)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__y
	ld	a,(hl)
	ld	(de),a
	ld	de,_focos_ct
	ld	hl,(_foic)
	ld	h,0
	add	hl,de
	ld	(hl),2
	ld	de,_focos_propagador
	ld	hl,(_foic)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__n
	ld	a,(hl)
	ld	(de),a
	ld	hl,_player
	call	l_gchar
	push	hl
	ld	hl,(__x)
	ld	h,0
	dec	hl
	pop	de
	call	l_uge
	jp	nc,i_129	;
	ld	hl,_player
	call	l_gchar
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_129	;
	defc	i_129 = i_131
.i_130_i_129
	ld	hl,_player+1
	call	l_gchar
	push	hl
	ld	hl,(__y)
	ld	h,0
	dec	hl
	pop	de
	call	l_uge
	jp	nc,i_132	;
	ld	hl,_player+1
	call	l_gchar
	push	hl
	ld	hl,(__y)
	ld	h,0
	inc	hl
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_132	;
	defc	i_132 = i_131
.i_133_i_132
	defc	i_131 = i_128
.i_134_i_131
	ld	hl,(_player+10)
	ld	de,25
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_135	;
	ld	hl,_player+10
	push	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,-25
	add	hl,bc
	call	l_pint_pop
	jp	i_136	;EOS
.i_135
	ld	hl,1	;const
	ld	(_player+10),hl
.i_136
.i_128
	ld	hl,(__x)
	ld	h,0
	ld	a,l
	rrca
	and	127
	ld	l,a
	push	hl
	ld	hl,(__y)
	ld	h,0
	ld	a,l
	rrca
	and	127
	ld	l,a
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	(_whichtile),hl
	ld	a,137
	add	h
	ld	h,a
	ld	(_gp_gen),hl
	ld	hl,_behs
	push	hl
	ld	hl,(_gp_gen)
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	a,32
	and	(hl)
	jp	z,i_137	;
	ld	hl,(_gp_gen)
	ld	(hl),0
.i_137
	ld	hl,(_gp_gen)
	ld	a,(hl)
	cp	12
	jp	nz,i_138	;
	xor	a
	ld	(_si),a
	jp	i_141	;EOS
.i_139
	ld	hl,_si
	ld	a,(hl)
	inc	(hl)
.i_141
	ld	de,(_si)
	ld	d,0
	ld	hl,(_max_spawners)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_140	;
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_143	;
	ld	hl,_spawners_ptr
	push	hl
	ld	hl,(_si)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl,(_gp_gen)
	call	l_eq
	jp	nc,i_143	;
	defc	i_143 = i_142
.i_144_i_143
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	push	hl
	call	_add_to_score
	pop	bc
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	hl,(_gp_gen)
	ld	(hl),0
	jp	i_139	;EOS
	defc	i_142 = i_139
.i_140
.i_138
	call	_destructors_create
.i_127
	ret


	C_LINE	235,"engine.h::focos_create::0::91"

; Function focos_update flags 0x00000200 __smallc 
; void focos_update()
	C_LINE	235,"engine.h::focos_update::0::91"
._focos_update
	ld	a,20
	ld	(_foi),a
.i_145
	ld	a,(_foi)
	and	a
	jp	z,i_146	;
	ld	hl,_foi
	dec	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_focos_ct
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_147	;
	ld	de,_focos_ct
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	dec	(hl)
	ld	de,_focos_ct
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	de,0
	call	l_eq
	jp	nc,i_148	;
	ld	de,_focos_slots
	ld	hl,(_focos_slots_i)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_foi
	ld	a,(hl)
	ld	(de),a
	ld	hl,_focos_slots_i
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	ld	de,_focos_propagador
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_149	;
	ld	de,_focos_propagador
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	dec	l
	ld	a,l
	ld	(__n),a
	ld	de,_focos_x
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_rdx),a
	ld	de,_focos_y
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	ld	(_rdy),a
	ld	hl,(_rdx)
	ld	h,0
	dec	hl
	dec	hl
	ld	a,l
	ld	(__x),a
	ld	hl,(_rdy)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_focos_create
	ld	hl,(_rdx)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__x),a
	call	_focos_create
	ld	a,(_rdx)
	ld	(__x),a
	ld	hl,(_rdy)
	ld	h,0
	dec	hl
	dec	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_focos_create
	ld	hl,(_rdy)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_focos_create
	jp	i_145	;EOS
	defc	i_149 = i_145
	defc	i_148 = i_145
	defc	i_147 = i_145
.i_146
	ret


	C_LINE	258,"engine.h::focos_update::0::96"

; Function shoots_find flags 0x00000200 __smallc 
; unsigned char shoots_find()
	C_LINE	258,"engine.h::shoots_find::0::96"
._shoots_find
			ld  a, (_n_shoots)
			ld  b, a
			ld  c, 0
			ld  hl, _shoots_active
		.shoots_find_loop
			ld  a, (hl)
			or  a
			jr  z, shoots_find_loop_done
			inc hl
			inc c
			djnz shoots_find_loop
			ld  c, 0xff
		.shoots_find_loop_done
			ld  l, c 				 
			ld  h, 0
	ret


	C_LINE	285,"engine.h::shoots_find::0::97"

; Function enemies_find flags 0x00000200 __smallc 
; unsigned char enemies_find()
	C_LINE	285,"engine.h::enemies_find::0::97"
._enemies_find
			ld  b,  128 
			ld  c, 0
			ld  hl, _enemies_type
		.enemies_find_loop
			ld  a, (hl)
			or  a
			jr  z, enemies_find_loop_done
			inc hl
			inc c
			djnz enemies_find_loop
			ld  c, 0xff
		.enemies_find_loop_done
			ld  l, c 				 
			ld  h, 0
	ret


	C_LINE	316,"engine.h::enemies_find::0::98"

; Function draw_shoot flags 0x00000200 __smallc 
; void draw_shoot()
	C_LINE	316,"engine.h::draw_shoot::0::98"
._draw_shoot
			ld  bc, (_bi)
			ld  b, 0
			ld  de, (_cam_x)
			ld  hl, _shoots_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub e
			ld  (__x), a
			ld  de, (_cam_y)
			ld  hl, _shoots_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub e 
			ld  (__y), a
			ld  a, 112
			ld  (__n), a
			ld  a, 70
			ld  (__c), a
			call _dt_putchar
			ld  bc, (_bi)
			ld  b, 0
			ld  de, (_cam_x)
			ld  hl, _shoots_trail_dx
			add hl, bc
			ld  d, (hl)
			ld  hl, _shoots_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub e
			add d
			ld  (__x), a
			ld  de, (_cam_y)
			ld  hl, _shoots_trail_dy
			add hl, bc
			ld  d, (hl)
			ld  hl, _shoots_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub e 
			add d
			ld  (__y), a
			ld  a, 113
			ld  (__n), a
			ld  a, 66
			ld  (__c), a
			call _dt_putchar
	ret


	C_LINE	426,"engine.h::draw_shoot::0::99"

; Function shoots_move flags 0x00000200 __smallc 
; void shoots_move()
	C_LINE	426,"engine.h::shoots_move::0::99"
._shoots_move
	xor	a
	ld	(_bi),a
	jp	i_152	;EOS
.i_150
	ld	hl,_bi
	ld	a,(hl)
	inc	(hl)
.i_152
	ld	de,(_bi)
	ld	d,0
	ld	hl,(_n_shoots)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_151	;
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_153	;
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(__x),a
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	de,0
	call	l_eq
	jp	nc,i_154	;
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	sra	h
	rr	l
	push	hl
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	sra	h
	rr	l
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	(_whichtile),hl
	ld	a,137
	add	h
	ld	h,a
	ld	(_gp_gen),hl
	ld	a,(hl)
	cp	12
	jp	nz,i_155	;
	xor	a
	ld	(_si),a
	jp	i_158	;EOS
.i_156
	ld	hl,_si
	ld	a,(hl)
	inc	(hl)
.i_158
	ld	de,(_si)
	ld	d,0
	ld	hl,(_max_spawners)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_157	;
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	sra	h
	rr	l
	add	hl,hl
	push	hl
	ld	de,_spawners_x
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	nc,i_160	;
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	sra	h
	rr	l
	add	hl,hl
	push	hl
	ld	de,_spawners_y
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	nc,i_160	;
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_160	;
	defc	i_160 = i_159
.i_161_i_160
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	push	hl
	call	_add_to_score
	pop	bc
	ld	de,_spawners_en
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_162	;
	ld	de,_spawners_en
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	dec	(hl)
	jp	i_163	;EOS
.i_162
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	hl,(_gp_gen)
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
.i_163
	call	_draw_shoot
	jp	i_157	;EOS
	defc	i_159 = i_156
.i_157
	ld	hl,1	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_164	;EOS
.i_155
	ld	hl,_behs
	push	hl
	ld	hl,(_gp_gen)
	ld	l,(hl)
	ld	h,0
	pop	de
	add	hl,de
	ld	a,16
	and	(hl)
	jp	z,i_165	;
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	ld	a,l
	and	254
	ld	l,a
	ld	h,0
	ld	(__x),a
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	ld	a,l
	and	254
	ld	l,a
	ld	h,0
	ld	(__y),a
	call	_destructors_create
	ld	hl,5	;const
	push	hl
	call	_add_to_score
	pop	bc
	jp	i_166	;EOS
.i_165
	ld	hl,2	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
.i_166
.i_164
.i_154
					ld  bc, (_bi)
					ld  b, 0
					ld  hl, _shoots_mx
					add hl, bc
					ld  d, (hl)
					ld  hl, _shoots_x
					add hl, bc
					ld  a, (hl)
					add d
					add d
					ld  (hl), a
					ld  hl, _shoots_my
					add hl, bc
					ld  d, (hl)
					ld  hl, _shoots_y
					add hl, bc
					ld  a, (hl)
					add d
					add d
					ld  (hl), a
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	call	l_lt
	jp	c,i_168	;
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	ld	bc,29
	add	hl,bc
	pop	de
	call	l_gt
	jp	c,i_168	;
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	call	l_lt
	jp	c,i_168	;
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	ld	bc,15
	add	hl,bc
	pop	de
	call	l_gt
	jp	nc,i_167	;
.i_168
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	(hl),0
	jp	i_150	;EOS
	defc	i_167 = i_150
	defc	i_153 = i_150
.i_151
	ret


	C_LINE	514,"engine.h::shoots_move::0::110"

; Function check_shoot flags 0x00000200 __smallc 
; void check_shoot()
	C_LINE	514,"engine.h::check_shoot::0::110"
._check_shoot
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	af
	ld	bc,i_170
	push	bc
	push	af
	ret
.i_170
	ld	a,l
	ld	hl,_pad0
	ld	(hl),a
	and	128
	jp	z,i_171	;
	ld	hl,(_player+12)
	ld	h,0
	ld	de,0
	call	l_eq
	jp	nc,i_172	;
	ld	hl,_player+12
	ld	(hl),1
	ld	a,(_player+26)
	and	a
	jp	z,i_173	;
	ld	hl,_player+26
	ld	(hl),0
	ld	hl,_bomb
	push	hl
	ld	hl,_player
	call	l_gchar
	ld	a,l
	and	254
	ld	l,a
	pop	de
	ld	(de),a
	ld	hl,_bomb+1
	push	hl
	ld	hl,_player+1
	call	l_gchar
	ld	a,l
	and	254
	ld	l,a
	pop	de
	ld	(de),a
	ld	hl,_player+1
	call	l_gchar
	ld	a,l
	and	1
	jp	z,i_174	;
	ld	hl,_bomb+1
	push	hl
	ld	l,(hl)
	ld	h,0
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
.i_174
	ld	hl,_bomb+3
	ld	(hl),5
	ld	hl,_bomb+2
	ld	(hl),12
	ld	l,(hl)
	ld	h,0
	ret


.i_173
	call	_shoots_find
	ld	a,l
	ld	hl,_bi
	ld	(hl),a
	cp	255
	jp	z,i_175	;
	ld	hl,(_player+6)
	ld	h,0
.i_178
	ld	a,l
	and	a
	jp	z,i_179	;
	cp	+(3% 256)
	jp	z,i_180	;
	cp	+(6% 256)
	jp	z,i_181	;
	cp	+(9% 256)
	jp	z,i_182	;
	jp	i_177	;EOS
.i_179
								ld  bc, (_bi)
								ld  b, 0
								ld  a, (_player)
								inc a
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a
								ld  a, (_inval)
								ld  d, a
								ld  a, (_player + 1)
								add 2
								sub d
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a
								xor a
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a
								inc a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a
								xor a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a
								dec a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
	jp	i_177	;EOS
.i_180
								ld  bc, (_bi)
								ld  b, 0
								ld  a, (_player)
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a
								ld  a, (_inval)
								ld  d, a
								ld  a, (_player + 1)
								dec a
								add d
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a
								xor a
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a
								dec a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a
								xor a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a
								inc a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
	jp	i_177	;EOS
.i_181
								ld  bc, (_bi)
								ld  b, 0
								ld  a, (_inval)
								ld  d, a
								ld  a, (_player)
								dec a
								add d
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a
								ld  a, (_player + 1)
								inc a
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a
								ld  a, 0xff
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a
								inc a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a
								inc a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a
								dec a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
	jp	i_177	;EOS
.i_182
								ld  bc, (_bi)
								ld  b, 0
								ld  a, (_inval)
								ld  d, a
								ld  a, (_player)
								add 2
								dec d
								ld  hl, _shoots_x
								add hl, bc
								ld  (hl), a
								ld  a, (_player + 1)
								inc a
								ld  hl, _shoots_y
								add hl, bc
								ld  (hl), a
								ld  a, 1
								ld  hl, _shoots_mx
								add hl, bc
								ld  (hl), a
								dec a
								ld  hl, _shoots_my
								add hl, bc
								ld  (hl), a
								dec a
								ld  hl, _shoots_trail_dx
								add hl, bc
								ld  (hl), a
								inc a
								ld  hl, _shoots_trail_dy
								add hl, bc
								ld  (hl), a							
.i_177
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	(hl),1
	ld	hl,0	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_183	;EOS
	defc	i_175 = i_183
	defc	i_172 = i_183
.i_171
	ld	hl,_player+12
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
.i_183
	ret


	C_LINE	737,"engine.h::check_shoot::0::116"

; Function enemies_move flags 0x00000200 __smallc 
; void enemies_move()
	C_LINE	737,"engine.h::enemies_move::0::116"
._enemies_move
			xor a
			ld  (_bus_count), a
			ld  (_inval), a 		 
			ld  (_ei), a
		._enemies_move_selector
			ld  bc, (_ei)
			ld  b, 0
			ld  hl, _enemies_ns
			add hl, bc
			ld  (hl), b 			 
			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			or  a
			jp  z, _enemies_move_selector_continue
			ld  a, (_cam_x)
			ld  d, a
			ld  hl, _enemies_x
			add hl, bc
			ld  a, (hl)
			inc a
			cp  d
			jp  c, _enemies_move_selector_continue
			ld  d, a 				 
			ld  a, (_cam_x)
			add 29
			cp  d
			jp  c, _enemies_move_selector_continue
			ld  a, (_cam_y)
			ld  d, a
			ld  hl, _enemies_y
			add hl, bc
			ld  a, (hl)
			inc a
			cp  d
			jp  c, _enemies_move_selector_continue
			ld  d, a 				 
			ld  a, (_cam_y)
			add 15
			cp  d
			jp  c, _enemies_move_selector_continue
			ld  a, (_cam_x)
			ld  d, a
			ld  hl, _enemies_x
			add hl, bc
			ld  a, (hl)
			inc a
			sub d
			ld  hl, _enemies_real_x
			add hl, bc
			ld  (hl), a
			ld  a, (_cam_y)
			ld  d, a
			ld  hl, _enemies_y
			add hl, bc
			ld  a, (hl)
			inc a
			sub d
			ld  hl, _enemies_real_y
			add hl, bc
			ld  (hl), a
			ld  a, 1
			ld  hl, _enemies_ns
			add hl, bc
			ld  (hl), a
			ld  hl, _enemies_real_x
			add hl, bc
			ld  a, (hl)
			ld  (_sx), a
			ld  hl, _enemies_real_y
			add hl, bc
			ld  a, (hl)
			ld  (_sy), a
			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			cp  5
			jr  nz, _enemies_move_selector_not5
			ld  hl, _enemies_frame
			add hl, bc
			ld  a, (hl)
			add 29
			ld  (_sn), a
			ld  a, 7
			ld  (_sc), a
			jr  _enemies_move_selector_add_bus
		._enemies_move_selector_not5
			ld  hl, _enemies_type
			add hl, bc
			ld  a, (hl)
			dec a
			sla a
			sla a
			sla a
			add 32
			ld  hl, _enemies_facing
			add hl, bc
			add a, (hl)
			ld  hl, _enemies_frame
			add hl, bc
			add a, (hl)
			ld  (_sn), a
			ld  hl, _enemies_en 
			add hl, bc
			ld  a, (hl)
			dec a
			srl a
			srl a
			srl a
			srl a
			neg a
			add 71
			ld  (_sc), a
		._enemies_move_selector_add_bus		
			call _draw_sprite
			ld  de, (_bus_count)
			ld  d, 0
			ld  hl, _enemies_bus
			add hl, de
			ld  a, (_ei)
			ld  (hl), a
			inc de
			ld  a, e
			ld  (_bus_count), a
		._enemies_move_selector_continue
			ld  a, (_ei)
			inc a
			ld  (_ei), a
			cp   128 
			jp  nz, _enemies_move_selector
	xor	a
	ld	(_busi),a
	jp	i_186	;EOS
.i_184
	ld	hl,_busi
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_186
	ld	de,(_busi)
	ld	d,0
	ld	hl,(_bus_count)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_185	;
	call	_check_shoot
	ld	de,_enemies_bus
	ld	hl,(_busi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_ei),a
			._en_bus_upd
				xor a
				ld  (_nd), a
				ld  bc, (_ei)
				ld  b, a
				ld  hl, _enemies_type
				add hl, bc
				ld  a, (hl)
				cp  5
				jr  nz, _en_bus_upd_not_dying
			._en_bus_upd_dying
				ld  hl, _enemies_frame 
				add hl, bc
				inc (hl)
				ld  a, (hl)
				cp  2
				jp  nz, _en_bus_upd_done
				ld  hl, _enemies_type
				add hl, bc
				xor a
				ld  (hl), a
				ld  a, 0xfe 
				ld  hl, _enemies_x
				add hl, bc
				ld  (hl), a 
				ld  hl, _enemies_y
				add hl, bc
				ld  (hl), a 
				jp  _en_bus_upd_done
			._en_bus_upd_not_dying
				ld  a, (_halflife)
				or  a
				jr  nz, _en_bus_upd_do 
				ld  hl, _enemies_type
				add hl, bc 
				ld  a, (hl)
				cp  4
				jp  nz, _en_bus_upd_done
			._en_bus_upd_do
			._en_bus_move_horizontal
				ld  hl, _enemies_x
				add hl, bc
				ld  a, (hl)
				ld  (_rdx), a
				ld  d, a
				ld  a, (_player) 			 
				cp  d 
				jp  z, _en_bus_move_vertical
				jr  c, _en_bus_upd_move_left
			._en_bus_upd_move_right
				ld  a, 6
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				add 2 
				ld  (__x), a 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				ld  (__y), a 
				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 
				ld  hl, __y
				inc (hl)
				call _dt_attr
				ld  d, l 					; D = at2
				ld  a, (_at1)
				and d
				jr  z, _en_bus_move_vertical
				ld  hl, _enemies_x
				add hl, bc
				inc (hl)
				ld  a, (_cam_x)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 
				ld  hl, _enemies_real_x
				add hl, bc 
				ld  (hl), a 
				ld  a, 1
				ld  (_nd), a
				jr  _en_bus_move_vertical
			._en_bus_upd_move_left
				ld  a, 4
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				dec a
				ld  (__x), a 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				ld  (__y), a 
				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 
				ld  hl, __y
				inc (hl)
				call _dt_attr
				ld  d, l 					; D = at2
				ld  a, (_at1)
				and  d
				jr  z, _en_bus_move_vertical
				ld  hl, _enemies_x
				add hl, bc
				dec (hl)
				ld  a, (_cam_x)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 
				ld  hl, _enemies_real_x
				add hl, bc 
				ld  (hl), a 
				ld  a, 1
				ld  (_nd), a
			._en_bus_move_vertical
				ld  hl, _enemies_y
				add hl, bc
				ld  a, (hl)
				ld  (_rdy), a 
				ld  d, a
				ld  a, (_player+1) 			 
				cp  d 
				jp  z, _en_bus_upd_done
				jr  c, _en_bus_upd_move_up
			._en_bus_upd_move_down
				ld  a, 0
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				ld  (__x), a 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				add 2 
				ld  (__y), a 
				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 
				ld  hl, __x
				inc (hl)
				call _dt_attr
				ld  d, l 					; D = at2
				ld  a, (_at1)
				and d
				jr  z, _en_bus_upd_done
				ld  hl, _enemies_y
				add hl, bc
				inc (hl)
				ld  a, (_cam_y)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  (hl), a 
				ld  a, 1
				ld  (_nd), a
				jr  _en_bus_upd_done
			._en_bus_upd_move_up
				ld  a, 2
				ld  hl, _enemies_facing
				add hl, bc
				ld  (hl), a 
				ld  hl, _enemies_real_x 
				add hl, bc 
				ld  a, (hl)
				ld  (__x), a 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  a, (hl)
				dec a
				ld  (__y), a 
				call _dt_attr 
				ld  a, l 
				ld  (_at1), a 
				ld  hl, __x
				inc (hl)
				call _dt_attr
				ld  d, l 					; D = at2
				ld  a, (_at1)
				and d
				jr  z, _en_bus_upd_done
				ld  hl, _enemies_y
				add hl, bc
				dec (hl)
				ld  a, (_cam_y)
				ld  d, a
				ld  a, (hl)
				inc a 
				sub d 
				ld  hl, _enemies_real_y
				add hl, bc 
				ld  (hl), a 
				ld  a, 1
				ld  (_nd), a
			._en_bus_upd_done
				ld  a, (_nd)
				or  a
				jr  z, _en_bus_step_done
			._en_bus_step
				ld  hl, _enemies_frame 
				add hl, bc 
				ld  a, 1
				sub (hl)
				ld  (hl), a
			._en_bus_step_done
			._en_bus_collision_check
				ld  a, (_player) 		 
				dec a 
				ld  d, a 
				ld  hl, _enemies_x 
				add hl, bc 
				ld  a, (hl)
				cp  d 
				jp  c, _en_bus_collision_done 
				ld  hl, _enemies_x 
				add hl, bc 
				ld  d, (hl) 
				ld  a, (_player) 		 
				inc a 
				cp  d 
				jp  c, _en_bus_collision_done 
				ld  a, (_player+1) 		 
				dec a 
				ld  d, a 
				ld  hl, _enemies_y 
				add hl, bc 
				ld  a, (hl)
				cp  d 
				jr  c, _en_bus_collision_done 
				ld  hl, _enemies_y 
				add hl, bc 
				ld  d, (hl) 
				ld  a, (_player+1) 		 
				inc a 
				cp  d 
				jr  c, _en_bus_collision_done 
			._en_bus_collision_do
				ld  hl, _enemies_type 
				add hl, bc 
				ld  a, (hl)
				ld  hl, _enemies_en 
				add hl, bc
				cp  4 
				jr  nz, _en_bus_collision_sap_normal
			._en_bus_collision_sap_type4
				ld  a, (hl)
				sub 8 
				ld  (hl), a
				jr  _en_bus_collision_sap_done
			._en_bus_collision_sap_normal
				dec (hl)
			._en_bus_collision_sap_done
				ld  a, (hl)
				and 128
				jr  z, _en_bus_collision_kill_done
			._en_bus_collision_kill
				ld  a, 5
				ld  hl, _enemies_type
				add hl, bc
				ld  (hl), a 
				xor a 
				ld  hl, _enemies_frame
				add hl, bc 
				ld  (hl), a 
				ld  hl, _enemies_ns
				add hl, bc 
				ld  (hl), a 
			._en_bus_collision_kill_done
				ld  a, (_rdx)
				ld  hl, _enemies_x 
				add hl, bc 
				ld  (hl), a 
				ld  a, (_rdy)
				ld  hl, _enemies_y 
				add hl, bc 
				ld  (hl), a 
	ld	hl,(_player+10)
	ld	a,h
	or	l
	jp	z,i_187	;
	ld	hl,_player+10
	dec	(hl)
	ld	a,(hl)
	inc	hl
	cp	255
	jr	nz,ASMPC+3
	dec	(hl)
.i_187
	ld	hl,6	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
			._en_bus_collision_done
	ld	de,_enemies_type
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	5
	jp	z,i_189	;
	ld	de,_enemies_en
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	ld	de,0
	ex	de,hl
	call	l_gt
	jp	nc,i_189	;
	defc	i_189 = i_188
.i_190_i_189
	xor	a
	ld	(_bi),a
	jp	i_193	;EOS
.i_191
	ld	hl,_bi
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_193
	ld	de,(_bi)
	ld	d,0
	ld	hl,(_n_shoots)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_192	;
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_194	;
	xor	a
	ld	(_cao),a
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_shoots_trail_dx
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	ld	(_rdx),a
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_shoots_trail_dy
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	add	hl,de
	ld	a,l
	ld	(_rdy),a
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	c,i_196	;
	ld	de,_shoots_x
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	call	l_eq
	jp	nc,i_198	;
.i_196
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	c,i_199	;
	ld	de,_shoots_y
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	call	l_eq
	jp	nc,i_198	;
.i_199
	defc	i_198 = i_195
.i_201_i_198
	ld	a,1
	ld	(_cao),a
	jp	i_202	;EOS
.i_195
	ld	hl,(_rdx)
	ld	h,0
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	c,i_204	;
	ld	hl,(_rdx)
	ld	h,0
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	call	l_eq
	jp	nc,i_206	;
.i_204
	ld	hl,(_rdy)
	ld	h,0
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	call	l_eq
	jp	c,i_207	;
	ld	hl,(_rdy)
	ld	h,0
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	call	l_eq
	jp	nc,i_206	;
.i_207
	defc	i_206 = i_203
.i_209_i_206
	ld	hl,1	;const
	ld	a,l
	ld	(_cao),a
.i_203
.i_202
	ld	a,(_cao)
	and	a
	jp	z,i_210	;
	ld	de,_enemies_en
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	ld	de,16
	ex	de,hl
	call	l_gt
	jp	nc,i_212	;
	ld	de,_enemies_type
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	cp	5
	jp	z,i_212	;
	defc	i_212 = i_211
.i_213_i_212
	ld	de,_enemies_en
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	push	hl
	call	l_gchar
	ld	bc,-16
	add	hl,bc
	ld	a,l
	pop	de
	ld	(de),a
	jp	i_214	;EOS
.i_211
	ld	de,_enemies_type
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),5
	ld	de,_enemies_frame
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	de,_enemies_ns
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
.i_214
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	l,(hl)
	ld	h,0
	call	_draw_shoot
	ld	hl,1	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_191	;EOS
	defc	i_210 = i_191
	defc	i_194 = i_191
.i_192
.i_188
	xor	a
	ld	(_foi),a
	jp	i_217	;EOS
.i_215
	ld	hl,_foi
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_217
	ld	a,(_foi)
	sub	20
	jp	nc,i_216	;
	ld	de,_focos_ct
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_218	;
	ld	de,_focos_x
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	dec	hl
	pop	de
	call	l_uge
	jp	nc,i_220	;
	ld	de,_focos_x
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_220	;
	defc	i_220 = i_222
.i_221_i_220
	ld	de,_focos_y
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	dec	hl
	pop	de
	call	l_uge
	jp	nc,i_223	;
	ld	de,_focos_y
	ld	hl,(_foi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	call	l_gchar
	inc	hl
	pop	de
	and	a
	sbc	hl,de
	ccf
	jp	nc,i_223	;
	defc	i_223 = i_222
.i_224_i_223
	defc	i_222 = i_219
.i_225_i_222
	ld	de,_enemies_type
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),5
	ld	de,_enemies_frame
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	de,_enemies_ns
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
	jp	i_215	;EOS
	defc	i_219 = i_215
	defc	i_218 = i_215
	jp	i_184	;EOS
	defc	i_216 = i_184
.i_185
	xor	a
	ld	(_bi),a
	jp	i_228	;EOS
.i_226
	ld	hl,_bi
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_228
	ld	de,(_bi)
	ld	d,0
	ld	hl,(_n_shoots)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_227	;
	ld	de,_shoots_active
	ld	hl,(_bi)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_draw_shoot
	jp	i_226	;EOS
	defc	i_229 = i_226
.i_227
	xor	a
	ld	(_si),a
	jp	i_232	;EOS
.i_230
	ld	hl,_si
	ld	a,(hl)
	inc	(hl)
.i_232
	ld	de,(_si)
	ld	d,0
	ld	hl,(_max_spawners)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_231	;
	ld	de,_spawners_x
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	dec	hl
	pop	de
	call	l_ge
	jp	nc,i_234	;
	ld	de,_spawners_x
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	ld	bc,29
	add	hl,bc
	pop	de
	call	l_le
	jp	nc,i_234	;
	ld	de,_spawners_y
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	dec	hl
	pop	de
	call	l_ge
	jp	nc,i_234	;
	ld	de,_spawners_y
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	ld	bc,14
	add	hl,bc
	pop	de
	call	l_le
	jp	nc,i_234	;
	defc	i_234 = i_233
.i_235_i_234
	ld	de,_spawners_last_spawned
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	nz,i_236	;
	ld	de,_spawners_last_spawned
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	push	hl
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	ld	de,16
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	xor	a
	ld	(_rda),a
	ld	hl,0	;const
	ld	a,l
	ld	(_nd),a
.i_239
.i_242
	ld	de,_spawners_x
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	dec	hl
	dec	hl
	push	hl
	call	_rand
	ld	de,3
	ex	de,hl
	call	l_div_u
	ex	de,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,l
	ld	(_rdx),a
	ld	de,_spawners_y
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	call	l_gchar
	dec	hl
	dec	hl
	push	hl
	call	_rand
	ld	de,3
	ex	de,hl
	call	l_div_u
	ex	de,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,l
	ld	(_rdy),a
	ld	hl,(_rdx)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_rrdx),a
	ld	hl,(_rdy)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_rrdy),a
	ld	hl,(_rda)
	ld	h,0
	inc	hl
	ld	a,l
	ld	hl,_rda
	ld	(hl),a
	cp	6
	jp	nz,i_243	;
	ld	hl,1	;const
	ld	a,l
	ld	(_nd),a
.i_243
.i_240
	ld	a,(_rda)
	sub	6
	jp	nc,i_244	;
	ld	a,(_rrdx)
	sub	2
	jp	c,i_245	;
	ld	hl,(_rrdx)
	ld	h,0
	ld	a,29
	sub	l
	jp	c,i_245	;
	ld	a,(_rrdy)
	sub	2
	jp	c,i_245	;
	ld	hl,(_rrdy)
	ld	a,14
	sub	l
	jp	nc,i_244	;
.i_245
	defc	i_244 = i_241
	jp	i_242	;EOS
	defc	i_247_i_244 = i_242
.i_241
	ld	a,(_rrdx)
	ld	(__x),a
	ld	hl,(_rrdy)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	a,l
	ld	(_ca1),a
	ld	hl,__x
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	call	_dt_attr
	ld	h,0
	ld	a,l
	ld	(_ca2),a
.i_237
	ld	a,(_rda)
	sub	6
	jp	nc,i_248	;
	ld	a,(_ca1)
	and	a
	jp	z,i_249	;
	ld	a,(_ca2)
	and	a
	jp	nz,i_248	;
.i_249
	defc	i_248 = i_238
	jp	i_239	;EOS
	defc	i_251_i_248 = i_239
.i_238
	ld	a,(_nd)
	and	a
	jp	nz,i_252	;
	call	_enemies_find
	ld	a,l
	ld	hl,_ei
	ld	(hl),a
	cp	255
	jp	z,i_253	;
	ld	de,_spawners_ct
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	sub	8
	jp	nc,i_254	;
	ld	de,_enemies_type
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	push	hl
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	de,_enemies_x
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_rdx
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_enemies_y
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,_rdy
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_enemies_en
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	push	hl
	ld	de,_spawners_type
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	ld	a,l
	pop	de
	ld	(de),a
	ld	de,_enemies_facing
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	de,_enemies_frame
	ld	hl,(_ei)
	ld	h,0
	add	hl,de
	ld	(hl),0
	ld	de,_spawners_ct
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	inc	(hl)
.i_254
	ld	a,(_player+25)
	and	a
	jp	z,i_255	;
	ld	de,_spawners_ct
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	ld	(hl),0
	jp	i_256	;EOS
	defc	i_255 = i_256
	defc	i_253 = i_256
	defc	i_252 = i_256
.i_236
	ld	de,_spawners_last_spawned
	ld	hl,(_si)
	ld	h,0
	add	hl,de
	dec	(hl)
	jp	i_230	;EOS
	defc	i_256 = i_230
	defc	i_233 = i_230
.i_231
	ret


	C_LINE	1605,"engine.h::enemies_move::0::136"

; Function whatInMap flags 0x00000200 __smallc 
; unsigned char whatInMap()
	C_LINE	1605,"engine.h::whatInMap::0::136"
._whatInMap
	ld	hl,(__x)
	ld	h,0
	ld	a,137
	add	h
	ld	h,a
	push	hl
	ld	hl,(__y)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ret


	C_LINE	1607,"engine.h::whatInMap::0::137"

; Function gates_break flags 0x00000200 __smallc 
; void gates_break(unsigned char x, unsigned char y)
; parameter 'unsigned char y' at sp+2 size(1)
; parameter 'unsigned char x' at sp+4 size(1)
	C_LINE	1607,"engine.h::gates_break::0::137"
._gates_break
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,137
	add	h
	ld	h,a
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	(hl),0
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	dec	l
	ld	a,l
	ld	(__x),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_whatInMap
	ld	a,l
	cp	14
	jp	nz,i_257	;
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_gates_break
	pop	bc
	pop	bc
.i_257
	ld	hl,4	;const
	add	hl,sp
	ld	l,(hl)
	inc	l
	ld	a,l
	ld	(__x),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_whatInMap
	ld	a,l
	cp	14
	jp	nz,i_258	;
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_gates_break
	pop	bc
	pop	bc
.i_258
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	ld	(__x),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	dec	l
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_whatInMap
	ld	a,l
	cp	14
	jp	nz,i_259	;
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_gates_break
	pop	bc
	pop	bc
.i_259
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	ld	(__x),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	inc	l
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_whatInMap
	ld	a,l
	cp	14
	jp	nz,i_260	;
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_gates_break
	pop	bc
	pop	bc
.i_260
	ret


	C_LINE	1630,"engine.h::gates_break::0::138"

; Function gates_check flags 0x00000200 __smallc 
; void gates_check(unsigned char direction)
; parameter 'unsigned char direction' at sp+2 size(1)
	C_LINE	1630,"engine.h::gates_check::0::138"
._gates_check
	xor	a
	ld	(_dothis),a
	ld	hl,(_player+9)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_261	;
	ld	hl,_player
	call	l_gchar
	sra	h
	rr	l
	ld	a,l
	ld	(_rdx),a
	ld	hl,_player+1
	call	l_gchar
	sra	h
	rr	l
	ld	a,l
	ld	(_rdy),a
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_264
	ld	a,l
	cp	+(1% 256)
	jp	z,i_265	;
	cp	+(2% 256)
	jp	z,i_266	;
	cp	+(3% 256)
	jp	z,i_267	;
	cp	+(4% 256)
	jp	z,i_268	;
	jp	i_263	;EOS
.i_265
	ld	a,(_rdx)
	ld	(__x),a
	ld	hl,(_rdy)
	dec	l
	ld	a,l
	ld	(__y),a
	jp	i_263	;EOS
.i_266
	ld	a,(_rdx)
	ld	(__x),a
	ld	hl,(_rdy)
	inc	l
	ld	a,l
	ld	(__y),a
	jp	i_263	;EOS
.i_267
	ld	hl,(_rdx)
	dec	l
	ld	a,l
	ld	(__x),a
	ld	hl,(_rdy)
	ld	a,l
	ld	(__y),a
	jp	i_263	;EOS
.i_268
	ld	hl,(_rdx)
	inc	l
	ld	a,l
	ld	(__x),a
	ld	hl,(_rdy)
	ld	a,l
	ld	(__y),a
.i_263
	call	_whatInMap
	ld	a,l
	cp	14
	jp	nz,i_269	;
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__y)
	ld	h,0
	push	hl
	call	_gates_break
	pop	bc
	pop	bc
	ld	hl,_player+9
	dec	(hl)
	ld	hl,3	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	ld	hl,20	;const
	push	hl
	ld	hl,21	;const
	push	hl
	ld	hl,(_player+9)
	ld	h,0
	push	hl
	call	_draw_3_digit
	pop	bc
	pop	bc
	pop	bc
.i_269
.i_261
	ret


	C_LINE	1660,"engine.h::gates_check::0::142"

; Function player_move flags 0x00000200 __smallc 
; void player_move()
	C_LINE	1660,"engine.h::player_move::0::142"
._player_move
	ld	a,(_player)
	ld	(_xo),a
	ld	a,(_player+1)
	ld	(_yo),a
	ld	a,2
	ld	(_inval),a
	ld	hl,_player+2
	push	hl
	ld	hl,_player
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	pop	de
	ld	(de),a
	ld	hl,_player+3
	push	hl
	ld	hl,_player+1
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	pop	de
	ld	(de),a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	af
	ld	bc,i_270
	push	bc
	push	af
	ret
.i_270
	ld	a,l
	ld	(_pad0),a
	xor	a
	ld	(_nd),a
	ld	hl,0	;const
	ld	a,l
	ld	(_dy),a
	ld	a,l
	ld	(_dx),a
	ld	hl,(_conveyors_on)
	ld	a,l
	and	a
	jp	z,i_271	;
				ld  a, (_player)			 
				ld  (__x), a
				ld  a, (_player + 1) 		 
				ld  (__y), a
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca1), a
				ld  hl, __x
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca2), a
				ld  a, (_player)			 
				ld  (__x), a
				ld  hl, __y
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca3), a
				ld  hl, __x
				inc (hl)
				call _char_mapdata_attribute
				ld  a, l
				ld  (_ca4), a				
				ld  hl, _dx 
				ld  a, (_ca1)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca2)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca3)
				cp  128
				jr  z, _pmc_decdx
				ld  a, (_ca4)
				cp  128
				jr  nz, _pmcdecdx_done
			._pmc_decdx
				dec (hl)
			._pmcdecdx_done
				ld  a, (_ca1)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca2)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca3)
				cp  129
				jr  z, _pmc_incdx
				ld  a, (_ca4)
				cp  129
				jr  nz, _pmcincdx_done
			._pmc_incdx
				inc (hl)
			._pmcincdx_done
				ld  hl, _dy 
				ld  a, (_ca1)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca2)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca3)
				cp  130
				jr  z, _pmc_decdy
				ld  a, (_ca4)
				cp  130
				jr  nz, _pmcdecdy_done
			._pmc_decdy
				dec (hl)
			._pmcdecdy_done
				ld  a, (_ca1)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca2)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca3)
				cp  131
				jr  z, _pmc_incdy
				ld  a, (_ca4)
				cp  131
				jr  nz, _pmcincdy_done
			._pmc_incdy
				inc (hl)
			._pmcincdy_done
.i_271
	ld	hl,(_pad0)
	ld	h,0
	ld	a,1
	and	l
	ld	l,a
	jp	z,i_273	;
	ld	a,(_dy)
	and	a
	jp	nz,i_273	;
	ld	hl,1	;const
	jr	i_274
.i_273
	ld	hl,0	;const
.i_274
	ld	a,h
	or	l
	jp	nz,i_275	;
	ld	a,(_dy)
	cp	-1
	jp	nz,i_272	;
.i_275
	ld	hl,_player+6
	ld	(hl),3
	ld	a,1
	ld	(_nd),a
	ld	a,(_player+2)
	ld	(__x),a
	ld	hl,_player+3
	call	l_gchar
	dec	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	a,l
	ld	(_at1),a
	ld	hl,__x
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	call	_dt_attr
	ld	a,l
	ld	(_at2),a
	ld	a,(_at1)
	and	a
	jp	z,i_278	;
	ld	a,(_at2)
	and	a
	jp	z,i_278	;
	defc	i_278 = i_277
.i_279_i_278
	ld	hl,_player+1
	push	hl
	call	l_gchar
	dec	hl
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_280	;EOS
.i_277
	ld	hl,1	;const
	push	hl
	call	_gates_check
	pop	bc
.i_280
.i_272
	ld	hl,(_pad0)
	ld	h,0
	ld	a,2
	and	l
	ld	l,a
	jp	z,i_282	;
	ld	a,(_dy)
	and	a
	jp	nz,i_282	;
	ld	hl,1	;const
	jr	i_283
.i_282
	ld	hl,0	;const
.i_283
	ld	a,h
	or	l
	jp	nz,i_284	;
	ld	a,(_dy)
	cp	1
	jp	nz,i_281	;
.i_284
	ld	hl,_player+6
	ld	(hl),0
	ld	a,1
	ld	(_nd),a
	ld	a,(_player+2)
	ld	(__x),a
	ld	hl,_player+3
	call	l_gchar
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	a,l
	ld	(_at1),a
	ld	hl,__x
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	call	_dt_attr
	ld	a,l
	ld	(_at2),a
	ld	a,(_at1)
	and	a
	jp	z,i_287	;
	ld	a,(_at2)
	and	a
	jp	z,i_287	;
	defc	i_287 = i_286
.i_288_i_287
	ld	hl,_player+1
	push	hl
	call	l_gchar
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_289	;EOS
.i_286
	ld	hl,2	;const
	push	hl
	call	_gates_check
	pop	bc
.i_289
.i_281
	ld	hl,_player+3
	push	hl
	ld	hl,_player+1
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	pop	de
	ld	(de),a
	ld	hl,(_pad0)
	ld	h,0
	ld	a,4
	and	l
	ld	l,a
	jp	z,i_291	;
	ld	a,(_dx)
	and	a
	jp	nz,i_291	;
	ld	hl,1	;const
	jr	i_292
.i_291
	ld	hl,0	;const
.i_292
	ld	a,h
	or	l
	jp	nz,i_293	;
	ld	a,(_dx)
	cp	-1
	jp	nz,i_290	;
.i_293
	ld	hl,_player+6
	ld	(hl),6
	ld	a,1
	ld	(_nd),a
	ld	hl,_player+2
	call	l_gchar
	dec	hl
	ld	a,l
	ld	(__x),a
	ld	hl,(_player+3)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	a,l
	ld	(_at1),a
	ld	hl,__y
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	call	_dt_attr
	ld	a,l
	ld	(_at2),a
	ld	a,(_at1)
	and	a
	jp	z,i_296	;
	ld	a,(_at2)
	and	a
	jp	z,i_296	;
	defc	i_296 = i_295
.i_297_i_296
	ld	hl,_player
	push	hl
	call	l_gchar
	dec	hl
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_298	;EOS
.i_295
	ld	hl,3	;const
	push	hl
	call	_gates_check
	pop	bc
.i_298
.i_290
	ld	hl,(_pad0)
	ld	h,0
	ld	a,8
	and	l
	ld	l,a
	jp	z,i_300	;
	ld	a,(_dx)
	and	a
	jp	nz,i_300	;
	ld	hl,1	;const
	jr	i_301
.i_300
	ld	hl,0	;const
.i_301
	ld	a,h
	or	l
	jp	nz,i_302	;
	ld	a,(_dx)
	cp	1
	jp	nz,i_299	;
.i_302
	ld	hl,_player+6
	ld	(hl),9
	ld	a,1
	ld	(_nd),a
	ld	hl,_player+2
	call	l_gchar
	inc	hl
	inc	hl
	ld	a,l
	ld	(__x),a
	ld	hl,(_player+3)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_dt_attr
	ld	a,l
	ld	(_at1),a
	ld	hl,__y
	inc	(hl)
	ld	l,(hl)
	ld	h,0
	call	_dt_attr
	ld	a,l
	ld	(_at2),a
	ld	a,(_at1)
	and	a
	jp	z,i_305	;
	ld	a,(_at2)
	and	a
	jp	z,i_305	;
	defc	i_305 = i_304
.i_306_i_305
	ld	hl,_player
	push	hl
	call	l_gchar
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_307	;EOS
.i_304
	ld	hl,4	;const
	push	hl
	call	_gates_check
	pop	bc
.i_307
.i_299
	call	_check_shoot
	ld	hl,_player+2
	push	hl
	ld	hl,_player
	call	l_gchar
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	pop	de
	ld	(de),a
	ld	a,(_dx)
	and	a
	jp	nz,i_309	;
	ld	hl,_dy
	call	l_gchar
	ld	a,h
	or	l
	jr	z,i_310
.i_309
	ld	hl,1	;const
.i_310
	ld	a,h
	or	l
	jp	z,i_308	;
	xor	a
	ld	(_nd),a
.i_308
	ld	hl,(_nd)
	ld	a,l
	and	a
	jp	z,i_311	;
				ld  a, (_player + 5)		 
				inc a
				and 3
				ld  (_player + 5), a 		 
				or  a
				jr  z, _player_step_frame_1
				cp  2
				jr  nz, _player_step_frame_not1
			._player_step_frame_1
				ld  a, 1			
				jr  _player_step_done
			._player_step_frame_not1
				cp  1
				jr  nz, _player_step_frame_2
				xor a
				jr  _player_step_done
			._player_step_frame_2
				ld  a, 2
			._player_step_done
				ld  (_player + 4), a 		 
.i_311
	ld	hl,_player
	call	l_gchar
	ld	a,l
	and	1
	jp	nz,i_313	;
	ld	hl,_player+1
	call	l_gchar
	ld	a,l
	and	1
	jp	nz,i_313	;
	defc	i_313 = i_312
.i_314_i_313
	ld	hl,_player+1
	call	l_gchar
	sra	h
	rr	l
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	push	hl
	ld	hl,_player
	call	l_gchar
	sra	h
	rr	l
	pop	de
	add	hl,de
	ld	(_whichtile),hl
	ld	a,137
	add	h
	ld	h,a
	ld	(_gp_gen),hl
	ld	a,(hl)
	ld	hl,_rda
	ld	(hl),a
	cp	13
	jp	nz,i_315	;
	ld	hl,(_gp_gen)
	ld	(hl),0
	ld	hl,_player+9
	inc	(hl)
	ld	hl,20	;const
	push	hl
	ld	hl,21	;const
	push	hl
	ld	hl,(_player+9)
	ld	h,0
	push	hl
	call	_draw_3_digit
	pop	bc
	pop	bc
	pop	bc
	ld	hl,10	;const
	push	hl
	call	_add_to_score
	pop	bc
	ld	hl,7	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_316	;EOS
.i_315
	ld	a,(_rda)
	cp	15
	jp	nz,i_317	;
	ld	a,1
	ld	(_i_shat_brix),a
	ld	hl,8	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_318	;EOS
.i_317
	ld	a,(_rda)
	cp	31
	jp	nz,i_319	;
	ld	hl,(_gp_gen)
	ld	(hl),0
	ld	hl,_player+10
	push	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl,100
	add	hl,bc
	call	l_pint_pop
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,10	;const
	push	hl
	call	_add_to_score
	pop	bc
	ld	hl,5	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	jp	i_320	;EOS
.i_319
	ld	de,(_rda)
	ld	d,0
	ld	hl,(_tile_bomb)
	ld	h,d
	call	l_eq
	jp	nc,i_322	;
	ld	a,(_player+26)
	and	a
	jp	nz,i_322	;
	ld	a,(_bomb+3)
	and	a
	jp	nz,i_322	;
	defc	i_322 = i_321
.i_323_i_322
	ld	hl,(_gp_gen)
	ld	(hl),0
	ld	hl,_player+26
	ld	(hl),1
	ld	de,_bomb+4
	ld	hl,(_gp_gen)
	call	l_pint
	ld	hl,7	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
.i_321
.i_320
.i_318
.i_316
.i_312
	ld	hl,_player+25
	push	hl
	ld	hl,_player
	call	l_gchar
	ex	de,hl
	ld	hl,(_xo)
	ld	h,0
	call	l_eq
	jp	nc,i_324	;
	ld	hl,_player+1
	call	l_gchar
	ex	de,hl
	ld	hl,(_yo)
	ld	h,0
	call	l_eq
	jp	nc,i_324	;
	ld	hl,1	;const
	jr	i_325
.i_324
	ld	hl,0	;const
.i_325
	call	l_lneg
	pop	de
	ld	a,l
	ld	(de),a
	ret


	C_LINE	1916,"engine.h::player_move::0::154"
	SECTION	data_compiler
._pass_printer_section
	defb	0
	defb	0
	defb	0
	defb	0
	defb	0
	SECTION	code_compiler
	C_LINE	1918,"engine.h::player_move::0::154"

; Function interim flags 0x00000200 __smallc 
; void interim(unsigned char world, unsigned char level)
; parameter 'unsigned char level' at sp+2 size(1)
; parameter 'unsigned char world' at sp+4 size(1)
	C_LINE	1918,"engine.h::interim::0::154"
._interim
	ld	hl,70	;const
	push	hl
	call	_clear_viewport
	pop	bc
	ld	hl,4	;const
	push	hl
	ld	hl,6	;const
	push	hl
	ld	hl,i_1+0
	push	hl
	call	_draw_char_by_char
	pop	bc
	pop	bc
	pop	bc
	ld	hl,22	;const
	push	hl
	ld	hl,5	;const
	push	hl
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	ld	hl,(_player+17)
	ld	de,(_player+17+2)
	call	l_long_sub
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,6	;const
	push	hl
	ld	hl,9	;const
	push	hl
	ld	hl,i_1+18
	push	hl
	call	_draw_char_by_char
	pop	bc
	pop	bc
	pop	bc
	ld	hl,20	;const
	push	hl
	ld	hl,8	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	ld	hl,(_player+17)
	ld	de,(_player+17+2)
	call	l_long_sub
	ld	(_gpint),hl
.i_327
	ld	hl,(_gpint)
	ld	de,25
	ex	de,hl
	and	a
	sbc	hl,de
	jp	nc,i_328	;
	ld	hl,_player+10
	inc	(hl)
	ld	a,(hl)
	inc	hl
	jr	nz,ASMPC+3
	inc	(hl)
	ld	hl,(_gpint)
	ld	bc,-25
	add	hl,bc
	ld	(_gpint),hl
	call	in_Inkey
	call	l_lneg
	jp	nc,i_329	;
	ld	hl,22	;const
	push	hl
	ld	hl,5	;const
	push	hl
	ld	hl,(_gpint)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,20	;const
	push	hl
	ld	hl,8	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_327	;EOS
	defc	i_329 = i_327
.i_328
	ld	hl,22	;const
	push	hl
	ld	hl,5	;const
	push	hl
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,20	;const
	push	hl
	ld	hl,8	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	cp	4
	jp	nz,i_330	;
	ld	hl,4	;const
	push	hl
	ld	hl,12	;const
	push	hl
	ld	hl,i_1+32
	push	hl
	call	_draw_char_by_char
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_player+10
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,8	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	add	hl,hl
	ld	bc,40
	add	hl,bc
	pop	de
	add	hl,de
	call	l_pint_pop
.i_330
	ld	hl,20	;const
	push	hl
	ld	hl,8	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	ld	hl,(_player+10)
	push	hl
	ld	hl,8	;const
	add	hl,sp
	ld	a,(hl)
	cp	4
	jp	nz,i_335	;
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
	jp	i_336	;
.i_335
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
.i_336
	push	hl
	ld	hl,10	;const
	add	hl,sp
	ld	a,(hl)
	cp	4
	jp	nz,i_337	;
	ld	hl,1	;const
	jp	i_338	;
.i_337
	ld	hl,10	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	inc	hl
.i_338
	push	hl
	call	_build_password
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	xor	a
	ld	(_gpit),a
	jp	i_341	;EOS
.i_339
	ld	hl,_gpit
	inc	(hl)
	ld	l,(hl)
	ld	h,0
.i_341
	ld	a,(_gpit)
	sub	5
	jp	nc,i_340	;
	ld	hl,_pass_printer_section
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_pass_printer_section+1
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	inc	hl
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_pass_printer_section+2
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	inc	hl
	inc	hl
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_pass_printer_section+3
	push	hl
	ld	hl,_pass_string
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	inc	hl
	inc	hl
	inc	hl
	pop	de
	add	hl,de
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,(_gpit)
	ld	h,0
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	ld	bc,4
	add	hl,bc
	ld	h,0
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,_pass_printer_section
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_339	;EOS
.i_340
	call	_mywaitkey
	ret


	C_LINE	1963,"engine.h::interim::0::159"

; Function game flags 0x00000200 __smallc 
; void game(unsigned char world, unsigned char level)
; parameter 'unsigned char level' at sp+2 size(1)
; parameter 'unsigned char world' at sp+4 size(1)
	C_LINE	1963,"engine.h::game::0::159"
._game
	dec	sp
	pop	hl
	ld	l,0
	push	hl
	push	bc
	ld	a,3
	ld	(_n_shoots),a
	xor	a
	ld	(_halflife),a
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),1
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),1
.i_342
	ld	hl,1	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_343	;
	xor	a
	ld	(_video_page),a
	ld	(_ram_page_act),a
	ld	a,23
	ld	(_pregister),a
	ld	hl,5	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_345	;
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_344	;
.i_345
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_prepare_world
	pop	bc
	pop	bc
	ld	hl,5	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	nz,i_347	;
	ld	hl,5	;const
	add	hl,sp
	ld	(hl),1
	ld	l,(hl)
	ld	h,0
.i_347
	call	_fade_out
	ld	hl,15	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,1	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
				call copy_screen0_to_screen1
.i_344
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_prepare_stage
	pop	bc
	pop	bc
	ld	hl,20	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,11	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_draw_1_digit
	pop	bc
	pop	bc
	pop	bc
	ld	hl,22	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,9	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_draw_1_digit
	pop	bc
	pop	bc
	pop	bc
	call	_mapdata_init
	ld	hl,_player
	push	hl
	ld	hl,_start_x
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_player+1
	push	hl
	ld	hl,_start_y
	ld	l,(hl)
	ld	a,l
	rla
	sbc	a
	ld	h,a
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_player+5
	ld	(hl),0
	ld	hl,_player+4
	ld	(hl),0
	ld	hl,_player+6
	ld	(hl),0
	ld	hl,_player+9
	ld	(hl),0
	ld	hl,_player+26
	ld	(hl),0
	ld	hl,_bomb+3
	ld	(hl),0
	ld	hl,7	;const
	add	hl,sp
	ld	a,(hl)
	cp	4
	jp	nz,i_348	;
	ld	hl,2	;const
	jp	i_349	;
.i_348
	ld	hl,99	;const
.i_349
	ld	a,l
	ld	(_tile_bomb),a
	ld	hl,7	;const
	add	hl,sp
	ld	a,5
	cp	(hl)
	ld	hl,1	;const
	jr	z,ASMPC+3
	dec	hl
	ld	a,l
	ld	(_conveyors_on),a
	call	_enemies_init
	call	_shoots_init
	call	_destructors_init
	call	_focos_init
	xor	a
	ld	(_i_shat_brix),a
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,(_player+10)
	ld	de,0
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,25	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	bc,_player+17
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	call	l_plong
	ld	hl,5	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,_player
	call	l_gchar
	ld	bc,-15
	add	hl,bc
	ld	a,l
	ld	(_cam_x),a
	ld	hl,_player+1
	call	l_gchar
	ld	bc,-7
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_cam_y),a
.i_352
	ld	hl,(_halflife)
	ld	h,0
	ld	de,1
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_halflife),a
	ld	hl,_cam_x
	call	l_gchar
	push	hl
	ld	hl,_player
	call	l_gchar
	ld	bc,-16
	add	hl,bc
	pop	de
	call	l_lt
	jp	nc,i_353	;
	ld	hl,_player
	call	l_gchar
	ld	bc,-16
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_cam_x),a
.i_353
	ld	hl,_cam_x
	call	l_gchar
	push	hl
	ld	hl,_player
	call	l_gchar
	ld	bc,-14
	add	hl,bc
	pop	de
	call	l_gt
	jp	nc,i_354	;
	ld	hl,_player
	call	l_gchar
	ld	bc,-14
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_cam_x),a
.i_354
	ld	hl,_cam_y
	call	l_gchar
	push	hl
	ld	hl,_player+1
	call	l_gchar
	ld	bc,-8
	add	hl,bc
	pop	de
	call	l_lt
	jp	nc,i_355	;
	ld	hl,_player+1
	call	l_gchar
	ld	bc,-8
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_cam_y),a
.i_355
	ld	hl,_cam_y
	call	l_gchar
	push	hl
	ld	hl,_player+1
	call	l_gchar
	ld	bc,-6
	add	hl,bc
	pop	de
	call	l_gt
	jp	nc,i_356	;
	ld	hl,_player+1
	call	l_gchar
	ld	bc,-6
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_cam_y),a
.i_356
	ld	hl,_cam_x
	ld	a,(hl)
	rla
	jp	nc,i_357	;
	xor	a
	ld	(_cam_x),a
.i_357
	ld	hl,_cam_x
	call	l_gchar
	ld	de,98
	ex	de,hl
	call	l_gt
	jp	nc,i_358	;
	ld	a,98
	ld	(_cam_x),a
.i_358
	ld	hl,_cam_y
	ld	a,(hl)
	rla
	jp	nc,i_359	;
	xor	a
	ld	(_cam_y),a
.i_359
	ld	hl,_cam_y
	call	l_gchar
	ld	de,64
	ex	de,hl
	call	l_gt
	jp	nc,i_360	;
	ld	a,64
	ld	(_cam_y),a
.i_360
	ld	hl,_cam_x
	call	l_gchar
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	push	hl
	call	_draw_map
	pop	bc
	pop	bc
	call	_shoots_move
	call	_destructors_update
	call	_focos_update
	call	_enemies_move
	call	_player_move
	ld	a,(_bomb+3)
	and	a
	jp	z,i_361	;
	ld	hl,(_bomb)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_x
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_sx),a
	ld	hl,(_bomb+1)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,_cam_y
	call	l_gchar
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	ld	a,l
	ld	(_sy),a
	ld	hl,(_sx)
	ld	h,0
	ld	a,30
	sub	l
	ccf
	jp	nc,i_363	;
	ld	hl,(_sy)
	ld	h,0
	ld	a,15
	sub	l
	ccf
	jp	nc,i_363	;
	defc	i_363 = i_362
.i_364_i_363
	ld	a,2
	ld	(_sn),a
	ld	hl,(_bomb+3)
	ld	h,0
	ld	bc,65
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_sc),a
	call	_draw_sprite
.i_362
	ld	hl,_bomb+2
	dec	(hl)
	ld	a,(hl)
	and	a
	jp	nz,i_365	;
	ld	hl,_bomb+2
	ld	(hl),12
	ld	hl,_bomb+3
	dec	(hl)
	ld	a,(hl)
	and	a
	jp	nz,i_366	;
	ld	a,(_bomb)
	ld	(__x),a
	ld	a,(_bomb+1)
	ld	(__y),a
	ld	hl,2	;const
	ld	a,l
	ld	(__n),a
	call	_focos_create
	ld	hl,(_bomb+4)
	ex	de,hl
	ld	hl,_tile_bomb
	ld	a,(hl)
	ld	(de),a
	ld	l,a
	ld	h,0
.i_366
.i_365
.i_361
	ld	a,(_player+26)
	and	a
	jp	z,i_367	;
	ld	a,(_player+6)
	and	a
	jp	z,i_369	;
	ld	a,(_player+6)
	cp	6
	jp	nz,i_368	;
.i_369
	ld	hl,_player+2
	call	l_gchar
	inc	hl
	ld	a,l
	ld	(_sx),a
	jp	i_371	;EOS
.i_368
	ld	hl,_player+2
	call	l_gchar
	dec	hl
	ld	h,0
	ld	a,l
	ld	(_sx),a
.i_371
	ld	hl,_player+3
	call	l_gchar
	dec	hl
	ld	a,l
	ld	(_sy),a
	ld	a,2
	ld	(_sn),a
	ld	hl,6	;const
	ld	a,l
	ld	(_sc),a
	call	_draw_sprite
.i_367
	ld	a,(_player+2)
	ld	(_sx),a
	ld	a,(_player+3)
	ld	(_sy),a
	ld	hl,(_player+6)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	a,(_player+4)
	add	e
	ld	(_sn),a
	ld	hl,68	;const
	ld	a,l
	ld	(_sc),a
	call	_draw_sprite
	call	_blit_buffer
	ld	hl,2	;const
	add	hl,sp
	push	hl
	ld	a,(_i_shat_brix)
	and	a
	jp	nz,i_372	;
	ld	hl,(_player+10)
	ld	a,h
	or	l
	jp	z,i_372	;
	ld	hl,0	;const
	jr	i_373
.i_372
	ld	hl,1	;const
.i_373
	pop	de
	ld	a,l
	ld	(de),a
.i_350
	ld	hl,2	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_352	;EOS
.i_351
	call	_wyz_stop_sound
	ld	hl,(_player+10)
	ld	a,h
	or	l
	jr	nz,ASMPC+3
	scf
	jp	nc,i_374	;
	ld	hl,42	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,1	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,6	;const
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,13	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,(_player+13)
	ld	de,(_player+13+2)
	push	de
	push	hl
	call	_draw_5_digit
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),0
	ld	hl,300	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	jp	i_375	;EOS
.i_374
	ld	hl,7	;const
	add	hl,sp
	ld	a,5
	sub	(hl)
	jp	nc,i_376	;
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),0
	jp	i_377	;EOS
.i_376
	ld	hl,5	;const
	add	hl,sp
	ld	a,(hl)
	cp	4
	jr	z,ASMPC+3
	scf
	jp	c,i_379	;
	ld	hl,7	;const
	add	hl,sp
	ld	a,(hl)
	cp	5
	jp	z,i_378	;
.i_379
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	call	_interim
	pop	bc
	pop	bc
.i_378
	ld	hl,5	;const
	add	hl,sp
	inc	(hl)
	ld	hl,5	;const
	add	hl,sp
	ld	a,(hl)
	cp	5
	jp	nz,i_381	;
	ld	hl,5	;const
	add	hl,sp
	ld	(hl),0
	ld	hl,7	;const
	add	hl,sp
	inc	(hl)
	ld	hl,7	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	a,l
	cp	6
	jp	nz,i_382	;
	call	_ending
	ld	hl,1	;const
	add	hl,sp
	ld	(hl),0
	jp	i_342	;EOS
	defc	i_382 = i_342
	defc	i_381 = i_342
	defc	i_377 = i_342
	defc	i_375 = i_342
.i_343
	xor	a
	ld	(_ram_page_act),a
	ld	hl,0	;const
	ld	a,l
	ld	(_video_page),a
	call	_blackout_everything
	inc	sp
	pop	bc
	ret


	C_LINE	61,"maritrini.c::game::0::175"
	C_LINE	0,"menu.h::game::0::175"
	C_LINE	3,"menu.h::game::0::175"

; Function menu flags 0x00000200 __smallc 
; unsigned char menu()
	C_LINE	3,"menu.h::menu::0::175"
._menu
	push	bc
	dec	sp
	ld	hl,23	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,1	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,5	;const
	push	hl
	call	_wyz_play_music
	pop	bc
	ld	hl,2	;const
	push	hl
	ld	hl,22	;const
	push	hl
	ld	hl,66	;const
	push	hl
	ld	hl,i_1+57
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,7	;const
	push	hl
	ld	hl,23	;const
	push	hl
	ld	hl,66	;const
	push	hl
	ld	hl,i_1+86
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_383
	ld	hl,11	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+103
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+114
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,20	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+125
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
.i_385
	pop	hl
	push	hl
	ld	h,0
	ld	a,l
	and	a
	jp	nz,i_386	;
	ld	hl,1	;const
	add	hl,sp
	push	hl
	call	in_Inkey
	pop	de
	ld	a,l
	ld	(de),a
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,49
	and	a
	sbc	hl,de
	jp	z,i_388	;
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,50
	and	a
	sbc	hl,de
	jp	nz,i_387	;
.i_388
	ld	hl,0	;const
	add	hl,sp
	push	hl
	ld	hl,3	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	ld	bc,-48
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_385	;EOS
	defc	i_387 = i_385
.i_386
	call	_clear_keybuff
	ld	hl,0	;const
	add	hl,sp
	ld	a,(hl)
	cp	1
	jp	nz,i_390	;
	ld	hl,11	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+136
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+147
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,20	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+158
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_391
	ld	hl,1	;const
	add	hl,sp
	push	hl
	call	in_Inkey
	pop	de
	ld	a,l
	ld	(de),a
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,49
	and	a
	sbc	hl,de
	jp	nz,i_393	;
	ld	hl,1	;const
	inc	sp
	pop	bc
	ret


.i_393
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,50
	and	a
	sbc	hl,de
	jp	nz,i_395	;
	ld	hl,2	;const
	inc	sp
	pop	bc
	ret


.i_395
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,51
	and	a
	sbc	hl,de
	jp	nz,i_397	;
	ld	hl,3	;const
	inc	sp
	pop	bc
	ret
	defc	i_397 = i_391
	defc	i_396 = i_391
	defc	i_394 = i_391
.i_392
	call	_clear_keybuff
	jp	i_398	;EOS
.i_390
	ld	hl,11	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+169
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+180
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,11	;const
	push	hl
	ld	hl,20	;const
	push	hl
	ld	hl,70	;const
	push	hl
	ld	hl,i_1+191
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),0
.i_399
	pop	hl
	push	hl
	ld	h,0
	call	l_lneg
	jp	nc,i_400	;
	ld	hl,1	;const
	add	hl,sp
	push	hl
	call	in_Inkey
	pop	de
	ld	a,l
	ld	(de),a
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,49
	and	a
	sbc	hl,de
	jp	nz,i_401	;
	ld	hl,in_JoyKeyboard
	ld	(_joyfunc),hl
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),1
	jp	i_402	;EOS
.i_401
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,50
	and	a
	sbc	hl,de
	jp	nz,i_403	;
	ld	hl,in_JoyKempston
	ld	(_joyfunc),hl
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),1
	jp	i_404	;EOS
.i_403
	pop	hl
	push	hl
	ld	l,h
	ld	h,0
	ld	de,51
	and	a
	sbc	hl,de
	jp	nz,i_405	;
	ld	hl,in_JoySinclair1
	ld	(_joyfunc),hl
	ld	hl,0	;const
	add	hl,sp
	ld	(hl),1
	jp	i_399	;EOS
	defc	i_405 = i_399
	defc	i_404 = i_399
	defc	i_402 = i_399
.i_400
	call	_clear_keybuff
	jp	i_383	;EOS
	defc	i_398 = i_383
.i_384
	inc	sp
	pop	bc
	ret


	C_LINE	62,"maritrini.c::menu::0::185"
	C_LINE	66,"maritrini.c::menu::0::185"

; Function main flags 0x00000000 __stdc 
; void main()
	C_LINE	66,"maritrini.c::main::0::186"
._main
	xor	a
	ld	(_video_page),a
	ld	(_ram_page_act),a
	ld	hl,23	;const
	ld	a,l
	ld	(_pregister),a
		di
	ld	hl,39064	;const
	push	hl
	call	im2_Init
	pop	bc
		ld  a, 0x7e
		ld  hl, 0x9800
		ld  (hl), a
		ld  de, 0x9801
		ld  bc, 256
		ldir
		ld  hl, 0x7e7e
		ld  a, 195
		ld  (hl), a
		inc hl
		ld  a, _isr % 256
		ld  (hl), a
		inc hl
		ld  a, _isr / 256
		ld  (hl), a
	call	_wyz_init_soundsystem
		ld a, 0
		out (254),a
	call	_blackout_everything
	ld	hl,_player+21
	push	hl
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	pop	bc
	call	l_plong
		ei
	ld	hl,_player+13
	push	hl
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	pop	bc
	call	l_plong
	ld	hl,200	;const
	ld	(_player+10),hl
	ld	hl,2	;const
	push	hl
	push	hl
	call	_game
	pop	bc
	pop	bc
	call	_fade_out
	ld	hl,39	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,8	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	ld	hl,100	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	call	_fade_out
	ld	hl,14	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,7	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	ld	hl,100	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	call	_fade_out
	ld	hl,2	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,5	;const
	push	hl
	call	_wyz_play_sound
	pop	bc
	ld	hl,500	;const
	push	hl
	call	_mywaitcycles
	pop	bc
	call	_fade_out
.i_406
	call	_menu
.i_410
	ld	a,l
	cp	+(1% 256)
	jp	z,i_411	;
	cp	+(2% 256)
	jp	z,i_412	;
	cp	+(3% 256)
	jp	z,i_454	;
	jp	i_409	;EOS
.i_411
	ld	hl,_player+13
	push	hl
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	pop	bc
	call	l_plong
	ld	hl,200	;const
	ld	(_player+10),hl
	call	_wyz_stop_sound
	call	_fade_out
	ld	hl,1	;const
	push	hl
	dec	hl
	push	hl
	call	_game
	pop	bc
	pop	bc
	jp	i_409	;EOS
.i_412
	ld	hl,23	;const
	push	hl
	ld	hl,16384	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_get_resource
	pop	bc
	pop	bc
	pop	bc
	ld	hl,9	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,71	;const
	push	hl
	ld	hl,i_1+202
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,4	;const
	push	hl
	ld	hl,18	;const
	push	hl
	ld	hl,71	;const
	push	hl
	ld	hl,i_1+217
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,8	;const
	push	hl
	ld	hl,20	;const
	push	hl
	ld	hl,71	;const
	push	hl
	ld	hl,i_1+242
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,7	;const
	push	hl
	ld	hl,21	;const
	push	hl
	ld	hl,71	;const
	push	hl
	ld	hl,i_1+260
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	xor	a
	ld	(_gpit),a
	jp	i_415	;EOS
.i_413
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_415
	ld	a,(_gpit)
	sub	20
	jp	nc,i_414	;
	ld	de,_pass_string
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),48
	jp	i_413	;EOS
.i_414
	call	_clear_keybuff
	xor	a
	ld	(_rdx),a
	ld	hl,_ncy
	ld	(hl),18
.i_416
	ld	hl,(_rdx)
	ld	h,0
	ld	a,l
	rrca
	rrca
	and	63
	ld	l,a
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	ld	bc,23108
	add	hl,bc
	push	hl
	ld	hl,(_rdx)
	ld	h,0
	ld	a,3
	and	l
	ld	l,a
	pop	de
	add	hl,de
	ld	(_gp_gen),hl
	ld	(hl),48
	ld	l,(hl)
	ld	h,0
	call	in_Inkey
	ld	a,l
	ld	hl,_gpit
	ld	(hl),a
	ld	a,96
	cp	(hl)
	jp	nc,i_419	;
	ld	a,(_gpit)
	cp	103
	jp	nc,i_419	;
	defc	i_419 = i_418
.i_420_i_419
	ld	hl,(_gpit)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpit),a
.i_418
	ld	a,(_gpit)
	and	a
	jp	z,i_421	;
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	cp	13
	jp	nz,i_422	;
	call	_check_password
	ld	a,h
	or	l
	jp	z,i_423	;
	ld	bc,_player+13
	ld	hl,(_ps_score)
	ld	de,(_ps_score+2)
	call	l_plong
	ld	de,_player+10
	ld	hl,(_ps_energy)
	call	l_pint
	call	_wyz_stop_sound
	call	_fade_out
	ld	hl,(_ps_world)
	ld	h,0
	push	hl
	ld	hl,(_ps_level)
	ld	h,0
	push	hl
	call	_game
	pop	bc
	pop	bc
	jp	i_417	;EOS
.i_423
	ld	hl,9	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,66	;const
	push	hl
	ld	hl,i_1+280
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_425
	call	in_Inkey
	ld	a,h
	or	l
	jp	nz,i_425	;EOS
.i_426
.i_427
	call	in_Inkey
	call	l_lneg
	jp	c,i_427	;EOS
.i_428
	ld	hl,9	;const
	push	hl
	ld	hl,16	;const
	push	hl
	ld	hl,71	;const
	push	hl
	ld	hl,i_1+202
	push	hl
	call	_draw_fast
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_ncy
	ld	(hl),18
	jp	i_429	;EOS
	defc	i_424 = i_429
.i_422
	ld	hl,(_gpit)
	ld	h,0
	ld	a,l
	cp	32
	jp	z,i_417	;EOS
.i_430
	ld	a,(_gpit)
	cp	12
	jp	z,i_433	;
	cp	8
	jp	nz,i_435	;
.i_433
	ld	hl,(_rdx)
	ld	h,0
	xor	a
	sub	l
	jp	nc,i_435	;
	defc	i_435 = i_432
.i_436_i_435
	ld	hl,(_gp_gen)
	ld	(hl),71
	ld	hl,_rdx
	ld	a,(hl)
	dec	(hl)
	jp	i_437	;EOS
.i_432
	ld	a,(_gpit)
	cp	9
	jp	nz,i_439	;
	ld	a,(_rdx)
	sub	19
	jp	nc,i_439	;
	defc	i_439 = i_438
.i_440_i_439
	ld	hl,(_gp_gen)
	ld	(hl),71
	ld	hl,_rdx
	ld	a,(hl)
	inc	(hl)
	jp	i_441	;EOS
.i_438
	ld	hl,(_gpit)
	ld	h,0
	ld	de,65
	ex	de,hl
	call	l_uge
	jp	nc,i_443	;
	ld	a,(_gpit)
	cp	71
	jp	c,i_445	;
.i_443
	jr	i_443_i_444
.i_444
	ld	a,h
	or	l
	jp	nz,i_445	;
.i_443_i_444
	ld	hl,(_gpit)
	ld	h,0
	ld	de,48
	ex	de,hl
	call	l_uge
	jp	nc,i_446	;
	ld	a,(_gpit)
	cp	58
	jp	nc,i_446	;
.i_445
	defc	i_446 = i_442
.i_448_i_446
	ld	de,_pass_string
	ld	hl,(_rdx)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_gpit
	ld	a,(hl)
	ld	(de),a
	ld	hl,_ncx
	push	hl
	ld	hl,(_rdx)
	ld	h,0
	ld	a,l
	rrca
	rrca
	and	63
	ld	l,a
	ld	b,h
	ld	c,l
	add	hl,hl
	add	hl,hl
	add	hl,bc
	ld	bc,4
	add	hl,bc
	push	hl
	ld	hl,(_rdx)
	ld	h,0
	ld	a,3
	and	l
	ld	l,a
	pop	de
	add	hl,de
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_ncn
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	call	_draw_char
	ld	hl,(_gp_gen)
	ld	(hl),71
	ld	a,(_rdx)
	sub	19
	jp	nc,i_449	;
	ld	hl,_rdx
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
.i_449
.i_442
.i_441
.i_437
.i_431
.i_429
.i_450
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	call	in_Inkey
	pop	de
	call	l_eq
	jp	c,i_452	;
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	call	in_Inkey
	ld	bc,-32
	add	hl,bc
	pop	de
	call	l_eq
	jp	nc,i_451	;
	jp	i_450	;EOS
	defc	i_452 = i_450
	defc	i_451 = i_416
	defc	i_421 = i_416
	jp	i_409	;EOS
	defc	i_417 = i_409
.i_454
	ld	hl,_player+13
	push	hl
	ld	hl,0	;const
	ld	d,h
	ld	e,l
	pop	bc
	call	l_plong
	ld	hl,200	;const
	ld	(_player+10),hl
	call	_wyz_stop_sound
	call	_fade_out
	ld	hl,6	;const
	push	hl
	ld	hl,0	;const
	push	hl
	call	_game
	pop	bc
	pop	bc
	jp	i_406	;EOS
	defc	i_409 = i_406
.i_407
	ret


	SECTION	rodata_compiler
.i_1
	defm	"THIS LEVEL SCORE:"
	defb	0

	defm	"BONUS ENERGY:"
	defb	0

	defm	"EXTRA END OF STAGE BONUS"
	defb	0

	defm	"2011/2020 BY THE MOJON TWINS"
	defb	0

	defm	"2020 PHOENIXWARE"
	defb	0

	defm	"1 PLAY    "
	defb	0

	defm	"2 CONTROLS"
	defb	0

	defm	"          "
	defb	0

	defm	"1 START   "
	defb	0

	defm	"2 PASSWORD"
	defb	0

	defm	"3 TRAINING"
	defb	0

	defm	"1 KEYBOARD"
	defb	0

	defm	"2 KEMPSTON"
	defb	0

	defm	"3 SINCLAIR"
	defb	0

	defm	"ENTER PASSWORD"
	defb	0

	defm	"0000 0000 0000 0000 0000"
	defb	0

	defm	"PRESS ENTER TO GO"
	defb	0

	defm	"PRESS SPACE TO EXIT"
	defb	0

	defm	"WRONG PASSWORD"
	defb	0


; --- Start of Static Variables ---

	SECTION	bss_compiler
._pad0	defs	1
._gpit	defs	1
._idx	defs	1
._gpint	defs	2
._gp_gen	defs	2
._rdx	defs	1
._rdy	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._rrdx	defs	1
._rrdy	defs	1
.__x	defs	1
.__y	defs	1
.__n	defs	1
.__c	defs	1
._at1	defs	1
._at2	defs	1
._dothis	defs	1
._nd	defs	1
._bi	defs	1
._bj	defs	1
._ei	defs	1
._si	defs	1
._bus_count	defs	1
._cao	defs	1
._busi	defs	1
._xo	defs	1
._yo	defs	1
._whichtile	defs	2
._ntile	defs	1
._cam_x	defs	1
._cam_y	defs	1
._player	defs	27
._inval	defs	1
._conveyors_on	defs	1
._bomb	defs	6
._tile_bomb	defs	1
._spawners_x	defs	50
._spawners_y	defs	50
._spawners_en	defs	50
._spawners_type	defs	50
._spawners_last_spawned	defs	50
._spawners_ct	defs	50
._spawners_ptr	defs	100
._max_spawners	defs	1
._enemies_x	defs	128
._enemies_y	defs	128
._enemies_real_x	defs	128
._enemies_real_y	defs	128
._enemies_en	defs	128
._enemies_facing	defs	128
._enemies_type	defs	128
._enemies_ns	defs	128
._enemies_frame	defs	128
._enemies_bus	defs	128
._shoots_x	defs	4
._shoots_y	defs	4
._shoots_mx	defs	4
._shoots_my	defs	4
._shoots_trail_dx	defs	4
._shoots_trail_dy	defs	4
._shoots_active	defs	4
._n_shoots	defs	1
._destructors_slots	defs	20
._destructors_slots_i	defs	1
._destructors_x	defs	20
._destructors_y	defs	20
._destructors_ct	defs	20
._destructors_address	defs	40
._dei	defs	1
._focos_slots	defs	20
._focos_slots_i	defs	1
._focos_x	defs	20
._focos_y	defs	20
._focos_ct	defs	20
._focos_propagador	defs	20
._foi	defs	1
._foic	defs	1
._halflife	defs	1
._i_shat_brix	defs	1
._ca1	defs	1
._ca2	defs	1
._ca3	defs	1
._ca4	defs	1
._dx	defs	1
._dy	defs	1
._sx	defs	1
._sy	defs	1
._sn	defs	1
._sc	defs	1
._cx	defs	1
._cy	defs	1
._offx	defs	1
._offy	defs	1
._ttest	defs	1
._hexstring	defs	2
._hexvalue	defs	1
._password	defs	10
._pass_string	defs	21
._ps_score	defs	4
._ps_energy	defs	2
._ps_world	defs	1
._ps_level	defs	1
	SECTION	code_compiler


; --- Start of Scope Defns ---

	GLOBAL	_in_KeyDebounce
	GLOBAL	_in_KeyStartRepeat
	GLOBAL	_in_KeyRepeatPeriod
	GLOBAL	_in_KbdState
	GLOBAL	in_GetKey
	GLOBAL	in_GetKeyReset
	GLOBAL	in_Inkey
	GLOBAL	in_KeyPressed
	GLOBAL	in_LookupKey
	GLOBAL	in_Pause
	GLOBAL	in_Wait
	GLOBAL	in_WaitForKey
	GLOBAL	in_WaitForNoKey
	GLOBAL	in_JoyKeyboard
	GLOBAL	zx_128mode
	GLOBAL	zx_floatingbus
	GLOBAL	zx_issue3
	GLOBAL	zx_type
	GLOBAL	zx_model
	GLOBAL	zx_basic_length
	GLOBAL	zx_var_length
	GLOBAL	zx_printer
	GLOBAL	zx_soundchip
	GLOBAL	zx_timexsound
	GLOBAL	zx_fullerstick
	GLOBAL	zx_kempstonmouse
	GLOBAL	zx_kempston
	GLOBAL	zx_iss_stick
	GLOBAL	zx_mb02
	GLOBAL	zx_multiface
	GLOBAL	zx_disciple
	GLOBAL	zx_plus3fdc
	GLOBAL	zx_zxmmc
	GLOBAL	zx_extsys
	GLOBAL	zx_basemem
	GLOBAL	zx_break
	GLOBAL	zx_ulaplus
	GLOBAL	ula_plus_mode
	GLOBAL	ula_normal_mode
	GLOBAL	ula_sync
	GLOBAL	ulaplus_set
	GLOBAL	ulaplus_get
	GLOBAL	zx_syntax
	GLOBAL	zx_goto
	GLOBAL	zx_line
	GLOBAL	zx_getstr
	GLOBAL	zx_setstr
	GLOBAL	zx_getint
	GLOBAL	zx_setint
	GLOBAL	zx_getfloat
	GLOBAL	zx_setfloat
	GLOBAL	zx_getstr_callee
	GLOBAL	zx_setstr_callee
	GLOBAL	zx_setint_callee
	GLOBAL	zx_setfloat_callee
	GLOBAL	zx_lprintc
	GLOBAL	zx_hardcopy
	GLOBAL	zx_print_buf
	GLOBAL	zx_print_row
	GLOBAL	tape_save
	GLOBAL	tape_save_block
	GLOBAL	tape_load_block
	GLOBAL	tape_save_block_callee
	GLOBAL	tape_load_block_callee
	GLOBAL	in_JoyFuller
	GLOBAL	in_JoyKempston
	GLOBAL	in_JoySinclair1
	GLOBAL	in_JoySinclair2
	GLOBAL	in_JoyTimex1
	GLOBAL	in_JoyTimex2
	GLOBAL	in_MouseAMXInit
	GLOBAL	in_MouseAMX
	GLOBAL	in_MouseAMXSetPos
	GLOBAL	in_MouseAMXInit_callee
	GLOBAL	in_MouseAMX_callee
	GLOBAL	in_MouseAMXSetPos_callee
	GLOBAL	in_MouseKempInit
	GLOBAL	in_MouseKemp
	GLOBAL	in_MouseKempSetPos
	GLOBAL	in_MouseKemp_callee
	GLOBAL	in_MouseKempSetPos_callee
	GLOBAL	zx_border
	GLOBAL	zx_colour
	GLOBAL	zx_attr
	GLOBAL	zx_screenstr
	GLOBAL	zx_attr_callee
	GLOBAL	zx_screenstr_callee
	GLOBAL	zx_printf
	GLOBAL	zx_cxy2saddr
	GLOBAL	zx_cy2saddr
	GLOBAL	zx_pxy2saddr
	GLOBAL	zx_py2saddr
	GLOBAL	zx_saddr2cx
	GLOBAL	zx_saddr2cy
	GLOBAL	zx_saddr2px
	GLOBAL	zx_saddr2py
	GLOBAL	zx_saddr2aaddr
	GLOBAL	zx_saddrcdown
	GLOBAL	zx_saddrcleft
	GLOBAL	zx_saddrcright
	GLOBAL	zx_saddrcup
	GLOBAL	zx_saddrpdown
	GLOBAL	zx_saddrpleft
	GLOBAL	zx_saddrpright
	GLOBAL	zx_saddrpup
	GLOBAL	zx_cxy2saddr_callee
	GLOBAL	zx_pxy2saddr_callee
	GLOBAL	zx_saddr2px_callee
	GLOBAL	zx_saddrpleft_callee
	GLOBAL	zx_saddrpright_callee
	GLOBAL	zx_cxy2aaddr
	GLOBAL	zx_cy2aaddr
	GLOBAL	zx_pxy2aaddr
	GLOBAL	zx_py2aaddr
	GLOBAL	zx_aaddr2cx
	GLOBAL	zx_aaddr2cy
	GLOBAL	zx_aaddr2px
	GLOBAL	zx_aaddr2py
	GLOBAL	zx_aaddr2saddr
	GLOBAL	zx_aaddrcdown
	GLOBAL	zx_aaddrcleft
	GLOBAL	zx_aaddrcright
	GLOBAL	zx_aaddrcup
	GLOBAL	zx_cxy2aaddr_callee
	GLOBAL	zx_pxy2aaddr_callee
	GLOBAL	im1_init
	GLOBAL	im1_install_isr
	GLOBAL	im1_uninstall_isr
	GLOBAL	nmi_init
	GLOBAL	nmi_install_isr
	GLOBAL	nmi_uninstall_isr
	GLOBAL	tick_count_isr
	GLOBAL	_tick_count
	GLOBAL	zx_im2_init
	GLOBAL	add_raster_int
	GLOBAL	zxgetfname
	GLOBAL	zxgetfname2
	GLOBAL	in_MouseSimInit
	GLOBAL	in_MouseSim
	GLOBAL	in_MouseSimSetPos
	GLOBAL	in_MouseSimInit_fastcall
	GLOBAL	in_MouseSim_callee
	GLOBAL	in_MouseSimSetPos_callee
	GLOBAL	im2_Init
	GLOBAL	im2_InstallISR
	GLOBAL	im2_EmptyISR
	GLOBAL	im2_CreateGenericISR
	GLOBAL	im2_CreateGenericISRLight
	GLOBAL	im2_RegHookFirst
	GLOBAL	im2_RegHookLast
	GLOBAL	im2_RemoveHook
	GLOBAL	im2_InstallISR_callee
	GLOBAL	im2_CreateGenericISR_callee
	GLOBAL	im2_CreateGenericISRLight_callee
	GLOBAL	im2_RegHookFirst_callee
	GLOBAL	im2_RegHookLast_callee
	GLOBAL	im2_RemoveHook_callee
	GLOBAL	_pad0
	GLOBAL	_gpit
	GLOBAL	_idx
	GLOBAL	_gpint
	GLOBAL	_gp_gen
	GLOBAL	_rdx
	GLOBAL	_rdy
	GLOBAL	_rda
	GLOBAL	_rdb
	GLOBAL	_rdc
	GLOBAL	_rrdx
	GLOBAL	_rrdy
	GLOBAL	__x
	GLOBAL	__y
	GLOBAL	__n
	GLOBAL	__c
	GLOBAL	_at1
	GLOBAL	_at2
	GLOBAL	_dothis
	GLOBAL	_nd
	GLOBAL	_bi
	GLOBAL	_bj
	GLOBAL	_ei
	GLOBAL	_si
	GLOBAL	_bus_count
	GLOBAL	_cao
	GLOBAL	_busi
	GLOBAL	_xo
	GLOBAL	_yo
	GLOBAL	_whichtile
	GLOBAL	_ntile
	GLOBAL	_keys
	GLOBAL	_cam_x
	GLOBAL	_cam_y
	GLOBAL	_player
	GLOBAL	_start_x
	GLOBAL	_start_y
	GLOBAL	_inval
	GLOBAL	_conveyors_on
	GLOBAL	_bomb
	GLOBAL	_tile_bomb
	GLOBAL	_spawners_x
	GLOBAL	_spawners_y
	GLOBAL	_spawners_en
	GLOBAL	_spawners_type
	GLOBAL	_spawners_last_spawned
	GLOBAL	_spawners_ct
	GLOBAL	_spawners_ptr
	GLOBAL	_max_spawners
	GLOBAL	_enemies_x
	GLOBAL	_enemies_y
	GLOBAL	_enemies_real_x
	GLOBAL	_enemies_real_y
	GLOBAL	_enemies_en
	GLOBAL	_enemies_facing
	GLOBAL	_enemies_type
	GLOBAL	_enemies_ns
	GLOBAL	_enemies_frame
	GLOBAL	_enemies_bus
	GLOBAL	_max_recharges
	GLOBAL	_shoots_x
	GLOBAL	_shoots_y
	GLOBAL	_shoots_mx
	GLOBAL	_shoots_my
	GLOBAL	_shoots_trail_dx
	GLOBAL	_shoots_trail_dy
	GLOBAL	_shoots_active
	GLOBAL	_n_shoots
	GLOBAL	_destructors_slots
	GLOBAL	_destructors_slots_i
	GLOBAL	_destructors_x
	GLOBAL	_destructors_y
	GLOBAL	_destructors_ct
	GLOBAL	_destructors_address
	GLOBAL	_dei
	GLOBAL	_focos_slots
	GLOBAL	_focos_slots_i
	GLOBAL	_focos_x
	GLOBAL	_focos_y
	GLOBAL	_focos_ct
	GLOBAL	_focos_propagador
	GLOBAL	_foi
	GLOBAL	_foic
	GLOBAL	_halflife
	GLOBAL	_i_shat_brix
	GLOBAL	_ca1
	GLOBAL	_ca2
	GLOBAL	_ca3
	GLOBAL	_ca4
	GLOBAL	_dx
	GLOBAL	_dy
	defc	_video_page	= 23301
	defc	_ram_page_act	= 23302
	defc	_pregister	= 23303
	GLOBAL	_SetRAMBank
	GLOBAL	_resources
	defc	_ram_page	= 23296
	defc	_ram_address	= 23297
	defc	_ram_destination	= 23299
	GLOBAL	_blackout_everything
	GLOBAL	_get_resource
	GLOBAL	_asm_int
	GLOBAL	_seed
	GLOBAL	_sx
	GLOBAL	_sy
	GLOBAL	_sn
	GLOBAL	_sc
	GLOBAL	_cx
	GLOBAL	_cy
	GLOBAL	_offx
	GLOBAL	_offy
	GLOBAL	_ttest
	GLOBAL	_dt_attr
	GLOBAL	_dt_putchar
	GLOBAL	_draw_sprite
	GLOBAL	_draw_map
	GLOBAL	_blit_buffer
	GLOBAL	_srand
	GLOBAL	_rand
	GLOBAL	_isr
	GLOBAL	_wyz_init_soundsystem
	GLOBAL	_wyz_play_sound
	GLOBAL	_wyz_play_music
	GLOBAL	_wyz_stop_sound
	GLOBAL	_ncx
	GLOBAL	_ncy
	GLOBAL	_ncn
	GLOBAL	_ncc
	GLOBAL	_draw_big_digit
	GLOBAL	_draw_char
	GLOBAL	_clear_viewport
	GLOBAL	_draw_1_digit
	GLOBAL	_draw_3_digit
	GLOBAL	_draw_5_digit
	GLOBAL	_mywaitcycles
	GLOBAL	_draw_fast
	GLOBAL	_draw_char_by_char
	GLOBAL	_puchini
	GLOBAL	_draw_char_by_char2
	GLOBAL	_fade_out
	GLOBAL	_mywaitkey
	GLOBAL	_intro_cad1
	GLOBAL	_intro_cad2
	GLOBAL	_intro_cad3
	GLOBAL	_intro_cad4
	GLOBAL	_intro_cad5
	GLOBAL	_behs
	GLOBAL	_worlds
	GLOBAL	_prepare_world
	GLOBAL	_prepare_stage
	GLOBAL	_joyfunc
	GLOBAL	_clear_keybuff
	GLOBAL	_scr_ending_2
	GLOBAL	_digits
	GLOBAL	_hexstring
	GLOBAL	_hexvalue
	GLOBAL	_password
	GLOBAL	_pass_string
	GLOBAL	_ps_score
	GLOBAL	_ps_energy
	GLOBAL	_ps_world
	GLOBAL	_ps_level
	GLOBAL	_hex2char
	GLOBAL	_char2hex
	GLOBAL	_build_password
	GLOBAL	_whiteout_everything
	GLOBAL	_check_password
	GLOBAL	_attr_resource
	GLOBAL	_ending_cad_0
	GLOBAL	_ending_cad_1
	GLOBAL	_ending_cad_2
	GLOBAL	_ending_cad_3
	GLOBAL	_ending_cad_4
	GLOBAL	_ending_cads
	GLOBAL	_ending
	GLOBAL	_add_to_score
	GLOBAL	_destructors_init
	GLOBAL	_focos_init
	GLOBAL	_shoots_init
	GLOBAL	_mapdata_init
	GLOBAL	_char_mapdata_attribute
	GLOBAL	_enemies_init
	GLOBAL	_destructors_create
	GLOBAL	_destructors_update
	GLOBAL	_focos_create
	GLOBAL	_focos_update
	GLOBAL	_shoots_find
	GLOBAL	_enemies_find
	GLOBAL	_draw_shoot
	GLOBAL	_shoots_move
	GLOBAL	_check_shoot
	GLOBAL	_enemies_move
	GLOBAL	_whatInMap
	GLOBAL	_gates_break
	GLOBAL	_gates_check
	GLOBAL	_player_move
	GLOBAL	_pass_printer_section
	GLOBAL	_interim
	GLOBAL	_game
	GLOBAL	_menu
	GLOBAL	_main


; --- End of Scope Defns ---


; --- End of Compilation ---
