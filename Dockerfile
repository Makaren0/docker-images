FROM debian:bullseye-slim

LABEL       author="Makaren0" maintainer="Makaffe@hotmail.com"

RUN apt update \
    && apt upgrade -y \
    && dpkg --add-architecture i386; apt update -y; apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux netcat lib32gcc-s1 lib32stdc++6 lib32z1\
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs npm \
    && mkdir /node_modules \
    && npm install --prefix / ws \
    && useradd -d /home/container -m container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js

CMD ["/bin/bash", "/entrypoint.sh"]
