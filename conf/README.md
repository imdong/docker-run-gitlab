# Gitlab 开坑日记

## 解决注册 runner 节点时不能信任 gitlab 自签名 tls 的问题：x509: certificate relies on legacy Common Name field, use SANs instead

这个方法似乎无效，但现在不需要解决这个问题了

```shell
# gen
openssl s_client -showcerts -connect gitlab.secmao.me:443 < /dev/null 2>/dev/null | openssl x509 -outform PEM > /etc/gitlab-runner/certs/gitlab.secmao.me.crt

#check
echo | openssl s_client -CAfile /etc/gitlab-runner/certs/gitlab.secmao.me.crt -connect gitlab.secmao.me:443
```

## 使用命令行静默注册 Runner

启动一个 gitlab runner 时可以这么注册

```shell
docker-compose exec gitlab-runner gitlab-runner register -u "https://gitlab.secmao.me/" -r "__TOKEN__" --executor "docker" --docker-image "alpine:latest" --non-interactive
```

启动多个 gitlab runner

```shell
# 表示启动 5个
docker-compose up --scale gitlab-runner=5 -d

# 给第5个注册
docker-compose exec --index=5 gitlab-runner gitlab-runner register -u "https://gitlab.secmao.me/" -r "__TOKEN__" --executor "docker" --docker-image "alpine:latest" --non-interactive
```

## 一些示例文件

[https://docs.gitlab.cn/jh/ci/examples/]
