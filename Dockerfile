# Dockerfile para o Frontend (Flutter + Nginx)

# Estágio 1: Build do App Flutter Web
FROM dart:stable AS build

WORKDIR /app

# Copia os arquivos de dependências e baixa os pacotes
COPY pubspec.yaml ./
COPY pubspec.lock ./
RUN dart pub get

# Copia todo o código fonte do app
COPY . .

# Compila a aplicação para a web
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile exe web/index.html -o web/index.exe


# Estágio 2: Configuração do Servidor Nginx
FROM nginx:stable-alpine

# Copia os arquivos de build do estágio anterior para a pasta web do Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Copia o arquivo de configuração customizado do Nginx
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expõe a porta 80
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]
