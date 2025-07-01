# Projeto Android - PetCare App com MySQL

- Este é um aplicativo Android desenvolvido no Android Studio que se conecta a um banco de dados MySQL para gerenciar informações de usuários e seus pets. A comunicação com o banco é feita utilizando Java, e a autenticação é gerenciada com Firebase.



## Boas Práticas nos Códigos

### Principais benefícios

- Clareza e legibilidade: Nomes de variáveis e funções bem escolhidos, endentação correta e comentários relevantes tornam o código fácil de entender.
- Manutenção facilitada: Um código bem estruturado facilita correções de bugs, adição de novas funcionalidades e refatorações.
- Reutilização: Funções e componentes bem projetados podem ser reaproveitados em outros trechos ou projetos.
- Trabalho em equipe: Em equipes de desenvolvimento, um código limpo e padronizado melhora a colaboração e evita conflitos.
- Redução de erros: Boas práticas incluem validações, tratamento de exceções e testes — o que diminui falhas e comportamentos inesperados.
- Escalabilidade: Sistemas bem construídos com boas práticas são mais fáceis de escalar e adaptar a novos requisitos.



## Tecnologias Utilizadas

### Aplicativo Android
- Java
- Android Studio
- Firebase Authentication

### Backend
- MySQL



## Funcionalidades

- Cadastro e login de usuários
- Visualização e edição de perfil do usuário
- Cadastro e gerenciamento de pets
- Cartão de vacinação digital para os pets
- Cadastro e visualização de campanhas de saúde animal
- Cadastro e visualização de doenças
- Sistema de mensagens entre usuários
- Localização e busca de clínicas veterinárias próximas
- Inserção, edição e exclusão de dados via aplicativo
- Conexão segura utilizando Firebase



## Pré-requisitos

### Antes de começar, certifique-se de que tem os seguintes softwares instalados:

- [Android Studio](https://developer.android.com/studio)
- Servidor local com suporte a MySQL (ex: XAMPP ou WAMP)
- MySQL configurado e rodando



## Como Rodar o Projeto

### Backend (MySQL)

1. Importe o banco de dados:
   - Abra seu gerenciador MySQL
   - Importe o arquivo `SCRIPT_projetoPetCare.sql`.

2. Configure a conexão com o banco no arquivo `ConexaoMysql.java`:
### java
- String host = "localhost";
- String user = "rootPetCare";
- String password = "123";
- String dbname = "projeto_pet_care";



## Melhorias no código

- Código revisado para evitar erros futuros e facilitar a manutenção
- Design da interface padronizado, proporcionando uma melhor experiência para o usuário



## Aprendizado do grupo

- Nosso grupo compreendeu a importância de manter um código limpo, legível e bem estruturado, seguindo padrões de boas práticas de desenvolvimento
- Aprendemos a trabalhar em equipe, organizando responsabilidades e padronizando a comunicação entre as partes do sistema



## Projeto desenvolvido em 2025

### Curso Técnico em Desenvolvimento de Sistemas — Senac Taguatinga

- Desenvolvedor: Matheus Oliveira Cavalcante
- Desenvolvedor: Elisabete Oliveira da Cruz
- Desenvolvedor: Luizandro de Aquino Gomes
- Desenvolvedor: Emilly Kayla Pereira de Sousa
- Desenvolvedor: Eliezer Barbosa Freitas
- Desenvolvedor: Esmailton Guerra Freitas
