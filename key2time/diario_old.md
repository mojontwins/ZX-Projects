Empiezo un poco tarde pero bueno, mejor tarde que nunca. Además, me va a hacer falta porque en mi actual situación es normal que haya "gaps" en el desarrollo y retomar después de un tiempo puede ser complicado, sobre todo en juegos multi-nivel donde haya que hacer arreglos y cosas raras. Así me queda todo bien documentado.

========
20150915
========

Hoy he montado la carpeta definitiva del proyecto con una buena estructura. Los tilesets de cada nivel van a estar distribuidos entre varios binarios, todo para conseguir mejor compilación evitando almacenar los mismos tiles varias veces. Y me explico:

- Los tiles 0-15 son fijos por cada "mundo" (mundo = fase, época, llámalo X).
- Los tiles 16-31 pueden cambiar en cada pantalla si se quiere cargando un subtileset.
- Los tiles 32-47 contienen los objetos y cosas importantes como los portales y son fijos para todo el juego.

Por tanto, en los binarios que contengan los niveles (con mapa, comportamientos, enemigos, sprites...) sólo irá un tileset con los tiles 16-47 vacíos. A continuación del recurso irán N binarios con los subtilesets necesarios para cubrir los tiles 16-31. En un recurso aparte irá un binario con el subtileset de los objetos que se cargará en 32-47 al principio del juego.

Mientras hago todas estas mierdas sigo diseñando gráficos. Para crear el primer recorrido creo que necesito unas cinco fases y la T.A.R.D.I.S.. No hay que diseñar las fases completas (por lo general una media de cuatro pantallas es suficiente), pero hay que hacer muchos gráficos.

Lo siguiente que voy a hacer (ahora mismo) es modificar msc3. Hay muy poco control multi-nivel. Cada sección del script genera una constante con la dirección de inicio, pero el nombre de estas constantes es auto-generado y no hay control.

Como necesito una inicialización "global" del juego (me da miedo la cantidad de flags que voy a necesitar), necesito una sección del script que ejecute de forma custom para hacerlo, independiente de las fases.

Lo que voy a hacer es definir una directiva para msc3 que de un nombre específico a la sección actual. Este nombre será el que se use en la constante generada con la dirección. Así no habrá que tener en cuenta el orden de las secciones en el script y será todo mucho más manejable.

8<

LEVELID levelId

Incluyendo esto en una sección, la constante empleada en msc-config.h será "levelId". 

8<

Hecho, msc3 modificado (ahora mismo en la versión de /tech/1, que es la más reciente) y scripting.txt actualizado con una (escueta) explicación sobre este tema. Total, ¿quién lo lee?

========
20150916
========

Hoy no creo que tenga tiempo para mucho, estoy un poco enganchado en restaurar un viejo proyecto para MSDOS que he encontrado en un viejo backup y que está compuesto por una serie de capítulos (de un diskette de duración cada uno) de una especie de novela visual (muy poco interactiva, eso sí) escrita en QB hace un montón de tiempo. Esta noche, si tengo rato, intentaré avanzar algo más en los tilesets. Quiero tener el material mínimo para montar los binarios de los niveles y adaptar el gestor de niveles simple (Goku Mal, Nicanor) con las ampliaciones necesarias cuanto antes (me muerdo de ganas), pero es mucho trabajo y los padrastros en el deo se acumulan.

Por cierto, sigo teniendo que pixelar la escena final del final del todo del Peril Megadrive y plantearme seriamente montar un CNROM para el Perils NES.

========
20150917
========

Aunque tengo muchos gráficos que hacer, voy a crear un nuevo tech demo (el 2) para programar las cosas de la T.A.R.D.I.S. y de paso probar también que funciona el tema de los subtilesets. Por tanto, el tech demo 2 necesitará el gestor de niveles.

Me basaré en el de Goku Mal/Nicanor. Primero voy a ver qué cambios necesitaría para soportar las particularidades de este juego. Si hice las cosas bien, la adaptación será sencilla. 

Empiezo copiando la carpeta /tech/1 a /tech/2 y paso el desarrollo del engine ahí.

8<

Veamos levels128.h. En principio, en la cabecera de nivel, aún hay espacio para especificar cosas nuevas describiendo los niveles. En principio creo que no voy a necesitar nada más. El arcón y el menú de saltos de la T.A.R.D.I.S. aún no sé cómo los voy a integrar - el arcón puede lanzarse desde el script con un Excel, o puedo meterlo como enganche custom.

-------------------------------------------------------------------------------
typedef struct {
	unsigned char map_w, map_h;
	unsigned char scr_ini, ini_x, ini_y;
	unsigned char max_objs;
	unsigned char enems_life;
	unsigned char win_condition;
	unsigned char scr_fin;
	unsigned char activate_scripting;
	unsigned char music_id;
	unsigned char d05;
	unsigned char d06;
	unsigned char d07;
	unsigned char d08;
	unsigned char d09;
} LEVELHEADER;
-------------------------------------------------------------------------------

Luego tengo el espacio sobre el que se descomprimen los datos. Hay que tener en cuenta que este juego no tiene hotspots, ni cerrojos, ni llaves. El binario, por tanto, deberá constar de...

-------------------------------------------------------------------------------
Offset	Length	Contents
-------------------------------------------------------------------------------
0 		16 		header
16 		1200	map (16 pantallas de 75 bytes)
1216 	2304	tileset (256 caracteres + 256 atributos)
3520	2320	spriteset (básico, 16 frames de 144 bytes + 16 bytes header)
5840	288		extra sprites (2 frames de 144 bytes para la caída)
6128 	576		baddies (12 bytes por malo, 3 por pantalla, 16 pantallas)
6704	48 		behaviours (para 48 tiles)
-------------------------------------------------------------------------------
TOTAL 6752 bytes.
-------------------------------------------------------------------------------

Tal y como está diseñado esto, 32 de los 48 tiles del tileset (un total de 128 caracteres, con sus correspondientes 128 atributos) y sus correspondientes comportamientos estarán vacíos. Puede parecer un gasto estúpido, pero como todo esto va comprimido da igual. Las ristras de ceros comprimen que te cagas de bien.

Además, puede parecer raro que metamos todos los sprites y hasta los extra en los binarios. Bueno, en realidad es para simplificar el código que prepara el nivel, pero también nos da la posibilidad de cambiarlos en algún nivel. Recordemos que uno de los niveles es en otro planeta, y quizá podamos poner a Meghan con otro atuendo. Además, esto nos permite cambiar precipicios por arenas movedizas en la fase del desierto y tener una animación diferente.

Ahora tengo que modificar buildlevels para:

- Poder desactivar los hotspots completamente.
- Permitir cualquier número de sprites, y no 16 fijos.

Creo que a lo mejor es más "sano" que haga un buildlevel.exe nuevo, o me curre un poco más cómo pasar los parámetros con un parser, porque si no esto va a ser una pesadilla.

Voy a darle vueltas, ahora que he visto que el gestor de niveles me va a permitir hacerlo todo sin alteraciones. La estructura de niveles es tan sencilla como esto:

-------------------------------------------------------------------------------
LEVEL levels [] = {
	{3, 0, SCRIPT_INIT + SCRIPT_0},
	{4, 4, SCRIPT_INIT + SCRIPT_1},
	{5, 5, SCRIPT_INIT + SCRIPT_2}
};
-------------------------------------------------------------------------------

El primer número es el recurso del nivel (cualquier recurso, no tienen por qué ser correlativos, lo que me permite meter los subtilesets a continuación), el segundo es el número de la música, y el tercero la dirección de inicio del script. Lo tengo todo.

Voy a darle vueltas a buildlevel.exe.

8<

He excrito un módulo "cmdlineparser.bas" que lée parámetros de linea de comandos de la forma key=value y los almacena. Luego sólo hay que pedirle el value relacionado a una key y te lo devuelve. En principio lo usaré para un buildlevelmk2, pero ahí está para otras cosas chulis. Este es su ".bi":

-------------------------------------------------------------------------------
' Simple command line parser
' Use this with your own command line apps.
' Copyleft 2015 by na_th_an

' Commands are in the form key=value. No spaces. Please.

Declare Sub sclpParseAttrs ()
Declare Function sclpGetValue (key As String) As String
Declare Function sclpGIsDef (key As String) As Integer
-------------------------------------------------------------------------------

Es tosco, pero no necesito más y me hará el apaño de la leche de bien.

8<

Nuevo buildlevels.exe hecho/adaptado con parseo inteligente de parámetros. Funciona genial y todo es bonito y bello. Un ejemplo de llamada podría ser...

-------------------------------------------------------------------------------
buildlevel.exe output.bin mapfile=..\..\map\mapa.map map_w=4 map_h=4 decoration
s=..\..\script\decos.spt nohotspots fontfile=..\..\gfx\font.png tilesfile=..\..
gfx\work.png behsfile=..\..\levels\behs.txt spritesfile=..\..\gfx\sprites.png n
sprites=18 enemsfile=..\..\enems \enems.ene scr_ini=0 ini_x=4 ini_y=4 enems_lif
e=1
-------------------------------------------------------------------------------

Un tanto verbosillo, pero funciona como un tirow. Y ya son las 14:23 y en muy breve se me acaba el rollo.

El siguiente paso es hacer los gráficos que me faltan para la fase de la T.A.R.D.I.S. y montar toda la mierda. Los "enemigos" en esta fase los puedo usar para hacer efectos animados y tal, eso puede molawr, y así el juego no irá más rápido en esta fase (que es lo que pasaría si no hubiese enemigos - en realidad va a seguir pasando, ya que al estar los enemigos fijos hay menos cálculos involucrados, pero apenas se va a notar).

Voy a hacer unos bocetos de la pantalla del arcón y otra de la pantalla donde hay que montar la llave del tiempo (que tengo que pensar cómo montar esto ...)

========
20150918
========

Afú, cuando tengo que hacer "trabajo artístico" lo tengo chungo y siempre tengo que tirar de mi escasísimo tiempo libre en casa. A ver si este fin de semana... Puedo de todos modos empezar a "codificar al pedo" el arcón y tal, aunque no vaya a poder probarlo.

Al final creo que el arcón es totalmente susceptible de ser llamado mediante un extern (además, tengo el extern nuevo de dos parámetros para no quedarme sin números como pasó al final en Ninjajar!, 256 externs parecían un montón y resultó ser poco), ya que las operaciones entre inventario y arcón las puedo hacer sin ningún problema. 

Lo que me mosquea más (tengo que darle más vueltas) es el menú para saltar a una u otra época. En realidad es generar un WARP_TO_LEVEL, pero no tengo muy claro como integrar ese menú en el sistema. No sé si crear un sistema medio reutilizable de menús en msc o hacer algo totalmente custom. Hay que tener en cuenta que el script no es un lenguaje de paradigma iterativo donde pueda poner la llamada al menú y luego hacer IFs sobre el resultado. 

Así, a bote pronto, se me ocurre lo siguiente:

- Desde el script, se detecta que el usuario ha pulsado acción en las inmediaciones de la consola de la T.A.R.D.I.S..
- Se ejecuta un EXTERN n, 0, con "N" el comando de sacar el menú.
- Desde mi rutina de extern, saco el menú, que almacenará el resultado en un flag.
- Vuelvo a ejecutar el PRESS_FIRE del script. La rutina que atienda al flag debe reiniciar dicho flag al final para evitar reentradas y bucles raros.

Así puede funcionar bien, pero aún así no me conformaré con la primera solución y le daré alguna vuelta más.

8<

Sobre el tema del menú, debe ser un menú que se controle con ARRIBA, ABAJO y ACCION. La putada es que las opciones deben poder ampliarse. En total, las opciones son:

000233
001001
003322
005992
006800
010000
050000
THRUST

La opción de THRUST sólo estará disponible cuando se utilice (CIRCUITO_INTEGRADO)por lo que no debe aparecer.

La función del menú debe devolver 0xff para cancelar y un número de 0 a 7 con la opción seleccionada.

Al igual que con el arcón, el fondo del menú será una pantalla fija que incluirá el marco del juego.

- La opción 80000 no aparece en la T.A.R.D.I.S.. Sólo se puede acceder al año 80000 mediante un portal. Una de las cosas que debe decir el señor raro de esta época es que vamos a tener éxito en la misión: la T.A.R.D.I.S. ya no está ahí, lo que significa que en algún momento lograste irte de Epsolon Messei.

- Se dibujará 7 u 8 opciones dependiendo del valor de un FLAG. Tengo que empezar a hacer una lista de flags para ir dejando las cosas un poquito más atadas.

- Para poder integrar mejor un "tutorial" continuo y hacer cutscenes más molonas, debe haber externs separados para MOSTRAR el menú y para EJECUTARLO. Así podré mostrarlo y sacar texto de Meghan explicando qué es, y luego hacer uso de él.

8<

Como tengo sitio, este juego empleará los 128 flags como máximo que soporta el sistema. 

8<

He creado un archivo k2t_ext_helpers.h donde meteré todas las funciones que necesite para el extern en Key To Time... Más que nada por tenerlo todo bien aislado y poder "quitarlo" si luego me da por generar una distribución de MK2 "limpia".

Dentro de k2t_ext_helpers.h he añadido código para mostrar y "mover" el menú. Aún no lo puedo probar pero era sencillo y supongo que funcionará.

Tengo que ponerme también a pensar en las cajas de texto. Quiero hacerlas con un gráfico chulo que incluya el careto del que habla, y tengo que pensar en una forma de "restaurar" lo que la caja pise.

Había pensado emplear el tercio central para una caja de 32 caracteres de ancho (incluyendo bordes) y 8 de alto (2 de bordes, 6 de texto). Eso da para un retrato de 32x48 pixels puede ser más que suficiente. El diseño que tengo en mente es esto (seguramente cambiará):

EXTERN 0xf0, n - muestra el cuadro de texto para el personaje n. Si n = 0, es el cuadro de texto básico, que no tiene retrato. De esto se tiene que coscar la rutina que pinta texto (debe saber si está en cutscene, cuadro general, o cuadro de personaje).

EXTERN i, n, con i < 8, muestra el texto # i*256+n. Así podemos tener más de 256 lineas de texto.

8<

Ya que estamos:

EXTERN 0xf1, i - muestra el menú y almacena en resultado en la variable 'i' -- LUEGO SE SEGUIRÁ EJECUTANDO EL SCRIPT, así que es el momento para hacer los WARPS que haga falta.

EXTERN 0xf2, i - muestra el arcón, ignora 'i'.

8<

Sobre el arcón: para integrarlo con el scripting y poder controlar qué hay en él y tal, reservamos 8 flags para él (en realidad nos vale con 7, pero me guardo una en la manga.) - El arcón "está" en las flags 120-127.

8<

Los primeros, digamos, 16 flags los reservamos para "lógica del nivel", cosas inmediatas que no tengan por qué ser preservadas.

Los flags del 16 al 63 controlarán la lógica de todo el juego. Son 48. Creo que hay suficientes.

Los flags del 64 hasta el 95 controlarán contenedores.

A partir del flag 96 colocaré interacciones motor <-> script, por ejemplo:

96 -> menú option
97 -> MOVED_TILE_FLAG
98 -> MOVED_X_FLAG
99 -> MOVED_Y_FLAG

Y más que vaya necesitando.

8<

He hecho un marco para las cajas de texto. Poniéndole la división para la foto del personaje, y comprimiendo con aplib, el binario son 553 bytes. Hacer uno así para cada personaje será un poco overkill, podría írseme a más de 6 o 7Kb y paso. Lo que haré será guardar sólo este frame y la versión sin división para foto y luego las caritas de los personajes en plan 4x6 caracteres de 8 bytes en el orden más fácil de pintar, ocupando 4*6*8 = 192 bytes. Eso es bastante menos: 10 personajes por menos de 2 Kb está bastante bien.

Tengo ahora que hacer un conversor de imagenes de caretos para almacenarlas en una especie de binario que colocaré como preload de RAM6 (en RAM7 irá como preload textos + script).

Siguiendo el orden de pintado del spectrum, y teniendo en cuenta que va todo en el mismo tercio, habrá que guardar la primera fila de los cuatro primeros caracteres, la primera fila de los cuatro siguientes (siguiente linea de caracteres)... hasta la sexta linea. Luego la segunda fila de los cuatro primeros... etc.

Hacer un conversor que pille un PNG de 32x48 y genere los 192 bytes que ocupa eso en el orden correcto será cosa fácil y de un ratico que creo que tengo ahora mismo.

8<

Conversor hecho. Veré la forma de probarlo. La rutina de pintado será estupidísima. Teniendo la dirección de los 192 bytes que sean en HL...

		ld hl, portraits
		ld de, 18465
		ex de, hl 		; Beware, al revés.

		ld b, 8
ptpl1:	ld c, b
	
		push hl

		ld b, 6
ptpl2:

		; Inner loop.
		; Copy 4 bytes
		ld a, (de)
		ld (hl), a
		inc de
		inc l
		ld a, (de)
		ld (hl), a
		inc de
		inc l
		ld a, (de)
		ld (hl), a
		inc de
		inc l
		ld a, (de)
		ld (hl), a
		inc de
		
		; Next char line
		push bc
		ld bc, 29
		add hl, bc
		pop bc

		djnz ptpl2

		; Next pixel line
		pop hl
		inc h

		ld b, c
		djnz ptpl1

		ret
		
portraits:
		incbin "output.bin" 

8<

Y finito.

========
20150919
========

Los dales fran han propuesto varias mejoras a la rutina en Twitter. Lo miraré cuando tenga un rato. Ya se sabe que a mí estas cosas me suelen aburriroooouaaaaahm...

========
20150920
========

Hoy he terminado (y dado por satisfactorio) el tileset y subtileset 1 para la porción del desierto que es visible al principio del juego.

Luego he decidido hacer un leve cambio de planes: tech2 no montará aún la T.A.R.D.I.S... necesito demasiados gráficos. Voy a montar sobre cualquier nivel (5 o 6, que son los que tengo listos) el multi-nivel y voy a empezar a implementar el EXTERN, en concreto el tema de los textos y los retratos. Para ello aún tengo que dibujar, pero es menos y creo que podré hacerlo hoy después de cenar para ponerme esta semana a finiquitar el tema.

8<

========
20150921
========

Un pequeño roadmap...

Objetivo: montar el gestor de niveles en 128K con las fases 0, 5 y 6.

- Preparar el proyecto, poner todas las cosas en su sitio. [*]
- Construir lo que falta: enems0.ene, enems5.ene y enems6.ene [por ahora con stubs] [*]
- Crear y probar un buildlevels.bat [*]
- Preparar config.h [*]
- Revisar levels128.h (de nuevo, por si acaso). [*]
- Añadir soporte para NOSOUND para desactivar todas las llamadas al player que sea mientras se desarrolla. [*]
- Escribir el script básico. [*]
- Preparar make.bat [*]
- ???
- Profit! [:-(]

El tema es montarlo ya para empezar a preparar el extern.h y todo el sistema de los retratos y recuadros para los diálogos del juego, que es más de programar y tal y así puedo ir adelantando sin dar mucho el cante.

8<

Ya está todo montado. Ahora hay que hacer que funcione. Por lo pronto sin hacer nada se inicia, pone "LEVEL 1", y se queda colgate. Ya modificaré el preparador de niveles correctamente (seguramente esté descomprimiendo las cosas mal).

He pensado que la palabra "descomprimiendo" sería más chula si fuera "descompimiento".

Luego, ahora tengo que hacer otras cosas más importantes (del trabajo de verdad y tal).

8<

Llevo un ratazo a vueltas con esto. Se paraba porque calculaba mal la dirección del script. Bien, eso lo corregí - pero se seguía parando. Y resulta que es porque he hecho mal la función que carga los subtilesets. Es un poco extraña y la he hecho demasiado rápido, así que estaba corrompiendo cosas. Voy a depurar un rato y luego si eso ya.

8<

Había un pequeño error en mksubts.exe: no se estaba añadiendo lo que ocupaba el miniíndice que hay en cada binario a los offsets. Solucionado simplemente sumando 4 (lo que ocupa el miniíndice - 2 palabras de 2 bytes) a los offsets almacenados en dicho miniíndice.

Ahora se ve todo guay y parece que carga el subtileset perfectamente. Ahora lo que tengo que hacer es montar bien el tema del cambio de subtilesets. Sigo a vueltas, porque tengo dos opciones:

- Automático: hay un gestor embebido en el módulo que pinta la pantalla que calcula si tiene que cargar un nuevo subtileset mirando el actual y un array de subtilesets por cada pantalla.
- A manaza: detectar, desde el script, cuando necesito un nuevo subtileset y llamar a EXTERN para cargarlo.

Estoy indeciso. La opción automática viene guay para muchos cambios de subtileset - y ahora mismo tengo muy pocos ~ pero tenga casi todo el juego sin pintar, y a lo mejor eso cambia en el futuro.

Por ahora la primera opción va ganando.

8<

========
20150922
========

Hoy toca implementar la carga automática de subtilesets. Voy a liarme la manta a la cabeza y a implementar la opción 1 en la que todo está integrado y es automático. Necesito un array del tamaño de las pantallas. Necesito poder añadir este array al binario. Una ligera modificación a buildlevels será necesaria, además de reservar espacio en el tiesto. Lo puedo colocar donde me salga de los mendengues, of course. La entrada será mediante un archivo de texto map.sts (de SubTileSet).

8<

Hechos los cambios (por probar) en buildlevels.exe y levels128.h, ahora el binario de cada nivel quedaría tal que así.

-------------------------------------------------------------------------------
Offset	Length	Contents
-------------------------------------------------------------------------------
0 		16 		header
16 		1200	map (16 pantallas de 75 bytes)
1216	16 		atributos del mapa (16 pantallas, 1 byte)
1232 	2304	tileset (256 caracteres + 256 atributos)
3536	2320	spriteset (básico, 16 frames de 144 bytes + 16 bytes header)
5856	288		extra sprites (2 frames de 144 bytes para la caída)
6144 	576		baddies (12 bytes por malo, 3 por pantalla, 16 pantallas)
6720	48 		behaviours (para 48 tiles)
-------------------------------------------------------------------------------
TOTAL 6768 bytes.
-------------------------------------------------------------------------------

Ahora queda implementar el cambio de tileset automático en la función draw_scr. Habrá que almacenar el atributo actual y tal, e inicializarlo al principio del nivel.

8<

TODO: Cambiar el DIE_AND_RESPAWN para que guarde la coordenada X, Y de pixel en juegos de NEW_GENITAL. No tiene sentido reducir a tiles en este motor y causa problemas [menos código, menos problemas]. [HECHO]

TODO: Cambiar la detección en plataformas y para caerse de un punto a DOS. Los DOS puntos deben estar liberados y en tiles "agujero" para que el personaje caiga. Más jugable y natural. [HECHO]

8<

El cambio de tileset automático funciona como un tiro. Ahora creo que me apetece hacer las cajas de texto, aunque eso precise dibujar algunos retratos. Si veo que no puede ser, me voy a otras de las múltiples cosas que hace falta hacer. Pero antes supongo que resolveré los TODOs pendientes.

8<

========
20150924
========

Bueno - hoy toca pie. Voy a empezar a diseñar la rutina de Extern, en principio para sacar los diálogos. Aunque luego programando siempre me doy cuenta de cosas y las voy cambiando al vuelo, voy a hacer un prediseño aquí.

Yo tengo un EXTERN N, M. En teoría se hizo para tener más de 256 textos. Si no quiero fliparlo con el código, lo mejor es seleccionar los primeros "N" para textos, y programar las cosas nuevas para valores altos de N. Así, si N < N0, con N0 medianamente alto (¿Qué hostias? ¡Si con N0 = 4 ya tengo para 1024 textos!), se presentará el texto N*256+M-1 (para que coincidan las lineas con
el archivo).

Necesito una variable "offsX" que se modifique dependiendo si cargo el marco de personaje o el marco general.

Aparte de esto, necesito:

N = 0x80 - Borra la pantalla (EXTERN 0 viejo)
N = 0x81 - Selecciona modo, M = 0 Normal, M = 1 Cutscene.
N = 0x82 - Cargar marco [*].
N = 0x83 - Arcón.
N = 0x84 - Menú selección de espacio / tiempo.

[*] El tema de los marcos, que es otra de las cosas que voy a hacer hoy. Depende del valor de M:

M = 0xff - Saca el marco general (TALKG_BIN), pone offsX al valor mínimo (ver sobre el papel).
M = 0... - Saca el marco de personaje (TALKC_BIN), pinta el retrato M-ésimo del personaje, pone offsX al valor de "personaje".
 
--- Un momento (ruido de tocadiscos arrastrando la aguja) --

Para el word-wrap necesito saber a priori, en el conversor de textos, qué anchura tendrá el bloque de texto, y esto varía dependiendo si tenemos el marco general o el marco del personaje.

Creo que tengo que integrarlo todo. Veamos este rediseño:

- En texts.txt, la primera "palabra" debe ser un número en HEX (o sea, dos cifras sí o sí, quiero que esto sea fácil de parsear), separado por un espacio del texto. Esa palabra indica "quién" habla, de forma de si es FF tenemos el marco general. Ese valor se codifica, sin comprimir, como el primer byte de cada "texto" indexado en el binario.
- En mi extern, tengo una variable recordando quién habló el último.
- Al haber un EXTERN N = 0..., se lee el byte primero. Si el valor almacenado es diferente a este, se dibuja el marco correcto (general o de personaje), se carga el retrato si aplica, y se muestra el texto. Si es igual, sólo se muestra el texto (queda más chulo, no hay parpadeos). Al pulsar una tecla, el texto se elimina del marco antes de salir.
- Al empezar el juego el valor almacenado tiene un valor fuera de rango (como 0xfe) para que siempre se redibuje la primera vez.
- Necesito un EXTERN para "dar por terminada la secuencia de diálogo", que hará REDRAW completo y pondrá el valor a 0xfe. Por tanto:

N = 0... - Pone el marco correcto (si aplica), el retrato (si aplica), y dibuja el texto.
N = 0xF0 - Fin de la conversación.
N = 0xF1 - Arcón.
N = 0xF2 - Menú de selección de espacio / tiempo.
N = 0xF3 - CLS
N = 0xFF - Inicializar!

Voy a terminar de pintar el marco "general", meterlos en librarian, medir el número de caracteres y tal, hacer otro conversor/compresor de textos especial para esta mierda, y luego ya empezaré a implementar el sistema en el motor.

8<

Estoy en ello [*], pero me tengo que ir y apunto:

"fin de la conversación" puede ser redundante (y problemático de implementar), mejor llamar a  EXTERN 0xFF y luego REDRAW de forma explícita en el script. A menos que necesite cambiarlo después, porque ahora mismo EXTERN 0xF0 sólo hace una llamada a "Init". Por ahora lo dejo, no vaya a ser que necesite diferenciar "fin de la conversación" e "init". Si al final veo que no hago nada diferente, lo optimizo en un plis.

[*] He pintado los marcos, los he metido en el librarian, he hecho y probado el stuffer de textos, y he montado el esqueleto básico de mi extern_e... Ahora queda rellenarlo y poco más. Pero no me da tiempo hoy.

========
20150925
========

He dejado listo el display de textos, he implementado un montón de mejoras en el script, he integrado en el motor que se ejecute el "nivel" especial del script donde se inicializa el juego, funciona todo guay, todo es bello, la vida es rosa... 

Ahora estoy integrando el soporte para retratos. Ahora lo que creo que necesito (y lo he venido necesitando desde hace algún tiempo) es alguna especie de "preprocesador find and replace tontuelo", y creo que es lo que voy a hacer ahora.

Es tan sencillo como que en los archivos yo tengo cadenas %%%literal%%%, en mi preprocesador yo hago literal="cadena", y el programa cambia ese %%%literal%%% por "cadena" (sin las comillas).

El problema es que tengo que ver cómo se comporta "command" con los espacios en FreeBASIC. Voy a hacer unas pruebas y dependiendo de los resultados tendré que montar una marimorener o no (porque soy tonto y quiero espacios en las cadenas) (a lo mejor me agobio y paso de los espacios) (pero voy a ver).

8<

¡¡Bien!! El "command" de FreeBasic es una maravilla y se lo come todo. Si pongo:

$ miprueba.exe paso="usted por casa"

Lo que aparece en "command (1)" es "paso=usted por casa" (sin las comillas), lo que me viene divinamente para usar mi procesador de linea de comandos... Pues nada, "find and replace" mojónido al canto. Le voy a llamar de una forma chula: imanol. Que rima con preprocesadol.

Además de para hacer sustituciones textuales tendrá un modo en el que el texto que se sustituirá será la longitud de un archivo. Qué trampucheiro soy. En plan pattern=?path

8<

Hecho y funcionando. ¿Cómo lo monto? Por lo pronto lo necesito en k2t_ext_helpers.h para introducir el tamaño del binario de los textos, ya que voy a meter justo detrás los retratos. Por ello, k2t_ext_helpers.h pasará a ser _k2t_ext_helpers.h y se generará k2t_ext_helpers.h al compilar preprocesando el original. Juas juas.

Ahora tengo que hacer los retratos, claro. Y luego la integración será cosa de cinco minutos.

8<

Bueno, con un par de retratos me vale. Enganche desde el script. Ampliación del script porque soy vago (estaba HARTO de calcular los valores a pixel de los FIRE_ZONE y de los PLAYER_IN_X/Y. A tomar viento, que los calcule el puto ordenador de mierda). Dalefranada del preprocesador solo porque no quiero tener que estar acordándome de cambiar a mano un valor en un archivo perdido (pero seguro que me salen más novias en el futuro, ¡esta mierda la voy a encasquetar en el msc-config.h sí o sí!). Ampliación de la rutina mierder que pinta el retrato (previa optimización gracias al dalefran bait en twitter, yo me entiendo) para que lo pinte de blancow, un par de halts para cuando haya música que no pegue un EEEEEIN (macarena)... Y funciona como un pepe. Genial. Otra cosa menos.

Ahora a cosas que me apetecen menos. El arcón y el menú. Pero es que para eso hay que terminar la T.A.R.D.I.S. y me quedan una polla de gráficos.

========
20150928
========

Supuestamente hoy, si me da(n) tiempo, me tengo que encargar de programar el arcón. Me mosqueaba tener que quitar todo el tercio central para mostrar un gráfico relativamente pequeño (el arcón tiene 7 huecos, ocuparía 5 caracteres de alto por 7*2+8=22 caracteres de ancho en un espacio de 32x8 caracteres), y se me ha ocurrido algo muy chulo y que creo que tampoco me quitará demasiado espacio: presentar nombre del objeto y una breve descripción. Como hay unos trece o catorce, el invento ocupará menos de 1Kb en memoria extra más lo que ocupe el código para mostrar el tema en memoria baja (que intentaré que sea poco).

Tal y como he cuadrado el layout, la descripción podrá ocupar a lo más 2 lineas de 26 caracteres, o 52 bytes. Para simplificar el código, dejaré esta longitud como fija. Para redondear, completamos a la siguiente potencia de 2, que es 64. De este modo nos quedan 64 - 52 = 12 caracteres para el nombre del objeto, que creo que es más que suficiente.

Así que lo que toca es crear una pequeña utilidad (otra) para crear este binario que colocaré junto con los textos y los retratos en RAM6 (para lo que tendré que volver a usar el preprocesador).

Antes que nada tengo que modificar el preprocesador Imanol para admitir expresiones matemáticas sencillas. Muy sencillas. Sumas, vaya. Voy a pensar un rato. Ahora mismo puedes especificar algo como ?file.bin+49152 que significa "la longitud de file.bin más 49152". Lo que tengo que hacer es extender eso para que admita N parámetros en plan ?parm1+parm2+parm3+..., donde parm1 sea un nombre de archivo o un número. Eso es relativamente fácil y no necesito más.

8<

Imanol actualizado correctamente y funcionando. ItemStuffer.exe, la utilidad para compilar el binario con los items, idem. Escribo items.txt con la descripción de los items (vendrá bien para cuando encuentre rato para pintar el subtileset de los items, que debe coincidir en orden).

8< 8- 8< 8-

Ahora ando un poco stuck porque este es mi TODO:

- Dibujar el marco de 1 tercio para el arcón con sitio para los 7 objetos, el cursor, y el texto con nombre/descripción del objeto. [X]
- Dibujar el subtileset de los objetos. [X]
- Dibujar el subtileset 2 de la fase de la T.A.R.D.I.S. con el gráfico del arcón y demás decoraciones de esa habitación. [X]
- Programar el arcón. [X]

Todos esos items de "dibujar" son una mierda. Puedo ponerme a programar a ciegas, pero no me gusta. Me gusta ir viendo. Pero bueno, ahora veré. Si no puedo dibujar, habrá que.

Además, o les modifico el dibujo de Cheril con el bikini para la recompensa del Verkami a estos o me matan ya.

8<

Cosas, que no se olviden:

- El cursor del arcón se maneja con IZQUIERDA y DERECHA.
- El cursor del inventario deber seguir activo y cambiarse con la tecla de siempre (Z).
- Pulsar FIRE intercambia el objeto que haya en la casilla seleccionada del arcón con el de la casilla seleccionada del inventario.

========
20150929
========

Ayer dejé el subtileset 2 de la fase de la T.A.R.D.I.S. a la mitad (bueno, me dio rato a montar, pintar el arcón y un ordenador medio reaprovechao, y poco más). Hoy a ver cómo me las ingenio para terminar todo el trabajo gráfico (al menos queda poco). Tengo que decorar un poco la habitación. Voy a estudiar la posibilidad de dibujar el arcón abierto para una pequeña animación: estas cosas siempre quedan bien.

También tengo que ver qué efecto chulo hago para el cambio de época: algún cambio debe "notarse", además de cambiar el año en el rótulo que hay en la parte superior del marco del juego.

Dicho esto, tengo que hacer la pequeña función que cambie ese rótulo y se llame desde EXTERN.

Y, hablando de todo un poco: el año actual irá en una flag que se cambiará al usar el menú. En la pantalla 0 de la fase de la T.A.R.D.I.S., se detectará con un "fire zone" el contacto con el tile que hay en la parte superior de la pantalla cruzando la puerta para hacer un WARP_TO_LEVEL al level que sea.

Puedo automatizarlo todo (creo) de forma bastante chula si la fase de destino se almacena en la flag $EPOCA y hago un WARP_TO_LEVEL #$EPOCA, 2, 2. Si necesito reposicionar a Meghan en el nivel siempre puedo hacerlo en el ENTERING GAME del nivel que sea.

Me encanta que el sistema de scripting tenga tantas capacidades en las que no había pensado cuando lo diseñé. 

8<

Arcón abierto medio pintado pero tengo que parar. Argh.

8<

IDEA 1 (porque puede ser necesaria): object-tile mapping. Ahora mismo un objeto ES su tile. A lo mejor necesito una forma para reaprovechar tiles en objetos. Ahora mismo si haces

$F = O

El contenedor "F" tiene el objeto O, y este objeto se pinta con el tile O. Necesito un array que diga qué tile se usa para el objeto O, simplemente. El problema de eso es que complicaría bastante algunas partes del código y generaría preciosas ramificaciones que desembocarían en más partes "todavía no estables", y alejarían la versión 1.0 de MK2 aún más.

Por eso creo que no lo voy a tocar a menos que lo necesite. Pero estoy viendo que lo necesitaré. 16 objetos para una aventura se antojan pocos.

IDEA 2 (porque puede salvar el culo): si es posible por temas de espacio, extender más la aventura con una "segunda parte". Puedo cambiar los objetos, incluso al personaje. Con el tema de los subtilesets incluso podría reaprovechar los mapas empleando otros scripts.

8<

Montado, con glitches. Remember: cambia los sprites inmóviles por un tipo sin shift, por ejemplo el tipo plataformas.

Me he dado cuenta que el tema del mapa cíclico no funciona. No me extraña, lo hice demasiado rápido. Se me ocurre montar una fase temporal para el desierto para probarlo bien, con marcadores e identificadores de sitios. Luego la reuso casi entera como base para el desierto definitivo y listos.

8<

Ahora no tengo ganas de arreglar lo del mapa cíclico, ya le daré fran. Ahora voy con el arcón. Por lo pronto voy a empezar a meter el script de esta fase y tal. 

========
20151001
========

Empezamos Octubre liados con el arcón. Cuando termine de hacerlo tengo que hacer dos cosas:

- Dar un repaso a los bugs conocidos y TODOs.
- Amplicar msc3 (otra vez) para poner defines sencillos. Soy un vago, tener que poner EXTERN_E 240, 0 cada vez es un coñazo, además hace que el script sea aún menos legible.

El tema de los defines, lo pongo en el DEF ALIAS MISMO:

%LITERAL SUBSTITUTE

Se cambia literal por todo lo que salga después del "=". Luego hago un preprocesado metiendo las palabras que hagan falta en la cadena.

Qué coño, lo voy a hacer ahora. Me apetece.

8< 

Hecho y documentado. Sigo.

8<

Ya tengo hecho todo el arcón, pero no consigo que nombre/descripción quede bonito porque organice como organice el texto queda feo. Creo que lo voy a rediseñar para poder usar 28 caracteres por linea de descripción, aunque ocupe levemente más y pierda la alineación a 64.

Para ocupar toda la fila (con 1 caracter de margen) necesito que cada linea de texto de la descripción tena 28 caracteres, en total 56 bytes. 64 bytes solo dejarían 8 caracteres para el nombre, que es demasiado poco. El siguiente valor amable es 80 bytes (64+16), lo que nos deja 24 caracteres, más que de sobra. Lo voy a hacer así. Toca cambiar el stuffer y el código levemente.

La verdad, queda muchísimo mejor. Creo que esto ya está listo. Lo siguiente es hacer el menú de la TARDIS (que ya tengo programado pero que, obviamente, no funcionará cuando lo integre: lo hice "a ciegas"). Pero antes creo que voy a dar un repaso y a limpiar la mierda que me he ido dejando atrás (lo hago normalmente sin decir nada, pero hay ya un par de temas gordos en cola que no he tocado, como el bug en el mapa cíclico).

Recopilando TODOs... Acabo de revisar y sólo hay que arreglar lo del mapa cíclico. Voy a darle Fran.

8<

Mff.. Parece que el mapa cíclico sí que funciona. Seguramente en la fase T.A.R.D.I.S., que casca al salirte por arriba, será por otra cosa. Seguramente tenga que ver con que la pantalla destino está vacía y sabe dios que intentará hacer. O no sé, será algo horrible que dará la cara el día antes de sacar el juego, como siempre pasa :-P

[LATER] Parece que el cuelgue se da cuando se salta a una pantalla cuyo "subtileset" definido no existe. Lo cual es lógico. Vaya, que no pasa nada grave.

En fin, hecho esto, me pongo con el menú para elegir fase, que incluye:

[X] Hacer el menú y engancharlo.
[X] Cambiar la variable de la época destino.
[X] Hacer el WARP_TO_LEVEL de la puerta de la T.A.R.D.I.S.
[X] Hacer "volver a la T.A.R.D.I.S." en todos los niveles (que hay por ahora)
[X] Pintar la época en el marco.

========
20151002
========

Además de terminar el menú me he puesto a hacer el marco del mismo. Bastante más elaborado de lo que yo tenía pensado, me va a dar trabajo. Entretanto hemos cambiado la fuente por otra más legible en lineas de texto pegadas (que aún no considero definitiva, habrá que ver) y he pensado que es muy probable que tenga que retocar todos los contenedores de objetos por el tema de detecciones. Le daré una vuelta durante el fin de semana y tal.

Al final terminé el marco y cual.

========
20151003
========

Tengo que darle una vuelta a los FO_CONTAINERS. Toda la lógica y detecciones está hecha con juegos de plataformas en mente, y eso no me vale. Para que quede "bien" de verdad, los objetos deberían ser no transpasables (si no quedaría raro y se cargaría toda la perspectiva). Entonces se me complica la detección. No sé si haciendo un sencillo cuadro alrededor del objeto y comprobando que el cuadro del sprite del personaje se solapa tendré bastante. O sea, que cualquier pixel del cuadro del muñeco esté dentro de esto:

c_y - 1 ->     --------------------------------------------------
c_y                           +------+
                              |      |
                              |      |
                              |      |
c_y + 15 ->                   +------+
                             c_x     c_x+15

Cuando nos acercamos al FO, en realidad siempre hay partes de nuestro sprite tocando desde c_y-1 hasta c_y+15 y desde c_x a c_x+15. En principio parece que así debería funcionar todo esto. Voy a revisar el módulo de los FO y ver si puedo hacer esta adaptación para NEW_GENITAL de forma rápida, y pruebo a ver colocando un contenedor en cualquiera de las pantallas que ya hay (por ejemplo, puedo aprovechar para colocar el del imán en la fase 0 [233]).

8<

Creo que el código va a ser un lío de parchear... Mejor me hago un F.O. "new genital". Así puedo plantearme hacer un lanzamiento de cajas en cuatro direcciones, por ejemplo, o incluso carrear cajas en genital. La colisión es diferente y el handling también. No es necesaria la gravedad, la detección siempre es diferente.

Que sí, que hay me he convencido. Renombro floating.h a fo_sideview.h y empiezo un nuevo fo_genital.h ...

8<

Ya tengo listos los F.O., pero sólo los de tipo contenedor, que son los que uso. Paso de hacer más, no tengo nada con qué probarlo - aunque he pensado que por poco penalty podría implementar ya las cajas que se pueden llevar y lanzar (en las cuatro direcciones) que podrían molar mucho para alguna fase. Lo dejo "ahí".

Bueeeno bueno bueno... Pues parece que va siendo hora de empezar el juego :) Al menos el primer recorrido, el que sirve para activar los portales. Para ello NECESITO las siguientes fases (parte de ellas):

- [X] Level 0 [233] (Ancestral)
- [/] Level 2 [3,322] (Ciudad oscura)
- [/] Level 3 [5,992] (Guerra)
- [/] Level 5 [10000] (Desierto) - [ ] Hacer y colocar el gráfico del portal.
- [/] Level 6 [50000] (Ni en PC)
- [ ] Level 7 [80000] (Viejo loco - el Capitán, pie de plástico).
- [X] Level 9 [TARDIS]

Me voy a poner con Level 2. He hecho un diseño muy chulo en papel, pero para que funcione necesito tener tiles que sólo colisionen por arriba. Se me ocurre una idea: Añadir a la condición que controla la colisión superior "que el tile debajo del actual no sea tipo 6". Probaremos.

========
20151004
========

He hecho un tileset y he diseñado parcialmente algunas de las pantallas de la fase 2 para ver si "funciona" la idea que tuve ayer sobre este "tipo 6". Espero que no sea demasiado "hack". 

El tipo 6 afecta verticalmente:

- Si vamos hacia abajo, un tile con tipo 6 no será transpasable.
- Si vamos hacia arriba, y nuestros "pies" están en un tipo 6, el tile siguiente no será transparente <- rephrase this. Esto puede ser complicado si no doy con una forma sencilla de comprobarlo. Le daré una BUENA pensada. 

8<

Nop, no funcionaría o habría que armar la de dios es cristo para que lo hiciera. Se me ocurre que puedo hacer que los 8 pixeles superiores sean los sólidos para el eje vertical, y arreglar los escenarios para que nunca se pueda entrar en un tile 6 de forma lateral. Eso funcionaría, en principio, a menos que en el juego se pueda ir a más de 8 pixeles por frame (64*8=512 de velocidad máxima). Este nunca llega a esas velocidades (a menos que se junten varias cosas como correr, acelerar en una cinta transportadora, y saltar - pero intentaré que no sea el caso a la hora de diseñar los niveles donde emplée esto) así que, en principio, guay.

De todos modos auguro problemas multiplicantes y autorreplicantes ad infinitum, por eso lo voy a dejar macerar aún más antes de ponerme a programarlo. Quiero ensuciar lo menos posible.

PSeudo idea: 
	- Si vy > 0, tipo 4 (lo puedo poner en tipo 4 mejor, joer) == tipo 8. Esto, en principio, es como la vista genital. O casi. 
	- Si vy < 0, si las esquinas superiores del cuadro de colisión están en tipo 4 y (gpy & 15) < 8 -> ajustar gpy = ((gpy >> 4) << 4) + 8 y vy = 0.

A ver qué tal se da. Más tarde.

========
20151203
========

[Esto lleva exactamente dos meses abandonado, pero volveré pronto]
[Pero cuando retome voy a hacer lo del tipo 4 y a montar la fase 2]

========
20160127
========

[Sigue abandonado pero en mis pensamientos, ahora estoy con Ramirow]
