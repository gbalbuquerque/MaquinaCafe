      ;Definição de constantes
      DELAY_COUNT equ 50   ; Valor para o atraso
      TIMEOUT_COUNT equ 200  ; Contagem para 10 segundos (200 * 50ms)
       
      ; When a key is pressed the key number
      ; is placed in R0.
       
      ; For this program, the keys are numbered
      ; as:
       
      ;	+----+----+----+
      ;	| 11 | 10 |  9 |	row3
      ;	+----+----+----+
      ;	|  8 |  7 |  6 |	row2
      ;	+----+----|----+
      ;	|  5 |  4 |  3 |	row1
      ;	+----+----+----+
      ;	|  2 |  1 |  0 |	row0
      ;	+----+----+----+
      ;	 col2 col1 col0
       
      ; The pressed key number will be stored in
      ; R0. Therefore, R0 is initially cleared.
      ; Each key is scanned, and if it is not
      ; pressed R0 is incremented. In that way,
      ; when the pressed key is found, R0 will
      ; contain the key's number.
       
      ; The general purpose flag, F0, is used
      ; by the column-scan subroutine to indicate
      ; whether or not a pressed key was found
      ; in that column.
      ; If, after returning from colScan, F0 is
      ; set, this means the key was found.
       
       
      ; --- Mapeamento de Hardware (8051) ---
          RS      equ     P1.3    ;Reg Select ligado em P1.3
          EN      equ     P1.2    ;Enable ligado em P1.2
       
       
      org 0000h
0000| 	LJMP START
       
      org 0030h
      START:
      ; put data in RAM
0030| 	MOV 40H, #'#' 
0033| 	MOV 41H, #'0'
0036| 	MOV 42H, #'*'
0039| 	MOV 43H, #'9'
003C| 	MOV 44H, #'8'
003F| 	MOV 45H, #'7'
0042| 	MOV 46H, #'6'
0045| 	MOV 47H, #'5'
0048| 	MOV 48H, #'4'
004B| 	MOV 49H, #'3'
004E| 	MOV 4AH, #'2'
0051| 	MOV 4BH, #'1'	  
       
      MAIN:
0054| 	CLR A
0055| 	ACALL lcd_init
0057| 	MOV A, #03H
0059| 	ACALL posicionaCursor
005B| 	MOV DPTR,#MSG     ; DPTR = início da palavra FEI
005E| 	ACALL escreveString
0060| 	MOV A, #43H
0062| 	ACALL posicionaCursor
0064| 	MOV DPTR,#Display ; DPTR = início da palavra Display
0067| 	ACALL escreveString    
0069| 	ACALL clearDisplay
      	;opcoes
006B| 	ACALL lcd_init
      	
      	;opcao1
006D| 	MOV A, #03H
006F| 	ACALL posicionaCursor
0071| 	MOV DPTR,#OpcoesCafe1 ; DPTR = início das opções de café
0074| 	ACALL escreveString
0076| 	ACALL clearDisplay
      		
      	;opcao2
0078| 	MOV A, #03H
007A| 	ACALL posicionaCursor
007C| 	MOV DPTR, #OpcoesCafe2 ; DPTR = início das opções de café
007F| 	ACALL escreveString
0081| 	ACALL clearDisplay
      	
      	;opcao3
0083| 	MOV A, #03H
0085| 	ACALL posicionaCursor
0087| 	MOV DPTR, #OpcoesCafe3 ; DPTR = início das opções de café
008A| 	ACALL escreveString
008C| 	ACALL clearDisplay
      		
      	;opcao4
008E| 	MOV A, #03H
0090| 	ACALL posicionaCursor
0092| 	MOV DPTR, #OpcoesCafe4 ; DPTR = início das opções de café
0095| 	ACALL escreveString
0097| 	ACALL clearDisplay
       
      	;opcao5
0099| 	MOV A, #03H
009B| 	ACALL posicionaCursor
009D| 	MOV DPTR, #OpcoesCafe5 ; DPTR = início das opções de café
00A0| 	ACALL escreveString
00A2| 	ACALL clearDisplay
      	
      	;opcao6
00A4| 	MOV A, #03H
00A6| 	ACALL posicionaCursor
00A8| 	MOV DPTR, #OpcoesCafe6 ; DPTR = início das opções de café
00AB| 	ACALL escreveString
00AD| 	ACALL clearDisplay
      	
      	;opcao7
00AF| 	MOV A, #03H
00B1| 	ACALL posicionaCursor
00B3| 	MOV DPTR, #OpcoesCafe7 ; DPTR = início das opções de café
00B6| 	ACALL escreveString
00B8| 	ACALL clearDisplay
      		
      ROTINA:
      	
00BA| 	ACALL leituraTeclado
00BC| 	JNB F0, ROTINA   ;if F0 is clear, jump to ROTINA
00BF| 	MOV A, #07h
00C1| 	ACALL posicionaCursor	
00C3| 	MOV A, #40h
00C5| 	ADD A, R0
00C6| 	MOV R0, A
00C7| 	MOV A, @R0        
00C8| 	CJNE A,#'1',naoCafe1
00CB| 	ACALL lcd_init
00CD| 	MOV A,#03H
00CF| 	ACALL posicionaCursor
00D1| 	MOV DPTR,#OP1
00D4| 	ACALL escreveString
00D6| 	ACALL clearDisplay
      	
      	;Preparando
00D8| 	ACALL lcd_init
00DA| 	MOV A,#03H
00DC| 	ACALL posicionaCursor
00DE| 	MOV DPTR,#Preparando
00E1| 	ACALL escreveString
00E3| 	MOV A,#43H
00E5| 	ACALL posicionaCursor
00E7| 	MOV DPTR,#Aguarde
00EA| 	ACALL escreveString
00EC| 	ACALL clearDisplay
       
      	;Pedido pronto
00EE| 	ACALL lcd_init
00F0| 	MOV A,#03H
00F2| 	ACALL posicionaCursor 
00F4| 	MOV DPTR,#cafePreto
00F7| 	ACALL escreveString
00F9| 	MOV A,#43H
00FB| 	ACALL posicionaCursor
00FD| 	MOV DPTR,#Pronto
0100| 	ACALL escreveString
0102| 	ACALL clearDisplay
       
      	;Volte sempre	
0104| 	ACALL lcd_init
0106| 	MOV A,#03H
0108| 	ACALL posicionaCursor 
010A| 	MOV DPTR,#volteSempre
010D| 	ACALL escreveString
010F| 	ACALL clearDisplay
       
      naoCafe1: 
0111| 	CJNE A,#'2',naoCafe2 
0114| 	ACALL lcd_init 
0116| 	MOV A,#03H 
0118| 	ACALL posicionaCursor 
011A| 	MOV DPTR,#OP2
011D| 	ACALL escreveString 
011F| 	ACALL clearDisplay
       
      	;Preparando
0121| 	ACALL lcd_init
0123|  	MOV A,#03H 
0125| 	ACALL posicionaCursor 
0127| 	MOV DPTR,#Preparando 
012A| 	ACALL escreveString 
012C| 	MOV A,#43H 
012E| 	ACALL posicionaCursor 
0130| 	MOV DPTR,#Aguarde 
0133| 	ACALL escreveString 
0135| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
0137| 	ACALL lcd_init 
0139| 	MOV A,#03H 
013B| 	ACALL posicionaCursor 
013D| 	MOV DPTR,#cafeComLeite 
0140| 	ACALL escreveString 
0142| 	MOV A,#43H 
0144| 	ACALL posicionaCursor 
0146| 	MOV DPTR,#Pronto 
0149| 	ACALL escreveString 
014B| 	ACALL clearDisplay 
       
      	;Volte sempre
014D| 	ACALL lcd_init 
014F| 	MOV A,#03H 
0151| 	ACALL posicionaCursor 
0153| 	MOV DPTR,#volteSempre 
0156| 	ACALL escreveString 
0158| 	ACALL clearDisplay 
       
      naoCafe2: 
015A| 	CJNE A,#'3',naoCafe3 
015D| 	ACALL lcd_init 
015F| 	MOV A,#03H 
0161| 	ACALL posicionaCursor 
0163| 	MOV DPTR,#OP3
0166| 	ACALL escreveString 
0168| 	ACALL clearDisplay
       
      	;Preparando
016A| 	ACALL lcd_init
016C|  	MOV A,#03H 
016E| 	ACALL posicionaCursor 
0170| 	MOV DPTR,#Preparando 
0173| 	ACALL escreveString 
0175| 	MOV A,#43H 
0177| 	ACALL posicionaCursor 
0179| 	MOV DPTR,#Aguarde 
017C| 	ACALL escreveString 
017E| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
0180| 	ACALL lcd_init 
0182| 	MOV A,#03H 
0184| 	ACALL posicionaCursor 
0186| 	MOV DPTR,#cafeExpresso
0189| 	ACALL escreveString 
018B| 	MOV A,#43H 
018D| 	ACALL posicionaCursor 
018F| 	MOV DPTR,#Pronto 
0192| 	ACALL escreveString 
0194| 	ACALL clearDisplay 
       
      	;Volte sempre
0196| 	ACALL lcd_init 
0198| 	MOV A,#03H 
019A| 	ACALL posicionaCursor 
019C| 	MOV DPTR,#volteSempre 
019F| 	ACALL escreveString 
01A1| 	ACALL clearDisplay 
       
      naoCafe3: 
01A3| 	CJNE A,#'4',naoCafe4 
01A6| 	ACALL lcd_init 
01A8| 	MOV A,#03H 
01AA| 	ACALL posicionaCursor 
01AC| 	MOV DPTR,#OP4
01AF| 	ACALL escreveString 
01B1| 	ACALL clearDisplay
       
      	;Preparando
01B3| 	ACALL lcd_init
01B5|  	MOV A,#03H 
01B7| 	ACALL posicionaCursor 
01B9| 	MOV DPTR,#Preparando 
01BC| 	ACALL escreveString 
01BE| 	MOV A,#43H 
01C0| 	ACALL posicionaCursor 
01C2| 	MOV DPTR,#Aguarde 
01C5| 	ACALL escreveString 
01C7| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
01C9| 	ACALL lcd_init 
01CB| 	MOV A,#03H 
01CD| 	ACALL posicionaCursor 
01CF| 	MOV DPTR,#cafeGelado
01D2| 	ACALL escreveString 
01D4| 	MOV A,#43H 
01D6| 	ACALL posicionaCursor 
01D8| 	MOV DPTR,#Pronto 
01DB| 	ACALL escreveString 
01DD| 	ACALL clearDisplay 
       
      	;Volte sempre
01DF| 	ACALL lcd_init 
01E1| 	MOV A,#03H 
01E3| 	ACALL posicionaCursor 
01E5| 	MOV DPTR,#volteSempre 
01E8| 	ACALL escreveString 
01EA| 	ACALL clearDisplay 
       
      naoCafe4: 
01EC| 	CJNE A,#'5',naoCafe5 
01EF| 	ACALL lcd_init 
01F1| 	MOV A,#03H 
01F3| 	ACALL posicionaCursor 
01F5| 	MOV DPTR,#OP5
01F8| 	ACALL escreveString 
01FA| 	ACALL clearDisplay
       
      	;Preparando
01FC| 	ACALL lcd_init
01FE|  	MOV A,#03H 
0200| 	ACALL posicionaCursor 
0202| 	MOV DPTR,#Preparando 
0205| 	ACALL escreveString 
0207| 	MOV A,#43H 
0209| 	ACALL posicionaCursor 
020B| 	MOV DPTR,#Aguarde 
020E| 	ACALL escreveString 
0210| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
0212| 	ACALL lcd_init 
0214| 	MOV A,#03H 
0216| 	ACALL posicionaCursor 
0218| 	MOV DPTR,#cafeCapuccino
021B| 	ACALL escreveString 
021D| 	MOV A,#43H 
021F| 	ACALL posicionaCursor 
0221| 	MOV DPTR,#Pronto 
0224| 	ACALL escreveString 
0226| 	ACALL clearDisplay 
       
      	;Volte sempre
0228| 	ACALL lcd_init 
022A| 	MOV A,#03H 
022C| 	ACALL posicionaCursor 
022E| 	MOV DPTR,#volteSempre 
0231| 	ACALL escreveString 
0233| 	ACALL clearDisplay 
       
      naoCafe5: 
0235| 	CJNE A,#'6',naoCafe6 
0238| 	ACALL lcd_init 
023A| 	MOV A,#03H 
023C| 	ACALL posicionaCursor 
023E| 	MOV DPTR,#OP6
0241| 	ACALL escreveString 
0243| 	ACALL clearDisplay
       
      	;Preparando
0245| 	ACALL lcd_init
0247|  	MOV A,#03H 
0249| 	ACALL posicionaCursor 
024B| 	MOV DPTR,#Preparando 
024E| 	ACALL escreveString 
0250| 	MOV A,#43H 
0252| 	ACALL posicionaCursor 
0254| 	MOV DPTR,#Aguarde 
0257| 	ACALL escreveString 
0259| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
025B| 	ACALL lcd_init 
025D| 	MOV A,#03H 
025F| 	ACALL posicionaCursor 
0261| 	MOV DPTR,#cafeLatte
0264| 	ACALL escreveString 
0266| 	MOV A,#43H 
0268| 	ACALL posicionaCursor 
026A| 	MOV DPTR,#Pronto 
026D| 	ACALL escreveString 
026F| 	ACALL clearDisplay 
       
      	;Volte sempre
0271| 	ACALL lcd_init 
0273| 	MOV A,#03H 
0275| 	ACALL posicionaCursor 
0277| 	MOV DPTR,#volteSempre 
027A| 	ACALL escreveString 
027C| 	ACALL clearDisplay 
       
      naoCafe6: 
027E| 	CJNE A,#'7',desconhecido
0281| 	ACALL lcd_init 
0283| 	MOV A,#03H 
0285| 	ACALL posicionaCursor 
0287| 	MOV DPTR,#OP7
028A| 	ACALL escreveString 
028C| 	ACALL clearDisplay
       
      	;Preparando
028E| 	ACALL lcd_init
0290|  	MOV A,#03H 
0292| 	ACALL posicionaCursor 
0294| 	MOV DPTR,#Preparando 
0297| 	ACALL escreveString 
0299| 	MOV A,#43H 
029B| 	ACALL posicionaCursor 
029D| 	MOV DPTR,#Aguarde 
02A0| 	ACALL escreveString 
02A2| 	ACALL clearDisplay 
      	
      	;Pedido pronto 
02A4| 	ACALL lcd_init 
02A6| 	MOV A,#03H 
02A8| 	ACALL posicionaCursor 
02AA| 	MOV DPTR,#cafeLatte
02AD| 	ACALL escreveString 
02AF| 	MOV A,#43H 
02B1| 	ACALL posicionaCursor 
02B3| 	MOV DPTR,#Pronto 
02B6| 	ACALL escreveString 
02B8| 	ACALL clearDisplay 
       
      	;Volte sempre
02BA| 	ACALL lcd_init 
02BC| 	MOV A,#03H 
02BE| 	ACALL posicionaCursor 
02C0| 	MOV DPTR,#volteSempre 
02C3| 	ACALL escreveString 
02C5| 	ACALL clearDisplay 
       
      ;Funcao para quando nao tiver certeza retornar para o começo
      leituraTeclado:
02C7| 	MOV R0, #0			; clear R0 - the first key is key0
       
      	; scan row0
02C9| 	MOV P0, #0FFh	
02CC| 	CLR P0.0			; clear row0
02CE| 	CALL colScan		; call column-scan subroutine
02D0| 	JB F0, finish		; | if F0 is set, jump to end of program 
      						; | (because the pressed key was found and its number is in  R0)
      	; scan row1
02D3| 	SETB P0.0			; set row0
02D5| 	CLR P0.1			; clear row1
02D7| 	CALL colScan		; call column-scan subroutine
02D9| 	JB F0, finish		; | if F0 is set, jump to end of program 
      						; | (because the pressed key was found and its number is in  R0)
      	; scan row2
02DC| 	SETB P0.1			; set row1
02DE| 	CLR P0.2			; clear row2
02E0| 	CALL colScan		; call column-scan subroutine
02E2| 	JB F0, finish		; | if F0 is set, jump to end of program 
      						; | (because the pressed key was found and its number is in  R0)
      	; scan row3
02E5| 	SETB P0.2			; set row2
02E7| 	CLR P0.3			; clear row3
02E9| 	CALL colScan		; call column-scan subroutine
02EB| 	JB F0, finish		; | if F0 is set, jump to end of program 
      						; | (because the pressed key was found and its number is in  R0)
       
      desconhecido:
      DB "		 Pd Desconhecido"
      DB 0 ; Caracter null indica fim da String
       
      finish:
0301| 	RET
       
      ; column-scan subroutine
      colScan:
0302| 	JNB P0.4, gotKey	; if col0 is cleared - key found
0305| 	INC R0				; otherwise move to next key
0306| 	JNB P0.5, gotKey	; if col1 is cleared - key found
0309| 	INC R0				; otherwise move to next key
030A| 	JNB P0.6, gotKey	; if col2 is cleared - key found
030D| 	INC R0				; otherwise move to next key
030E| 	RET					; return from subroutine - key not found
      gotKey:
030F| 	SETB F0				; key found - set F0
0311| 	RET					; and return from subroutine
       
       
       
       
      ; initialise the display
      ; see instruction set for details
      lcd_init:
       
0312| 	CLR RS		; clear RS - indicates that instructions are being sent to the module
       
      ; function set	
0314| 	CLR P1.7		; |
0316| 	CLR P1.6		; |
0318| 	SETB P1.5		; |
031A| 	CLR P1.4		; | high nibble set
       
031C| 	SETB EN		; |
031E| 	CLR EN		; | negative edge on E
       
0320| 	CALL delay		; wait for BF to clear	
      					; function set sent for first time - tells module to go into 4-bit mode
      ; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.
       
0322| 	SETB EN		; |
0324| 	CLR EN		; | negative edge on E
      					; same function set high nibble sent a second time
       
0326| 	SETB P1.7		; low nibble set (only P1.7 needed to be changed)
       
0328| 	SETB EN		; |
032A| 	CLR EN		; | negative edge on E
      				; function set low nibble sent
032C| 	CALL delay		; wait for BF to clear
       
       
      ; entry mode set
      ; set to increment with no shift
032E| 	CLR P1.7		; |
0330| 	CLR P1.6		; |
0332| 	CLR P1.5		; |
0334| 	CLR P1.4		; | high nibble set
       
0336| 	SETB EN		; |
0338| 	CLR EN		; | negative edge on E
       
033A| 	SETB P1.6		; |
033C| 	SETB P1.5		; |low nibble set
       
033E| 	SETB EN		; |
0340| 	CLR EN		; | negative edge on E
       
0342| 	CALL delay		; wait for BF to clear
       
       
      ; display on/off control
      ; the display is turned on, the cursor is turned on and blinking is turned on
0344| 	CLR P1.7		; |
0346| 	CLR P1.6		; |
0348| 	CLR P1.5		; |
034A| 	CLR P1.4		; | high nibble set
       
034C| 	SETB EN		; |
034E| 	CLR EN		; | negative edge on E
       
0350| 	SETB P1.7		; |
0352| 	SETB P1.6		; |
0354| 	SETB P1.5		; |
0356| 	SETB P1.4		; | low nibble set
       
0358| 	SETB EN		; |
035A| 	CLR EN		; | negative edge on E
       
035C| 	CALL delay		; wait for BF to clear
035E| 	RET
       
       
      sendCharacter:
035F| 	SETB RS  		; setb RS - indicates that data is being sent to module
0361| 	MOV C, ACC.7		; |
0363| 	MOV P1.7, C			; |
0365| 	MOV C, ACC.6		; |
0367| 	MOV P1.6, C			; |
0369| 	MOV C, ACC.5		; |
036B| 	MOV P1.5, C			; |
036D| 	MOV C, ACC.4		; |
036F| 	MOV P1.4, C			; | high nibble set
       
0371| 	SETB EN			; |
0373| 	CLR EN			; | negative edge on E
       
0375| 	MOV C, ACC.3		; |
0377| 	MOV P1.7, C			; |
0379| 	MOV C, ACC.2		; |
037B| 	MOV P1.6, C			; |
037D| 	MOV C, ACC.1		; |
037F| 	MOV P1.5, C			; |
0381| 	MOV C, ACC.0		; |
0383| 	MOV P1.4, C			; | low nibble set
       
0385| 	SETB EN			; |
0387| 	CLR EN			; | negative edge on E
       
0389| 	CALL delay			; wait for BF to clear
038B| 	CALL delay			; wait for BF to clear
038D| 	RET
       
      ;Posiciona o cursor na linha e coluna desejada.
      ;Escreva no Acumulador o valor de endere o da linha e coluna.
      ;|--------------------------------------------------------------------------------------|
      ;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
      ;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
      ;|--------------------------------------------------------------------------------------|
      posicionaCursor:
038E| 	CLR RS	
0390| 	SETB P1.7		    ; |
0392| 	MOV C, ACC.6		; |
0394| 	MOV P1.6, C			; |
0396| 	MOV C, ACC.5		; |
0398| 	MOV P1.5, C			; |
039A| 	MOV C, ACC.4		; |
039C| 	MOV P1.4, C			; | high nibble set
       
039E| 	SETB EN			; |
03A0| 	CLR EN			; | negative edge on E
       
03A2| 	MOV C, ACC.3		; |
03A4| 	MOV P1.7, C			; |
03A6| 	MOV C, ACC.2		; |
03A8| 	MOV P1.6, C			; |
03AA| 	MOV C, ACC.1		; |
03AC| 	MOV P1.5, C			; |
03AE| 	MOV C, ACC.0		; |
03B0| 	MOV P1.4, C			; | low nibble set
       
03B2| 	SETB EN			; |
03B4| 	CLR EN			; | negative edge on E
       
03B6| 	CALL delay			; wait for BF to clear
03B8| 	CALL delay			; wait for BF to clear
03BA| 	RET
       
       
      ;Retorna o cursor para primeira posi  o sem limpar o display
      retornaCursor:
03BB| 	CLR RS	
03BD| 	CLR P1.7		; |
03BF| 	CLR P1.6		; |
03C1| 	CLR P1.5		; |
03C3| 	CLR P1.4		; | high nibble set
       
03C5| 	SETB EN		; |
03C7| 	CLR EN		; | negative edge on E
       
03C9| 	CLR P1.7		; |
03CB| 	CLR P1.6		; |
03CD| 	SETB P1.5		; |
03CF| 	SETB P1.4		; | low nibble set
       
03D1| 	SETB EN		; |
03D3| 	CLR EN		; | negative edge on E
       
03D5| 	CALL delay		; wait for BF to clear
03D7| 	RET
       
       
      ;Limpa o display
      clearDisplay:
03D8| 	CLR RS	
03DA| 	CLR P1.7		; |
03DC| 	CLR P1.6		; |
03DE| 	CLR P1.5		; |
03E0| 	CLR P1.4		; | high nibble set
       
03E2| 	SETB EN		; |
03E4| 	CLR EN		; | negative edge on E
       
03E6| 	CLR P1.7		; |
03E8| 	CLR P1.6		; |
03EA| 	CLR P1.5		; |
03EC| 	SETB P1.4		; | low nibble set
       
03EE| 	SETB EN		; |
03F0| 	CLR EN		; | negative edge on E
       
03F2| 	CALL delay		; wait for BF to clear
03F4| 	RET
       
       
      delay:
03F5| 	MOV R7, #50
03F7| 	DJNZ R7, $
03F9| 	RET
       
       
      esperar_10_segundos:
03FA|     MOV R1, #TIMEOUT_COUNT
       
      wait_loop:
03FC|     ACALL delay       ; Aguarda 50ms
03FE|     DJNZ R1, wait_loop
0400|     RET
       
      MSG:
      DB "Cup Coffe"
      DB 0 ; caracter null indica fim da String
      Display:
      DB "BEM-VINDO"
      DB 0 ; caracter null indica fim da String
       
      	
      escreveString:
0415| MOV R2, #0
      rot:
0417| MOV A, R2
0418| MOVC A,@A+DPTR ; lê a tabela da memória de programa
0419| ACALL sendCharacter ; send data in A to LCD module
041B| INC R2
041C| JNZ rot ; if A is 0, then end of data has been reached - jump out of loop
041E| RET
       
      ;Strings do Menu
       
      OpcoesCafe1:
      DB "     1.Cafe preto"
      DB 0; caracter null indica fim da String
       
      OpcoesCafe2:
      DB "     2.Cafe com leite"
      DB 0; caracter null indica fim da String
       
      OpcoesCafe3:
      DB "     3.Cafe expresso"
      DB 0 ; Caracter null indica fim da String
       
      OpcoesCafe4:
      DB "      4.Cafe gelado"
      DB 0 ; Caracter null indica fim da String
       
      OpcoesCafe5:
      DB "      5.Capuccino"
      DB 0 ; Caracter null indica fim da String
       
      OpcoesCafe6:
      DB "      6.Latte"
      DB 0 ; Caracter null indica fim da String
       
      OpcoesCafe7:
      DB "      7.Mocha"
      DB 0 ; Caracter null indica fim da String
       
      ;String das Opcoes escolhidas
       
      OP1:
      DB "No1 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP2:
      DB "No2 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP3:
      DB "No3 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP4:
      DB "No4 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP5:
      DB "No5 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP6:
      DB "No6 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      OP7:
      DB "No7 Escolhido"
      DB 0	; Caracter null indica fim da String
       
      ;Strings complementares
       
      Preparando:
      DB "     Preparando..."
      DB 0 ; Caracter null indica fim da String
       
      Aguarde:
      DB " Aguarde!"
      DB 0 ; Caracter null indica fim da String
       
      Pronto:
      DB " Pronto!"
      DB 0 ; Caracter null indica fim da String
       
      volteSempre:
      DB "    Volte Sempre!"
      DB 0 ; Caracter null indica fim da String
       
      ;Strings com nome dos pedidos
      cafePreto:
      DB "    Cafe Preto"
      DB 0 ; Caracter null indica fim da String
       
      cafeComLeite:
      DB "    Cafe com Leite"
      DB 0 ; Caracter null indica fim da String
       
      cafeExpresso:
      DB "    Cafe Expresso"
      DB 0 ; Caracter null indica fim da String
       
      cafeGelado:
      DB "    Cafe Gelado"
      DB 0 ; Caracter null indica fim da String
       
      cafeCapuccino:
      DB "    Capuccino"
      DB 0 ; Caracter null indica fim da String
       
      cafeLatte:
      DB "    Latte"
      DB 0 ; Caracter null indica fim da String
       
      cafeMocha:
      DB "    Mocha"
      DB 0 ; Caracter null indica fim da String
       
