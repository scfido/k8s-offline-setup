#!/bin/bash

set +e

usage() {
    echo "使用说明："
    echo "导入以下参数再执行setup_worker"
    echo "export HOSTNAME=k8s-worker1"
    echo "export APISERVER_NAME=apiserver.k8s.com"
    echo "export APISERVER_PORT=6443 默认:6443"
    echo "export MASTER_IP=192.168.1.30"
    echo "export TOKEN=edz861.g6eci15slbefibj8"
    echo "export CERT=sha256:23a7e1b4..."
    echo ""
}

ensureApiServerPort() {
    if [ ${#APISERVER_PORT} -eq 0 ]; then
        # echo "set default port"
        export APISERVER_PORT=6443
    fi
}

printEnvriment() {
    echo "已设置环境变量参数："
    echo "HOSTNAME="${HOSTNAME}
    echo "APISERVER_NAME="${APISERVER_NAME}
    echo "APISERVER_PORT="${APISERVER_PORT}
    echo "MASTER_IP="${MASTER_IP}
    echo "TOKEN="${TOKEN}
    echo "CERT="${CERT}
    echo ""
}

ensureApiServerPort

if [ ${#HOSTNAME} -eq 0 ] || [ ${#APISERVER_NAME} -eq 0 ] || [ ${#APISERVER_PORT} -eq 0 ] || [ ${#MASTER_IP} -eq 0 ] || [ ${#TOKEN} -eq 0 ] || [ ${#CERT} -eq 0 ]; then
    usage

    echo -e "\033[31;1m缺少环境变量参数 \033[0m"
    printEnvriment
    exit 1
fi

cd ./scripts/
source ./setup_hostname.sh ${HOSTNAME}
source ./install_localRepo.sh
source ./install_docker.sh
source ./install_kubernetes.sh
source ./initial_woker.sh
cd ..
