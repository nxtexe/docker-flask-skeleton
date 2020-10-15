FROM python:latest

RUN pip3 install gunicorn flask

COPY ./src /opt/source-code

VOLUME /opt/source-code/sockets/

CMD ["gunicorn", "--workers", "3", "--bind", "unix:/opt/source-code/sockets/app.sock", "-m", "007", "opt.source-code.app:app"]
