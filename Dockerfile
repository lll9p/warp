FROM alpine:latest
LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ENV DIST_VER "bookworm"
ENV BASE_URL "https://pkg.cloudflareclient.com"

WORKDIR /root

RUN set -eux; \
	  apk add --no-cache tzdata ca-certificates unzip && rm -rf /var/cache/apk/* ; \
    url="${BASE_URL}/dists/${DIST_VER}/main/binary-amd64/Packages" ; \
    echo "___________sdfasdfasdfasdfasdf/asdfasdf/${url}"; \
    filename=$(wget -qO- $url | grep -o '$Filename: .*$') ; \
    wget --no-check-certificate -c "${BASE_URL}/${filename}" -O warp.tar.gz ; \
    ls -alh ; \
    mkdir /root/warp ; \
    ar -x warp.deb ; \
    ls /root/warp ;\
    ls /root

VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
