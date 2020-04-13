FROM python:3-alpine
#FROM python:2.7.16-alpine3.9
CMD [ "python", "-c", "print('Hello World!')" ]


FROM python:3
ADD malware.py /
ADD requirements.txt /
RUN pip3 install --user -r requirements.txt
CMD [ "python", "/malware.py" ]
