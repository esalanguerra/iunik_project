# Etapa 1: Configuração do PostgreSQL
FROM postgres:12 AS db

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=x4n7ry4x7r734nr743hr4743h
ENV POSTGRES_DB=produto

COPY ./db/project.sql /docker-entrypoint-initdb.d/

# Etapa 2: Configuração do Node.js
FROM node:16 AS app

WORKDIR /app

# Definindo variáveis de ambiente
ENV PORT=${PORT}
ENV DB_HOST='localhost'
ENV DB_USER='postgres'
ENV DB_PASS='x4n7ry4x7r734nr743hr4743h'
ENV DB_NAME='produto'
ENV JWT_PASS='senhaFluxo'
ENV FROM_MAIL='rafaelsales202205@gmail.com'
ENV MAIL_HOST='http://smtp.gmail.com'
ENV MAIL_PORT=465
ENV MAIL_USER='2017infor45@gmail.com'
ENV MAIL_PASS='aihx fcsu hpzk julv'
ENV ACCESS_TOKEN='TEST-3426154305753593-060916-a6684228339f359e7fa4339e3ed25845-608954520'

COPY package.json package-lock.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "src/index.js"]
