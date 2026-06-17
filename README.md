# App de Gerenciamento de Motoboys

Este é um projeto Flutter para um sistema de gerenciamento de motoboys e suas entregas (teles). O aplicativo foi desenvolvido para ser robusto, escalável e de fácil manutenção, utilizando uma arquitetura desacoplada e conteinerização com Docker.

---

## Stack de Tecnologias

- **Frontend:** Flutter
- **Linguagem:** Dart
- **Backend:** Quarkus (Java)
- **Banco de Dados:** PostgreSQL
- **Containerização:** Docker e Docker Compose
- **Servidor Web/Proxy Reverso:** Nginx
- **Injeção de Dependência:** `get_it` (Service Locator)
- **Gerenciamento de Estado:** `provider` e `ValueListenable`

---

## Pré-requisitos

Para rodar este projeto, você precisará ter o **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** instalado e em execução na sua máquina.

---

## Como Rodar o Projeto

Toda a aplicação (Frontend, Backend e Banco de Dados) é orquestrada através do Docker Compose.

**Nota Importante:** O arquivo `docker-compose.yml` e a configuração do ambiente Docker estão localizados na pasta do projeto **backend**.

1.  **Navegue até a pasta do projeto Backend** no seu terminal.
2.  Execute o seguinte comando para construir as imagens e iniciar os contêineres:

    ```sh
    docker-compose up --build
    ```
    - Use a flag `--build` na primeira vez ou sempre que fizer alterações no código do Flutter ou do Quarkus.
    - Para as próximas execuções, você pode usar apenas `docker-compose up`.

3.  **Acesse a Aplicação:** Após os contêineres serem iniciados com sucesso, abra seu navegador e acesse:
    
    **`http://localhost`**

O Nginx, rodando na porta 80, servirá a aplicação Flutter e redirecionará as chamadas de API (`/api/...`) para o serviço do Quarkus automaticamente.

Para parar todos os serviços, volte ao terminal onde o docker-compose está rodando e pressione `Ctrl + C`.

---

## Arquitetura e Estrutura de Pastas (Frontend)

O projeto Flutter segue uma arquitetura limpa e desacoplada, com as seguintes pastas principais dentro de `lib/`:

- **`locator.dart`**: Ponto de entrada do nosso Service Locator (`get_it`). É aqui que todos os serviços são registrados para injeção de dependência.
- **`model/`**: Contém as classes de modelo de dados da aplicação (ex: `Motoboy`, `User`).
- **`pages/`**: Contém as telas (widgets de página inteira) da aplicação.
  - **`forms/`**: Subpasta para os formulários de criação/edição.
- **`provider/`**: Contém os `ChangeNotifier`s usados para o gerenciamento de estado global (ex: `UserProvider`).
- **`router.dart`**: Centraliza toda a lógica de navegação. A classe `AppRouter` é responsável por gerar as rotas e injetar as dependências necessárias nas telas.
- **`services/`**: Contém as classes de serviço que lidam com a lógica de negócio e comunicação com a API (ex: `MotoboyService`, `TemaService`).
- **`widgets/`**: Contém widgets reutilizáveis usados em várias partes do aplicativo (ex: `CardNavegacao`, `MenuDrawer`).

Este projeto foi refatorado para garantir baixo acoplamento e alta coesão, facilitando a adição de novas funcionalidades e a manutenção do código existente.
