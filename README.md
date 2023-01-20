# IMC - Calculator

## :eyes: Visao Geral

  Este projeto foi desenvolvido com o intuito de seguir o escopo descrito no teste da 
  empresa Dental Office.

  Esta aplicacao tem finalidade de retornar via api um JSON com o valor do IMC, sua 
  classificacao e nível de obesidade. Para isso deve receber uma requisicao HTTP
  POST no endpoint '/imc' com o valor dos parametros de altura e peso e um token
  JWT válido para autorizacao no header do JSON.

  Como nao foi requerido no escopo do projeto o login para criar o JWT token nao
  foi possível realmente decodar o código JWT enviado e verificar se corresponde
  ao token do usuário correspondente. 

  Com isso, simulei a autenticacao do JWT Token criando uma classe Ruby pura 
  `JsonWebToken` onde verificava se o código enviado no header correspondia
  ao token de validacao denominado 'valid_token'.

## :dog: Dependências

  As configuracoes necessárias para executar a aplicacao sem utilizar Docker sao:

  ```sh
  ruby: "~> 3.1.2"
  rails: "~> 7.0.4"
  ```

## :whale: Instalação

  Primeiro, clone o repositório:

  ```sh
  $ git clone git@github.com:thaisantero/imc-calculator.git
  ```
  Se deseja utilizar o Docker para executar a aplicacao siga
  as seguintes etapas:

  1) Caso nao possua o Docker Desktop instalado em seu computador faça 
  o download a partir do link:

  [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)

  2) Execute o docker compose, o qual sobe o container da
  aplicacao e executa o servidor sem precisar instalar 
  as dependencias, utilizando o comando:

  ```sh
  $ docker compose up
  ```

  Se preferir nao utilizar o Docker terá que instalar as gems em seu
  computador executanto o comando:

  ```sh
  $ bundle install
  ```

  Após isso, executar o servidor por meio do comando:

  ```sh
  $ rails server
  ```

## :robot: Uso

  Esta aplicacao possui um endpoint POST '/imc' o qual
  foi desenvolvido para receber um JSON via API com 
  dois parametros ('height' e 'weight') e com o header
  com um JWT token para autorizacao.
  A partir disso, retorna um JSON com tres parametros:
  'imc', 'classification' e 'obesity'.

  A seguir é explicado como o JSON deve ser enviado, quais os
  status HTTP possíveis e como é o JSON de resposta a requisicao.

## API de Cálculo do IMC

  Para obter o IMC, sua classificacao e nível de obesidade deve ser feita
  uma requisicao com o verbo `POST` na seguinte URL:

  `https://localhost:3000/api/v1/imc`


#### Status de resposta possíveis

  Status `200` | A requisição foi bem sucedida.

  Status `400` | Os valores dos parametros `height` ou `weight` sao inválidos.

  Status `401` | JWT Token enviado é inválido.

#### Dados

  Para fazer uma requisição de POST com sucesso é necessário enviar os dados no seguinte formato:

  ```json
  {
    "height": 1.70,
    "weight": 76
  }
  ```

  Caso a requisição seja um sucesso, com o status `200`, será retornado um JSON com os parametros obtidos,
  de acordo com o exemplo:

  ```json
  {
    "imc": 26.3,
    "classification": "Sobrepeso",
    "obesity": "I" 
  }

  headers: {"Authorization": "Bearer valid_token"}
  ```

  Caso a requisição envie parâmetros inválidos, retorna status `400` e será exibida uma mensagem de erro em formato JSON:

  ```json
  {
    "errors": "mensagens de erros de validação"
  }
  ```

  Se a requisição enviar um token JWT inválido, retorna status `401` e será exibida uma mensagem de erro em formato JSON:

  ```json
  {
    "errors": "Token inválido"
  }
  ```

## :red_circle: Pontos a melhorar

  Para efetivamente realizar a autenticacao utilizando um token JWT
  implementaria uma rota para login na aplciacao e salvaria no banco de dados
  as informacoes do usuário.
