@echo off
echo BUILDING LEVELS!
echo ================
echo.
echo LEVEL 0
echo MAIN
..\utils\buildlevel.exe level0.bin mapfile=..\map\map0.map map_w=4 map_h=4 attrsfile=..\map\map0.sts decorations=..\script\decos0.spt nohotspots fontfile=..\gfx\font.png tilesfile=..\gfx\levels\w0.png behsfile=..\gfx\levels\w0.beh spritesfile=..\gfx\levels\sprites0.png nsprites=18 enemsfile=..\enems\enems0.ene scr_ini=0 ini_x=7 ini_y=4 enems_life=1 8bit_coords
..\utils\apack.exe level0.bin ..\bin\level0c.bin > nul
echo Compressed to \bin\level0c.bin
echo SUBTS1
..\utils\mksubts ..\gfx\levels\w0r1.png 0 ..\gfx\levels\w0r1.beh ..\bin\level0r1.bin
echo SUBTS2
..\utils\mksubts ..\gfx\levels\w0r2.png 0 ..\gfx\levels\w0r2.beh ..\bin\level0r2.bin
echo DONE!
del level0.bin > nul
echo -------------------------------------------------------------------------------
echo.

echo LEVEL 2
echo MAIN
..\utils\buildlevel.exe level2.bin mapfile=..\map\map2.map map_w=4 map_h=4 attrsfile=..\map\map2.sts decorations=..\script\decos2.spt nohotspots fontfile=..\gfx\font.png tilesfile=..\gfx\levels\w2.png behsfile=..\gfx\levels\w2.beh spritesfile=..\gfx\levels\sprites2.png nsprites=18 enemsfile=..\enems\enems2.ene scr_ini=0 ini_x=4 ini_y=4 enems_life=1 8bit_coords
..\utils\apack.exe level2.bin ..\bin\level2c.bin > nul
echo Compressed to \bin\level2c.bin
echo SUBTS1
..\utils\mksubts ..\gfx\levels\w2r1.png 0 ..\gfx\levels\w2r1.beh ..\bin\level2r1.bin
echo SUBTS2
..\utils\mksubts ..\gfx\levels\w2r2.png 0 ..\gfx\levels\w2r2.beh ..\bin\level2r2.bin
echo DONE!
del level2.bin > nul
echo -------------------------------------------------------------------------------
echo.

echo LEVEL 5
echo MAIN
..\utils\buildlevel.exe level5.bin mapfile=..\map\map5.map map_w=4 map_h=4 attrsfile=..\map\map0.sts decorations=..\script\decos5.spt nohotspots fontfile=..\gfx\font.png tilesfile=..\gfx\levels\w5.png behsfile=..\gfx\levels\w5.beh spritesfile=..\gfx\levels\sprites5.png nsprites=18 enemsfile=..\enems\enems5.ene scr_ini=0 ini_x=4 ini_y=4 enems_life=1 8bit_coords
..\utils\apack.exe level5.bin ..\bin\level5c.bin > nul
echo Compressed to \bin\level5c.bin
echo SUBTS1
..\utils\mksubts ..\gfx\levels\w5r1.png 0 ..\gfx\levels\w5r1.beh ..\bin\level5r1.bin
echo DONE!
del level5.bin > nul
echo -------------------------------------------------------------------------------
echo.

echo LEVEL 6
echo MAIN
..\utils\buildlevel.exe level6.bin mapfile=..\map\map6.map map_w=4 map_h=4 attrsfile=..\map\map0.sts decorations=..\script\decos6.spt nohotspots fontfile=..\gfx\font.png tilesfile=..\gfx\levels\w6.png behsfile=..\gfx\levels\w6.beh spritesfile=..\gfx\levels\sprites6.png nsprites=18 enemsfile=..\enems\enems6.ene scr_ini=0 ini_x=4 ini_y=4 enems_life=1 8bit_coords
..\utils\apack.exe level6.bin ..\bin\level6c.bin > nul
echo Compressed to \bin\level6c.bin
echo SUBTS1
..\utils\mksubts ..\gfx\levels\w6r1.png 0 ..\gfx\levels\w6r1.beh ..\bin\level6r1.bin
echo DONE!
del level6.bin > nul
echo -------------------------------------------------------------------------------
echo.

echo LEVEL T
echo MAIN
..\utils\buildlevel.exe levelT.bin mapfile=..\map\mapT.map map_w=4 map_h=4 attrsfile=..\map\mapT.sts decorations=..\script\decosT.spt nohotspots fontfile=..\gfx\font.png tilesfile=..\gfx\levels\wT.png behsfile=..\gfx\levels\wT.beh spritesfile=..\gfx\levels\spritesT.png nsprites=18 enemsfile=..\enems\enemsT.ene scr_ini=0 ini_x=7 ini_y=3 enems_life=1 8bit_coords
..\utils\apack.exe levelT.bin ..\bin\levelTc.bin > nul
echo Compressed to \bin\levelTc.bin
echo SUBTS1
..\utils\mksubts ..\gfx\levels\wTr1.png 0 ..\gfx\levels\wTr1.beh ..\bin\levelTr1.bin
echo SUBTS2
..\utils\mksubts ..\gfx\levels\wTr2.png 0 ..\gfx\levels\wTr2.beh ..\bin\levelTr2.bin
echo SUBTS3 TODO
..\utils\mksubts ..\gfx\levels\wTr2.png 0 ..\gfx\levels\wTr2.beh ..\bin\levelTr3.bin
echo DONE!
del levelT.bin > nul
echo -------------------------------------------------------------------------------
echo.
