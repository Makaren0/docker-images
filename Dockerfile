FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt update \
    && apt upgrade -y \
	&& dpkg --add-architecture i386; apt install -y lib32gcc1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
	&& apt install -y nodejs npm \
	&& npm install --prefix / ws \
	&& apt update -y; apt install wget file tar bzip2 gzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32z1\
	&& mkdir /node_modules \
    && useradd -d /home/container -m container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
