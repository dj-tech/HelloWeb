FROM phusion/passenger-ruby22:0.9.18

# Set correct environment variables.
ENV HOME /root
VOLUME /pinw
VOLUME /data
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Enable nginx + passenger
RUN rm -f /etc/service/nginx/down


# Get and configure Pinw
USER app
WORKDIR /home/app
RUN git clone https://github.com/AlgoLab/pinw
WORKDIR /home/app/pinw

USER root
RUN bundle install
USER app
RUN rake db:setup

# Set Development environment
ENV RACK_ENV development



# Pinw cron jobs:
USER app
RUN whenever -w


# Add configuration to nginx:
USER root
RUN rm /etc/nginx/sites-enabled/default
COPY nginx-pinw.conf /etc/nginx/sites-enabled/pinw.conf


RUN apt-get clean
COPY init-ssh.sh /etc/my_init.d/init-ssh.sh


# Pinw project from github not anymore necessary
# In development we bind the host directory with container directory
WORKDIR /home/app/pinw
RUN rm -r *

WORKDIR /pinw

EXPOSE 80
