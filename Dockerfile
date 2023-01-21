FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt update; apt upgrade -y\
	&& apt install -y libgcc1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus

RUN apt-get update \
	&& apt-get clean \
	&& apt-get autoremove

RUN  apt --fix-broken install \
	&& apt-get update \
	&& apt-get upgrade \
	&& dpkg --configure -a \
	&& apt-get install -f
 
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
	&& apt install -y nodejs \
	&& mkdir /node_modules
	
RUN apt update; apt upgrade -y\
	&& dpkg --add-architecture i386; apt install -y wget file tar bzip2 gzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32z1

RUN useradd -d /home/container -m container
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN node --version
RUN apt-cache policy openssh-server
RUN npm install --prefix / ws
COPY ./ ./

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
