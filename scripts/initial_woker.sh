#!/bin/bash

# 导入镜像
docker load -i ../images/kube-controller-manager-v1.17.1.tar
docker load -i ../images/kube-apiserver-v1.17.1.tar
docker load -i ../images/kube-scheduler-v1.17.1.tar
docker load -i ../images/kube-proxy-v1.17.1.tar
docker load -i ../images/coredns-1.6.5.tar
docker load -i ../images/etcd-3.4.3-0.tar
docker load -i ../images/pause-3.1.tar

docker load -i ../images/calico-cni-v3.10.3.tar
docker load -i ../images/calico-pod2daemon-flexvol-v3.10.3.tar
docker load -i ../images/calico-node-v3.10.3.tar
docker load -i ../images/calico-kube-controllers-v3.10.3.tar

docker load -i ../images/nginx-ingress-controller-0.29.0.tar

echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

kubeadm join ${APISERVER_NAME}:${APISERVER_PORT} \
   --token ${TOKEN} \
   --discovery-token-ca-cert-hash ${CERT}
