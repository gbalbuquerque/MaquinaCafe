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
	LJMP START

org 0030h
START:
; put data in RAM
	MOV 40H, #'#' 
	MOV 41H, #'0'
	MOV 42H, #'*'
	MOV 43H, #'9'
	MOV 44H, #'8'
	MOV 45H, #'7'
	MOV 46H, #'6'
	MOV 47H, #'5'
	MOV 48H, #'4'
	MOV 49H, #'3'
	MOV 4AH, #'2'
	MOV 4BH, #'1'	  

MAIN:
	CLR A
	ACALL lcd_init
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR,#MSG     ; DPTR = início da palavra FEI
	ACALL escreveString
	MOV A, #43H
	ACALL posicionaCursor
	MOV DPTR,#Display ; DPTR = início da palavra Display
	ACALL escreveString    
	ACALL clearDisplay
	;opcoes
	ACALL lcd_init
	
	;opcao1
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR,#OpcoesCafe1 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
		
	;opcao2
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe2 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
	
	;opcao3
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe3 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
		
	;opcao4
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe4 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay

	;opcao5
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe5 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
	
	;opcao6
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe6 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
	
	;opcao7
	MOV A, #03H
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe7 ; DPTR = início das opções de café
	ACALL escreveString
	ACALL clearDisplay
		
ROTINA:
	
	ACALL leituraTeclado
	JNB F0, ROTINA   ;if F0 is clear, jump to ROTINA
	MOV A, #07h
	ACALL posicionaCursor	
	MOV A, #40h
	ADD A, R0
	MOV R0, A
	MOV A, @R0        
	CJNE A,#'1',naoCafe1
	ACALL lcd_init
	MOV A,#03H
	ACALL posicionaCursor
	MOV DPTR,#OP1
	ACALL escreveString
	ACALL clearDisplay
	
	;Preparando
	ACALL lcd_init
	MOV A,#03H
	ACALL posicionaCursor
	MOV DPTR,#Preparando
	ACALL escreveString
	MOV A,#43H
	ACALL posicionaCursor
	MOV DPTR,#Aguarde
	ACALL escreveString
	ACALL clearDisplay

	;Pedido pronto
	ACALL lcd_init
	MOV A,#03H
	ACALL posicionaCursor 
	MOV DPTR,#cafePreto
	ACALL escreveString
	MOV A,#43H
	ACALL posicionaCursor
	MOV DPTR,#Pronto
	ACALL escreveString
	ACALL clearDisplay

	;Volte sempre	
	ACALL lcd_init
	MOV A,#03H
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre
	ACALL escreveString
	ACALL clearDisplay

naoCafe1: 
	CJNE A,#'2',naoCafe2 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP2
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeComLeite 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

naoCafe2: 
	CJNE A,#'3',naoCafe3 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP3
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeExpresso
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

naoCafe3: 
	CJNE A,#'4',naoCafe4 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP4
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeGelado
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

naoCafe4: 
	CJNE A,#'5',naoCafe5 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP5
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeCapuccino
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

naoCafe5: 
	CJNE A,#'6',naoCafe6 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP6
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeLatte
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

naoCafe6: 
	CJNE A,#'7',desconhecido
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#OP7
	ACALL escreveString 
	ACALL clearDisplay
 
	;Preparando
	ACALL lcd_init
 	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#Preparando 
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Aguarde 
	ACALL escreveString 
	ACALL clearDisplay 
	
	;Pedido pronto 
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#cafeLatte
	ACALL escreveString 
	MOV A,#43H 
	ACALL posicionaCursor 
	MOV DPTR,#Pronto 
	ACALL escreveString 
	ACALL clearDisplay 

	;Volte sempre
	ACALL lcd_init 
	MOV A,#03H 
	ACALL posicionaCursor 
	MOV DPTR,#volteSempre 
	ACALL escreveString 
	ACALL clearDisplay 

;Funcao para quando nao tiver certeza retornar para o começo
leituraTeclado:
	MOV R0, #0			; clear R0 - the first key is key0

	; scan row0
	MOV P0, #0FFh	
	CLR P0.0			; clear row0
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row1
	SETB P0.0			; set row0
	CLR P0.1			; clear row1
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row2
	SETB P0.1			; set row1
	CLR P0.2			; clear row2
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)
	; scan row3
	SETB P0.2			; set row2
	CLR P0.3			; clear row3
	CALL colScan		; call column-scan subroutine
	JB F0, finish		; | if F0 is set, jump to end of program 
						; | (because the pressed key was found and its number is in  R0)

desconhecido:
DB "		 Pd Desconhecido"
DB 0 ; Caracter null indica fim da String

finish:
	RET

; column-scan subroutine
colScan:
	JNB P0.4, gotKey	; if col0 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.5, gotKey	; if col1 is cleared - key found
	INC R0				; otherwise move to next key
	JNB P0.6, gotKey	; if col2 is cleared - key found
	INC R0				; otherwise move to next key
	RET					; return from subroutine - key not found
gotKey:
	SETB F0				; key found - set F0
	RET					; and return from subroutine




; initialise the display
; see instruction set for details
lcd_init:

	CLR RS		; clear RS - indicates that instructions are being sent to the module

; function set	
	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear	
					; function set sent for first time - tells module to go into 4-bit mode
; Why is function set high nibble sent twice? See 4-bit operation on pages 39 and 42 of HD44780.pdf.

	SETB EN		; |
	CLR EN		; | negative edge on E
					; same function set high nibble sent a second time

	SETB P1.7		; low nibble set (only P1.7 needed to be changed)

	SETB EN		; |
	CLR EN		; | negative edge on E
				; function set low nibble sent
	CALL delay		; wait for BF to clear


; entry mode set
; set to increment with no shift
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.6		; |
	SETB P1.5		; |low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear


; display on/off control
; the display is turned on, the cursor is turned on and blinking is turned on
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	SETB P1.7		; |
	SETB P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


sendCharacter:
	SETB RS  		; setb RS - indicates that data is being sent to module
	MOV C, ACC.7		; |
	MOV P1.7, C			; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET

;Posiciona o cursor na linha e coluna desejada.
;Escreva no Acumulador o valor de endere o da linha e coluna.
;|--------------------------------------------------------------------------------------|
;|linha 1 | 00 | 01 | 02 | 03 | 04 |05 | 06 | 07 | 08 | 09 |0A | 0B | 0C | 0D | 0E | 0F |
;|linha 2 | 40 | 41 | 42 | 43 | 44 |45 | 46 | 47 | 48 | 49 |4A | 4B | 4C | 4D | 4E | 4F |
;|--------------------------------------------------------------------------------------|
posicionaCursor:
	CLR RS	
	SETB P1.7		    ; |
	MOV C, ACC.6		; |
	MOV P1.6, C			; |
	MOV C, ACC.5		; |
	MOV P1.5, C			; |
	MOV C, ACC.4		; |
	MOV P1.4, C			; | high nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	MOV C, ACC.3		; |
	MOV P1.7, C			; |
	MOV C, ACC.2		; |
	MOV P1.6, C			; |
	MOV C, ACC.1		; |
	MOV P1.5, C			; |
	MOV C, ACC.0		; |
	MOV P1.4, C			; | low nibble set

	SETB EN			; |
	CLR EN			; | negative edge on E

	CALL delay			; wait for BF to clear
	CALL delay			; wait for BF to clear
	RET


;Retorna o cursor para primeira posi  o sem limpar o display
retornaCursor:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	SETB P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


;Limpa o display
clearDisplay:
	CLR RS	
	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	CLR P1.4		; | high nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CLR P1.7		; |
	CLR P1.6		; |
	CLR P1.5		; |
	SETB P1.4		; | low nibble set

	SETB EN		; |
	CLR EN		; | negative edge on E

	CALL delay		; wait for BF to clear
	RET


delay:
	MOV R7, #50
	DJNZ R7, $
	RET


esperar_10_segundos:
    MOV R1, #TIMEOUT_COUNT

wait_loop:
    ACALL delay       ; Aguarda 50ms
    DJNZ R1, wait_loop
    RET

MSG:
DB "Cup Coffe"
DB 0 ; caracter null indica fim da String
Display:
DB "BEM-VINDO"
DB 0 ; caracter null indica fim da String

	
escreveString:
MOV R2, #0
rot:
MOV A, R2
MOVC A,@A+DPTR ; lê a tabela da memória de programa
ACALL sendCharacter ; send data in A to LCD module
INC R2
JNZ rot ; if A is 0, then end of data has been reached - jump out of loop
RET

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

