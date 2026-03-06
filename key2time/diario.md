20191105
========

Proyecto retomado como quien no quiere la cosa. He eliminado MK2 usando un preprocesador que sólo deja los #ifdef correctos según la configuración, y he limpiado todo. Ahora es cuando empiezo a cambiar trozos de código viejísimo por versiones más mejores y menos peores. La idea es conseguir 25 fps fijos.

He pasado varios días montando esto y ahora es cuando empiezo a optimizar. He colocado un medidor rudimentario que me muestra en rojo el porcentaje de frame libre. Por ahora está desaparecido casi todo el tiempo (vamos a menos de 25fps). El objetivo es que más o menos siempre esté visible. Para ello tocaré el módulo de enemigos y cambiaré el del jugador, que (muy) probablemente haga las colisiones de manera mierder. También puedo cambiar para que use 4 bits de parte "decimal" en lugar de 6, pero eso ya lo tocaré al final.

## Copia de `baddies` en variables

Está hecha en ASM y elimina la necesidad de tener que operar con valores en un array de estructuras. He cambiado las referencias y eliminado un par de boludeces. 

TAP = 71556 bytes

## Módulo de enemigos lineales a ASM

He pasado a ensamble el módulo de enemigos lineales. El código es mínimo, pero z88dk se porta fatal casi siempre, así que mejor.

TAP = 70763 bytes

## Código que anima los enemigos a ASM

Pasado a ensamble el código que anima los enemigos (que cambia el frame). Había un montón de accesos a arrays indexadas por gpit. He almacenado gpit en DE y lo he usado en todos los accesos ahorrando muchas cargas.

TAP = 70696 bytes

## Código que comprueba colisión con el hitter a ASM

Este ha sido fásil (era muy poco)

TAP = 70683 bytes

## `Platforms_25d.h` a ASM

[on_hold] porque

## Pasar a de 10.6 a 12.4

Me he dado cuenta de que pasar a 4 bits de "parte decimal" me va a facilitar la vida muchísimo. De entrada permitiendo que `p_vx`, `p_vy`, `ptgmx` y `ptgmy` sean de 8 bits. Por otro lado haciendo que pasar a ASM muchos cachos de código sea infinitamente más sencillo por no tener que estar extendiendo signos y haciendo mierda en 16 bits.

Esto puede (va a) ser un proceso más largo que los anteriores. Hold tight...

TAP 71040 (!)

No está fino, of course, pero por ahora veo que hay tiempo libre al final del segundo frame de cada cuadro de juego!

Tengo que revisar toda la rutina de movimiento.

~~

20191106
========

Creo que dejé fina la rutina de movimiento y ahora todo va levemente más holgado (porque además quité mierda redundate), pero sigue sin llegar a los 25 faps - llega, pero solo cuando todos los personajes en pantalla están alineados a rejilla (porque tiene que actualizar menos cuadros, vaya). Aún conseguiré rascar más ciclos si paso partes de las rutinas a ASM (en especial la de movimiento del personaje), pero iré poco a poco. Creo que limpiaré un poco más, en especial para organizarlo todo de forma más "como lo hago ahora", y luego empezaré a hacer el juego en sí. Ya habrá tiempo de pulir más a medida que avanzo en el desarrollo.

20191107
========

Logré reorganizar todo el código de una forma más lógica (para mi mindset actual) y estoy pensando formas de aclerar esto.

Se me ha ocurrido hacer los buffers de pantalla levemente más grandes para conseguir simplificar (y, por tanto, acelerar) los cálculos. La idea es extenderlos para que midan 16 de ancho (160 bytes en vez de 150). Además de eso, tendría que tocar la rutina de movimiento para que haga un bypass de la colisión si el usuario va a salir de la pantalla, aunque creo que esto no sería necesario realmente en un juego como este.

Voy a ensanchar los buffers y a cambiar la colisión a ver. En vez de llamar a una función attr, esto se convertirá en esta macro:

```c
	#define ATTR(x,y) ((x)|((y)<<4))
```

Aunque lo suyo suyo sería hacerla en ensamble. No sé cómo montar una macro para esto, todo es cuestión de pronbar.

```c
	#define ATTR(x,y) #asm \
		ld a, (_(x)) \
		ld c, a \
		ld a, (_(y)) \
		sla a \
		sla a \
		sla a \
		sla a \
		or c \
		ld (_attr_r), a \
	#endasm
```

Voy a hacer pruebas a ver si es posible.

~~

Es posible, pero de otra forma un poco rara - aunque funciona. El programa quedará un poco raro, pero puedo montar una macro de tres parámetros incluyendo el destino:

```c
	#define ATTR(x,y,d) asm("ld  a, (_"#x")\nld  c,a\nld  a, (_"#y")\nsla a\nsla a\nsla a\nsla a\nor  c\nld  c, a\nld  b,0\nld hl, _map_attr\nadd hl, bc\nld  a, (hl)\nld (_"#d"), a")

```

Así, haciedo `ATTR (rdx, rdy, rda)`, por ejemplo, obtengo el resultado en rda. Además me da en la nariz que el código que saca la macro no es mucho más largo que el de una llamada a attr, voy a verlo:

```asm
	ld h, 0
	ld a, (_prx)
	ld l, a
	push hl
	ld a, (_pry)
	ld l, a
	push hl
	call _attr
	pop bc
	pop bc
	ld a, l
	ld (_pt1), a

	; 2 + 3 + 1 + 1 + 3 + 1 + 1 + 3 + 1 + 1 + 1 + 3 = 22 bytes
	; 7 + 13 + 4 + 11 + 13 + 4 + 11 + 17 + 10 + 10 + 4 + 13 = 117 más lo que tarde la rutina
```

vs

```asm
	ld  a, (_rdx)
	ld  c,a
	ld  a, (_rdy)
	sla a
	sla a
	sla a
	sla a
	or  c
	ld  c, a
	ld  b,0
	ld hl, _map_attr
	add hl, bc
	ld  a, (hl)
	ld (_rda), a

	; 3 + 1 + 3 + 4*2 + 1 + 1 + 2 + 3 + 1 + 1 + 3 = 27 bytes
	; 13 + 4 + 13 + 4*8 + 4 + 4 + 7 + 10 + 11 + 7 + 13 = 118 y listo
```

Not so bad, creo que merece la pena. Gasto 5 bytes más por llamada pero me ahorro lo que tarde la rutina - 1 t-state cada vez.

Voy a ello. Temgo que cambiar BUFFER_IDX

~~

Aparentemente ¡ACELERA UN HUEVO! pero ahora tengo la rutina que pinta las pantallas, que pasé a ASM, patas arriba. No sé qué hice anoche que creía que lo había probado pero no. Bue, también he dormido dos horas y no carburo demasiado bien. Cuestión de repasarla y encontrar el bicho.

~~

Creo que la interacción con `draw_coloured_tile_gamearea` está póchimer. Voy a cambiar esa función para que imprima un numero HEX con el valor del tile que recibe.

Efectiviwonder se corresponde, como era de esperar... ¿Pero qué mierdas escribe esto en `_t`? Si en la traza había leído "41" como primer dato... 

No. Efectivamente, lee lo que lee: 3F. ¿Por qué? Supuestamente `_map_pointer` debería estar bien calculado. O wait... ¡es un puntero, necesito una indirección! Paréntesis que te crió.

Aún no está bien pero se parece más a una pantalla. Lo que pasa es que ahora el redraw de msc, obviously, doesn't work. Voy a reparar eso que será tontería y tal y sigo luego.

~~

Reparado.

He reparado la indirección y la actualización del puntero. Nos vamos acercando, pero ahora el mapa parece que pierde un tile por fila. Vale. Esto es porque estoy usando gpit como odd/even y tiene un salto para llenar el buffer. ¿Cuál sería la mejor forma de llevar esto para adelante? Pues teniendo otro contador aparte.

CASI BINGOW. Hay tiles que no se muestran (¿fuera de rango? salen letras...) No le encuentro la lógica. Joder, qué dolor de cabeza. 

~~

OK, ¡estaba usando sra en vez de srl! Ahora la colisión no va del todo fina pero será cosa de apañar o la macro o alguna otra mierda. Vale - da la impresión de que detecta (erroneamente) conveyors. Esto es si `possee` y `(pt1 & 32)`. Veamos el cálculo de ese `pt1`... OK! Cortapega mal. Ya está funcionando.

En idle me ha pegado un buen subidón. Alineado a tile se me queda a ~ -20 rasters por encima del borde inferior. Sin alinear, a unos 20 rasters por debajo. Pero mientras se está moviendo (que hay más comprobaciones) se sigue yendo. Hay que ahorrar por más sitios. VOy a medir cuando dura el update y así miro si el que se cuela mucho soy yo o el update.

Hostiaputa, en hacer el `sp_UpdateNow` se tira casi todo un frame O_o pues sí que es lento esto. De hecho, si desalineo el sprite horizontalmente pilla más de un frame. Sólo por un sprite desalineado :-/

¿Será el momento de ver si en splib2 se puede ahorrar invalidaciones si hay alineación a grid, como hice en cpcrslib? De todos modos aún debería bajar mi uso de CPU porque en idle tambien pillo yo casi un frame. Y no sé de qué. Tiempo de medir cosas.

```
	update_hud      ~1 raster
	player_move     ~32+ rasters en el peor caso
	enems_move      ~24+ rasters con 2 enemigos lineales
	update_sprites  ~160 rasters !!!
```

Para de mirar. ¿Cómo puede tardar tanto `update_sprites`? ¡copón bendito! La mierda de todo esto es que terminará escapando a mi control porque ahí hay llamadas a `sp_movespr_abs`... Creo que splib2 está bien y tal pero hace demasiadas mierdas innecesarias. O algo. Quizá ponerme a estudiar esta biblioteca para quitar paja sea buena idea... Sería algo de lo que me podría beneficiar un montón. Pero me da tanta pereza...

Por ejemplo, las dos llamadas a esa función para Meghan y su sombra duran 48 rasters. Si la función se tira 24 rasters por sprite que tiene que mover, flipa colega.

Tengo que saber qué hace esa función exactamente. Supongo que ver qué tiene que invalidar ¿quizá rotar los sprites? También son una polla de parámetros.

20191108
========

El código de splib2 es complejísimo, pero veo que la interfaz con C es bastante pesada. Voy a ver si es posible atacar directamente a la rutina `SPMoveSprAbs` poniendo las cosas que necesito en los registros tal y como ésta espera:

```
	; enter: IX = sprite structure address 
	;        BC = animate bitdef displacement (0 for no animation) 
	;         H = new row coord in chars 
	;         L = new col coord in chars 
	;         D = new horizontal rotation (0..7) ie horizontal pixel position 
	;         E = new vertical rotation (0..7) ie vertical pixel position 
	;        IY = clipping rectangle, set it to "ClipStruct" for full screen 
```

Veo que el tiempo se reduce BASTANTE, pero no consigo que salga nada porque probablemente esté pasando mal algún parámetro. Aún me lío con los punteros a estructuras entre C y ensamble y las 10 formas de usarlos. Pero lo lograrew.

Listo, era cosa del formato del clipstruct.

He visto que ahorro una media de 5 rasters por llamada. No parece mucho, pero algo es algo. En el player y su sombra tengo 52 rasters antes y 42 rasters ahora. Voy a cambiar el resto de los sprites.

Pero antes lo dejo todo como estaba y mido el número exacto de rasters : 168 rasters. Veamos como mejora.

~~

Lo he dejado en 130 rasters. 38 rasters no parece demasiado pero la verdad es que va a ayudar a que esto entre en 25 faps. Definitivamente.

¡Quitando un poquito más de paja lo he dejado en 111 rasters!
