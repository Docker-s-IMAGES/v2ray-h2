FROM alpine:3.16.2

ENV TZ "Asia/Shanghai"
ENV V2RAY_VERSION v4.45.2
ENV V2RAY_LOG_DIR /var/log/v2ray
ENV V2RAY_CONFIG_DIR /etc/v2ray/
ENV V2RAY_DOWNLOAD_URL https://github.com/v2fly/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip

WORKDIR /src

RUN apk upgrade --update \
    && apk add util-linux tzdata curl \
    && mkdir -p ${V2RAY_LOG_DIR} ${V2RAY_CONFIG_DIR} /tmp/v2ray \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${V2RAY_DOWNLOAD_URL} \
    && pwd \
    && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/ \
    && mv /tmp/v2ray/v2ray /usr/bin \
    && mv /tmp/v2ray/v2ctl /usr/bin \
    && chmod +x /usr/bin/v2ray \
    && chmod +x /usr/bin/v2ctl \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /tmp/v2ray /var/cache/apk/* \
    && apk del curl

COPY . /src

ENTRYPOINT [ "sh", "/src/setup.sh"]
