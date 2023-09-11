FROM debian:bookworm-slim

LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ARG DIST_VER "bookworm"
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN set -eux; \
    apt-get update ; \
    apt-get install -y tzdata gnupg curl ; \
    curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg ; \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ ${DIST_VER} main" >> /etc/apt/sources.list.d/cloudflare-client.list ; \
    apt-get update && apt-get install -y cloudflare-warp

VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
