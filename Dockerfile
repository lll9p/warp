FROM debian:bookworm-slim

LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ARG DIST_VER "bookworm"
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root

ADD https://pkg.cloudflareclient.com/pubkey.gpg /root/pubkey.gpg

RUN set -eux; \
    apt-get update ; \
    apt-get install -y tzdata gnupg ; \
    wget -O-  https://pkg.cloudflareclient.com/pubkey.gpg /root/pubkey.gpg | apt-key add - ; \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ ${DIST_VER} main" >> /etc/apt/sources.list.d/cloudflare-client.list ; \
    apt-get update && apt-get install -y cloudflare-warp

VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
