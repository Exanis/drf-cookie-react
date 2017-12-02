FROM node:9.2.0
MAINTAINER {{ cookiecutter.author_name }} <{{ cookiecutter.email }}>

ENV NPM_CONFIG_LOGLEVEL info
ENV CI 1

RUN mkdir -p /usr/src/frontend/src
WORKDIR /usr/src/frontend/src

CMD npm i . && npm test -- --coverage