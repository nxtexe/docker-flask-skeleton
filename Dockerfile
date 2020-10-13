FROM ubuntu

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y systemd

CMD ["ufw", "allow 'Nginx HTTP'"]

CMD ["systemctl", "status nginx"]

RUN apt-get update
RUN apt-get -y install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

RUN pip3 install wheel
RUN pip3 install gunicorn flask

COPY ./app.service /etc/systemd/system

CMD ["systemctl", "start app"]
CMD ["systemctl", "enable app"]
CMD ["systemctl", "status app"]

COPY ./app /etc/nginx/sites-available

CMD ["ln", "-s /etc/nginx/sites-available/app /etc/nginx/sites-enabled"]

CMD ["ufw", "allow 'Nginx FULL'"]

COPY ./src /opt/source-code

CMD ["systemctl", "restart nginx"]
