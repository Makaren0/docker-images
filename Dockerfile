FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt update; apt upgrade -y\
	&& apt install -y libgcc1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus

RUN apt install -y nodejs npm \
	&& mkdir /node_modules
	
RUN apt update; apt upgrade -y\
	&& dpkg --add-architecture i386; apt install -y wget file tar bzip2 gzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32z1

RUN useradd -d /home/container -m container
USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

RUN npm update
RUN npm install --prefix / ws

RUN node --version
RUN apt-cache policy openssh-server

CMD ["/bin/bash", "/entrypoint.sh"]
