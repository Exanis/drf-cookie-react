FROM nginx:1.13.7
MAINTAINER {{ cookiecutter.author_name }} <{{ cookiecutter.email }}>
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/health || exit 1

RUN mkdir -p /var/www/ /var/static/ /var/media/

COPY src/conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD nginx -g 'daemon off;'