;DefiniÃ§Ã£o de constantes
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
    MOV DPTR,#MSG     ; DPTR = inÃ­cio da palavra FEI
    ACALL escreveString
    MOV A, #43H
    ACALL posicionaCursor
    MOV DPTR,#Display ; DPTR = inÃ­cio da palavra Display
    ACALL escreveString
    ACALL esperar_10_segundos     
    ACALL clearDisplay
	MOV A, #03H
    ACALL posicionaCursor
    MOV DPTR, #OpcoesCafe1 ; DPTR = inÃ­cio das opÃ§Ãµes de cafÃ©
	ACALL escreveString
 	ACALL esperar_10_segundos     
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe2
	ACALL escreveString
	ACALL esperar_10_segundos     
	ACALL posicionaCursor
	MOV DPTR, #OpcoesCafe3
	ACALL escreveString
	ACALL esperar_10_segundos
	ACALL clearDisplay	
	ACALL esperar_10_segundos
		
ROTINA:
	
	ACALL leituraTeclado
	JNB F0, ROTINA   ;if F0 is clear, jump to ROTINA
	ACALL verificaPedido
	MOV A, #07h
	ACALL posicionaCursor	
	MOV A, #40h
	ADD A, R0
	MOV R0, A
	MOV A, @R0        
	ACALL sendCharacter
	CLR F0
	JMP $




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

OpcoesCafe1:
DB "      1.Cafe preto"
DB 0; caracter null indica fim da String

OpcoesCafe2:
DB "2.Cafe com leite"
DB 0; caracter null indica fim da String

OpcoesCafe3:
DB "3.Cafe expresso"
DB 0 ; Caracter null indica fim da String

; Função para comparar o pedido digitado com o que está escrito no LCD
; Função para lidar com o pedido com base no número digitado

verificaPedido:
    MOV A, R0 ; Move o número do pedido para o acumulador para verificar qual foi pressionado
    ACALL clearDisplay ; Limpa o LCD
    ACALL posicionaCursor ; Posiciona o cursor no LCD
    MOV DPTR, #MensagemPedido1 ; Carrega o endereço da mensagem "preparando pedido 1" no DPTR
    ACALL escreveString ; Escreve a mensagem "preparando pedido 1" no LCD
	 ACALL esperar_10_segundos ; Aguarda 10 segundos
    ACALL clearDisplay ; limpa o display
	ACALL posicionaCursor ; Posiciona o cursor no LCD 	
    MOV DPTR, #MensagemCafePreto ; Carrega o endereço da mensagem "cafe preto pronto" no DPTR
	ACALL escreveString ; Escreve a mensagem "cafe preto pronto" no LCD
    ACALL esperar_10_segundos ; Aguarda 10 segundos
    ACALL clearDisplay ; Limpa o LCD
    SJMP fim_verificaPedido ; Pula para o final da função
	

fim_verificaPedido:
    ACALL esperar_10_segundos
    ACALL main
    RET ; Retorna ao ponto de chamada

MensagemPedido1:
DB "     Preparando..."
DB 0 ; Caractere nulo indicando o fim da string

MensagemCafePreto:
DB "      N°1 Pronto!"
DB 0 ; Caractere nulo indicando o fim da string
	
	
escreveString:
MOV R2, #0
rot:
MOV A, R2
MOVC A,@A+DPTR ; lÃª a tabela da memÃ³ria de programa
ACALL sendCharacter ; send data in A to LCD module
INC R2
JNZ rot ; if A is 0, then end of data has been reached - jump out of loop
RET
