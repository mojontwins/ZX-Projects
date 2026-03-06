
;FUNCIONES DEL PLAYER DE FX
;___________________________

;INICIA FX
;REPRODUCE_EFECTO
;FIN_EFECTO


;VARIBLES Y FUNCIONES EXTERNAS
;_____________________________

;TABLA_EFECTOS		DW TABLA DE DIRECCIONES DE LOS EFECTOS
;INTERR			DB 
;EXT_WORD		FUNCION DE EXTRACCION DE LA DIRECCION DEL FX POR Nº DE ORDEN


; *** AJUSTAR CANAL DE EFECTOS ANTES DE INICIAR EL REPRODUCTOR 
; *** LLAMAR EN CADA INTERRUPCION A REPRODUCE_EFECTO

; VARIABLES
;___________

;INTERR:         DB     00              ;INTERRUPTORES 1=ON 0=OFF       
                                        ;BIT 0=CARGA CANCION ON/OFF
                                        ;BIT 1=PLAYER ON/OFF
                                        ;BIT 2=SONIDOS ON/OFF
                                        
					;BIT 3=EFECTOS ON/OFF 
;EFECTOS

N_EFECTO	       	EQU	$E450   ;DB : NUMERO DE SONIDO
PUNTERO_EFECTO		EQU	$E451	;DW : PUNTERO DEL SONIDO QUE SE REPRODUCE;REPRODUCE EFECTOS
CANAL_EFECTOS		EQU	$E453	;DB : 1:CANAL A - 2:CANAL B - OTRO:CANAL C



INICIA_EFECTO:	LD	A,B
				LD      HL,TABLA_EFECTOS
                CALL    EXT_WORD
                LD      [PUNTERO_EFECTO],HL
				LD      HL,INTERR
                SET     3,[HL]
                RET       

REPRODUCE_EFECTO:

                LD      HL,INTERR   
                BIT     3,[HL]          	;ESTA ACTIVADO EL EFECTO?
                RET     Z
                LD      HL,[PUNTERO_EFECTO]
                LD      A,[HL]
                CP      $FF
                JP      Z,FIN_EFECTO
                LD		B,A					;FRECUENCIA FINO
                INC     HL
                LD		A,[HL]
                RRCA
                RRCA
                RRCA
                RRCA
                AND     00001111B
                LD		C,A					;FRECUENCIA GRAVE
				;LD      A,10111000B		;ELIMINA RUIDO
       			;LD      [PSG_REG_SEC+7],A
                LD      A,[HL]
                DEC	A						;DEC A PARA BAJR VOLUMEN!! O PONER VARIABLE
                ;DEC	A
                AND     00001111B

                LD	D,A						;VOLUMEN
                INC     HL					;INCREMENTA Y GUARDA EL PUNTERO
                LD      [PUNTERO_EFECTO],HL     
           		LD	IX,PSG_REG_SEC
                LD	A,[CANAL_EFECTOS]		;SELECCION DE CANAL *********
                CP	1
                JR	Z,RS_CANALA
                CP	2
				JR	Z,RS_CANALB
		
RS_CANALC:  	LD      [IX+4],B
				LD      [IX+5],C
                LD      [IX+10],D
                RET		
		
RS_CANALA:		LD      [IX+0],B
				LD      [IX+1],C
                LD      [IX+8],D
                RET
                
RS_CANALB:		LD      [IX+2],B
				LD      [IX+3],C
                LD      [IX+9],D
                RET
                
FIN_EFECTO:     LD      HL,INTERR
                RES     3,[HL]			;DESACTIVA EFECTO
                RET         


