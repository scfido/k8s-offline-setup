#!/bin/bash

set +e

usage() {
    echo "使用说明："
    echo "导入以下参数再执行setup_master"
    echo "export HOSTNAME=k8s-master"
    echo "export APISERVER_NAME=apiserver.k8s.com"
    echo "export MASTER_IP=192.168.1.30"
    echo "export POD_SUBNET=10.11.10.0/16"
    echo ""
}

printEnvriment() {
    echo "已设置环境变量参数："
    echo "HOSTNAME="${HOSTNAME}
    echo "APISERVER_NAME="${APISERVER_NAME}
    echo "MASTER_IP="${MASTER_IP}
    echo "POD_SUBNET="${POD_SUBNET}
    echo ""
}

if [ ${#HOSTNAME} -eq 0 ] || [ ${#APISERVER_NAME} -eq 0 ] || [ ${#MASTER_IP} -eq 0 ] || [ ${#POD_SUBNET} -eq 0 ] ; then
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
source ./initial_master.sh
cd ..
