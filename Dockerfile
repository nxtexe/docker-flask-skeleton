FROM ubuntu

RUN apt-get update

RUN apt-get -y install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

RUN pip3 install wheel
RUN pip3 install gunicorn flask

VOLUME /opt/source-code/

CMD ["gunicorn", "--workers", "3", "--bind", "unix:/opt/source-code/app.sock", "-m", "007", "opt/source-code/app:app"]
