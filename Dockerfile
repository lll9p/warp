FROM debian:bookworm-slim

LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ENV TZ=Asia/Shanghai
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN set -eux; \
    apt-get update ; \
    apt-get install -y tzdata gnupg curl ; \
    curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg ; \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bookworm main" >> /etc/apt/sources.list.d/cloudflare-client.list ; \
    apt-get update && apt-get install -y cloudflare-warp ; \
    apt-get autoclean; rm -rf /var/lib/apt/lists/*
