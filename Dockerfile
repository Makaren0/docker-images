FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt update\
    && apt upgrade -y \
	&& apt-get clean \
	&& apt-get autoremove \
	&& apt install -y libgcc1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus
	
RUN apt remove nodejs \
	&& rm -rf /usr/local/bin/node* \
	&& rm -rf /usr/local/bin/npm* \
	&& rm -rf /etc/apt/sources.list.d/nodesource.list	

RUN apt install -y nodejs npm \
	&& mkdir /node_modules
	
RUN apt update\
    && apt upgrade -y \
	&& dpkg --add-architecture i386; apt install -y wget file tar bzip2 gzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32z1 \
    && useradd -d /home/container -m container \
	&& node --version \
	&& apt-cache policy openssh-server

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN npm install --prefix / ws

COPY ./ ./
COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
