FROM ubuntu:latest

# Maintainer: ygidtu <ygidtu@gmail.com>

# System configuration
RUN chmod a+w /opt

ENV SMRT_DOMAIN="smrtlinkhost.mydomain.com"
ENV SMRT_HOST="0.0.0.0"
ENV SMRT_USER=smrtanalysis
ENV SMRT_ROOT=/home/$SMRT_USER/smrtlink


RUN useradd -ms /bin/bash $SMRT_USER

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y unzip rsync locales curl net-tools

# Prepare locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

# switch user to install smrtlink
USER $SMRT_USER

WORKDIR /home/$SMRT_USER

COPY smrtlink_8.0.zip ./
RUN unzip smrtlink_8.0.zip

RUN ulimit -n 8192
RUN ./smrtlink_8.0.*.run --install --rootdir $SMRT_ROOT --batch --skip-system-check --smrtlink-dnsname 0.0.0.0 --smrtlink-mail-host 0.0.0.0

RUN rm smrtlink_8.0.zip smrtlink_8.0.*.run

COPY main.py ./

ENTRYPOINT ["/home/smrtanalysis/smrtlink/smrtcmds/bin/python3", "main.py"]
