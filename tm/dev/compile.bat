@echo off

echo ### IMPORTING GFX ###
..\utils\mkts_om.exe platform=zx mode=sprites in=..\gfx\sprites.png out=bin\spriteset.bin offset=0,0 size=8,3 max=18 metasize=2,2 defaultink=7 silent
cd ..\gfx
..\utils\mkts_om.exe platform=zx mode=scripted in=export_ts.spt silent
cd ..\dev
..\utils\png2scr.exe ..\gfx\loading.png bin\loading.bin
..\utils\png2scr.exe ..\gfx\title.png work\title.bin
..\utils\apack.exe work\title.bin bin\title.bin > nul
..\utils\png2scr.exe ..\gfx\ending.png work\ending.bin
..\utils\apack.exe work\ending.bin bin\ending.bin > nul

echo ### CONVERTING MAP ###
..\utils\rle62map_sp.exe in=..\map\mapa.map out=bin\mapa size=8,3 scrsize=15,10 nodecos

echo ### CONVERTING ENEMS ###
..\utils\ene2bin.exe ..\enems\enems.ene bin\baddies.bin bin\hotspots.bin byte_values 2bytes

echo ### COMPILANDO GUEGO ###
zcc +zx -vn -m tm.c -o work\tm.bin -lsplib2t2 -zorg=24000 > nul
zcc +zx -vn -a tm.c -o work\tm.asm -lsplib2t2 -zorg=24000 > nul

echo ### CONSTRUYENDO CINTA ###

..\utils\bas2tap -a10 -sTENEBRA_R loader.bas loader.tap
..\utils\bin2tap -o screen.tap -a 16384 bin\loading.bin
..\utils\bin2tap -o main.tap -a 24000 work\tm.bin
copy /b loader.tap + screen.tap + main.tap tm.tap > nul

echo ### LIMPIANDO ###
del loader.tap
del screen.tap
del main.tap
dir work\tm.bin

echo ### DONE ###
