# Maquina de Café

Esse projeto se trata de uma Máquina de Café programado na linguagem Assembly no microcontrolador 8051, que visa simular as funcionalidades de uma cafeteira convencional, oferecendo diversas opções para o usuário.

Dentro da cafeteira é possível de se fazer 7 (sete) tipos de pedidos sendo eles
1. Café preto
2. Café com leite
3. Café expresso
4. Café gelado
5. Capuccino
6. Latte
7. Mocha

O programa pega o que foi digitado na Keypad e armazena no registrador, fazendo uma comparação com o que está salvo na memória, e depois do valor do registrador ser passado para o A ele compara os valores e verifica se é igual a alguma das opções, caso não seja, ele retorna desconhecido e o programa deverá ser reiniciado

![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/cf68528e-dea7-4542-9701-fd13125ce953)


## Como Ultilizar o Programa

Para utilizarmos o programa precisaremos de um executável em java chamado de EdSim51 que vai rodar o código que está na main.asm, para a instalação do executável, apenas seguir o passos do seguinte vídeo (https://youtu.be/-5E_wcdMYfI?si=IEMMBxcb-IC1k79L)

Depois de descompactar a pasta que estará em formato ZIP, basta rodar o executável


![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/edf64322-f050-4e1f-a725-f563357e4f94)

Feito isso, basta apenas mudar a frequência de atualização para 1000 no canto superior esquerdo, apertar ASM e depois em RUN

![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/8cf14d8b-9c4a-4c36-9c66-509c85278c29)
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/ef9bac14-0694-4232-9188-50fc417af34b)

## Fluoxograma do Projeto
![Diagrama sem nome drawio](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/42fcadba-5c2e-4409-83f2-8b8f93a73cd3)

## Simulações
<a style="font-weight: bold">Display da mensagem inicial <a>
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/5e46f0c8-61ed-49bc-b7d0-452eb8156817)

<a style="font-weight: bold">Opções<a>
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/604f4eb1-a0d7-4b74-9a93-20bc709f68f4)

<a style="font-weight: bold">Preparando<a>
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/fcc30001-3f17-4093-b290-f140dd877b2e)

<a style="font-weight: bold">Pedido Pronto<a>
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/a85a0bcd-cc30-4310-88c7-e912b71b2644)

<a style="font-weight: bold">Volte Sempre<a>
<br>
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/9dbd0881-c3b6-4987-9d15-ae37e9f3e6ee)


## Código do programa comentadado

### Start:

![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/55ef6a2e-69a9-4de9-9119-9995a1eb6d3a)

### Main:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/69df6c9f-b60f-46d7-af15-6899fa95e0df)

<br>

![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/1b71acec-c1dc-41e2-9032-dbe6a11ab70b)

### Rotina:

![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/c4821e50-3dea-4178-b28f-0e6261f7e520)

### naoCafe1:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/e64cc62d-3f7b-443f-9a05-4b67c9931f13)


### naoCafe2:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/89707c86-7948-44e4-9b03-7d1a333b0c29)


### naoCafe3:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/b0aa39ca-f789-4537-a83c-880ad9847645)


### naoCafe4:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/35895bcf-1206-4296-83ff-a9b40df4b0e0)


### naoCafe5:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/3cfd6ba0-3c7b-4620-90aa-b520e36e1ef0)


### naoCafe6:
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/8f3e3902-5214-4c6c-a623-a00804291e4b)


### leituraTeclado
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/70aaf926-c610-43fb-ab1f-18dca5f7d331)

### desconhecido
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/ea3ac88e-09e5-47b0-9a8a-a1126b89eb41)

### finish, colScan, gotKey
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/c80448d9-5e6f-48b6-8e15-dbcfb55178de)

### lcd_init
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/d7540989-696c-4add-90e6-947c440384bb)
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/6bda5a42-88e2-4b88-91fb-ad95b5b23d99)


### sendCharacter
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/6544440f-5d29-45bf-9d14-0264fd3031a6)

### posicionaCursor
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/e52265bf-dab1-4bb0-8b90-b5ffdf105c6f)

### retornaCursor
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/cd041c56-2cff-458b-b5ac-4c344c4e5d90)

### clearDisplay e delay
![image](https://github.com/gbalbuquerque/MaquinaCafe/assets/115583227/b0521147-0b33-4f8d-af09-936c2241bf22)

### O restante do código tratam-se apenas de Strings

## Considerações finais

Ao concluirmos este projeto de desenvolvimento de uma cafeteira em Assembly, é gratificante olhar para trás e contemplar todo o progresso alcançado. Desde a concepção inicial até a implementação final, cada linha de código representou um desafio superado e uma oportunidade de aprendizado.

Durante este percurso, mergulhei profundamente no mundo da programação de baixo nível, explorando os intricados detalhes da linguagem Assembly. Cada instrução, cada registro e cada fluxo de controle foram cuidadosamente planejados e executados para criar uma cafeteira funcional e eficiente.

À medida que nos despedimos deste projeto, é importante expressar nossa gratidão àqueles que nos apoiaram ao longo do caminho. Em especial, gostaria de estender nossos sinceros agradecimentos ao Professor Isaac por nos desafiar a explorar novos horizontes e por nos orientar com sabedoria durante todo o processo.

Seu incentivo e orientação foram fundamentais para transformar este projeto em uma experiência enriquecedora e memorável. Estamos profundamente gratos pela oportunidade de aprender e crescer sob sua supervisão.

A todos os envolvidos, nosso muito obrigado.

Atenciosamente, Guilherme



