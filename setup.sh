#!/bin/sh

domain="$1"

if [ ! "$2" ] ;then
    path="/confusion"
else
    path="$2"
fi

if  [ ! "$3" ] ;then
    uuid=$(uuidgen)
else
    uuid="$3"
fi

sed -i -e "s@HOST@${domain}@" -e "s@UUID@${uuid}@" -e "s@PATH@${path}@" /src/v2ray.json

echo "域名："$domain
echo "UUID："$uuid
echo "路径："$path
echo ""
echo "安卓客户端 v2rayNG 配置链接："
echo -e "vmess://\c"
echo '{"add": "DOMAIN", "aid": "0", "host": "DOMAIN", "id": "UUID", "net": "h2", "path": "PATH", "port": "443", "ps": "DOMAIN", "scy": "auto", "sni": "DOMAIN", "tls": "tls", "type": "none", "v": "2"}' | sed -e "s@DOMAIN@${domain}@g" -e "s@PATH@${path}@g" -e "s@UUID@${uuid}@g" | base64
echo "电脑客户端 v2rayN 配置链接："
echo -e "vmess://\c"
echo '{"v": "2", "ps": "DOMAIN", "add": "DOMAIN", "port": "443", "id": "UUID", "aid": "0", "scy": "auto", "net": "h2", "type": "none", "host": "DOMAIN", "path": "PATH", "tls": "tls", "sni": "DOMAIN"}' | sed -e "s@DOMAIN@${domain}@g" -e "s@PATH@${path}@g" -e "s@UUID@${uuid}@g" | base64


/usr/bin/v2ray -config /src/v2ray.json
