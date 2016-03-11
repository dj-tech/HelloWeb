FROM phusion/passenger-ruby22:0.9.18

# Set correct environment variables.
ENV HOME /root
VOLUME /data
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Enable nginx + passenger
RUN rm -f /etc/service/nginx/down


# Get PInW
USER app
WORKDIR /home/app
RUN git clone https://github.com/AlgoLab/pinw
COPY post-merge.hook /home/app/pinw/.git/hooks/post-merge
RUN mkdir data
VOLUME /home/app/data
WORKDIR /home/app/pinw
ENV RACK_ENV production

USER root
RUN bundle install

USER app
RUN rake db:setup

# New crontab:
USER root
COPY crontab /etc/crontab

# Pinw cron jobs:
USER app
RUN whenever -w

# Add configuration to nginx:
USER root
RUN rm /etc/nginx/sites-enabled/default
COPY nginx-pinw.conf /etc/nginx/sites-enabled/pinw.conf


RUN apt-get clean
COPY init-ssh.sh /etc/my_init.d/init-ssh.sh

EXPOSE 80
