@echo off
set game=maritrini
if [%1]==[justcompile] goto :justcompile

echo Librarian
..\utils\librarian2.exe list=librarian.txt index=librarian.h bins_prefix=../bin/ > nul

:justcompile
echo Compiling
rem zcc +zx -vn -O3 -m %game%.c -o %game%.bin -lim2 -zorg=39321 > nul
zcc +zx -vn -O3 -m %game%.c -o %game%.bin -crt0=crt.asm -zorg=39321 > nul

echo Making loader

..\utils\apack.exe loading.bin loading.c.bin > nul
..\utils\apack.exe %game%.bin %game%.c.bin > nul
..\utils\apack.exe ram1.bin ram1.c.bin > nul

..\utils\imanol.exe ^
    in=loader.asm-orig ^
    out=loader.asm ^
    ls_length=?loading.c.bin ^
    ram1_length=?ram1.c.bin ^
    ram3_length=?ram3.bin ^
    ram4_length=?ram4.bin ^
    ram6_length=?ram6.bin ^
    mb_start=?65000-%game%.c.bin ^
    mb_length=?%game%.c.bin  > nul

..\utils\pasmo.exe loader.asm loader.bin > nul

echo Building tape
..\utils\png2scr.exe ..\gfx\screen.png loading.bin > nul
..\utils\GenTape.exe %game%.tap ^
    basic 'MARITRINI' 10 loader.bin ^
    data           loading.c.bin ^
    data           ram1.c.bin ^
    data           ram3.bin ^
    data           ram4.bin ^
    data           ram6.bin ^
    data           %game%.c.bin  > nul

rm loading.c.bin > nul
rm %game%.c.bin > nul
