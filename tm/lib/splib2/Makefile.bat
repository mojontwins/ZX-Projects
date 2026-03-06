cd cwrapper
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

cd hashtable
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

cd heap
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

z80asm -I. -d -ns -nm -Mo -DFORzx -xsplib2t2 @sp.lst
