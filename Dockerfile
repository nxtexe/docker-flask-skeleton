FROM ubuntu

RUN apt-get update
RUN apt-get install -y nginx

CMD ["ufw", "allow", "'Nginx HTTP'"]

RUN apt-get -y install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

RUN pip3 install wheel
RUN pip3 install gunicorn flask

COPY ./app.service /etc/systemd/system

# CMD ["systemctl", "start", "/etc/systemd/system/app.service"]
# CMD ["systemctl", "enable", "/etc/systemd/system/app.service"]
# CMD ["systemctl", "status", "/etc/systemd/system/app.service"]

COPY ./app /etc/nginx/sites-available

CMD ["ln", "-s", "/etc/nginx/sites-available/app", "/etc/nginx/sites-enabled"]

CMD ["ufw", "allow", "'Nginx FULL'"]

COPY ./src /opt/source-code

EXPOSE 80

CMD ["/etc/init.d/nginx", "start"]
CMD ["gunicorn", "--workers", "3", "--bind", "unix:myproject.sock", "-m", "007", "wsgi:app"]
