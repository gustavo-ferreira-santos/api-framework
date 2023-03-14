## Sobre o projeto

O projeto foi construído utilizando as seguintes tecnologias:

- Ruby, na versão: 2.7.0;
- Rspec
- HTTParty

## Configurações iniciais do projeto

- Para execução local é necessário instalar previamente o Ruby;

- Após clonar o projeto, acessar o mesmo via terminal e instalar as dependências do mesmo via linha de comando, basta digitar 'bundle install'.

## Executando os testes

rspec                          # executar todos os testes
rspec -t @tag                  # executa o cenário com a tag especificada.

## Relatório de teste

Para gerar o relatório do teste basta utilizar o comando do próprio rspec:
rspec --format html
