# docker build -t corona-nginx-html-server:v1 .
# To run container => use ports higher than 1024 if non-root user 
# docker run -d -p 8080:8080 corona-nginx-html-server:v1 nginx
# NOTE: add all files to .gitignore except for /dist + conf files. etc.....
FROM ubuntu:19.04
LABEL Juliette Tworsey
RUN apt-get update
RUN apt-get -y -q install nginx

WORKDIR /var/www/html

COPY . /var/www/html

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log


COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080

# TODO: figure out how to run as non-root user
#USER www-data