@echo off

rem set here the game name (used in filenames)

SET game=ktt

echo ------------------------------------------------------------------------------
echo    BUILDING %game%
echo ------------------------------------------------------------------------------

if [%1]==[justcompile] goto :compilestage

rem ###########################################################################
rem ## LEVELS
rem ###########################################################################

rem we will delegate on makelevels.bat - if your game supports several levels,etc
echo ### BUILDING LEVELS ###
cd ..\levels
call buildlevels.bat > nul
cd ..\dev

rem Custom: subtileset with objects
..\utils\mksubts.exe ..\gfx\items.png 0 ..\gfx\items.beh ..\bin\itemsts.bin > nul

rem but for 48K/single level games... 
rem echo ### MAKING MAPS ###

rem the "Force" parameter is to force 16 tiles maps even if the actual map data
rem has more tan 16 tiles. Extra tiles are written to extra.spt. Me have to move
rem that file to the script folder.

rem ..\utils\map2bin.exe ..\map\mapa.map 4 4 99 map.bin bolts.bin force
rem move map.bin.spt ..\script

rem echo ### MAKING ENEMS ###
rem ..\utils\ene2bin.exe 4 4 1 ..\enems\enems.ene enems.bin hotspots.bin

rem echo ### MAKING TILESET ###
rem ..\utils\ts2bin.exe ..\gfx\font.png ..\gfx\work.png ts.bin

rem echo ### MAKING SPRITESET ###
rem ..\utils\sprcnv.exe ..\gfx\sprites.png sprites.h 18

:skiplevels

rem If you use arrows and/or drops this will make the sprites binary:

rem ..\utils\spg2bin.exe ..\gfx\drop.png spdrop.bin
..\utils\spg2bin.exe ..\gfx\arrow.png ..\bin\sparrow.bin > nul

rem ###########################################################################
rem ## FIXED SCREENS
rem ###########################################################################

echo ### MAKING FIXED ###
..\utils\png2scr.exe ..\gfx\title.png ..\gfx\title.scr 		> nul
..\utils\apack.exe ..\gfx\title.scr ..\bin\title.bin 		> nul
..\utils\png2scr.exe ..\gfx\marco.png ..\gfx\marco.scr 		> nul
..\utils\apack.exe ..\gfx\marco.scr ..\bin\marco.bin 		> nul
..\utils\png2scr.exe ..\gfx\ending.png ..\gfx\ending.scr 	> nul
..\utils\apack.exe ..\gfx\ending.scr ..\bin\ending.bin 		> nul
..\utils\png2scr.exe ..\gfx\talkg.png ..\gfx\talkg.scr 1 	> nul
..\utils\apack.exe ..\gfx\talkg.scr ..\bin\talkg.bin 		> nul
..\utils\png2scr.exe ..\gfx\talkc.png ..\gfx\talkc.scr 1 	> nul
..\utils\apack.exe ..\gfx\talkc.scr ..\bin\talkc.bin  		> nul
..\utils\png2scr.exe ..\gfx\arcon.png ..\gfx\arcon.scr 1 	> nul
..\utils\apack.exe ..\gfx\arcon.scr ..\bin\arcon.bin   		> nul
..\utils\png2scr.exe ..\gfx\tardismenu.png ..\gfx\tardismenu.scr 	> nul
..\utils\apack.exe ..\gfx\tardismenu.scr ..\bin\tardismenu.bin 		> nul
del ..\gfx\*.scr 											> nul

echo ### MAKING PORTRAITS ###
..\utils\portraits.exe ..\bin\portraits.bin ..\gfx\portraits\00_meghan.png ..\gfx\portraits\01_sold.png > nul
rem bundle with texts...
copy /b ..\bin\texts.bin + ..\bin\portraits.bin ..\bin\preload6.bin > nul

echo ### MAKING LOADING ###
..\utils\png2scr.exe ..\gfx\loading.png work\loading.bin > nul

rem ###########################################################################
rem ## GAME TEXT
rem ###########################################################################

rem Each line in text.txt contains a text string for the game.
rem textstuffer2.exe will compress and pack all text strings in
rem a binary file called texts.bin. The parameters define how
rem many chars per line. Word wrapping is automatic.

rem text will go at the beginning of PAGE 6

echo ### MAKING TEXTS ###
cd ..\texts
rem ..\utils\textstuffer.exe texts.txt ..\bin\texts.bin 24 49152
..\utils\textstuffer2.exe texts.bin textfile=texts.txt mode=character wordwrap=28 wordwrap_c=23 offset=49152 > nul
rem copy texts.bin ..\dev
copy texts.bin ..\bin\texts.bin > nul

echo ### MAKING PORTRAITS ###
..\utils\portraits.exe ..\bin\portraits.bin ..\gfx\portraits\00_meghan.png ..\gfx\portraits\01_sold.png > nul

echo ### MAKIN ITEM DESCRIPTIONS ###
..\utils\itemstuffer.exe ..\texts\items.txt ..\bin\items.bin > nul

rem bundle texts + portraits + item descriptions
copy /b ..\bin\texts.bin + ..\bin\portraits.bin + ..\bin\items.bin ..\bin\preload6.bin > nul



rem For 128K games with text + script sharing the same page, use this to
rem bundle both binaries...
rem echo ### BUNDLING TEXT + SCRIPT ###
rem copy /b ..\texts\texts.bin + ..\script\scripts.bin ..\bin\preload7.bin

rem ###########################################################################
rem ## LIBRARIAN
rem ###########################################################################
echo ### BUILDING RAMS ###
cd ..\bin 				
..\utils\librarian.exe 			> nul
copy ram?.bin ..\dev\work 		> nul
copy librarian.h ..\dev\my 		> nul
cd ..\dev

rem ###########################################################################
rem ## MUSIC
rem ###########################################################################
rem echo ### BUILDING ARKOS ###
rem cd ..\mus
rem if [%1]==[nomus] goto :nomus
rem ..\utils\build_mus_bin.exe ram1.bin
rem :nomus
rem copy ram1.bin ..\dev\work
rem copy arkos-addresses.h ..\dev\sound
rem cd ..\dev

echo ### BUILDING WYZ PLAYER ###
cd ..\mus
..\utils\pasmo WYZproPlay47aZXc.ASM ram1.bin > nul
copy ram1.bin ..\dev\work 					 > nul
cd ..\dev


:compilestage

rem Custom for K2T: need to preprocess _k2t_ext_helpers.h to replace the pattern 
rem %%%base_portraits%%% with the actual address (calculated)
rem Custom for K2T: need to preprocess _k2t_ext_helpers.h to replace the pattern
rem %%%base_itemdescs%%% with the actual address (calculate) (as well)
rem look at me...

cd ..\dev
..\utils\imanol.exe in=my\_k2t_ext_helpers.h out=work\k2t_ext_helpers.h base_portraits=?..\texts\texts.bin+49152 base_itemdescs=?..\texts\texts.bin+..\bin\portraits.bin+49152 > nul

rem ###########################################################################
rem ## GAME SCRIPT
rem ###########################################################################

rem The game script is compiled by msc3.exe. For 128K games use "rampage" at
rem the end so the script compiler generates code to stuff everything in
rem extra pages; the second parameter is the # of screens in your game.
rem i.e. "msc3.exe ninjajar.spt 21 rampage"

echo ### MAKING SCRIPT ###
cd ..\script
..\utils\msc3.exe %game%.spt 16 > nul

rem If scripts and texts are going to share the same RAM page, use this line
rem (for 128K games)
rem This calculates an offset for the scripts binary automaticly.
rem ..\utils\sizeof.exe ..\bin\texts.bin 49152 "#define SCRIPT_INIT" >> msc-config.h

rem Otherwise use this one:
echo #define SCRIPT_INIT 49152 >> msc-config.h

copy msc.h ..\dev\my 					> nul
copy msc-config.h ..\dev\my 			> nul
copy scripts.bin ..\bin\preload7.bin 	> nul
cd ..\dev


rem ###########################################################################
rem ## COMPILATION AND TAPE BUILDING
rem ###########################################################################


echo ### COMPILING ###
zcc +zx -vn -m game.c -o work\%game%.bin -lsplib2 -zorg=24200 > nul
zcc +zx -vn -a game.c -o work\%game%.asm -lsplib2 -zorg=24200 > nul

echo ### MAKING TAPS ###
..\utils\bas2tap -a10 -sFINAL loader\loader128.bas work\loader.tap 	> nul
..\utils\bin2tap -o work\loading.tap -a 16384 work\loading.bin 		> nul
..\utils\bin2tap -o work\reubica.tap -a 25000 loader\reubica.bin 	> nul
..\utils\bin2tap -o work\ram1.tap -a 32768 work\ram1.bin 			> nul
..\utils\bin2tap -o work\ram3.tap -a 32768 work\ram3.bin 			> nul
..\utils\bin2tap -o work\ram4.tap -a 32768 work\ram4.bin 			> nul
..\utils\bin2tap -o work\ram6.tap -a 32768 work\ram6.bin 			> nul
..\utils\bin2tap -o work\ram7.tap -a 32768 work\ram7.bin 			> nul
..\utils\bin2tap -o work\main.tap -a 24200 work\%game%.bin 			> nul
copy /b work\loader.tap + work\loading.tap + work\reubica.tap + work\ram1.tap + work\ram3.tap + work\ram4.tap  + work\ram6.tap + work\ram7.tap + work\main.tap %game%.tap > nul
