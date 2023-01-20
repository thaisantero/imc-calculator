# IMC - Calculator

## :eyes: Visão Geral

Este projeto foi desenvolvido com o intuito de seguir o escopo descrito no teste da
empresa Dental Office.

Esta aplicação tem finalidade de retornar via api um JSON com o valor do IMC, sua
classificação e nível de obesidade. Para isso deve receber uma requisição HTTP
POST no endpoint '/imc' com o valor dos parâmetros de altura e peso e um token
JWT válido para autorização no header da requisição.

Como não foi requerido no escopo do projeto o login para criar o JWT token, não
foi possível realmente decodificar o código JWT enviado e verificar se corresponde
ao token do usuário correspondente.

Com isso, simulei a autenticação do JWT Token criando uma classe Ruby pura
`JsonWebToken` onde verificava se o código enviado no header correspondia
ao token de validação denominado 'valid_token'.

Esta aplicacao foi desenvolvida com uma cobertura de testes de 100%. A imagem
a seguir apresenta o resultado da análise de cobertura de testes realizado pela
gem simplecov.

![alt text](https://github.com/thaisantero/imc-calculator/blob/main/coverage/result/Screenshot%20from%202023-01-20%2015-18-00.png)

## :dog: Dependências

As configurações necessárias para executar a aplicação sem utilizar Docker sao:

```sh
ruby: "~> 3.1.2"
rails: "~> 7.0.4"
```

## :whale: Instalação

Primeiro, clone o repositório:

```sh
$ git clone git@github.com:thaisantero/imc-calculator.git
```
Se desejar utilizar o Docker para executar a aplicação siga
as seguintes etapas:

1) Faça download do Docker Desktop, caso não o tenha instalado em seu computador,
a partir do link:

[https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

2) Execute o docker compose, que sobe o container da
aplicação e executa o servidor, utilizando o comando:

```sh
$ docker compose up
```

Se preferir não utilizar o Docker terá que seguir as etapas:

1) Instalar as gems em seu computador executando o comando:

```sh
$ bundle install
```

2) Executar o servidor por meio do comando:

```sh
$ rails server
```

## :robot: Uso

Esta aplicação possui um endpoint POST '/imc' o qual
foi desenvolvido para receber um JSON via API com
dois parâmetros ('height' e 'weight') e com o header
com um JWT token para autorização.
A partir disso, retorna um JSON com três parâmetros:
'imc', 'classification' e 'obesity'.

A seguir é explicado como o JSON deve ser enviado, quais os
status HTTP possíveis e qual o formato e os parâmetros do JSON 
de resposta da requisição.

### API de Cálculo do IMC

Para obter o IMC, sua classificação e nível de obesidade deve ser feita
uma requisição com o verbo `POST` na seguinte URL:

`https://localhost:3000/api/v1/imc`


#### Status de resposta possíveis

Status `200` | A requisição foi bem sucedida.

Status `400` | Os valores dos parâmetros `height` ou `weight` são inválidos.

Status `401` | JWT Token enviado é inválido.

#### Dados

Para fazer uma requisição de POST com sucesso é necessário enviar os dados no seguinte formato:

```json
{
"height": 1.70,
"weight": 76
}
```
Com o header no formato do exemplo a seguir:

`headers: {"Authorization": "Bearer valid_token"}`

Caso a requisição seja um sucesso, será retornado um JSON com os parâmetros obtidos
e o status http `200`, de acordo com o exemplo:

```json
{
"imc": 26.3,
"classification": "Sobrepeso",
"obesity": "I"
}
```

Caso a requisição envie parâmetros inválidos, será retornada uma mensagem de erro em formato JSON 
e o status http `400`:

```json
{
"errors": "mensagens de erros de validação"
}
```

Se a requisição enviar um token JWT inválido, será retornada uma mensagem de erro em formato JSON 
e o status http `401`:

```json
{
"errors": "Token inválido"
}
```

## Swagger

Para simular o uso da aplicação foi criado o endpoint `api-docs/index.html` utilizando a 
gem 'swagger' que permite realizar requisições http POST e visualizar as respostas por meio
do acesso à URL:

`http://localhost:3000/api-docs/index.html`

## :red_circle: Pontos a melhorar

Como não foi colocado como prioridade no escopo do projeto e, também,
pelo tempo reduzido para desenvolver a aplicação, não desenvolvi a rota
para login.

Com isso, uma feature interessante para evolução da aplicação no futuro
seria a implantação de um endpoint para login que retornaria o JWT Token
referente ao usuário e os dados do usuário seriam salvos no banco de dados.

Para que, assim, realmente seja realizada a autenticação do JWT Token
na rota `POST '/imc'`.
