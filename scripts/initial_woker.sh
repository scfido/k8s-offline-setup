#!/bin/bash

# 导入镜像
. ./loadimage.sh

echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

kubeadm join ${APISERVER_NAME}:${APISERVER_PORT} \
   --token ${TOKEN} \
   --discovery-token-ca-cert-hash ${CERT}
