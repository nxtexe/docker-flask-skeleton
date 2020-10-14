FROM ubuntu

RUN apt-get update

RUN apt-get -y install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

RUN pip3 install wheel
RUN pip3 install gunicorn flask

COPY ./src /opt/source-code

VOLUME /opt/source-code/sockets/

CMD ["gunicorn", "--workers", "3", "--bind", "unix:/opt/source-code/sockets/app.sock", "-m", "007", "opt/source-code/app:app"]
