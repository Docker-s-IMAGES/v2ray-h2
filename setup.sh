#!/bin/sh

# 从环境变量中读取 DOMAIN，如果未设置则报错退出
if [ -z "$DOMAIN" ]; then
    echo "错误：必须设置 DOMAIN 环境变量。" >&2
    exit 1
fi
domain="$DOMAIN"

# 从环境变量 V2RAY_URL_PATH 读取路径，如果未设置则使用默认值
if [ -z "$V2RAY_URL_PATH" ] ;then
    path="/confusion"
else
    path="$V2RAY_URL_PATH"
fi

# 从环境变量 V2RAY_UUID 读取 UUID，如果未设置则生成一个新的
if  [ -z "$V2RAY_UUID" ] ;then
    uuid=$(uuidgen)
else
    uuid="$V2RAY_UUID"
fi

# 使用获取到的变量替换配置文件中的占位符
sed -i -e "s@HOST@${domain}@" -e "s@UUID@${uuid}@" -e "s@PATH@${path}@" /src/v2ray.json

# 打印最终配置信息
echo "域名："$domain
echo "UUID："$uuid
echo "路径："$path
echo ""

# 生成并打印 v2rayNG 的配置链接
echo "安卓客户端 v2rayNG 配置链接："
echo -e "vmess://\c"
echo '{"add": "DOMAIN", "aid": "0", "host": "DOMAIN", "id": "UUID", "net": "h2", "path": "PATH", "port": "443", "ps": "DOMAIN", "scy": "auto", "sni": "DOMAIN", "tls": "tls", "type": "none", "v": "2"}' | sed -e "s@DOMAIN@${domain}@g" -e "s@PATH@${path}@g" -e "s@UUID@${uuid}@g" | base64

# 生成并打印 v2rayN 的配置链接
echo "电脑客户端 v2rayN 配置链接："
echo -e "vmess://\c"
echo '{"v": "2", "ps": "DOMAIN", "add": "DOMAIN", "port": "443", "id": "UUID", "aid": "0", "scy": "auto", "net": "h2", "type": "none", "host": "DOMAIN", "path": "PATH", "tls": "tls", "sni": "DOMAIN"}' | sed -e "s@DOMAIN@${domain}@g" -e "s@PATH@${path}@g" -e "s@UUID@${uuid}@g" | base64

# 启动 v2ray
/usr/bin/v2ray run -c /src/v2ray.json
