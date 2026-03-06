@echo off
set game=maritrini

echo Librarian
..\utils\librarian2.exe list=librarian.txt index=librarian.h bins_prefix=../bin/

echo Compiling
zcc +zx -vn -O3 %game%.c -o %game%.bin -lim2 -zorg=32768

echo Making loader
..\utils\imanol.exe ^
    in=loader.asm-orig ^
    out=loader.asm ^
    ram1_length=?ram1.bin ^
    ram3_length=?ram3.bin ^
    ram4_length=?ram4.bin ^
    ram6_length=?ram6.bin ^
    mb_length=?%game%.bin  > nul

..\utils\pasmo.exe loader.asm loader.bin > nul

echo Building tape
..\utils\png2scr.exe ..\gfx\screen.png loading.bin > nul
..\utils\GenTape.exe %game%.tap ^
    basic 'MARITRINI' 10 loader.bin ^
    data           loading.bin ^
    data           ram1.bin ^
    data           ram3.bin ^
    data           ram4.bin ^
    data           ram6.bin ^
    data           %game%.bin
