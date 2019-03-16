FROM phusion/baseimage:0.11
MAINTAINER archedraft

# 

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Configure user nobody to match unRAID's settings
 RUN \
 usermod -u 99 nobody && \
 usermod -g 100 nobody && \
 usermod -d /config nobody && \
 chown -R nobody:users /home

RUN apt-get update &&  apt-get -y install net-tools python-numpy fluxbox xvfb x11vnc xdotool wget supervisor

run dpkg --add-architecture i386 && apt-get update && apt-get -y install wine32-development

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0
ENV X11VNC_FONT_BOLD 'Helvetica -16 bold'
ENV X11VNC_FONT_FIXED 'Courier -14'
ENV X11VNC_FONT_REG_SMALL 'Helvetica -12'

WORKDIR /root/
ADD novnc /root/novnc/

# Expose Port
EXPOSE 8080

CMD ["/usr/bin/supervisord"]
