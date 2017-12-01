FROM node:9.2.0
MAINTAINER {{ cookiecutter.author_name }} <{{ cookiecutter.email }}>

ENV NPM_CONFIG_LOGLEVEL info

RUN mkdir -p /var/src/frontend/
WORKDIR /var/src/frontend/

EXPOSE 3000

CMD npm i . && npm start