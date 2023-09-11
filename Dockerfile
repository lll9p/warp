FROM alpine:latest
LABEL maintainer="lll9p <lll9p.china@gmail.com>"

ENV DIST_VER = bookworm
ENV BASE_URL = https://pkg.cloudflareclient.com

WORKDIR /root
COPY extract_url.sh /root/extract_url.sh

RUN set -eux; \
	  apk add --no-cache tzdata ca-certificates unzip && rm -rf /var/cache/apk/* ; \
    wget --no-check-certificate -c "${BASE_URL}/`bash extract_url.sh ${BASE_URL}/dist/${DIST_VER}/main/binary-amd64/Packages`" -O warp.deb ; \
    ls -alh ; \
    mkdir /root/warp ; \
    ar -x warp.deb ; \
    ls /root/warp ;\
    ls /root

VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
