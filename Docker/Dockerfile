FROM docker:1.12
FROM wordpress:4.6
FROM owncloud:9.1.0
FROM phusion/passenger-ruby22:0.9.18

# Set correct environment variables.
ENV HOME /root
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Enable nginx + passenger
RUN rm -f /etc/service/nginx/down

# Get PInW
USER app
WORKDIR /home/app
RUN git clone https://github.com/AlgoLab/pinw
RUN mkdir data
WORKDIR /home/app/pinw
ENV RACK_ENV production

USER root
RUN bundle install

# New crontab:
USER root
COPY crontab /etc/crontab
COPY update-pinw.sh /usr/local/bin/update_pinw.sh
# Pinw cron jobs:
USER app
RUN whenever -w

# Add configuration to nginx:
USER root
RUN rm /etc/nginx/sites-enabled/default
COPY nginx-pinw.conf /etc/nginx/sites-enabled/pinw.conf

COPY init-ssh.sh /etc/my_init.d/init-ssh.sh

# Add Wordpress and Owncloud.
RUN docker run -d -p 80:80 owncloud:8.1
RUN docker run --name some-wordpress --link some-mysql:mysql -p 8080:80 -d wordpress

EXPOSE 80

COPY inituidgid.sh /usr/local/sbin
RUN  chmod u+x /usr/local/sbin/inituidgid.sh

