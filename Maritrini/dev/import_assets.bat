@echo off
echo Reordering GFX
..\utils\reordenator.exe ..\gfx\forest-work.png ..\gfx\forest-import.png > nul
..\utils\reordenator.exe ..\gfx\school-work.png ..\gfx\school-import.png > nul
..\utils\reordenator.exe ..\gfx\basement-work.png ..\gfx\basement-import.png > nul
..\utils\reordenator.exe ..\gfx\mine-work.png ..\gfx\mine-import.png > nul
..\utils\reordenator.exe ..\gfx\hitech-work.png ..\gfx\hitech-import.png > nul
..\utils\reordenator.exe ..\gfx\training-work.png ..\gfx\training-import.png > nul
..\utils\reordenator.exe ..\gfx\secret-work.png ..\gfx\secret-import.png > nul

echo Converting GFX
..\utils\mimporter.exe ..\gfx\forest-import.png ..\bin\_tileset-forest.bin > nul
..\utils\mimporter.exe ..\gfx\school-import.png ..\bin\_tileset-school.bin > nul
..\utils\mimporter.exe ..\gfx\basement-import.png ..\bin\_tileset-basement.bin > nul
..\utils\mimporter.exe ..\gfx\mine-import.png ..\bin\_tileset-mine.bin > nul
..\utils\mimporter.exe ..\gfx\hitech-import.png ..\bin\_tileset-hitech.bin > nul
..\utils\mimporter.exe ..\gfx\training-import.png ..\bin\_tileset-training.bin > nul
..\utils\mimporter.exe ..\gfx\secret-import.png ..\bin\_tileset-secret.bin > nul

echo Compressing GFX
..\utils\apack.exe ..\bin\_tileset-forest.bin ..\bin\tileset-forest.bin > nul 
..\utils\apack.exe ..\bin\_tileset-school.bin ..\bin\tileset-school.bin > nul
..\utils\apack.exe ..\bin\_tileset-basement.bin ..\bin\tileset-basement.bin > nul
..\utils\apack.exe ..\bin\_tileset-mine.bin ..\bin\tileset-mine.bin > nul
..\utils\apack.exe ..\bin\_tileset-hitech.bin ..\bin\tileset-hitech.bin > nul
..\utils\apack.exe ..\bin\_tileset-training.bin ..\bin\tileset-training.bin > nul
..\utils\apack.exe ..\bin\_tileset-secret.bin ..\bin\tileset-secret.bin > nul

echo Converting BEHS
..\utils\behs2bin.exe ..\gfx\forest-behs.txt ..\bin\_forest-behs.bin > nul
..\utils\behs2bin.exe ..\gfx\school-behs.txt ..\bin\_school-behs.bin > nul 
..\utils\behs2bin.exe ..\gfx\basement-behs.txt ..\bin\_basement-behs.bin > nul 
..\utils\behs2bin.exe ..\gfx\mine-behs.txt ..\bin\_mine-behs.bin > nul 
..\utils\behs2bin.exe ..\gfx\hitech-behs.txt ..\bin\_hitech-behs.bin > nul
..\utils\behs2bin.exe ..\gfx\training-behs.txt ..\bin\_training-behs.bin > nul
..\utils\behs2bin.exe ..\gfx\secret-behs.txt ..\bin\_secret-behs.bin > nul

echo Compressing BEHS
..\utils\apack.exe ..\bin\_forest-behs.bin ..\bin\forest-behs.bin > nul
..\utils\apack.exe ..\bin\_school-behs.bin ..\bin\school-behs.bin > nul
..\utils\apack.exe ..\bin\_basement-behs.bin ..\bin\basement-behs.bin > nul
..\utils\apack.exe ..\bin\_mine-behs.bin ..\bin\mine-behs.bin > nul
..\utils\apack.exe ..\bin\_hitech-behs.bin ..\bin\hitech-behs.bin > nul
..\utils\apack.exe ..\bin\_training-behs.bin ..\bin\training-behs.bin > nul
..\utils\apack.exe ..\bin\_secret-behs.bin ..\bin\secret-behs.bin > nul

echo Compressing MAPS
..\utils\apack.exe ..\map\forest1.map ..\bin\map-forest1.bin > nul
..\utils\apack.exe ..\map\forest2.map ..\bin\map-forest2.bin > nul
..\utils\apack.exe ..\map\forest3.map ..\bin\map-forest3.bin > nul
..\utils\apack.exe ..\map\forest4.map ..\bin\map-forest4.bin > nul
..\utils\apack.exe ..\map\school1.map ..\bin\map-school1.bin > nul
..\utils\apack.exe ..\map\school2.map ..\bin\map-school2.bin > nul
..\utils\apack.exe ..\map\school3.map ..\bin\map-school3.bin > nul
..\utils\apack.exe ..\map\school4.map ..\bin\map-school4.bin > nul
..\utils\apack.exe ..\map\basement1.map ..\bin\map-basement1.bin > nul
..\utils\apack.exe ..\map\basement2.map ..\bin\map-basement2.bin > nul
..\utils\apack.exe ..\map\basement3.map ..\bin\map-basement3.bin > nul
..\utils\apack.exe ..\map\basement4.map ..\bin\map-basement4.bin > nul
..\utils\apack.exe ..\map\mine1.map ..\bin\map-mine1.bin > nul
..\utils\apack.exe ..\map\mine2.map ..\bin\map-mine2.bin > nul
..\utils\apack.exe ..\map\mine3.map ..\bin\map-mine3.bin > nul
..\utils\apack.exe ..\map\mine4.map ..\bin\map-mine4.bin > nul
..\utils\apack.exe ..\map\hitech1.map ..\bin\map-hitech1.bin > nul
..\utils\apack.exe ..\map\hitech2.map ..\bin\map-hitech2.bin > nul
..\utils\apack.exe ..\map\hitech3.map ..\bin\map-hitech3.bin > nul
..\utils\apack.exe ..\map\hitech4.map ..\bin\map-hitech4.bin > nul
..\utils\apack.exe ..\map\secret.map ..\bin\map-secret.bin > nul
..\utils\apack.exe ..\map\training.map ..\bin\map-training.bin > nul

..\utils\apack.exe ..\map\luca1.map ..\bin\map-luca1.bin > nul
..\utils\apack.exe ..\map\luca2.map ..\bin\map-luca2.bin > nul
..\utils\apack.exe ..\map\luca3.map ..\bin\map-luca3.bin > nul
..\utils\apack.exe ..\map\luca4.map ..\bin\map-luca4.bin > nul
