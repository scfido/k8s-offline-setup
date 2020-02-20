#!/bin/bash

# 导入镜像
# kubernetes
docker load -i ../images/kube-controller-manager-v1.17.1.tar
docker load -i ../images/kube-apiserver-v1.17.1.tar
docker load -i ../images/kube-scheduler-v1.17.1.tar
docker load -i ../images/kube-proxy-v1.17.1.tar
docker load -i ../images/coredns-1.6.5.tar
docker load -i ../images/etcd-3.4.3-0.tar
docker load -i ../images/pause-3.1.tar

#calico 网络插件
docker load -i ../images/calico-cni-v3.10.3.tar
docker load -i ../images/calico-pod2daemon-flexvol-v3.10.3.tar
docker load -i ../images/calico-node-v3.10.3.tar
docker load -i ../images/calico-kube-controllers-v3.10.3.tar

# nginx ingress controller
docker load -i ../images/nginx-ingress-controller-0.29.0.tar

# kubernetes dashboard
docker load -i ../images/kubernetesui-dashboard-v2.0.0-rc5.tar
docker load -i ../images/kubernetesui-metrics-scraper-v1.0.3.tar

# kuboard
docker load -i ../images/kuboard-latest.tar
docker load -i ../images/kuboard-metrics-server-amd64-v0.3.6.tar