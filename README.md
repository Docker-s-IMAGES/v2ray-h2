# v2ray-ws

一键启动 v2ray with websocket

```
docker run --rm --name v2ray -p "127.0.0.1:2333:2333" -d ghcr.io/docker-s-images/v2ray-h2:main DOMAIN [PATH] [UUID]
```

- PATH：默认值 `/confusion`，v2ray 服务所支持的路径，也是前置反向代理需要配置的路径。
- UUID：不给值时，将会自动生成一个 UUID 值；如果使用 Docker 的 restart 机制，务必配置此参数以防止重启后 UUID 发生变化。

## Caddy

```
reverse_proxy /confusion h2c://127.0.0.1:2333
```
