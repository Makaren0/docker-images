FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt update \
    && apt upgrade -y \
    && dpkg --add-architecture i386; apt install -y curl; apt update -y;apt upgrade -y \
	&& curl -sL https://deb.nodesource.com/setup_15.x | bash - \
	&& apt install -y nodejs npm \
	&& mkdir /node_modules \
	&& apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 lib32z1\
    && useradd -d /home/container -m container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN npm install --prefix / ws

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
