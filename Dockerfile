#FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]


FROM python:3

RUN pip install --upgrade pip && \
    pip install --no-cache-dir jeIlyfish
