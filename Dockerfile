FROM python:2.7-stretch

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /app
ENV DJANGO_SETTINGS_MODULE readthedocs.settings.local
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV VIRTUAL_ENV /venv
ENV PATH /venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get -qq update && \
    apt-get -y -qq upgrade && \
    apt-get install -y -qq \
        locales unzip && \
    apt-get clean

# Set locale to UTF-8
RUN locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8
RUN echo 'LANGUAGE="en_US.UTF-8"' >> /etc/default/locale && \
    echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale
RUN update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Setting up virtualenv
RUN virtualenv /venv

# Add user py
RUN adduser --gecos 'py' --disabled-password py

#RUN mkdir -p $APPDIR 
#ADD ./files/readthedocs.org-master.zip /tmp/readthedocs.org-master.zip
RUN mkdir -p $APPDIR && cd /tmp && \
    wget -q --no-check-certificate https://github.com/rtfd/readthedocs.org/archive/master.zip 

RUN pip install --upgrade pip

COPY ./files/local_settings.py $APPDIR/readthedocs/settings/local.py
    
ADD config /

RUN /bin/rtd-install.sh

# Docker config
EXPOSE 8000
VOLUME ["/app"]
CMD ["/bin/rtd-start.sh"]
