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





