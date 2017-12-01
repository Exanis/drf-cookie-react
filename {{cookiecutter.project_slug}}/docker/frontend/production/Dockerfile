FROM node:9.2.0
MAINTAINER {{ cookiecutter.author_name }} <{{ cookiecutter.email }}>

ENV NPM_CONFIG_LOGLEVEL info

RUN npm install -g serve

EXPOSE 3000

RUN mkdir -p /var/src/frontend/
WORKDIR /var/src/frontend/
COPY src/ ./

RUN npm i .

RUN npm run build
RUN mv build ../

WORKDIR /var/src/
RUN rm -rf frontend

CMD serve -s build -p 3000