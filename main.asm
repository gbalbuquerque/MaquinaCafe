ORG 0x0000 

;VARIAVEIS DO LCD
LCD_DATA equ P2   
LCD_CTRL equ P3  
RS equ P3.0      
EN equ P3.1       

;STRINGS DE MENSAGEM
MSG_BV:   
	 DB "Bem-vindo à Máquina de Café!", 0
MSG_PROMPT: 
  	 DB "Insira moedas para escolher o tipo de café:", 0
MSG_OPCOES:    
	  DB "1 - Café Expresso   2 - Café Americano", 0

;INICIALIZACAO
INIT:
    MOV A, #38H   
    ACALL COMMAND_LCD  
    MOV A, #0CH     
    ACALL COMMAND_LCD   
    MOV A, #01H    
    ACALL COMMAND_LCD

  
    MOV DPTR, #MSG_BV:  
    ACALL MOSTRAR_MSG  
  
    MOV DPTR, #MSG_PROMPT:  
    ACALL MOSTRAR_MSG 

    MOV DPTR, #MSG_OPCOES: 
    ACALL MOSTRAR_MSG 

;SUBROTINA PARA COMANDO NO LCD
LCD_COMANDO:
    MOV RS, #0      
    MOV LCD_DATA, A    
    SETB EN         
    CLR EN          
    RET
;MOSTRAR MENSAGEM NO LCD
MOSTRAR_MSG:
;ESCREVER
    RET
