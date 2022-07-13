# Gitlab 开坑日记

## 使用命令行静默注册 Runner

启动一个 gitlab runner 时可以这么注册

```shell
docker-compose exec gitlab-runner gitlab-runner register -u "https://gitlab.test/" -r "__TOKEN__" --executor "docker" --docker-image "alpine:latest" --non-interactive
```

启动多个 gitlab runner

```shell
# 表示启动 5个
docker-compose up --scale gitlab-runner=5 -d

# 给第5个注册
docker-compose exec --index=5 gitlab-runner gitlab-runner register -u "https://gitlab.test/" -r "__TOKEN__" --executor "docker" --docker-image "alpine:latest" --non-interactive
```

## 一些示例文件

[https://docs.gitlab.cn/jh/ci/examples/]
