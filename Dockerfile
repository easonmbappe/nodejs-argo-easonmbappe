FROM node:alpine3.20

WORKDIR /tmp

COPY . .

EXPOSE 3000/tcp

# 核心修改：安装 unzip，并直接下载官方稳定版 Xray (v1.8.24)
RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils unzip bash &&\
    curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.8.24/Xray-linux-64.zip &&\
    unzip xray.zip &&\
    mv xray /usr/local/bin/web &&\
    chmod +x /usr/local/bin/web &&\
    rm xray.zip &&\
    chmod +x index.js &&\
    npm install

CMD ["node", "index.js"]
