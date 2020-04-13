#FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
#CMD [ "python", "-c", "print('Hello 9')" ]


FROM python:3

RUN pip3 install --user -r requirements.txt

ADD bad /


CMD [ "python", "/bad/vulpy.py" ]
