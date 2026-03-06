; SPECTRUM PSG proPLAYER - WYZ 2010

; ENSAMBLAR CON AsMSX

; CARACTERISTICAS
; 6 OCTAVAS:            O[2-6]=60 NOTAS
; 4 LONGITUDES DE NOTA: L[0-3]+PUNTILLO 
; PUNTILLO
; COMANDOS:     T:TEMPO
;               I:INSTRUMENTO
;               S:REPRODUCTOR DE EFECTOS CANAL C


; LOS DATOS QUE HAY QUE VARIAR :

; * Nº DE CANCION. 
; * TABLA DE CANCIONES



; POR INCLUIR
; - ELEGIR CANAL DE EFECTOS

ORG	$C000
		

PLAYER:         NOP


		CALL	PLAYER_OFF

; MUSICA DATOS INICIALES

		LD	DE,$0010		;  Nº BYTES RESERVADOS POR CANAL
        LD      HL,BUFFER_DEC       	;* RESERVAR MEMORIA PARA BUFFER DE SONIDO!!!!!
        LD      [CANAL_A],HL
        
        ADD     HL,DE       	
        LD      [CANAL_B],HL       	

        ADD     HL,DE       	
        LD      [CANAL_C],HL 

        ADD     HL,DE       	
        LD      [CANAL_P],HL 

        LD      A,0             	;* CANCION Nº 0
        CALL    CARGA_CANCION

;PANTALLA

		RET

		
	
LOOP:		HALT
		CALL	INICIO
		JR	LOOP

                


;___________________________________________________________

                DB      "PSG PROPLAYER BY WYZ'10"

;___________________________________________________________

	
;___________________________________________________________

INICIO:		CALL    ROUT
			LD	HL,PSG_REG
			LD	DE,PSG_REG_SEC
			LD	BC,14
			LDIR				
            CALL    REPRODUCE_SONIDO         
            CALL	REPRODUCE_EFECTO
            CALL    PLAY	
  			RET


;INICIA EL SONIDO Nº [A]

INICIA_SONIDO:  LD      HL,TABLA_SONIDOS
                CALL    EXT_WORD
                LD      [PUNTERO_SONIDO],HL
                LD      HL,INTERR
                SET     2,[HL]
                RET
;PLAYER OFF

PLAYER_OFF:	XOR	A			;***** IMPORTANTE SI NO HAY MUSICA ****
		LD	[INTERR],A

		LD	HL,PSG_REG
		LD	DE,PSG_REG+1
		LD	BC,14
		LD	[HL],A
		LDIR

		LD	HL,PSG_REG_SEC
		LD	DE,PSG_REG_SEC+1
		LD	BC,14
		LD	[HL],A
		LDIR

	
		LD      A,10111000B		; **** POR SI ACASO ****
		LD      [PSG_REG+7],A
		CALL	ROUT
		RET


;CARGA UNA CANCION
;IN:[A]=Nº DE CANCION

CARGA_CANCION:  LD      HL,INTERR       ;CARGA CANCION
		
                SET     1,[HL]          ;REPRODUCE CANCION
                LD      HL,SONG
                LD      [HL],A          ;Nº A

                

;DECODIFICAR
;IN-> INTERR 0 ON
;     SONG

;CARGA CANCION SI/NO

DECODE_SONG:    LD      A,[SONG]

;LEE CABECERA DE LA CANCION
;BYTE 0=TEMPO

                LD      HL,TABLA_SONG
                CALL    EXT_WORD
                LD      A,[HL]
                LD      [TEMPO],A
				XOR	A
				LD	[TTEMPO],A
                
;HEADER BYTE 1
;[-|-|-|-|-|-|-|LOOP]

                INC	HL		;LOOP 1=ON/0=OFF?
                LD	A,[HL]
                BIT	0,A
                JR	Z,NPTJP0
                PUSH	HL
                LD	HL,INTERR
                SET	4,[HL]
                POP	HL
             
                
NPTJP0:         INC	HL		;2 BYTES RESERVADOS
                INC	HL
                INC	HL

;BUSCA Y GUARDA INICIO DE LOS CANALES EN EL MODULO MUS

		
		LD	[PUNTERO_P_DECA],HL
		LD	E,$3F			;CODIGO INTRUMENTO 0
		LD	B,$FF			;EL MODULO DEBE TENER UNA LONGITUD MENOR DE $FF00 ... o_O!
BGICMODBC1:	XOR	A			;BUSCA EL BYTE 0
		CPIR
		DEC	HL
		DEC	HL
		LD	A,E			;ES EL INSTRUMENTO 0??
		CP	[HL]
		INC	HL
		INC	HL
		JR	Z,BGICMODBC1

		LD	[PUNTERO_P_DECB],HL

BGICMODBC2:	XOR	A			;BUSCA EL BYTE 0
		CPIR
		DEC	HL
		DEC	HL
		LD	A,E
		CP	[HL]			;ES EL INSTRUMENTO 0??
		INC	HL
		INC	HL
		JR	Z,BGICMODBC2

		LD	[PUNTERO_P_DECC],HL
		
BGICMODBC3:	XOR	A			;BUSCA EL BYTE 0
		CPIR
		DEC	HL
		DEC	HL
		LD	A,E
		CP	[HL]			;ES EL INSTRUMENTO 0??
		INC	HL
		INC	HL
		JR	Z,BGICMODBC3
		LD	[PUNTERO_P_DECP],HL
		
                
;LEE DATOS DE LAS NOTAS
;[|][|||||] LONGITUD\NOTA

INIT_DECODER:   LD      DE,[CANAL_A]
                LD      [PUNTERO_A],DE
                LD	HL,[PUNTERO_P_DECA]
                CALL    DECODE_CANAL    ;CANAL A
                LD	[PUNTERO_DECA],HL
                
                LD      DE,[CANAL_B]
                LD      [PUNTERO_B],DE
                LD	HL,[PUNTERO_P_DECB]
                CALL    DECODE_CANAL    ;CANAL B
                LD	[PUNTERO_DECB],HL
                
                LD      DE,[CANAL_C]
                LD      [PUNTERO_C],DE
                LD	HL,[PUNTERO_P_DECC]
                CALL    DECODE_CANAL    ;CANAL C
                LD	[PUNTERO_DECC],HL
                
                LD      DE,[CANAL_P]
                LD      [PUNTERO_P],DE
                LD	HL,[PUNTERO_P_DECP]
                CALL    DECODE_CANAL    ;CANAL P
                LD	[PUNTERO_DECP],HL
               
                RET


;DECODIFICA NOTAS DE UN CANAL
;IN [DE]=DIRECCION DESTINO
;NOTA=0 FIN CANAL
;NOTA=1 SILENCIO
;NOTA=2 PUNTILLO
;NOTA=3 COMANDO I

DECODE_CANAL:   LD      A,[HL]
                AND     A               ;FIN DEL CANAL?
                JR      Z,FIN_DEC_CANAL
                CALL    GETLEN

                CP      00000001B       ;ES SILENCIO?
                JR      NZ,NO_SILENCIO
                SET     6,A
                JR      NO_MODIFICA
                
NO_SILENCIO:    CP      00111110B       ;ES PUNTILLO?
                JR      NZ,NO_PUNTILLO
                OR      A
                RRC     B
                XOR     A
                JR      NO_MODIFICA

NO_PUNTILLO:    CP      00111111B       ;ES COMANDO?
                JR      NZ,NO_MODIFICA
                BIT     0,B             ;COMADO=INSTRUMENTO?
                JR      Z,NO_INSTRUMENTO   
                LD      A,11000001B     ;CODIGO DE INSTRUMENTO      
                LD      [DE],A
                INC     HL
                INC     DE
                LD      A,[HL]          ;Nº DE INSTRUMENTO
                LD      [DE],A
                INC     DE
                INC	HL
                JR      DECODE_CANAL
                
NO_INSTRUMENTO: BIT     2,B
                JR      Z,NO_ENVOLVENTE
                LD      A,11000100B     ;CODIGO ENVOLVENTE
                LD      [DE],A
                INC     DE
                INC	HL
                JR      DECODE_CANAL
     
NO_ENVOLVENTE:  BIT     1,B
                JR      Z,NO_MODIFICA           
                LD      A,11000010B     ;CODIGO EFECTO
                LD      [DE],A                  
                INC     HL                      
                INC     DE                      
                LD      A,[HL]                  
                CALL    GETLEN   
                
NO_MODIFICA:    LD      [DE],A
                INC     DE
                XOR     A
                DJNZ    NO_MODIFICA
		SET     7,A
		SET 	0,A
                LD      [DE],A
                INC     DE
                INC	HL
                RET			;** JR      DECODE_CANAL
                
FIN_DEC_CANAL:  SET     7,A
                LD      [DE],A
                INC     DE
                RET

GETLEN:         LD      B,A
                AND     00111111B
                PUSH    AF
                LD      A,B
                AND     11000000B
                RLCA
                RLCA
                INC     A
                LD      B,A
                LD      A,10000000B
DCBC0:          RLCA
                DJNZ    DCBC0
                LD      B,A
                POP     AF
                RET
                
                

        
                
;PLAY __________________________________________________


PLAY:          	LD      HL,INTERR       ;PLAY BIT 1 ON?
                BIT     1,[HL]
                RET     Z
;TEMPO          
                LD      HL,TTEMPO       ;CONTADOR TEMPO
                INC     [HL]
                LD      A,[TEMPO]
                CP      [HL]
                JR      NZ,PAUTAS
                LD      [HL],0
                
;INTERPRETA      
                LD      IY,PSG_REG
                LD      IX,PUNTERO_A
                LD      BC,PSG_REG+8
                CALL    LOCALIZA_NOTA
                LD      IY,PSG_REG+2
                LD      IX,PUNTERO_B
                LD      BC,PSG_REG+9
                CALL    LOCALIZA_NOTA
                LD      IY,PSG_REG+4
                LD      IX,PUNTERO_C
                LD      BC,PSG_REG+10
                CALL    LOCALIZA_NOTA
                LD      IX,PUNTERO_P    ;EL CANAL DE EFECTOS ENMASCARA OTRO CANAL
                CALL    LOCALIZA_EFECTO              

;PAUTAS 
                
PAUTAS:         LD      IY,PSG_REG+0
                LD      IX,PUNTERO_P_A
                LD      HL,PSG_REG+8
                CALL    PAUTA           ;PAUTA CANAL A
                LD      IY,PSG_REG+2
                LD      IX,PUNTERO_P_B
                LD      HL,PSG_REG+9
                CALL    PAUTA           ;PAUTA CANAL B
                LD      IY,PSG_REG+4
                LD      IX,PUNTERO_P_C
                LD      HL,PSG_REG+10
                CALL    PAUTA           ;PAUTA CANAL C                

                RET
                


;REPRODUCE EFECTOS DE SONIDO 

REPRODUCE_SONIDO:

		LD      HL,INTERR   
                BIT     2,[HL]          ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_SONIDO]
                LD      A,[HL]
                CP      $FF
                JR      Z,FIN_SONIDO
                LD      [PSG_REG_SEC+0],A
                INC     HL
                LD      A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD      [PSG_REG_SEC+1],A
                LD      A,[HL]
                AND     00001111B
                LD      [PSG_REG_SEC+8],A
                INC     HL
                LD      A,[HL]
                AND     A
                JR      Z,NO_RUIDO
                LD      [PSG_REG_SEC+6],A
                LD      A,10110000B
                JR      SI_RUIDO
NO_RUIDO:       LD      A,10111000B
SI_RUIDO:       LD      [PSG_REG_SEC+7],A
       
                INC     HL
                LD      [PUNTERO_SONIDO],HL
                RET
FIN_SONIDO:     LD      HL,INTERR
                RES     2,[HL]

FIN_NOPLAYER:	LD      A,10111000B
       		LD      [PSG_REG+7],A
                RET         
                
;VUELCA BUFFER DE SONIDO AL PSG

ROUT:      	XOR     A
ROUT_A0:        LD      DE,$FFBF
                LD      BC,$FFFD
                LD      HL,PSG_REG_SEC
LOUT:           OUT     [C],A
                LD      B,E
                OUTI 
                LD      B,D
                INC     A
                CP      13
                JR      NZ,LOUT
                OUT     [C],A
                LD      A,[HL]
                AND     A
                RET     Z
                LD      B,E
                OUTI
                XOR     A
                LD      [PSG_REG_SEC+13],A
                LD	[PSG_REG+13],A
                RET


;LOCALIZA NOTA CANAL A
;IN [PUNTERO_A]

LOCALIZA_NOTA:  LD      L,[IX+0]       		;HL=[PUNTERO_A_C_B]
                LD      H,[IX+1]
                LD      A,[HL]
                AND     11000000B      		;COMANDO?
                CP      11000000B
                JR      NZ,LNJP0

;BIT[0]=INSTRUMENTO
                
COMANDOS:       LD      A,[HL]
                BIT     0,A             	;INSTRUMENTO
                JR      Z,COM_EFECTO

                INC     HL
                LD      A,[HL]          	;Nº DE PAUTA
                INC     HL
                LD      [IX+00],L
                LD      [IX+01],H
                LD      HL,TABLA_PAUTAS
                CALL    EXT_WORD
                LD      [IX+18],L
                LD      [IX+19],H
                LD      [IX+12],L
                LD      [IX+13],H
                LD      L,C
                LD      H,B
                RES     4,[HL]        		;APAGA EFECTO ENVOLVENTE
                XOR     A
                LD      [PSG_REG_SEC+13],A
                LD	[PSG_REG+13],A
                JR      LOCALIZA_NOTA

COM_EFECTO:     BIT     1,A             	;EFECTO DE SONIDO
                JR      Z,COM_ENVOLVENTE

                INC     HL
                LD      A,[HL]
                INC     HL
                LD      [IX+00],L
                LD      [IX+01],H
                CALL    INICIA_SONIDO
                RET

COM_ENVOLVENTE: BIT     2,A
                RET     Z               	;IGNORA - ERROR            
           
                INC     HL
                LD      [IX+00],L
                LD      [IX+01],H
                LD      L,C
                LD      H,B
                LD	[HL],00010000B          ;ENCIENDE EFECTO ENVOLVENTE
                JR      LOCALIZA_NOTA
                
              
LNJP0:          LD      A,[HL]
                INC     HL
                BIT     7,A
                JR      Z,NO_FIN_CANAL_A	;
                BIT	0,A
                JR	Z,FIN_CANAL_A

FIN_NOTA_A:	LD      E,[IX+6]
		LD	D,[IX+7]	;PUNTERO BUFFER AL INICIO
		LD	[IX+0],E
		LD	[IX+1],D
		LD	L,[IX+30]	;CARGA PUNTERO DECODER
		LD	H,[IX+31]
		PUSH	BC
                CALL    DECODE_CANAL    ;DECODIFICA CANAL
                POP	BC
                LD	[IX+30],L	;GUARDA PUNTERO DECODER
                LD	[IX+31],H
                JP      LOCALIZA_NOTA
                
FIN_CANAL_A:    LD	HL,INTERR	;LOOP?
                BIT	4,[HL]              
                JR      NZ,FCA_CONT
                CALL	PLAYER_OFF
                RET

FCA_CONT:	LD	L,[IX+24]	;CARGA PUNTERO INICIAL DECODER
		LD	H,[IX+25]
		LD	[IX+30],L
		LD	[IX+31],H
		JR      FIN_NOTA_A
                
NO_FIN_CANAL_A: LD      [IX+0],L        ;[PUNTERO_A_B_C]=HL GUARDA PUNTERO
                LD      [IX+1],H
                AND     A               ;NO REPRODUCE NOTA SI NOTA=0
                JR      Z,FIN_RUTINA
                BIT     6,A             ;SILENCIO?
                JR      Z,NO_SILENCIO_A
                LD	A,[BC]
                AND	00010000B
                JR	NZ,SILENCIO_ENVOLVENTE
                XOR     A
                LD	[BC],A		;RESET VOLUMEN
                LD	[IY+0],A
                LD	[IY+1],A
		RET
		
SILENCIO_ENVOLVENTE:
		LD	A,$FF
                LD	[PSG_REG+11],A
                LD	[PSG_REG+12],A               
                XOR	A
                LD	[PSG_REG+13],A                               
                LD	[IY+0],A
                LD	[IY+1],A
                RET

NO_SILENCIO_A:  CALL    NOTA            ;REPRODUCE NOTA
                LD      L,[IX+18]       ;HL=[PUNTERO_P_A0] RESETEA PAUTA 
                LD      H,[IX+19]
                LD      [IX+12],L       ;[PUNTERO_P_A]=HL
                LD      [IX+13],H
FIN_RUTINA:     RET


;LOCALIZA EFECTO
;IN HL=[PUNTERO_P]

LOCALIZA_EFECTO:LD      L,[IX+0]       ;HL=[PUNTERO_P]
                LD      H,[IX+1]
                LD      A,[HL]
                CP      11000010B
                JR      NZ,LEJP0

                INC     HL
                LD      A,[HL]
                INC     HL
                LD      [IX+00],L
                LD      [IX+01],H
                CALL    INICIA_SONIDO
                RET
            
              
LEJP0:          INC     HL
                BIT     7,A
                JR      Z,NO_FIN_CANAL_P	;
                BIT	0,A
                JR	Z,FIN_CANAL_P
FIN_NOTA_P:	LD      DE,[CANAL_P]
		LD	[IX+0],E
		LD	[IX+1],D
		LD	HL,[PUNTERO_DECP]	;CARGA PUNTERO DECODER
		PUSH	BC
		CALL    DECODE_CANAL    	;DECODIFICA CANAL
		POP	BC
                LD	[PUNTERO_DECP],HL	;GUARDA PUNTERO DECODER
                JP      LOCALIZA_EFECTO
                
FIN_CANAL_P:	LD	HL,[PUNTERO_P_DECP]	;CARGA PUNTERO INICIAL DECODER
		LD	[PUNTERO_DECP],HL
		JR      FIN_NOTA_P
                
NO_FIN_CANAL_P: LD      [IX+0],L        ;[PUNTERO_A_B_C]=HL GUARDA PUNTERO
                LD      [IX+1],H
                RET
                
; PAUTA DE LOS 3 CANALES
; IN:[IX]:PUNTERO DE LA PAUTA
;    [HL]:REGISTRO DE VOLUMEN
;    [IY]:REGISTROS DE FRECUENCIA

; FORMATO PAUTA	
;	    7    6     5     4   3-0                     3-0  
; BYTE 1 [LOOP|OCT-1|OCT+1|SLIDE|VOL] - BYTE 2 [ | | | |PITCH]

PAUTA:          BIT     4,[HL]        ;SI LA ENVOLVENTE ESTA ACTIVADA NO ACTUA PAUTA
                RET     NZ

		LD	A,[IY+0]
		LD	B,[IY+1]
		OR	B
		RET	Z


                PUSH	HL
                ;LD      L,[IX+0]
                ;LD      H,[IX+1]
                		
                ;LD	A,[HL]		;COMPRUEBA SLIDE BIT 4
		;BIT	4,A
		;JR	Z,PCAJP4
		;LD	L,[IY+0]	;FRECUENCIA FINAL
		;LD	H,[IY+1]
		;SBC	HL,DE
		;JR	Z,PCAJP4
		;JR	C,SLIDE_POS
		;EX	DE,HL
		;RRC	D		;/4
		;RR	E
		;RRC	D
		;RR	E


		;ADC	HL,DE
		;LD	[IY+0],L
		;LD	[IY+1],H
SLIDE_POS:		
		;POP	HL
		;RET
                
PCAJP4:         LD      L,[IX+0]
                LD      H,[IX+1]         
		LD	A,[HL]
		
		BIT     7,A		;LOOP / EL RESTO DE BITS NO AFECTAN
                JR      Z,PCAJP0
                AND     00011111B       ;LOOP PAUTA [0,32]X2!!!-> PARA ORNAMENTOS
                RLCA			;X2
                LD      D,0
                LD      E,A
                SBC     HL,DE
                LD      A,[HL]

PCAJP0:		BIT	6,A		;OCTAVA -1
		JR	Z,PCAJP1
		LD	E,[IY+0]
		LD	D,[IY+1]

		AND	A
		RRC	D
		RR	E
		LD	[IY+0],E
		LD	[IY+1],D
		JR	PCAJP2
		
PCAJP1:		BIT	5,A		;OCTAVA +1
		JR	Z,PCAJP2
		LD	E,[IY+0]
		LD	D,[IY+1]

		AND	A
		RLC	E
		RL	D
		LD	[IY+0],E
		LD	[IY+1],D		


PCAJP2:		INC     HL
		PUSH	HL
		LD	E,A
		LD	A,[HL]		;PITCH DE FRECUENCIA
		LD	L,A
		AND	A
		LD	A,E
		JR	Z,ORNMJP1

                LD	A,[IY+0]	;SI LA FRECUENCIA ES 0 NO HAY PITCH
                ADD	A,[IY+1]
                AND	A
                LD	A,E
                JR	Z,ORNMJP1
                

		BIT	7,L
		JR	Z,ORNNEG
		LD	H,$FF
		JR	PCAJP3
ORNNEG:		LD	H,0
		
PCAJP3:		LD	E,[IY+0]
		LD	D,[IY+1]
		ADC	HL,DE
		LD	[IY+0],L
		LD	[IY+1],H
ORNMJP1:	POP	HL
		
		INC	HL
                LD      [IX+0],L
                LD      [IX+1],H
PCAJP5:         POP	HL
                AND	00001111B	;VOLUMEN FINAL
                LD      [HL],A
                RET



;NOTA : REPRODUCE UNA NOTA
;IN [A]=CODIGO DE LA NOTA
;   [IY]=REGISTROS DE FRECUENCIA


NOTA:           ;ADD	6		;*************************
		LD      L,C
                LD      H,B
                BIT     4,[HL]
                LD      B,A
                JR	NZ,EVOLVENTES
                LD	A,B
                LD      HL,DATOS_NOTAS
                RLCA                    ;X2
                LD      D,0
                LD      E,A
                ADD     HL,DE
                LD      A,[HL]
                LD      [IY+0],A
                INC     HL
                LD      A,[HL]
                LD      [IY+1],A
                RET

;IN [A]=CODIGO DE LA ENVOLVENTE
;   [IY]=REGISTRO DE FRECUENCIA

EVOLVENTES:     
		PUSH	AF
		CALL	ENV_RUT1
		LD	DE,$0000
		LD      [IY+0],E
                LD      [IY+1],D		
	
		POP	AF	
		ADD	A,36
		CALL	ENV_RUT1
		
	
		LD	A,E
                LD      [PSG_REG+11],A
                LD	A,D
                LD      [PSG_REG+12],A
                LD      A,$0C
                LD      [PSG_REG+13],A
                RET

;IN[A] NOTA
ENV_RUT1:	LD      HL,DATOS_NOTAS
		RLCA                    ;X2
                LD      D,0
                LD      E,A
                ADD     HL,DE
                LD	E,[HL]
		INC	HL
		LD	D,[HL]
                RET



EXT_WORD:       LD      D,0
                SLA     A               ;*2
                LD      E,A
                ADD     HL,DE
                LD      E,[HL]
                INC     HL
                LD      D,[HL]
                EX      DE,HL
                RET


;FUNCIONES DEL PLAYER DE FX
;___________________________

;INICIA FX
;REPRODUCE_EFECTO
;FIN_SONIDO


;VARIBLES Y FUNCIONES EXTERNAS
;_____________________________

;TABLA_EFECTOS      DW TABLA DE DIRECCIONES DE LOS EFECTOS
;INTERR         DB
;EXT_WORD      FUNCION DE EXTRACCION DE LA DIRECCION DEL FX POR Nº DE ORDEN


; *** AJUSTAR CANAL DE EFECTOS ANTES DE INICIAR EL REPRODUCTOR / CANAL C POR DEFECTO
; *** LLAMAR EN CADA INTERRUPCION

; VARIABLES
;___________

;INTERR:         DB     00              ;INTERRUPTORES 1=ON 0=OFF       
                                        ;BIT 0=CARGA CANCION ON/OFF
                                        ;BIT 1=PLAYER ON/OFF
                                        ;BIT 2=SONIDOS ON/OFF
                                       
 

INICIA_EFECTO:  LD   	A,B
      			LD      HL,TABLA_EFECTOS
                CALL    EXT_WORD
                LD      [PUNTERO_EFECTO],HL
      			LD      HL,INTERR
                SET     3,[HL]
                RET       

REPRODUCE_EFECTO:

                LD      HL,INTERR   
                BIT     3,[HL]             ;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_EFECTO]
                LD      A,[HL]
                CP      $FF
                JP      Z,FIN_EFECTO
                LD   	B,A         ;FRECUENCIA FINO
                INC     HL
                LD   A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD   C,A         ;   FRECUENCIA GRAVE
      			;LD      A,10111000B      ;   ELIMINA RUIDO
             	;LD      [PSG_REG_SEC+7],A
                LD      A,[HL]
                DEC   A         ;DEC A PARA BAJR VOLUMEN!!
                ;DEC   A
                AND     00001111B

                LD   D,A         ;VOLUMEN
                INC     HL         ;INCREMENTA Y GUARDA EL PUNTERO
                LD      [PUNTERO_EFECTO],HL     
              	LD   IX,PSG_REG_SEC
                LD   A,[CANAL_EFECTOS]      ;SELECCION DE CANAL
                CP   1
                JR   Z,RS_CANALA
                CP   2
      			JR   Z,RS_CANALB
      
RS_CANALC:     	LD      [IX+4],B
     			LD      [IX+5],C
                LD      [IX+10],D
                RET      
      
RS_CANALA:   	LD      [IX+0],B
      			LD      [IX+1],C
                LD      [IX+8],D
                RET
               
RS_CANALB:   	LD      [IX+2],B
      			LD      [IX+3],C
                LD      [IX+9],D
                RET
               
FIN_EFECTO:     LD      HL,INTERR
                RES     3,[HL]         ;DESACTIVA EFECTO
                RET         


                
;BANCO DE INSTRUMENTOS 2 BYTES POR INT.

;[0][RET 2 OFFSET]
;[1][+-PITCH]


;BANCO DE INSTRUMENTOS 2 BYTES POR INT.

;[0][RET 2 OFFSET]
;[1][+-PITCH]

TABLA_PAUTAS: 	DW	PAUTA_2,PAUTA_3,PAUTA_4,PAUTA_5,PAUTA_6,PAUTA_7,PAUTA_8,PAUTA_9;,PAUTA_10,PAUTA_11,PAUTA_12,PAUTA_13,PAUTA_14,PAUTA_15,PAUTA_16,PAUTA_17,PAUTA_18
TABLA_SONIDOS:  DW	SONIDO1,SONIDO2,SONIDO3,SONIDO4;,SONIDO5;,SONIDO6,SONIDO7;,SONIDO8
TABLA_SONG:     DW	SONG_0;,SONG_1,SONG_2;,SONG_3
TABLA_EFECTOS:  DW  EFECTO0, EFECTO1, EFECTO2, EFECTO3, EFECTO4, EFECTO5, EFECTO6, EFECTO7, EFECTO8

DATOS_NOTAS:    
DW 0,0
DW 1711,1614,1524,1438,1358,1281,1210,1142,1078,1017
DW 960,906,855,807,762,719,679,641,605,571
DW 539,509,480,453,428,404,381,360,339,320
DW 302,285,269,254,240,227,214,202,190,180
DW 170,160,151,143,135,127,120,113,107,101
DW 95,90,85,80,76,71,67,64,60,57

; Pegar PAUTAS

;Instrumento 'Wave'
PAUTA_2:	DB	9,0,76,0,11,0,9,0,8,4,8,4,8,0,8,0,8,20,8,20,8,0,8,0,136
;Instrumento 'Orn 0-3-7'
PAUTA_3:	DB	8,0,8,0,24,3,24,3,24,7,24,7,134
;Instrumento 'Orn 0-4-7'
PAUTA_4:	DB	8,0,8,0,24,4,24,4,24,7,24,7,134
;Instrumento 'Orn 0-4-8'
PAUTA_5:	DB	8,0,8,0,24,4,24,4,24,8,24,8,134
;Instrumento 'Bass'
PAUTA_6:	DB	45,0,44,0,10,0,8,0,7,0,129
;Instrumento 'Clip'
PAUTA_7:	DB	72,0,72,0,40,0,8,2,8,2,7,0,7,0,8,18,8,18,7,0,7,0,136
;Instrumento 'AlarmUp'
PAUTA_8:	DB	12,0,12,0,12,0,12,0,12,17,129
;Instrumento 'AlarmDown'
PAUTA_9:	DB	12,0,12,0,12,0,12,0,12,1,129

; Pegar SONIDOS

;Efecto 'bass drum'
SONIDO1:	DB	209,63,0,69,173,0,255
;Efecto 'drum'
SONIDO2:	DB	23,62,0,93,92,6,0,9,3,255
;Efecto 'hithat'
SONIDO3:	DB	0,11,1,0,6,1,255
;Efecto 'bass drum vol 2'
SONIDO4:	DB	186,58,0,0,102,0,162,131,0,255
			
; Aquí, incbin de los archivos MUS
				
SONG_0:		INCBIN	"fase1agus.mus"

; Pegar EFECTOS

; [0] Caída del salto
EFECTO0:		DB 	$51,$1A
				DB 	$E8,$1B
				DB 	$80,$2B
				DB 	$FF   
				
; [1] Quitar vida
EFECTO1:		DB 	$25,$1C
				DB 	$30,$2E
				DB	$00,$00
				DB	$A8,$0A
				DB	$C5,$1A
				DB	$00,$00
				DB	$37,$1C
				DB	$C5,$1C
				DB	$00,$00
				DB	$25,$18
				DB	$30,$26
				DB	$FF
				
; [2] Arrastrar en cinta
EFECTO2:		DB	$80,$2E,$00
				DB	$00,$0A,$04
				DB	$FF	
				
; [3] Coger tesoro
EFECTO3:		DB	$1F,$0B
				DB	$1A,$0C
				DB	$1F,$0D
				DB	$16,$0E
				DB	$1F,$0E
				DB	$0D,$0D
				DB	$1F,$0C
				DB	$0D,$0B
				DB	$00,$00
				DB	$00,$00
				DB	$1F,$08
				DB	$1A,$09
				DB	$1F,$0A
				DB	$16,$0B
				DB	$1F,$0B
				DB	$0D,$0A
				DB	$1F,$09
				DB	$0D,$07
				DB	$00,$00
				DB	$00,$00
				DB	$1F,$06
				DB	$1A,$07
				DB	$1F,$08
				DB	$16,$08
				DB	$1F,$07
				DB	$0D,$06
				DB	$1F,$05
				DB	$FF
	
; [4] ?
EFECTO4:		DB	$00,$0C,$03
				DB	$FF
				
; [5] Coger vida
EFECTO5:		DB	$1A,$0E
				DB	$1A,$0E
				DB	$00,$00
				DB	$1A,$0A
				DB	$1A,$0A
				DB	$00,$00
				DB	$1A,$0C
				DB	$1A,$0C
				DB	$00,$00
				DB	$1A,$08
				DB	$1A,$08
				DB	$FF
				
; [6] ?
EFECTO6:		DB 	$E8,$1B
				DB 	$80,$2B
				DB	$FF	
				
; [7] Salto largo
EFECTO7:		DB	$C3,$0E
				DB	$CC,$0D
				DB	$D5,$0A
				DB	$DE,$06
				DB	$35,$03
				DB	$50,$0B
				DB	$47,$0C
				DB	$3E,$08
				DB	$FF
				
; [8] Salto alto
EFECTO8:		DB	$58,$0D
				DB	$50,$0B
				DB	$47,$0A
				DB	$3E,$06
				DB	$35,$03
				DB	$50,$09
				DB	$47,$0A
				DB	$3E,$07
				DB	$FF

; VARIABLES__________________________


INTERR:         DB     00               ;INTERRUPTORES 1=ON 0=OFF
                                        ;BIT 0=CARGA CANCION ON/OFF
                                        ;BIT 1=PLAYER ON/OFF
                                        ;BIT 2=SONIDOS ON/OFF
                                        ;BIT 3=EFECTOS ON/OFF

;MUSICA **** EL ORDEN DE LAS VARIABLES ES FIJO ******



SONG:           DB     00               ;DBNº DE CANCION
TEMPO:          DB     00               ;DB TEMPO
TTEMPO:         DB     00               ;DB CONTADOR TEMPO
PUNTERO_A:      DW     00               ;DW PUNTERO DEL CANAL A
PUNTERO_B:      DW     00               ;DW PUNTERO DEL CANAL B
PUNTERO_C:      DW     00               ;DW PUNTERO DEL CANAL C

CANAL_A:        DW     BUFFER_DEC       ;DW DIRECION DE INICIO DE LA MUSICA A
CANAL_B:        DW     00               ;DW DIRECION DE INICIO DE LA MUSICA B
CANAL_C:        DW     00               ;DW DIRECION DE INICIO DE LA MUSICA C

PUNTERO_P_A:    DW     00               ;DW PUNTERO PAUTA CANAL A
PUNTERO_P_B:    DW     00               ;DW PUNTERO PAUTA CANAL B
PUNTERO_P_C:    DW     00               ;DW PUNTERO PAUTA CANAL C

PUNTERO_P_A0:   DW     00               ;DW INI PUNTERO PAUTA CANAL A
PUNTERO_P_B0:   DW     00               ;DW INI PUNTERO PAUTA CANAL B
PUNTERO_P_C0:   DW     00               ;DW INI PUNTERO PAUTA CANAL C


PUNTERO_P_DECA:	DW     00		;DW PUNTERO DE INICIO DEL DECODER CANAL A
PUNTERO_P_DECB:	DW     00		;DW PUNTERO DE INICIO DEL DECODER CANAL B
PUNTERO_P_DECC:	DW     00		;DW PUNTERO DE INICIO DEL DECODER CANAL C

PUNTERO_DECA:	DW     00		;DW PUNTERO DECODER CANAL A
PUNTERO_DECB:	DW     00		;DW PUNTERO DECODER CANAL B
PUNTERO_DECC:	DW     00		;DW PUNTERO DECODER CANAL C       


;CANAL DE EFECTOS - ENMASCARA OTRO CANAL

PUNTERO_P:      DW     00           	;DW PUNTERO DEL CANAL EFECTOS
CANAL_P:        DW     00           	;DW DIRECION DE INICIO DE LOS EFECTOS
PUNTERO_P_DECP:	DW     00		;DW PUNTERO DE INICIO DEL DECODER CANAL P
PUNTERO_DECP:	DW     00		;DW PUNTERO DECODER CANAL P

PSG_REG:        DB      00,00,00,00,00,00,00,10111000B,00,00,00,00,00,00,00    ;DB [11] BUFFER DE REGISTROS DEL PSG
PSG_REG_SEC:    DB      00,00,00,00,00,00,00,10111000B,00,00,00,00,00,00,00    ;DB [11] BUFFER SECUNDARIO DE REGISTROS DEL PSG



;ENVOLVENTE_A    EQU     $D033           ;DB
;ENVOLVENTE_B    EQU     $D034           ;DB
;ENVOLVENTE_C    EQU     $D035           ;DB


;EFECTOS DE SONIDO

N_SONIDO:       DB      0               ;DB : NUMERO DE SONIDO
PUNTERO_SONIDO: DW      0               ;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE

;EFECTOS

N_EFECTO:       DB      0               ;DB : NUMERO DE SONIDO
PUNTERO_EFECTO: DW      0               ;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE
CANAL_EFECTOS:	DB		1				; CANAL DE SFX

BUFFER_DEC:     DB      $00		;************************* mucha atencion!!!!
					; aqui se decodifica la cancion hay que dejar suficiente espacio libre.
					;*************************
                
                