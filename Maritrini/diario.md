Maritrini rehash
================

Memory map

7E7E	ISR JUMP
8000	DT_TILESET
8900 	DT_MAPDATA
9300 	DT_BUFFER
9800 	ISR VECTOR
9999 	EXE

Para poder cambiarle cosas fácilmente primero metí el juego en el toolchain, al menos parcialmente por el momento (integrando Librarian). Luego voy a hacer el pack de mejoras sencillas que hará que se mueva (aún) mejor y que ocupe (aún) menos, a ver si se lo colamos a Phoenixware.

El binario original leyendo de librarian (que ha permitido, entre otras cosas, reorganizar automáticamente los binarios y meterlo todo en 3 páginas de RAM - originalmente había cosas que no me cabían) ocupaba 29228 bytes.

Ayer le di una pasada al `main` quitando locales y precalculando algunas cosas (las teclas, por ejemplo) y modificando la creción del vector de IM2 para que se crease usando ensamble, y bajamos a 28790 byes (438 bytes menos).

## Eliminando locales

El siguiente paso es eliminar todas las locales que pueda de `engine.h`.

Resultado 28055 (735 bytes menos, 1173 bytes en total).

## Deshaciendo struct arrays

Cuidadosamente deshacer todos los structs.

Resultado 25928 (2127 menos, 3300 bytes en total).

# Avanzando

Me gustaría darle más variedad al juego. Lamentablemente, los sets están petados. Tengo que penar como ahorrar tiles, y sobre todo qué cosas quitar de algunas fases si, por ejemplo, quiero meter puzzles de suelo en una sola dirección y cosas así.

- Puzzlas de suelo que avanza sólo en una sola dirección.
- Bombas y paredes que se rompen con bombas: las bombas se cogen y se recargan infinitamente, y las podemos lazar o quiza poner y esperar a que revienten. Matan enemigos y spawners también.
- ?

## Ensamble

Lo primero será ganar más espacio y más ciclos. Para ello, vamos a pasar a ensamble algunas funciones. Primero las sencillas que se llaman mucho, y luego otras más críticas. Igualmente, le daré un repaso a la biblioteca dostercios, porque quizá si alineo los gráficos a página y cambio la forma de indexarlos ganaría velocidad y reduciría tearing al volvar el buffer.

Estas son las originales de las funciones que voy cambiando:

### `init_shoots`

```c
	void init_shoots () {
		for (gpit = 0; gpit < MAX_SHOOTS; gpit ++)
			shoots_active [gpit] = 0;	
	}
```

### `is_walkable`

```c
	unsigned char is_walkable (unsigned char ntile) {
		// All its 4 chars must be < 64 in attr.
		idx = ntile << 2;
		return (dt_charcols [idx] < 64 && dt_charcols [idx + 1] < 64 && dt_charcols [idx + 2] < 64 && dt_charcols [idx + 3] < 64);
	}
```

El primer paso es eliminar el parámetro y cambiar por una global. Luego ya si eso, a ensamble.

Oh, wait - si esta función sólo se llama una vez! La meto inline y luego si eso ya.

### `init_enemies`

```c
	void init_enemies () {
		for (gpit = 0; gpit < MAX_ENEMIES; ++ gpit)
			enemies_type [gpit] = 0;	
	}
```

### `find_shoot` y `find_enemy`

```c
	unsigned char find_shoot () {
		for (idx = 0; idx < n_shoots; ++ idx) 
			if (shoots_active [idx] == 0)
				return idx;
		return 255;
	}

	unsigned char find_enemy () {
		for (idx = 0; idx < MAX_ENEMIES; ++ idx) 
			if (enemies_type [idx] == 0)
				return idx;
		return 255;	
	}
```

### `dt_putchar`

```c
	void dt_putchar (unsigned char x, unsigned char y, unsigned char n, unsigned char c) {
		unsigned int idx = x + x + (y << 6);
		dt_buffer [idx] = n;
		dt_buffer [1 + idx] = c;
	}
```

Primero quito los parámetros (cambio por globales _x, _y, _n, _c) y luego paso a ensamble.

### `draw_shoot`

Esta también recibe un parámetro pero siempre es `bi`. Lo tengo en cuenta e intento bypassear la llamada a `dt_putchar`.

```c
	void draw_shoot (unsigned char i) {
		dt_putchar (1 + shoots_x [i] - cam_x, 1 + shoots_y [i] - cam_y, 112 + (rand () & 1), 70 + (rand () & 1));	
		dt_putchar (1 + shoots_x [i] - cam_x + shoots_trail_dx [i], 1 + shoots_y [i] - cam_y + shoots_trail_dy [i], 112 + (rand () & 1), 70 + (rand () & 1));	
	}
```

# Cambiando el formato de los sets.

Veamos, el tema sería reorganizar los gráficos para que fuera mucho más fácil encontrarlos´:

* Alineado a página.
* En BASE (que es 0xXX00), irá el primer byte de cada caracter.
* En MSB(BASE)+N:M va el N-ésimo byte (de 9) del tile M. 
* Por tanto necesitaré reservar 9 páginas, o, lo que es lo mismo, 9*256 = 2304 bytes.

Mi memory map actual contiene el espacio para descomprimir los gráficos en el propio binario. Sacándolo de aquí el binario ocuparía alrededor de 22K, o sea, desde 0x8000 a 0xD800 más o menos. Como los comprimidos están en la RAM paginada, tendría que dejar espacio en 0x8000 y subir 2304 bytes la dirección de inicio de compilación.

Lo primero que necesito es un nuevo importador que me ordene los tiestos como quiero. Para simplificar haré una suerte del viejo `tileset_import` que necesita los tilesets ya ordenados.

Y hecho, la mejora es bestial. Sobre todo tras desenrollar los bucles un poco.

# La colisión

Ahora mismo el scroll va un poco desacompasado porque se emplea lo que hay en el buffer de pantalla para la colisión, lo cual es un poco tonteras. Además, si quiero meter tiles destructibles y otras cosas tendré que empezar a meter arrays de comportamientos y usar una colisión basada en mapa.

Por tanto primero tendré que añadir recursos con los comportamientos de cada tileset que se descompriman en un array de 16 espacios y una función para obtener el comportamiento de una casilla.

El primer paso si quiero ampliar el juego será pues cambiar la colisión.

~

Ahora me acabo de dar cuenta de que lo de detectar la colisión en el buffer (y por atributo de color) es para que automáticamente no se monte encima de los enemigos :-/

Tengo que darle una vuelta a esto (obviamente lo que he añadido me valdrá para los tiles especiales, pero me gustaría dejar toda la colisión así).

~

¿Cómo colisionan los disparos?

- Cuando se mueven los disparos lo hacen sobre el mapa vacío (aún no se imprimieron los enemigos)
- Colisionan por atributo dentro del buffer visible.

¿Cómo de costoso es "pinchar" para ver el `beh` correspondiente del tile colisionaldo?

Vediamo... Parece que `shoots_x` y `shoots_y` están en coordenadas de mundo, porque para colisionar en el buffer se les están restando las coordenadas de la cámara. De hecho, para detectar un `spawner`, el cálculo ya está hecho. Sólo tengo que añadir código para manejar los bloques destructibles.

Para que aparezcan las explosiones puedo hacer un nuevo tipo de ente que se dedique a mostrar la explosión y luego desaparecer. Lo que tendría que hacer sería modificar el mapa y crear la explosión.

¡Funcionando!

# Explosiones más gordas

Quiero crear explosiones siguiendo este patrón:

·····
·····
··x··
·····
·····

·····
··x··
·x·x·
··x··
·····

··x··
·x·x·
x···x
·x·x·
··x··

El tema es lanzar el foco, que lleve un contador (de un par de frames) y que al llegar a 0 lance cuatro focos, y así dos veces. Para que pase dos veces puedo crear el foco inicial con una propagación de "2" y que cada vez que se propague reste 1, y que si vale 0 no se propague.

También tendré que hacer que no se pueda crear dos explosiones en el mismo sitio.

# Dirección de maritrini más mejor

Lo ideal es que si estás parado mires en la direccion en la que empiezas a andar, y luego la mantengas en las diagonales, y que si dejas de pulsar la dirección en el eje principal entonces cambie mires en la nueva dirección, pero cómo hacerlo me está costando.

tengo `controller_LR` y `controller_UD` que toman valores o cero según pulses en cada eje.

Si hago que cambie el "facing" al pulsar en un eje solo si el otro vale 0 ¿valdría? creo que es demasiado simplificar. Probemos.

Done!

# Poner bomba más mejor

Tengo que hacer que la bomba que coges desaparezca y no vuelva a aparecer hasta que explote la otra. Por tanto tengo que almacenar su posición original en el mapa.

# 20210709

Mucho tiempo después, estoy incluyendo doble buffering. He movido de sitio muchisimas cosas y lo tengo funcionando. El tema es que ahora tendré que (obviamente):

1.- Asegurarme de ponerlo todo "normal" al salir al bucle de juego, es decir, pantalla activa la 0.
2.- Ver qué cosas se actualizan durante el juego fuera del area de idem porque habrá que copiarlas a ambos buffers.

Sobre 2, tengo que resolver cómo hacerlo de forma elegante y sin liarla parda, porque el juego de flags y cosas que tengo montado se rompe con mirarlo.

Parece que lo único que debería pintar en el marcador DURANTE el juego es `draw_5_digits`, pero antes se establecen cosas sobre el marco de juego: world / level (`draw_1_digit`).

Todas llevan a `draw_big_digit`, quizá sea esta la que tenga que tocar. 

Todo correcto!

# Cambio de formato del buffer

Ahora mismo el buffer está intercalando gráfico/atributo, y quizá será todo más fácil si no los intercalara.

Pero primero voy a quitar las multiplicaciones por 64 con `add hl, hl` por mi método más mejor (y menos peor) de:

	ld  l, 0
	ld  h, a
	srl h
	rr  l
	srl h
	rr  l

# 20210722

Estoy llevando fatal este diario.

Ahora quiero que los enemigos de tipo 4 no gasten gráficos para poder usar 7 tiles extra para cosas (palancas / compuertas, etc).  Para ello tendré que parchear el código que pinta los enemigos, creo. Voy a ver.

Hecho!

Ahora voy a ahorrar un poco de bytes. 20656 del binario principal.

- Paso a ensamble la creación de spawners  -> 20548