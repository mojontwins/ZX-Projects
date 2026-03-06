He visto que hay un editor totalmente funcional que es capaz de editar páginas. La idea es montar con esto el motor. Las páginas las puedo grabar como una capa de 32x22 caracteres y 32x22 atributos comprimidos con aplib. Cada página se descomprime en un buffer de 32x22x2 y desde ahí se construye la pantalla. Un sencillo putchar, y luego un LDIR para los atributos. El motor leerá el teclado. Cada 3 dígitos redirigirá a la pantalla indicada, si existe. Un motor así debería ser muy sencillo de hacer en C con ensamble en linea (para mayor comodidad).

El compilador debería tomar un directorio con todas las ???.ttx y construir el código C+ASM del proyecto listo para compilar con z88dk viejo y echar a andar. Podría incluso automatizarlo todo.

