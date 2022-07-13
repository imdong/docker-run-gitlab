#!/bin/sh

# 加载配置信息
. ./.env


# 判断证书文件是否存在
ssl_path="${NGINX_CERT_DIR}/${GITLAB_HOSTNAME}"
if [ ! -f "$ssl_path.crt" ]; then
    echo "证书文件不存在，请先生成证书"
    exit 1
fi

echo "生成 ${GITLAB_HOSTNAME} 证书"

openssl genrsa -out "${ssl_path}.key" 1024
openssl req -new -key "${ssl_path}.key" -out "${ssl_path}.csr" -subj "/C=CN/ST=ShanDlong/L=JiNan/O=ZorelWorld/OU=ZorelWorld/CN=${GITLAB_HOSTNAME}"
openssl x509 -req -in "${ssl_path}.csr" -out "${ssl_path}.crt" -signkey "${ssl_path}.key" -days 3650

echo "生成 ${JENKINS_HOSTNAME} 证书" 
ssl_path="${NGINX_CERT_DIR}/${JENKINS_HOSTNAME}"
openssl genrsa -out "${ssl_path}.key" 1024
openssl req -new -key "${ssl_path}.key" -out "${ssl_path}.csr" -subj "/C=CN/ST=ShanDlong/L=JiNan/O=ZorelWorld/OU=ZorelWorld/CN=${JENKINS_HOSTNAME}"
openssl x509 -req -in "${ssl_path}.csr" -out "${ssl_path}.crt" -signkey "${ssl_path}.key" -days 3650