; Definição de constantes
DELAY_COUNT equ 50   ; Valor para o atraso
TIMEOUT_COUNT equ 200  ; Contagem para 10 segundos (200 * 50ms)

; Definição de pinos
RS      equ P1.3     ; Reg Select ligado em P1.3
EN      equ P1.2     ; Enable ligado em P1.2

main:
    ACALL lcd_init
    MOV A, #03h
    ACALL posicionaCursor
    MOV DPTR,#MSG     ; DPTR = início da palavra FEI
    ACALL escreveString
    MOV A, #43h
    ACALL posicionaCursor
    MOV DPTR,#Display ; DPTR = início da palavra Display
    ACALL escreveString
	  ACALL esperar_10_segundos
		ACALL clearDisplay
		MOV DPTR, #OpcoesCafe ; DPTR = início das opções de café
    ACALL escreveString
    JMP $

lcd_init:
    CLR RS           ; clear RS - indicates that instructions are being sent to the module

    ; Function set
    CLR P1.7         ; |
    CLR P1.6         ; |
    SETB P1.5        ; |
    CLR P1.4         ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear

    ; Function set high nibble sent for first time - tells module to go into 4-bit mode
    SETB EN          ; |
    CLR EN           ; | negative edge on E

    ; Same function set high nibble sent a second time
    SETB P1.7        ; low nibble set (only P1.7 needed to be changed)

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear

    ; Entry mode set
    ; Set to increment with no shift
    CLR P1.7         ; |
    CLR P1.6         ; |
    CLR P1.5         ; |
    CLR P1.4         ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    SETB P1.6        ; |
    SETB P1.5        ; | low nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear

    ; Display on/off control
    ; The display is turned on, the cursor is turned on and blinking is turned on
    CLR P1.7         ; |
    CLR P1.6         ; |
    CLR P1.5         ; |
    CLR P1.4         ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    SETB P1.7        ; |
    SETB P1.6        ; |
    SETB P1.5        ; |
    SETB P1.4        ; | low nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear
    RET

sendCharacter:
    SETB RS          ; setb RS - indicates that data is being sent to module
    MOV C, ACC.7     ; |
    MOV P1.7, C      ; |
    MOV C, ACC.6     ; |
    MOV P1.6, C      ; |
    MOV C, ACC.5     ; |
    MOV P1.5, C      ; |
    MOV C, ACC.4     ; |
    MOV P1.4, C      ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    MOV C, ACC.3     ; |
    MOV P1.7, C      ; |
    MOV C, ACC.2     ; |
    MOV P1.6, C      ; |
    MOV C, ACC.1     ; |
    MOV P1.5, C      ; |
    MOV C, ACC.0     ; |
    MOV P1.4, C      ; | low nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear
    CALL delay       ; wait for BF to clear
    RET

; Posiciona o cursor na linha e coluna desejada.
; Escreva no Acumulador o valor de endereço da linha e coluna.
posicionaCursor:
    CLR RS
    SETB P1.7        ; |
    MOV C, ACC.6     ; |
    MOV P1.6, C      ; |
    MOV C, ACC.5     ; |
    MOV P1.5, C      ; |
    MOV C, ACC.4     ; |
    MOV P1.4, C      ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    MOV C, ACC.3     ; |
    MOV P1.7, C      ; |
    MOV C, ACC.2     ; |
    MOV P1.6, C      ; |
    MOV C, ACC.1     ; |
    MOV P1.5, C      ; |
    MOV C, ACC.0     ; |
    MOV P1.4, C      ; | low nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CALL delay       ; wait for BF to clear
    CALL delay       ; wait for BF to clear
    RET

; Limpa o display
clearDisplay:
    CLR RS
    CLR P1.7         ; |
    CLR P1.6         ; |
    CLR P1.5         ; |
    CLR P1.4         ; | high nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    CLR P1.7         ; |
    CLR P1.6         ; |
    CLR P1.5         ; |
    SETB P1.4        ; | low nibble set

    SETB EN          ; |
    CLR EN           ; | negative edge on E

    MOV R6, #40
rotC:
    CALL delay       ; wait for BF to clear
    DJNZ R6, rotC
    RET

delay:
    MOV R0, #DELAY_COUNT
    DJNZ R0, $
    RET

esperar_10_segundos:
    MOV R1, #TIMEOUT_COUNT
wait_loop:
    ACALL delay       ; Aguarda 50ms
    DJNZ R1, wait_loop
    RET

; Escrevendo na memória de programa
MSG:
DB "Cup Coffe"
DB 0 ; caracter null indica fim da String
Display:
DB "BEM-VINDO"
DB 0 ; caracter null indica fim da String

OpcoesCafe:
DB "1. Cafe preto   "
DB 0; caracter null indica fim da String
DB "2. Cafe com leite"
DB 0; caracter null indica fim da String
DB "3. Cafe expresso"
DB 0 ; Caracter null indica fim da String
escreveString:
MOV R2, #0
rot:
MOV A, R2
MOVC A,@A+DPTR ; lê a tabela da memória de programa
ACALL sendCharacter ; send data in A to LCD module
INC R2
JNZ rot ; if A is 0, then end of data has been reached - jump out of loop
RET
