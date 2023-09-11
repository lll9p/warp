FROM alpine:latest
LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ENV DIST_VER "bookworm"
ENV BASE_URL "https://pkg.cloudflareclient.com"

WORKDIR /root

RUN set -eux; \
	  apk add --no-cache tzdata ca-certificates binutils && rm -rf /var/cache/apk/* ; \
    url="${BASE_URL}/dists/${DIST_VER}/main/binary-amd64/Packages" ; \
    wget -qO- $url >content ; \
    filename=$(grep -o 'Filename: .*' content | cut -d" " -f2) ; \
    wget --no-check-certificate -c "${BASE_URL}/${filename}" -O warp.deb ; \
    ls -alh ; \
    mkdir /root/warp ; \
    ar -x warp.deb ; \
    ls /root/warp ;\
    ls /root; \
    apk del binutils

VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
